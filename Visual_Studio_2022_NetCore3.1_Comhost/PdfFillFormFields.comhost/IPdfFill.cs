using System;
using System.Runtime.InteropServices;

namespace PdfFillFormFields
{
    [ComVisible(true)]
    [Guid(ContractGuids.ServerInterface)]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    public interface IPdfFill
    {
        public string FillFormFields(string inputFile, string outputFile, string[] fieldNames, string[] dataField);
        public string GetFormFields(string inputFile, ref string[] fieldNames);
       

    }
}