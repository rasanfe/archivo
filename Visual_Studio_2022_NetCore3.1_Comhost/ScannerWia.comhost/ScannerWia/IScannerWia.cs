using System;
using System.Runtime.InteropServices;
using WIA;

namespace ScannerWia
{
    [ComVisible(true)]
    [Guid(ContractGuids.ServerInterface)]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    public interface IScannerWia
    {
        public string[] ListScanners();
        public string Scan(string scanner, string format, string outputPath, string fileName);

        public void ConvertPDF(string imagePath, string pdfPath);


    }
}
