using System;
using System.Runtime.InteropServices;


namespace NetCoderObject
{
    [ComVisible(true)]
    [Guid(ContractGuids.ServerInterface)]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    public interface ICoderObject
    {
        public string Base64Encode(Byte[] bytes);
        public Byte[] Base64Decode(string encoded);
        public string Base64UrlEncode(Byte[] bytes);
        public Byte[] Base64UrlDecode(string encodedUrl);
        public string HexEncode(Byte[] bytes);
        public Byte[] HexDecode(string hexString);
        public string Base32Encode(Byte[] bytes);
        public Byte[] Base32Decode(string encoded);


    }

}
