using System;
using System.Runtime.InteropServices;

namespace COMServer
{
    [ComVisible(true)]
    [Guid(ContractGuids.ServerClass)]
    public interface IServer
    {
        public double ComputePi();
        
    }
}
