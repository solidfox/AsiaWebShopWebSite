using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;  // Add the System.Net.Mail namespace to the project to allow use of the mail sending functionality.


    public class EmailAlert
    {
        public bool sendEmail(string receiver, string subject, string body)
        {
            try
            {
                // Create an instance of MailMessage named mail.
                MailMessage mail = new MailMessage();

                // Create an instance of SmtpClient named emailServer and set the mail server to use as "smtp.cse.ust.hk".
                SmtpClient emailServer = new SmtpClient("smtp.cse.ust.hk");

                // Set the sender (From), receiver (To), subject and message body fields of the mail message.
                mail.From = new MailAddress("mycheungac@cse.ust.hk", "AsiaWebShop");
                mail.To.Add(receiver);
                mail.Subject = subject;
                mail.Body = body;
                mail.IsBodyHtml = true;

                // Send the message.
                emailServer.Send(mail);
                return true;
            }
            catch (Exception ex)
            {
                //Response.Write("Could not send the e-mail - error: " + ex.Message);
                return false;
            }
        }
    }

    /*
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            // Create an instance of MailMessage named mail.
            MailMessage mail = new MailMessage();

            // Create an instance of SmtpClient named emailServer and set the mail server to use as "smtp.cse.ust.hk".
            SmtpClient emailServer = new SmtpClient("smtp.cse.ust.hk");

            // Set the sender (From), receiver (To), subject and message body fields of the mail message.
            mail.From = new MailAddress("mycheungac@cse.ust.hk", "AsiaWebShop");
            mail.To.Add("mycheungac@cse.ust.hk");
            mail.Subject = "Email Alert About the Quanity of Item You have booked";
            mail.Body = "Buy it Now!";

            // Send the message.
            emailServer.Send(mail);
            //return true;
        }
        catch (Exception ex)
        {
            Response.Write("Could not send the e-mail - error: " + ex.Message);
            //return false;
        }
    }
        */

