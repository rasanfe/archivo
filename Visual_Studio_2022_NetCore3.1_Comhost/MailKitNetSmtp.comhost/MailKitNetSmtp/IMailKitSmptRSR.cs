using System;
using MimeKit;
using System.Runtime.InteropServices;

namespace MailKitNetSmtp
{
    [ComVisible(true)]
    [Guid(ContractGuids.ServerInterface)]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    public interface IMailKitSmptRSR
    {
        public int Send();
        public void SetMessage(string pbmessage, bool pbHTML);
        public void SetRecipientEmail(string pbRecipientName, string pbRecipientMail);
        public void SetCCRecipientEmail(string pbCCrecipientName, string pbCCrecipientMail);
        public void SetBCCRecipientEmail(string pbBCCrecipientName, string pbBCCrecipientMail);
        public void SetReplyToEmail(string pbReplytoName, string pbReplytoMail);
        public void SetSenderEmail(string pbSenderName, string pbSenderMail);
        public void SetSMTPServer(string pbsmtpserver);
        public void SetSubject(string pbsubject);
        public void SetAttachment(string pbattachment);
        public void SetCharSet(string pbcharset);
        public void SetUsernamePassword(string pbusername, string pbpassword);
        public void SetPort(int pbport);
        public void SetAuthMethod(int pbauthmethod);
        public void SetConnectionType(int pbconnecttype);
        public string GetLastErrorMessage();
        public void SetMailerName(string pbmailername);
        public void SetPriority(int pbpriority);
        public int SmtpConnect();
        public int SmtpSend();
        public int SmtpDisconnect();
    }
}
