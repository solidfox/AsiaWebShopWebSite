using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;
using System.Text;

public partial class ItemManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void dvItem_ItemDeleted(object sender, EventArgs e)
    {
        gvItem.DataBind();
    }

    protected void dvItem_ItemInserted(object sender, EventArgs e)
    {
        gvItem.DataBind();
    }

    protected void dvItem_ItemUpdated(object sender, EventArgs e)
    {
        FileUpload FileUploadPicture = (FileUpload)dvItem.FindControl("pictureFileUpload");
        if (FileUploadPicture.HasFile)
        {
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
            {
                // Get the value of the new UPC from the DetailsView control.
                Label txtUPC = (Label)dvItem.FindControl("EditUPC");

                // Count how many existing records have the student id value.
                connection.Open();

                SqlCommand command = new SqlCommand("UPDATE [Item] SET [picture]=@picture WHERE ([upc] = N'" + txtUPC.Text + "')", connection);
                command.Parameters.AddWithValue("@picture", FileUploadPicture.FileBytes);
                command.ExecuteScalar();
                connection.Close();

            }
        }

        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            Label UPC = (Label)dvItem.FindControl("EditUPC");
            connection.Open();
            SqlCommand quanNum = new SqlCommand("SELECT quantityAvailable FROM [item] WHERE ([upc] = N'" + UPC.Text + "')", connection);
            Int32 num = (Int32)quanNum.ExecuteScalar();
            connection.Close();
            if (num != 0)
                sendEmail(UPC.Text);
        }

        gvItem.DataBind();
    }

    protected bool sendEmail(string upc)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            // start to connect sql server
            connection.Open();

            Int32 count = 0;
            int emailSentNum = 0;
            do
            {
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [WishListItem] WHERE (([upc] = N'" + upc + "') AND ([emailSent] = N'" + false + "')  AND ([isAlert] = N'" + true + "') AND ([userName] in (SELECT userName FROM [member] WHERE [active] = N'" + true + "')))", connection);
                count = (Int32)command.ExecuteScalar();

                if (count != 0)
                {
                    SqlCommand test = new SqlCommand("SELECT userName FROM [WishListItem] WHERE (([upc] = N'" + upc + "') AND ([emailSent] = N'" + false + "')  AND ([isAlert] = N'" + true + "') AND ([userName] in (SELECT userName FROM [member] WHERE [active] = N'" + true + "')))", connection);
                    String customerName = test.ExecuteScalar().ToString().Trim();
                    SqlCommand name = new SqlCommand("SELECT name FROM [Item] WHERE (([upc] = N'" + upc + "'))", connection);
                    String itemName = name.ExecuteScalar().ToString().Trim();
                    SqlCommand userEmail = new SqlCommand("SELECT email FROM [member] WHERE (([userName] = N'" + customerName + "'))", connection);
                    String email = userEmail.ExecuteScalar().ToString().Trim();


                    EmailAlert instance = new EmailAlert();
                    bool isEmailSent = instance.sendEmail(email, itemName + " is now availiable. Come to AisaWebShop.", "Dear customer " + customerName + ":\n\n  "
                        + itemName + " is now on stock. Visit our website and You will find products you want are all in our shop.\n\nBest wishes, \nASiaWebShop");
                    if (isEmailSent == true)
                    {
                        SqlCommand alertEmailSent = new SqlCommand("UPDATE [WishListItem] SET [isAlert]= N'" + false + "', [emailSent]= N'" + true + "' WHERE (([upc] = N'" + upc + "') AND ([userName] = N'" + customerName + "'))", connection);
                        alertEmailSent.ExecuteScalar();
                        emailSentNum++;
                    }
                    else
                    {
                        ShowPopUpMsg("Email can't be sent");
                    }
                }
            } while (count != 0);

            if (emailSentNum != 0)
                ShowPopUpMsg(emailSentNum + " email(s) are sent");
            connection.Close();

        }
        return true;
    }

    protected void cvInsertUPC_ServerValidate(object source, ServerValidateEventArgs args)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            // Get the value of the new student id from the DetailsView control.
            TextBox insertedUPC = (TextBox)dvItem.FindControl("InsertUPC");

            // Count how many existing records have the student id value.
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Item] WHERE ([upc] = '" + insertedUPC.Text + "')", connection);
            Int32 count = (Int32)command.ExecuteScalar();
            connection.Close();

            // If the count is not zero the student id already exists, so cancel the insert.
            if (count != 0)
            {
                args.IsValid = false;
            }
        }
    }
    protected void cvEditCategory_ServerValidate(object source, ServerValidateEventArgs args)
    {
        String insertedCategory = ((TextBox)dvItem.FindControl("EditCategory")).Text;

        if (!validCategory(insertedCategory))
        {
            args.IsValid = false;
        }
    }
    protected void cvInsertCategory_ServerValidate(object source, ServerValidateEventArgs args)
    {
        String insertedCategory = ((TextBox)dvItem.FindControl("InsertCategory")).Text;

        if (!validCategory(insertedCategory))
        {
            args.IsValid = false;
        }
    }
    protected bool validCategory(String category)
    {
        switch (category.Trim())
        {
            case "Appliances":
            case "Baby and Children":
            case "Computers and Electronics":
            case "Jewelry and Watches":
            case "Luggage":
            case "Men":
            case "Toys and Games":
            case "Women":
                return true;
        }
        return false;
    }
    protected void pictureFileUpload_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = false;

        String filename = args.Value;
        Match jpgMatch = Regex.Match(filename, @".+\.(jpg|jpeg)$", RegexOptions.IgnoreCase);
        if (jpgMatch.Success)
        {
            FileUpload theFile = (FileUpload)dvItem.FindControl("pictureFileUpload");

            //Header of JPG:"FF D8"   So,FileBytes[0]=255,FileBytes[1]=216
            if (theFile.FileBytes[0] == 255 && theFile.FileBytes[1] == 216)
            {
                double filesize = theFile.FileContent.Length;
                if (filesize < 512000)
                {
                    args.IsValid = true;
                }
            }
            
        }
        
    }
    private void ShowPopUpMsg(string msg)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("alert('");
        sb.Append(msg.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'"));
        sb.Append("');");
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showalert", sb.ToString(), true);
    }
}