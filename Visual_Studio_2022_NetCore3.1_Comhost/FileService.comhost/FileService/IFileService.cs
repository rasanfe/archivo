using System;
using System.Runtime.InteropServices;

namespace FileService
{
    [ComVisible(true)]
    [Guid(ContractGuids.ServerInterface)]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    public interface IFileService
    {
        public string GetFilename(string fileInput);
        public string GetExtension(string fileInput);
        public string GetFileNameWithoutExtension(string fileInput);

        public string ChangeExtension(string fileInput, string extension);

        public string GetDirectoryName(string fileInput);

        public bool EndsInDirectorySeparator(string fileInput);

        public bool FileRename(string fileInput, string newFile);

    }
}
