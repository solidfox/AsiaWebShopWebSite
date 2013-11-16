using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;  // Add the System.Net.Mail namespace to the project to allow use of the mail sending functionality.

public partial class AdminOnly_EmailAlert_EmailAlert : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Create an instance of MailMessage named mail.
        MailMessage mail = new MailMessage();

        // Create an instance of SmtpClient named emailServer and set the mail server to use as "smtp.cse.ust.hk".
        SmtpClient emailServer = new SmtpClient("smtp.cse.ust.hk");

        // Set the sender (From), receiver (To), subject and message body fields of the mail message.
        mail.From = new MailAddress("mycheungac@cse.ust.hk", "AsiaWebShop");
        mail.To.Add("mycheungac@stu.ust.hk");
        mail.Subject = "Email Alert About the Quanity of Item You have booked";
        mail.Body = "Buy it Now!";

        // Send the message.
        emailServer.Send(mail);
    }
}