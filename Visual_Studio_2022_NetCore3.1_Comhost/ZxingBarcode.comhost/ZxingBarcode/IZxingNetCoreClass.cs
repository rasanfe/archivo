using System;
using System.Runtime.InteropServices;

namespace ZxingBarcode
{
    [ComVisible(true)]
    [Guid(ContractGuids.ServerInterface)]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    public interface IZxingNetCoreClass
    {
        public string ReadBarcode(string imageName);
        public string BarcodeGenerate(string source, string outputFile, int inFormat, int height, int width, bool pureBarcode, int margin);
    }
}
