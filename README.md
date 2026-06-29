# Archivo

Este es mi **baúl de los recuerdos**. 😄 Aquí voy guardando mis ejemplos en las
**versiones antiguas de PowerBuilder, Visual Studio y .NET** que ya no mantengo en el
día a día, pero que me gusta conservar: por si alguien sigue trabajando con esas
versiones, y por no perder el histórico.

La idea es sencilla: **cada ejemplo tiene su propio repositorio "vivo"** en
`github.com/rasanfe/<NombreEjemplo>`, siempre con la última versión. Cuando salto a una
versión nueva de PowerBuilder o de .NET, **archivo aquí la foto de la versión anterior**.
Así el repo del ejemplo se queda limpio con lo actual y aquí abajo queda lo viejo bien
guardado.

> 🔴 **Ojo:** todo lo que hay en este repositorio está **congelado**. No recibe mejoras ni
> correcciones. Si queréis la versión que mantengo hoy, id al repo propio de cada ejemplo
> (tenéis los enlaces en [Lo que sigue vivo](#lo-que-sigue-vivo-)).

## ¿Cómo está organizado?

Organizo el archivo por **generaciones de versión**, y dentro separo las dos piezas que
forman cada ejemplo:

- Los **proyectos PowerBuilder** (el IDE, las librerías `.pbl`, la aplicación).
- Las **librerías .NET en C#** (los servicios/DLL que PowerBuilder consume por debajo).

Cada generación de PowerBuilder usa su generación de .NET, así que las carpetas van
**emparejadas**.

### Proyectos PowerBuilder archivados

| Carpeta | Versión de PowerBuilder | Librerías .NET que usa | Notas |
|---|---|---|---|
| `PowerBuilder_115_b2506` | PowerBuilder **11.5** (build 2506) | `Visual_Studio_2022_NetCore3.1_Comhost` | Adaptados a **32 bits** llamando a C# vía COM host |
| `PowerBuilder_126_b3506` | PowerBuilder **12.6** (build 3506) | `Visual_Studio_2022_NetCore3.1_Comhost` | Adaptados a **32 bits** llamando a C# vía COM host |
| `PowerBuilder_2019_b2779` | PowerBuilder **2019** (build 2779) | `Visual_Studio_2022_NetCore3.1` | Librerías en .NET Core 3.1 |
| `PowerBuilder_2021_b1509` | PowerBuilder **2021** (build 1509) | `Visual_Studio_2022_NetCore3.1` | Librerías en .NET Core 3.1 |
| `PowerBuilder_2022_b3359` | PowerBuilder **2022** (build 3359) | `Visual_Studio_2022_Net6` | Librerías en .NET 6 |
| `PowerBuilder_2022_b3397` | PowerBuilder **2022 R3** (build 3397) | `Visual_Studio_2026_Net8` | Librerías en .NET 8 |

### Librerías .NET archivadas (Visual Studio)

| Carpeta | Plataforma .NET | Para qué PowerBuilder | Notas |
|---|---|---|---|
| `Visual_Studio_2022_NetCore3.1_Comhost` | .NET Core 3.1 (COM host) | PB **11.5** y **12.6** | Versión expuesta por **COM** para los PB clásicos de 32 bits |
| `Visual_Studio_2022_NetCore3.1` | .NET Core 3.1 | PB **2019** y **2021** | |
| `Visual_Studio_2022_Net6` | .NET 6 | PB **2022** (3359) | |
| `Visual_Studio_2026_Net8` | .NET 8 | PB **2022 R3** (3397) | Lo último que he archivado |

### El catálogo de ejemplos

A lo largo de todas estas versiones se repite más o menos el mismo conjunto de ejemplos
(cada uno con su librería .NET y, cuando aplica, su envoltorio PowerBuilder):

- **Ficheros:** `FileService` / `pbfileservice`
- **PDF:** `NetPdfService`, `PdfExtractor`, `PdfFillFormFields`, `SplitMergePdf` y las
  utilidades `pbpdfutilities`, `pdfsign`, `pdfbuilder_demo`
- **Códigos de barras y QR:** `RSRBarcode`, `ZxingBarcode`, `ImageSharp`, `ean13code`,
  `qrcode`, `qrcode_pdf`
- **OCR e imagen:** `ImageOCR` / `pbImageOCR`
- **Correo:** `MailKitNetSmtp` / `pbMailkit`
- **Impresión RAW:** `RawPrint` / `pbRawPrint`
- **Escáner WIA:** `ScannerWia` / `pbScanner`
- **Seguridad y cifrado:** `SecurityApi`, `app_secdata`, `EncryptGenerator`,
  `EncryptGeneratorApi`
- **Cloud framework propio:** `MyPowerServer`
- **Varios:** `pbcolors`, `toast`, `jsontodw`, `Table_to_Object`, `TestNested`,
  `BackupFtpApp`, `vpbautobuild`, `Reports_PowerServer`, `ExpoCom`

## Lo que sigue vivo 🟢

Todo lo de arriba es la **foto antigua**. La versión que mantengo hoy de cada ejemplo está
en su **propio repositorio**, ya en **PowerBuilder 2025 R2** y con las **librerías .NET
migradas a .NET 10**. Si os interesa la solución completa montada, la tenéis aquí:

- 👉 **[2025-Solution](https://github.com/rasanfe/2025-Solution)** — la solución actual.
- 👉 **Todos mis repos:** <https://github.com/rasanfe?tab=repositories>

### Librerías y servicios .NET (repo vivo)

[FileService](https://github.com/rasanfe/FileService) ·
[ImageOCR](https://github.com/rasanfe/ImageOCR) ·
[MailKitNetSmtp](https://github.com/rasanfe/MailKitNetSmtp) ·
[NetPdfService](https://github.com/rasanfe/NetPdfService) ·
[PdfExtractor](https://github.com/rasanfe/PdfExtractor) ·
[PdfFillFormFields](https://github.com/rasanfe/PdfFillFormFields) ·
[SplitMergePdf](https://github.com/rasanfe/SplitMergePdf) ·
[RawPrint](https://github.com/rasanfe/RawPrint) ·
[ScannerWia](https://github.com/rasanfe/ScannerWia) ·
[RSRBarcode](https://github.com/rasanfe/RSRBarcode) ·
[ZxingBarcode](https://github.com/rasanfe/ZxingBarcode) ·
[SecurityApi](https://github.com/rasanfe/SecurityApi) ·
[MyPowerServer](https://github.com/rasanfe/MyPowerServer) ·
[ExpoCom](https://github.com/rasanfe/ExpoCom) ·
[COMServer](https://github.com/rasanfe/COMServer)

> `ImageSharp` no tiene repo propio: es la librería de imagen compartida que usan los
> ejemplos de códigos de barras.

### Ejemplos y envoltorios PowerBuilder (repo vivo)

[pbcolors](https://github.com/rasanfe/pbcolors) ·
[pbfileservice](https://github.com/rasanfe/pbfileservice) ·
[pbImageOCR](https://github.com/rasanfe/pbImageOCR) ·
[pbMailKit](https://github.com/rasanfe/pbMailKit) ·
[pbPdfExtractor](https://github.com/rasanfe/pbPdfExtractor) ·
[pbPdfFillFormFields](https://github.com/rasanfe/pbPdfFillFormFields) ·
[pbpdfutilities](https://github.com/rasanfe/pbpdfutilities) ·
[pbRawPrint](https://github.com/rasanfe/pbRawPrint) ·
[pbScanner](https://github.com/rasanfe/pbScanner) ·
[pdfsign](https://github.com/rasanfe/pdfsign)

### Apps, APIs y utilidades (repo vivo)

[app_secdata](https://github.com/rasanfe/app_secdata) ·
[EncryptGenerator](https://github.com/rasanfe/EncryptGenerator) ·
[EncryptGeneratorApi](https://github.com/rasanfe/EncryptGeneratorApi) ·
[BackupFtpApp](https://github.com/rasanfe/BackupFtpApp) ·
[ean13code](https://github.com/rasanfe/ean13code) ·
[qrcode](https://github.com/rasanfe/qrcode) ·
[qrcode_pdf](https://github.com/rasanfe/qrcode_pdf) ·
[jsontodw](https://github.com/rasanfe/jsontodw) ·
[Table_to_Object](https://github.com/rasanfe/Table_to_Object) ·
[TestNested](https://github.com/rasanfe/TestNested) ·
[toast](https://github.com/rasanfe/toast) ·
[vpbautobuild](https://github.com/rasanfe/vpbautobuild) ·
[Reports_PowerServer](https://github.com/rasanfe/Reports_PowerServer) ·
[PdfBuilder_demo](https://github.com/rasanfe/PdfBuilder_demo)

### Novedades que solo viven en su repo

Estos ejemplos son posteriores a este archivo, así que aquí no hay foto antigua de ellos
(solo existen en su repositorio actual):

[PyPbExample](https://github.com/rasanfe/PyPbExample) ·
[FicharDemo](https://github.com/rasanfe/FicharDemo) ·
[FicharDemoApi](https://github.com/rasanfe/FicharDemoApi) ·
[JobersPartesApi](https://github.com/rasanfe/JobersPartesApi) ·
[TwoFactorAuthDemo](https://github.com/rasanfe/TwoFactorAuthDemo) ·
[Pb_Snake_Dw](https://github.com/rasanfe/Pb_Snake_Dw) ·
[Pb_SpaceBricks](https://github.com/rasanfe/Pb_SpaceBricks) ·
[PersonDemo03](https://github.com/rasanfe/PersonDemo03) ·
[inc.win.base.pb-json](https://github.com/rasanfe/inc.win.base.pb-json)

## El blog

Para estar al tanto de lo que voy publicando, os dejo el blog:

👉 **<https://rsrsystem.blogspot.com/>**

¡Nos vemos en el próximo artículo! Y recuerda: en PowerBuilder, los límites solo están en nuestra imaginación. 🚀
