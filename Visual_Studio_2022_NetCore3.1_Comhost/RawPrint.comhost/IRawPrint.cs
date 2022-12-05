using System;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;


namespace RawPrint
{
    [ComVisible(true)]
    [Guid(ContractGuids.ServerInterface)]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    public interface IRawPrint
    {
    
        public void PrintRawFile(string printer, string path, bool paused);

        public void PrintRawFile(string printer, string path, string documentName, bool paused);

        public void PrintRawStream(string printer, Stream stream, string documentName, bool paused);

        public void PrintRawStream(string printer, Stream stream, string documentName, bool paused, int pagecount);

        //private bool IsXPSDriver(SafePrinter printer);

        //private void DocPrinter(SafePrinter printer, string documentName, string dataType, Stream stream, bool paused, int pagecount, string printerName);

        //private void PagePrinter(SafePrinter printer, Stream stream, int pagecount);
   
        //private void WritePrinter(SafePrinter printer, Stream stream);

    }
}
