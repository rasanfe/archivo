using System;
using System.Collections.Generic;
using iTextSharp.text.pdf;
using iTextSharp.text;
using iTextSharp.text.exceptions;
using System.IO;
using System.Runtime.InteropServices;



namespace SplitMergePdf
{
    [ComVisible(true)]
    [Guid(ContractGuids.ServerInterface)]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    public interface ISplitMerge
    {
        public bool MergeFiles(string[] fileNames, string targetPdf);
        public int SplitFiles(string inputPath, string outputPath);
      
    }
}
