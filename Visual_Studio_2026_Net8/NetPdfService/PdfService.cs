using System;
using System.Text;
using iText.Kernel.Pdf;
using iText.Signatures;
using iText.Kernel.Geom;
using Org.BouncyCastle.X509;
using Org.BouncyCastle.Crypto;
using Org.BouncyCastle.Pkcs;
using System.Globalization;
using iText.Kernel.Font;
using iText.IO.Image;
using System.IO;
using System.Reflection;
using System.Runtime.Loader;
using iText.Bouncycastle.X509;
using iText.Commons.Bouncycastle.Cert;
using iText.Bouncycastle.Crypto;
using iText.Commons.Bouncycastle.Cert;

namespace NetPdfService
{
    public class PdfService
    {

        // Arregla el fallo de iText (ResourceUtil) en MODO LIBRERIA bajo hosts nativos como
        // PowerBuilder. Se ejecuta al instanciar PdfService, ANTES de que iText arranque.
        //
        // CAUSA: PB hospeda el CLR dejando AppDomain.CurrentDomain.BaseDirectory VACIO ("").
        // El ctor estatico de iText ResourceUtil hace Directory.GetFiles(BaseDirectory, "*.dll")
        // y solo comprueba == null (no cadena vacia) -> ArgumentException "The path is empty"
        // -> TypeInitializationException de ResourceUtil. (En consola no pasa: ahi BaseDirectory
        // es la carpeta del exe.)
        //
        // FIX: darle a AppContext un BaseDirectory valido (la carpeta de esta DLL). Ademas se
        // garantiza la carga de las 2 dependencias transitivas que usa ese mismo ctor
        // (Microsoft.DotNet.PlatformAbstractions / Microsoft.Extensions.DependencyModel) por si
        // el host no las resuelve.
        static PdfService()
        {
            try
            {
                Assembly self = typeof(PdfService).Assembly;
                string dir = "";
                try { dir = System.IO.Path.GetDirectoryName(self.Location) ?? ""; } catch { }
                if (string.IsNullOrEmpty(dir)) dir = AppContext.BaseDirectory ?? "";

                // BaseDirectory valido para iText (el fix principal).
                try
                {
                    if (string.IsNullOrEmpty(AppContext.BaseDirectory) && !string.IsNullOrEmpty(dir))
                        AppContext.SetData("APP_CONTEXT_BASE_DIRECTORY",
                            dir.EndsWith("\\") ? dir : dir + "\\");
                }
                catch { }

                // Asegurar la carga de las dependencias transitivas desde la carpeta de la DLL.
                AssemblyLoadContext alc = AssemblyLoadContext.GetLoadContext(self) ?? AssemblyLoadContext.Default;
                alc.Resolving += (ctx, name) =>
                {
                    try
                    {
                        string ruta = System.IO.Path.Combine(dir, (name.Name ?? "") + ".dll");
                        return File.Exists(ruta) ? ctx.LoadFromAssemblyPath(ruta) : null;
                    }
                    catch { return null; }
                };
                AppDomain.CurrentDomain.AssemblyResolve += (sender, e) =>
                {
                    try
                    {
                        string ruta = System.IO.Path.Combine(dir, (new AssemblyName(e.Name).Name ?? "") + ".dll");
                        return File.Exists(ruta) ? Assembly.LoadFrom(ruta) : null;
                    }
                    catch { return null; }
                };
                foreach (string n in new[] { "Microsoft.DotNet.PlatformAbstractions",
                                             "Microsoft.Extensions.DependencyModel" })
                {
                    try
                    {
                        string r = System.IO.Path.Combine(dir, n + ".dll");
                        if (File.Exists(r)) alc.LoadFromAssemblyPath(r);
                    }
                    catch { }
                }
            }
            catch { }
        }

        private string errorText = "";
        public void Firmar(string inFile, string outFile, string certFile, string password, string reason, string location, string contact, string imgeFile, int x1, int y1, int x2, int y2, string nombre, string dni)
        {

            const bool isVisible = true;

            if (String.IsNullOrEmpty(imgeFile))
            {
                errorText = "Image File cannot be null";
                throw new ArgumentNullException(paramName: nameof(imgeFile), message: errorText);
            }

            if (String.IsNullOrWhiteSpace(nombre)) { nombre = ""; }
            if (String.IsNullOrWhiteSpace(nombre)) { dni = ""; }

            Firmar(inFile, outFile, certFile, password, reason, location, contact, imgeFile, x1, y1, x2, y2, nombre, dni, isVisible);
        }
        public void Firmar(string inFile, string outFile, string certFile, string password, string reason, string location, string contact)
        {
            const string imgeFile = "";
            const int x1 = 0;
            const int y1 = 0;
            const int x2 = 0;
            const int y2 = 0;
            const string nombre = "";
            const string dni = "";
            const bool isVisible = false;

            Firmar(inFile, outFile, certFile, password, reason, location, contact, imgeFile, x1, y1, x2, y2, nombre, dni, isVisible);

        }

        internal void Firmar(string inFile, string outFile, string certFile, string password, string reason, string location, string contact, string imgeFile, int x1, int y1, int x2, int y2, string nombre, string dni, bool isVisible)
        {
            if (String.IsNullOrEmpty(inFile))
            {
                errorText = "Input File cannot be null";
                throw new ArgumentNullException(paramName: nameof(inFile), message: errorText);
            }
            if (System.IO.Path.GetExtension(inFile) != ".pdf")
            {
                errorText = "Input File Extension is not PDF";
                throw new ArgumentException(paramName: nameof(inFile), message: errorText);
            }

            if (String.IsNullOrEmpty(outFile))
            {
                errorText = "Output File cannot be null";
                throw new ArgumentNullException(paramName: nameof(outFile), message: errorText);
            }
            if (System.IO.Path.GetExtension(outFile) != ".pdf")
            {
                errorText = "Output File Extension is not PDF";
                throw new ArgumentException(paramName: nameof(outFile), message: errorText);
            }
            if (String.IsNullOrEmpty(certFile))
            {
                errorText = "Certificate File File cannot be null";
                throw new ArgumentNullException(paramName: nameof(certFile), message: errorText);
            }
            if (System.IO.Path.GetExtension(certFile) != ".pfx")
            {
                errorText = "Certificate File Extension is not PFX";
                throw new ArgumentException(paramName: nameof(certFile), message: errorText);
            }
            if (String.IsNullOrEmpty(password))
            {
                errorText = "Password cannot be null";
                throw new ArgumentNullException(paramName: nameof(password), message: errorText);
            }

            if (String.IsNullOrWhiteSpace(reason)) { reason = "proof of authenticity"; }

            ResetError();

            try
            {
                Sign(inFile, outFile, certFile, password, reason, location, contact, imgeFile, x1, y1, x2, y2, nombre, dni, isVisible, null, null, null, 0);
            }
            catch (Exception ex)
            {
                errorText = ex.Message;
            }

        }


        // TSA RFC3161 GRATUITA (sellado de tiempo). DigiCert es gratuito para todos.
        private const string TsaUrl = "http://timestamp.digicert.com";

        // Nivel PAdES logrado en la ultima firma: "B-LTA" | "B-T" | "B-B".
        private string signLevel = "";
        public string GetSignLevel() { return signLevel; }

        internal void Sign(string inFile, string outFile, string certFile, string password, string reason, string location, string contact, string imgeFile, int x1, int y1, int x2, int y2, string nombre, string dni, bool isVisible,
            ICollection<ICrlClient>? crlList, IOcspClient? ocspClient, ITSAClient? tsaClient, int estimatedSize)
        {
            // Material de firma (clave + cadena del certificado)
            IX509Certificate[]? chain = null;
            IExternalSignature? pks = null;
            CreateChainFromFile(certFile, password, DigestAlgorithms.SHA256, ref chain, ref pks);
            var convertedChain = chain.Select(x => (iText.Commons.Bouncycastle.Cert.IX509Certificate)x).ToArray();

            byte[] inputBytes = File.ReadAllBytes(inFile);
            int numberOfPages = GetNumberOfPages(inFile);
            string fieldName = "sig_" + dni + "_" + DateTime.Now.ToString("yyyyMMddHHmmss");

            // Clientes de revocacion para LTV
            IOcspClient ocsp = new OcspClientBouncyCastle();
            ICrlClient crlOnline = new CrlClientOnline();
            ICrlClient? crlDemo = LoadDemoCrl();   // CRL del cert demo (no tiene CDP online)

            // Firma una vez en PAdES (CAdES). useTsa = sello de tiempo; embedRev = embeber revocacion.
            byte[] SignOnce(bool useTsa, bool embedRev)
            {
                using var outMs = new MemoryStream();
                PdfSigner s = new PdfSigner(new PdfReader(new MemoryStream(inputBytes)), outMs, new StampingProperties());
                s.SetSignDate(DateTime.Now);
                s.SetFieldName(fieldName);
                s.SetLocation(location ?? "");
                s.SetReason(reason);
                s.SetContact(contact ?? "");
                if (isVisible)
                {
                    PdfSignatureAppearance appearance = s.GetSignatureAppearance();
                    appearance.SetImage(ImageDataFactory.Create(imgeFile));
                    appearance.SetReuseAppearance(false);
                    appearance.SetPageRect(new Rectangle(x1, y1, x2, y2));   // (x, y, ANCHO, ALTO)
                    appearance.SetPageNumber(numberOfPages);                  // ultima pagina
                    appearance.SetImageScale(0.22f);
                    StringBuilder buf = new StringBuilder();
                    buf.Append('\n').Append('\n').Append('\n').Append('\n').Append(@nombre).Append('\n').Append(@dni);
                    appearance.SetLayer2Text(buf.ToString());
                }
                ITSAClient? tsa = useTsa ? new TSAClientBouncyCastle(TsaUrl) : null;
                ICollection<ICrlClient>? crls = null;
                IOcspClient? oc = null;
                if (embedRev)
                {
                    crls = new List<ICrlClient> { crlOnline };
                    if (crlDemo != null) crls.Add(crlDemo);
                    oc = ocsp;
                }
                // CAdES => subfilter ETSI.CAdES.detached (PAdES)
                s.SignDetached(pks, convertedChain, crls, oc, tsa, 0, PdfSigner.CryptoStandard.CADES);
                return outMs.ToArray();
            }

            // Anade DSS (info de validacion) + sello de tiempo de documento => PAdES-B-LTA
            byte[] AddLta(byte[] signed)
            {
                byte[] withDss;
                using (var ms1 = new MemoryStream())
                {
                    PdfDocument doc = new PdfDocument(new PdfReader(new MemoryStream(signed)),
                        new PdfWriter(ms1), new StampingProperties().UseAppendMode());
                    SignatureUtil su = new SignatureUtil(doc);
                    LtvVerification v = new LtvVerification(doc);
                    // CRL para la cadena del firmante: la demo (offline) si existe — el cert
                    // demo no tiene CDP online — y CrlClientOnline para cadenas con CDP (TSA).
                    ICrlClient crlForLtv = crlDemo ?? crlOnline;
                    foreach (string name in su.GetSignatureNames())
                    {
                        v.AddVerification(name, ocsp, crlForLtv,
                            LtvVerification.CertificateOption.WHOLE_CHAIN,
                            LtvVerification.Level.OCSP_OPTIONAL_CRL,
                            LtvVerification.CertificateInclusion.YES);
                    }
                    v.Merge();
                    doc.Close();
                    withDss = ms1.ToArray();
                }
                using (var ms2 = new MemoryStream())
                {
                    PdfSigner ts = new PdfSigner(new PdfReader(new MemoryStream(withDss)), ms2,
                        new StampingProperties().UseAppendMode());
                    ts.Timestamp(new TSAClientBouncyCastle(TsaUrl), "ltv-ts");
                    return ms2.ToArray();
                }
            }

            // Cascada: B-LTA -> B-T -> B-B (siempre PAdES), degradando con gracia.
            byte[] result;
            try
            {
                result = AddLta(SignOnce(true, true));         // PAdES + sello + LTV
                signLevel = "B-LTA";
            }
            catch
            {
                try { result = SignOnce(true, false); signLevel = "B-T"; }    // PAdES + sello
                catch { result = SignOnce(false, false); signLevel = "B-B"; } // PAdES
            }
            File.WriteAllBytes(outFile, result);
        }

        // Carga la CRL demo (junto a la DLL) para embeber la revocacion del firmante,
        // ya que el certificado demo no tiene punto de distribucion de CRL (CDP) online.
        private ICrlClient? LoadDemoCrl()
        {
            try
            {
                string dir = System.IO.Path.GetDirectoryName(typeof(PdfService).Assembly.Location) ?? "";
                if (string.IsNullOrEmpty(dir)) dir = AppContext.BaseDirectory ?? "";
                string crlPath = System.IO.Path.Combine(dir, "demo.crl");
                return File.Exists(crlPath) ? new CrlClientOffline(File.ReadAllBytes(crlPath)) : null;
            }
            catch { return null; }
        }


        internal void CreateChainFromFile(String certFile, String password, String digestAlgorithm, ref IX509Certificate[]? chain, ref IExternalSignature? pks)
        {

            FileStream certStream = new FileStream(certFile, FileMode.Open, FileAccess.Read);
            try
            {
                Pkcs12Store pk12 = new Pkcs12StoreBuilder().Build();
                pk12.Load(certStream, password.ToCharArray());

                String alias = "";
                foreach (String tAlias in pk12.Aliases)
                {
                    if (pk12.IsKeyEntry(tAlias))
                    {
                        alias = tAlias;
                        break;
                    }
                }

                ICipherParameters pk = pk12.GetKey(alias).Key;
                X509CertificateEntry[] ce = pk12.GetCertificateChain(alias);
                chain = new IX509Certificate[ce.Length];
                for (int k = 0; k < ce.Length; ++k)
                {
                    chain[k] = new X509CertificateBC(ce[k].Certificate);
                }


                pks = new PrivateKeySignature(new PrivateKeyBC(pk), digestAlgorithm);


            }
            finally
            {
                certStream.Close();
            }

        }

        internal int GetNumberOfPages(string inputFile)
        {
            PdfReader reader = new PdfReader(inputFile);

            PdfDocument srcDoc = new PdfDocument(reader);
            int numberOfPages = srcDoc.GetNumberOfPages();
            srcDoc.Close();
            reader.Close();

            return numberOfPages;
        }
        public string GetLastError()
        {
            return errorText;
        }
        internal void ResetError()
        {
            errorText = "";
        }

    }
}