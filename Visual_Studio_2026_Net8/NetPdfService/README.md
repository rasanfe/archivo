# NetPdfService — Firma digital de PDF con iText7 (.NET 8)

Librería .NET 8 que firma documentos PDF (visible e invisible) con **iText7 8.0.5** y un
certificado `.pfx`. Está pensada para consumirse de **dos formas**:

| Consumidor | Cómo se usa | Proyecto |
|------------|-------------|----------|
| **`NetPdfService.dll`** (librería) | Cargada en proceso como `dotnetobject` desde **PowerBuilder** | `NetPdfService.csproj` |
| **`TestNetPdfService.exe`** (consola) | Lanzada como proceso externo (PB captura su salida) | `TestNetPdfService/` |

> El ejemplo PowerBuilder que la consume está en `Blog/PowerBuilder/pdfsign`.

---

## API (`NetPdfService.PdfService`)

```csharp
// Firma VISIBLE (imagen + nombre/DNI en un rectángulo)
void Firmar(string inFile, string outFile, string certFile, string password,
            string reason, string location, string contact,
            string imgeFile, int x1, int y1, int x2, int y2,
            string nombre, string dni);

// Firma INVISIBLE (solo criptográfica)
void Firmar(string inFile, string outFile, string certFile, string password,
            string reason, string location, string contact);

string GetLastError();   // "" si todo fue bien
string GetSignLevel();   // nivel PAdES logrado: "B-LTA" | "B-T" | "B-B"
```

- Devuelve por `GetLastError()` el mensaje de error (no lanza hacia el consumidor).
- La consola imprime **`Done!`** al terminar con éxito.
- Firma en **PAdES** (CAdES) con **sello de tiempo** y **LTV** — ver sección «Firma legal».

### Detalles de la firma visible
- **Coordenadas iText**: `new Rectangle(x1, y1, x2, y2)` → `(x, y, ANCHO, ALTO)`. Es decir
  `x1,y1` = esquina **inferior-izquierda** y `x2,y2` = **ancho** y **alto** de la caja.
- La firma se coloca en la **última página** del PDF.
- La imagen se escala con `SetImageScale(0.22f)` y el texto (nombre + DNI) se añade con
  `SetLayer2Text`.

---

## Firma legal — PAdES + sello de tiempo (TSA) + LTV

`PdfService.Sign` firma en **PAdES** (`PdfSigner.CryptoStandard.CADES` → `ETSI.CAdES.detached`),
añade **sello de tiempo** con `TSAClientBouncyCastle` (TSA gratuita, DigiCert) y, cuando puede,
**LTV** (PAdES-B-LTA): tras firmar, `LtvVerification.Merge()` añade el `/DSS` (cadena + revocación)
y `PdfSigner.Timestamp(...)` añade un **sello de documento**.

### Cascada con degradación (offline-safe)

```
B-LTA  (PAdES + sello + LTV)  →  B-T  (PAdES + sello)  →  B-B  (PAdES sin sello)
```

Si el sello o el LTV no se pueden obtener (sin internet, TSA caída…), degrada solo y la firma
**siempre se produce** (B-B en el peor caso). `GetSignLevel()` devuelve el nivel logrado.

### Revocación del firmante (demo)

El certificado demo no tiene CDP/AIA online, así que su CRL se aporta a mano: `Sign` carga
**`demo.crl`** de la carpeta de la DLL (`CrlClientOffline`) y la embebe en la firma y en el `/DSS`.
La cadena del TSA (DigiCert) sí se resuelve online (`CrlClientOnline` / `OcspClientBouncyCastle`).

> Material demo (cert + CA + CRL) generado en `Blog/PowerBuilder/pdfsign` (`firma_legal.pfx`, clave
> `PDFSIGN`). Es **DEMO**: para validez legal real, usar un certificado **cualificado**.

---

## 🔑 Fix: fallo en MODO LIBRERÍA bajo PowerBuilder

### Síntoma
Al firmar **cargando la DLL en proceso** (`dotnetobject` de PowerBuilder) fallaba con:

```
The type initializer for 'iText.IO.Util.ResourceUtil' threw an exception.
```

…pero el **mismo** `NetPdfService.dll` funcionaba perfectamente en **modo consola**
(`TestNetPdfService.exe`).

### Causa real
Al hospedar PowerBuilder el CLR, **`AppDomain.CurrentDomain.BaseDirectory` queda VACÍO (`""`)**.
El constructor estático de `iText.IO.Util.ResourceUtil` (en `LoadITextResourceAssemblies`) hace:

```csharp
if (FileUtil.GetBaseDirectory() == null) return;          // <-- solo comprueba null
string[] files = Directory.GetFiles(FileUtil.GetBaseDirectory(), "*.dll");
```

`FileUtil.GetBaseDirectory()` devuelve `AppDomain.CurrentDomain.BaseDirectory`. Bajo PB es `""`
(no `null`), así que pasa el `if` y llega a **`Directory.GetFiles("", "*.dll")`** →
`System.ArgumentException: The path is empty (Parameter 'path')` → el *type initializer* de
`ResourceUtil` revienta. En consola no ocurre porque ahí `BaseDirectory` es la carpeta del `.exe`.

> ⚠️ El mensaje externo (`type initializer for ResourceUtil`) es **genérico** para cualquier
> fallo en ese constructor; despista. La clave fue obtener la **inner exception** real
> (`ArgumentException: The path is empty`). Un primer diagnóstico apuntó (erróneamente) a la
> no-resolución de las dependencias transitivas `Microsoft.DotNet.PlatformAbstractions` /
> `Microsoft.Extensions.DependencyModel`, porque un repro en consola quitándolas daba el mismo
> mensaje externo — pero esas DLLs cargaban bien; el problema real era el `BaseDirectory` vacío.

### Solución
Un **constructor estático** en `PdfService` que se ejecuta al instanciar la clase
(`CREATE nvo_pdfservice` en PB), **antes** de que iText arranque, y le da a `AppContext` un
`BaseDirectory` válido (la carpeta de la propia DLL):

```csharp
static PdfService()
{
    try
    {
        Assembly self = typeof(PdfService).Assembly;
        string dir = System.IO.Path.GetDirectoryName(self.Location) ?? "";
        if (string.IsNullOrEmpty(dir)) dir = AppContext.BaseDirectory ?? "";

        // FIX principal: BaseDirectory válido para iText (PB lo deja vacío).
        if (string.IsNullOrEmpty(AppContext.BaseDirectory) && !string.IsNullOrEmpty(dir))
            AppContext.SetData("APP_CONTEXT_BASE_DIRECTORY", dir.EndsWith("\\") ? dir : dir + "\\");

        // Belt-and-suspenders: garantizar la carga de las dependencias transitivas que usa
        // ese mismo ctor (Microsoft.DotNet.PlatformAbstractions / Microsoft.Extensions.DependencyModel)
        // desde la carpeta de la DLL, por si el host nativo no las resolviera.
        var alc = AssemblyLoadContext.GetLoadContext(self) ?? AssemblyLoadContext.Default;
        alc.Resolving += (ctx, name) => {
            string r = System.IO.Path.Combine(dir, (name.Name ?? "") + ".dll");
            return File.Exists(r) ? ctx.LoadFromAssemblyPath(r) : null;
        };
        AppDomain.CurrentDomain.AssemblyResolve += (s, e) => {
            string r = System.IO.Path.Combine(dir, (new AssemblyName(e.Name).Name ?? "") + ".dll");
            return File.Exists(r) ? Assembly.LoadFrom(r) : null;
        };
        foreach (var n in new[]{ "Microsoft.DotNet.PlatformAbstractions",
                                 "Microsoft.Extensions.DependencyModel" })
        {
            string r = System.IO.Path.Combine(dir, n + ".dll");
            if (File.Exists(r)) alc.LoadFromAssemblyPath(r);
        }
    }
    catch { }
}
```

> `AppContext.SetData("APP_CONTEXT_BASE_DIRECTORY", dir)` **sí** cambia
> `AppDomain.CurrentDomain.BaseDirectory` (verificado en .NET 8).

**Validado** con un `AssemblyLoadContext` que simula el hosting de PowerBuilder y **confirmado en
PowerBuilder real** (firma correcta, sin el error de `ResourceUtil`).

`usings` necesarios: `System.Reflection`, `System.Runtime.Loader`, `System.IO`.

---

## Compilar y desplegar

```bat
dotnet build NetPdfService.csproj -c Release
```

Salida en `bin\Release\net8.0\`. Para el ejemplo PowerBuilder, copiar la `NetPdfService.dll`
resultante a `…\pdfsign\DotNet\NetPdfService\` (esa carpeta ya tiene el resto de DLLs de iText).

> Si PowerBuilder está abierto, la DLL queda **bloqueada** (`WinError 32`): cerrar PB antes de copiar.

## Dependencias

- `itext7` **8.0.5**
- `itext7.bouncy-castle-adapter` **8.0.5**
- `itext7.commons` **8.0.5**

(`Microsoft.DotNet.PlatformAbstractions` y `Microsoft.Extensions.DependencyModel` llegan como
dependencias transitivas de `itext.io`.)

---

Para estar al tanto de lo que publico puedes seguir mi blog:
<https://rsrsystem.blogspot.com/>
