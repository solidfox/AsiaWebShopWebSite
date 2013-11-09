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

public partial class ItemManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void DetailsView1_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
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

        gvItem.DataBind();
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
            double filesize = theFile.FileContent.Length;
            if (filesize < 512000)
            {
                args.IsValid = true;
            }
        }
        
    }
}