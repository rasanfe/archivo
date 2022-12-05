using System;
using System.Runtime.InteropServices;

namespace NetPdfService
{
    [ComVisible(true)]
    [Guid(ContractGuids.ServerInterface)]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    public interface IPdfService
    {
        public void FirmaVisual(string inFile, string outFile, string certFile, string password, string reason, string location, string contact, string imgeFile, int x1, int y1, int x2, int y2, string nombre, string dni);
        public void FirmaNoVisual(string inFile, string outFile, string certFile, string password, string reason, string location, string contact);
        public string GetLastError();

    }
}
