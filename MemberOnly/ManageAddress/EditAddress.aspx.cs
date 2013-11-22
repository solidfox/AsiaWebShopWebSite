using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class MemberOnly_ManageDeliveryAddress_EditAddress : System.Web.UI.Page
{
    String userName;
    protected void Page_Load(object sender, EventArgs e)
    {
        userName = User.Identity.Name;
        DeliveryAddressList.SelectParameters["userName"].DefaultValue = User.Identity.Name;
        SelectedDeliveryAddress.InsertParameters["userName"].DefaultValue = User.Identity.Name;
        // Bug with district selection
        SelectedDeliveryAddress.UpdateParameters["district"].DefaultValue = "Central and Western";
    }
    protected void dvAddress_ItemDeleted(object sender, EventArgs e)
    {
        gvAddress.DataBind();
    }

    protected void dvAddress_ItemInserted(object sender, EventArgs e)
    {
        gvAddress.DataBind();
    }

    protected void dvAddress_ItemUpdated(object sender, EventArgs e)
    {
        gvAddress.DataBind();
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            // Get the value of the new student id from the DetailsView control.
            TextBox AddressList = (TextBox)dvAddress.FindControl("InsertNickName");

            // Count how many existing records have the student id value.
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Address] WHERE (([nickname] = N'" + AddressList.Text + "') AND ([userName] = N'" + userName + "'))", connection);
            Int32 count = (Int32)command.ExecuteScalar();
            connection.Close();

            // If the count is not zero the student id already exists, so cancel the insert.
            if (count != 0)
            {
                args.IsValid = false;
            }
        }
    }
}