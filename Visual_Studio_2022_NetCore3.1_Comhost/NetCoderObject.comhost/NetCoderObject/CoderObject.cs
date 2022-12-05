using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;
using System.Runtime.InteropServices;


namespace NetCoderObject
{
    [ComVisible(true)]
    [Guid(ContractGuids.ServerClass)]
    public class CoderObject : ICoderObject
    {
        public CoderObject() { }
        public string Base64Encode(Byte[] bytes)
        {
            try
            {
                string encoded = Convert.ToBase64String(bytes);

                return encoded;
            }
            catch (Exception ex)
            {
                return string.Empty;
            }
        }
        public Byte[] Base64Decode(string encoded)
        {
            try
            {
                string archivoTemp = Path.GetTempFileName();
                Byte[] bytes = Convert.FromBase64String(encoded);
                File.WriteAllBytes(archivoTemp, bytes);
                File.Delete(archivoTemp);
                return bytes;
            }
            catch (Exception ex)
            {
                Byte[] bytes = { 0 };
                return bytes;
            }
        }
        public string Base64UrlEncode(Byte[] bytes)
        {
            try
            {
                string base64Encoded = Base64Encode(bytes);

                string encoded = base64Encoded.Replace("+", "-").Replace("/", "_");

                return encoded;
            }
            catch (Exception ex)
            {
                return string.Empty;
            }
        }
        public Byte[] Base64UrlDecode(string encodedUrl)
        {
            try
            {
                string encoded = encodedUrl.Replace("-", "+").Replace("_", "/");

                Byte[] bytes = Base64Decode(encoded);

                return bytes;
            }
            catch (Exception ex)
            {
                Byte[] bytes = { 0 };
                return bytes;
            }
        }
        public string HexEncode(Byte[] bytes)
        {
            try
            {
                string hexString = BitConverter.ToString(bytes);

                hexString = hexString.Replace("-", "");

                return hexString;
            }
            catch (Exception ex)
            {
                return string.Empty;
            }
        }
        public Byte[] HexDecode(string hexString)
        {
            try
            {

                Byte[] bytes = Enumerable.Range(0, hexString.Length)
                     .Where(x => x % 2 == 0)
                     .Select(x => Convert.ToByte(hexString.Substring(x, 2), 16))
                     .ToArray();

                return bytes;
            }
            catch (Exception ex)
            {
                Byte[] bytes = { 0 };
                return bytes;
            }
        }
        public string Base32Encode(Byte[] bytes)
        {
            try
            {
                const string alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
                string encoded = "";
                for (int bitIndex = 0; bitIndex < bytes.Length * 8; bitIndex += 5)
                {
                    int dualbyte = bytes[bitIndex / 8] << 8;
                    if (bitIndex / 8 + 1 < bytes.Length)
                        dualbyte |= bytes[bitIndex / 8 + 1];
                    dualbyte = 0x1f & (dualbyte >> (16 - bitIndex % 8 - 5));
                    encoded += alphabet[dualbyte];
                }

                return encoded;
            }
            catch (Exception ex)
            {
                return string.Empty;
            }
        }
        public Byte[] Base32Decode(string encoded)
        {
            try
            {
                const string alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
                List<byte> output = new List<byte>();
                char[] bytes = encoded.ToCharArray();
                for (int bitIndex = 0; bitIndex < encoded.Length * 5; bitIndex += 8)
                {
                    int dualbyte = alphabet.IndexOf(bytes[bitIndex / 5]) << 10;
                    if (bitIndex / 5 + 1 < bytes.Length)
                        dualbyte |= alphabet.IndexOf(bytes[bitIndex / 5 + 1]) << 5;
                    if (bitIndex / 5 + 2 < bytes.Length)
                        dualbyte |= alphabet.IndexOf(bytes[bitIndex / 5 + 2]);

                    dualbyte = 0xff & (dualbyte >> (15 - bitIndex % 5 - 8));
                    output.Add((byte)(dualbyte));
                }
                Byte[] bytesOut = output.ToArray();
                return bytesOut;
            }
            catch (Exception ex)
            {
                Byte[] bytesOut = { 0 };
                return bytesOut;
            }
        }


    }

}
