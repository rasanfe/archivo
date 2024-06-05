using System;
using System.Collections.Generic;
using System.Linq;
using WIA;
using System.IO;
using pdf = iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.parser;
using static iTextSharp.text.pdf.AcroFields;
using System.Reflection;
using iTextSharp.text;

namespace ScannerWia
{
    public class ScannerWia
    {
        const string WIA_FORMAT_BMP = "{B96B3CAB-0728-11D3-9D7B-0000F81EF32E}";
        const string WIA_FORMAT_PNG = "{B96B3CAF-0728-11D3-9D7B-0000F81EF32E}";
        const string WIA_FORMAT_GIF = "{B96B3CB0-0728-11D3-9D7B-0000F81EF32E}";
        const string WIA_FORMAT_JPEG = "{B96B3CAE-0728-11D3-9D7B-0000F81EF32E}";
        const string WIA_FORMAT_TIFF = "{B96B3CB1-0728-11D3-9D7B-0000F81EF32E}";
        private string _errorText = "";
        private int pageIndex = 1;

        private DeviceManager deviceManager;

        public ScannerWia()
        {
            deviceManager = new DeviceManager();
        }

        private DeviceInfo GetScannerByName(string scannerName)
        {
            // Buscar el escáner por nombre dentro de la lista de dispositivos
            return deviceManager.DeviceInfos
                .Cast<DeviceInfo>()
                .FirstOrDefault(deviceInfo => ((DeviceInfo)deviceInfo).Properties["Name"].get_Value().ToString() == scannerName);
        }
        public string[] ListScanners()
        {
            try
            {
                var deviceManager = new DeviceManager();
                var uniqueScannerNames = new HashSet<string>();

                for (int i = 1; i <= deviceManager.DeviceInfos.Count; i++)
                {
                    if (deviceManager.DeviceInfos[i].Type == WiaDeviceType.ScannerDeviceType)
                    {
                        string scannerName = deviceManager.DeviceInfos[i].Properties["Name"].get_Value().ToString();
                        uniqueScannerNames.Add(scannerName);
                    }
                }

                return uniqueScannerNames.ToArray();
            }
            catch (Exception ex)
            {
                _errorText = ex.Message;
                throw new Exception(_errorText);
            }
        }


        public string[] Scan(string scanner, string format, string outputPath, string fileName)
        {

            try
            {
                _errorText = "";
                DeviceInfo deviceInfo = GetScannerByName(scanner);
                //VAriables para pdf multiples:
                byte[] pdfbyte = null;
                byte[] mergedPdfbyte = null;

                var device = new Scanner(deviceInfo);

                if (device == null)
                {
                    _errorText = "Se debe proporcionar un dispositivo de escáner.";
                    throw new ArgumentNullException("device", _errorText);
                }
                else if (string.IsNullOrEmpty(fileName))
                {
                    _errorText = "Se debe proporcionar un nombre de archivo.";
                    throw new ArgumentException(_errorText, "fileName");
                }


                //ImageFile image = new ImageFile();
                List<ImageFile> images = new List<ImageFile>();
                List<string> imagePaths = new List<string>();
                string imageExtension = "";
                string wiaFormat = "";

                switch (GetFirstFourNonSpaceUpperChar(format))
                {
                    case "PNG":
                        wiaFormat = WIA_FORMAT_PNG;
                        imageExtension = ".png";
                        break;
                    case "JPEG":
                        wiaFormat = WIA_FORMAT_JPEG;
                        imageExtension = ".jpeg";
                        break;
                    case "BMP":
                        wiaFormat = WIA_FORMAT_BMP;
                        imageExtension = ".bmp";
                        break;
                    case "GIF":
                        wiaFormat = WIA_FORMAT_GIF;
                        imageExtension = ".gif";
                        break;
                    case "TIFF":
                        wiaFormat = WIA_FORMAT_TIFF;
                        imageExtension = ".tiff";
                        break;
                    case "PDF":
                        wiaFormat = WIA_FORMAT_PNG;
                        imageExtension = ".png";
                        break;
                    default:
                        _errorText = "Formato no válido. Formatos admitidos: PNG, JPEG, BMP, GIF, TIFF, PDF";
                        throw new ArgumentException(_errorText, "formato");

                }

                // Scan multiple pages
                images = device.ScanImages(wiaFormat);


                // Save single images
                pageIndex = 1;
                string singleImagePath = "";

                foreach (var image in images)
                {
                   
                    //Caso especial para hacer PDF
                    if (format == "PDF (Página única)")
                    {
                        singleImagePath = System.IO.Path.Combine(outputPath, $"{fileName}_{pageIndex}.pdf");

                        if (File.Exists(singleImagePath))
                        {
                            File.Delete(singleImagePath);
                        }

                        singleImagePath = ImageToPdf(image, singleImagePath);
                     
                    }
                    else if (format == "PDF (Páginas múltiples)")
                    {
                        singleImagePath = System.IO.Path.Combine(outputPath, $"{fileName}.pdf");

                        if (File.Exists(singleImagePath))
                        {
                            File.Delete(singleImagePath);
                        }

                        //Creamos un PDF en memoria y vamos acumulandoc ada imagen escaneada como una nueva página.
                        pdfbyte = ImageToPdfByte(image);
                        mergedPdfbyte = MergePdf(pdfbyte, mergedPdfbyte);

                    }
                    else
                    {
                        singleImagePath = System.IO.Path.Combine(outputPath, $"{fileName}_{pageIndex}{imageExtension}");

                        if (File.Exists(singleImagePath))
                        {
                            File.Delete(singleImagePath);
                        }

                        image.SaveFile(singleImagePath);
                        
                    }
                    pageIndex++;
                    imagePaths.Add(singleImagePath);


                }

                //Si es un PDF de Págianas Multiples lo Guardo en Disco
                if (format == "PDF (Páginas múltiples)")
                {
                    File.WriteAllBytes(singleImagePath, mergedPdfbyte);
                }

                return imagePaths.ToArray();
            }
            catch (Exception ex)
            {
                _errorText = ex.Message;
                throw new Exception(_errorText);
            }
        }

        internal string GetFirstFourNonSpaceUpperChar(string input)
        {
            // Obtener los primeros 4 caracteres
            string firstFour = input.Length >= 4 ? input.Substring(0, 4) : input;

            // Eliminar los espacios y caracteres no alfanuméricos
            string noSpacesString = firstFour.Trim();

            // Convertir a mayúsculas
            string upperString = firstFour.Trim();

            return upperString;
        }

        internal static byte[] ConvertWiaImageToByteArray(ImageFile imageFile)
        {
            MemoryStream ms = new MemoryStream(imageFile.FileData.get_BinaryData());
            byte[] byteArray = new byte[ms.Length];
            for (int count = 0; count < ms.Length; count++)
            {
                byteArray[count] = (byte)ms.ReadByte();
            }
            return byteArray;
        }

        internal byte[] ImageToPdfByte(byte[] imageBytes)
        {

            using (MemoryStream outputPdfStream = new MemoryStream())
            {
                using (Document document = new Document(PageSize.A4))
                {
                    PdfWriter writer = PdfWriter.GetInstance(document, outputPdfStream);
                    document.Open();

                    // Create image from byte array
                    iTextSharp.text.Image image = iTextSharp.text.Image.GetInstance(imageBytes);

                    // Set image to fit A4 size
                    image.SetAbsolutePosition(0, 0); // Bottom-left corner
                    image.ScaleAbsolute(PageSize.A4.Width, PageSize.A4.Height); // Scale to A4 size

                    document.Add(image);
                }

                return outputPdfStream.ToArray();
            }

        }

        internal byte[] ImageToPdfByte(ImageFile imageFile)
        {

            byte[] byteArray = ConvertWiaImageToByteArray(imageFile);
            byte[] pdfFilebyte = ImageToPdfByte(byteArray);
            return pdfFilebyte;

        }
        internal string ImageToPdf(byte[] imageBytes, string pdfFileName)
        {
            string pdfFilePath = pdfFileName;//System.IO.Path.Combine(System.IO.Path.GetTempPath(), $"{pdfFileName}.pdf");

            byte[] pdfbyte = ImageToPdfByte(imageBytes);

            File.WriteAllBytes(pdfFileName, pdfbyte);

            return pdfFilePath;
        }

        internal string ImageToPdf(ImageFile imageFile, string pdfFileName)
        {
            byte[] byteArray = ConvertWiaImageToByteArray(imageFile);
            string pdfFile = ImageToPdf(byteArray, pdfFileName);
            return pdfFile;
        }

        internal static byte[] MergePdf(byte[] sourcePdf, byte[] accumulatedPdf)
        {
            using (MemoryStream outputStream = new MemoryStream())
            {
                Document document = new Document();
                PdfCopy pdfCopy = new PdfCopy(document, outputStream);
                document.Open();

                // Añadir el PDF acumulado si no está vacío
                if (accumulatedPdf != null && accumulatedPdf.Length > 0)
                {
                    AddPdfToCopy(accumulatedPdf, pdfCopy);
                }

                // Añadir el nuevo PDF
                if (sourcePdf != null && sourcePdf.Length > 0)
                {
                    AddPdfToCopy(sourcePdf, pdfCopy);
                }

                document.Close();
                return outputStream.ToArray();
            }
        }

        internal static void AddPdfToCopy(byte[] pdfBytes, PdfCopy pdfCopy)
        {
            using (MemoryStream pdfStream = new MemoryStream(pdfBytes))
            {
                PdfReader pdfReader = new PdfReader(pdfStream);
                for (int i = 1; i <= pdfReader.NumberOfPages; i++)
                {
                    PdfImportedPage page = pdfCopy.GetImportedPage(pdfReader, i);
                    pdfCopy.AddPage(page);
                }
                pdfCopy.FreeReader(pdfReader);
                pdfReader.Close();
            }
        }

        public void ConvertPDF(string imagePath, string pdfPath)
{
    try
    {
        // Crear un nuevo documento PDF con tamaño de página A4
        pdf.Document document = new pdf.Document(pdf.PageSize.A4);
        PdfWriter.GetInstance(document, new FileStream(pdfPath, FileMode.Create));

        // Abrir el documento
        document.Open();

        // Cargar la imagen desde el archivo
        pdf.Image image = pdf.Image.GetInstance(imagePath);

        // Establecer el tamaño absoluto de la imagen para que coincida con el tamaño de la página
        image.SetAbsolutePosition(0, 0); // Posicionar la imagen en la esquina superior izquierda
        image.ScaleAbsolute(pdf.PageSize.A4.Width, pdf.PageSize.A4.Height);

        // Agregar la imagen al documento PDF
        document.Add(image);

        // Cerrar el documento
        document.Dispose();
        document.Close();
    }
    catch (Exception ex)
    {
        throw new Exception("Ha ocurrido un error: " + ex.Message);

    }

}

        public string GetErrorText()
        {
            return _errorText;
        }

        public int GetPageCount()
        {
            return pageIndex - 1;
        }

    }

}
