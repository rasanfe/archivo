using System;
using System.Runtime.InteropServices;

namespace SecurityProject
{
   [ComVisible(true)]
   [Guid(ContractGuids.ServerInterface)]
   [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    public interface ISecurity
    {
        public string Encrypt(string source, string key, string iv);
        public string Decrypt(string source, string key, string iv);
        public bool GetToken(string token, string masterKey, string masterIv, ref string key, ref string iv);
        

    }
}
