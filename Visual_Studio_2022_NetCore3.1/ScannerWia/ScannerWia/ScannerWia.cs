using System;
using System.Collections.Generic;
using System.Linq;
using WIA;
using System.IO;
using pdf = iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.parser;
using static iTextSharp.text.pdf.AcroFields;

namespace ScannerWia
{
    public class ScannerWia
    {
        public string errorText = "";
        const string WIA_FORMAT_BMP = "{B96B3CAB-0728-11D3-9D7B-0000F81EF32E}";
        const string WIA_FORMAT_PNG = "{B96B3CAF-0728-11D3-9D7B-0000F81EF32E}";
        const string WIA_FORMAT_GIF = "{B96B3CB0-0728-11D3-9D7B-0000F81EF32E}";
        const string WIA_FORMAT_JPEG = "{B96B3CAE-0728-11D3-9D7B-0000F81EF32E}";
        const string WIA_FORMAT_TIFF = "{B96B3CB1-0728-11D3-9D7B-0000F81EF32E}";

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
            var deviceManager = new DeviceManager();
            var uniqueScannerNames = new HashSet<string>();

            for (int i = 1; i <= deviceManager.DeviceInfos.Count; i++)
            {
                if (deviceManager.DeviceInfos[i].Type == WIA.WiaDeviceType.ScannerDeviceType)
                {
                    string scannerName = deviceManager.DeviceInfos[i].Properties["Name"].get_Value().ToString();
                    uniqueScannerNames.Add(scannerName);
                }
            }

            return uniqueScannerNames.ToArray();
        }


        public string Scan(string scanner, string format, string outputPath, string fileName)
        {

            DeviceInfo deviceInfo = GetScannerByName(scanner);

            var device = new Scanner(deviceInfo);

            if (device == null)
            {
                throw new ArgumentNullException("device", "Se debe proporcionar un dispositivo de escáner.");
            }
            else if (string.IsNullOrEmpty(fileName))
            {
                throw new ArgumentException("Se debe proporcionar un nombre de archivo.", "fileName");
            }

            
            ImageFile image = new ImageFile();
            string imageExtension = "";

            switch (format.ToUpper())
            {
                case "PNG":
                    image = device.ScanImage(WIA_FORMAT_PNG);
                    imageExtension = ".png";
                    break;
                case "JPEG":
                    image = device.ScanImage(WIA_FORMAT_JPEG);
                    imageExtension = ".jpeg";
                    break;
                case "BMP":
                    image = device.ScanImage(WIA_FORMAT_BMP);
                    imageExtension = ".bmp";
                    break;
                case "GIF":
                    image = device.ScanImage(WIA_FORMAT_GIF);
                    imageExtension = ".gif";
                    break;
                case "TIFF":
                    image = device.ScanImage(WIA_FORMAT_TIFF);
                    imageExtension = ".tiff";
                    break;
                case "PDF":
                    image = device.ScanImage(WIA_FORMAT_PNG);
                    imageExtension = ".png";
                    break;
                default:
                    throw new ArgumentException("Formato no válido. Formatos admitidos: PNG, JPEG, BMP, GIF, TIFF, PDF", "formato");

            }

            // Save the image
            var path = System.IO.Path.Combine(outputPath, fileName + imageExtension);

            if (File.Exists(path))
            {
                File.Delete(path);
            }

            image.SaveFile(path);

            if (format.ToUpper() == "PDF")
            {
                //Obtenemos el Nombre del PDF a partir del Nombre del PNG
                string pdfPath = System.IO.Path.GetDirectoryName(path) + "\\" + System.IO.Path.GetFileNameWithoutExtension(path) + ".pdf";

                if (File.Exists(pdfPath))
                {
                    File.Delete(pdfPath);
                }

                //Convertimos el PNG a PDF
                ConvertPDF(path, pdfPath);
                
                //Eliminamos Imagen Escaneada (PNG)
                File.Delete(path);

                //Cambio la Ruta de la Imagen por la del PDF
                path = pdfPath;

            }

            // If needed, return the path to the saved image
            return path;
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
    }
}
