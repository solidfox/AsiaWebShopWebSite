using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;


using System.Data.SqlClient;
using System.Configuration;
using System.Data;


public partial class AdminOnly_MemberManagement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


    }
    protected void EnableButton_Click(object sender, EventArgs e)
    {
        MembershipUser user = Membership.GetUser(UserName.Text.Trim());
        if (user != null)
        {
            user.IsApproved = true;
            Membership.UpdateUser(user);
           
            string connectionString = "AsiaWebShopDBConnectionString";
            string query = "UPDATE [Member]"+ "SET [active]="+ 1 +"WHERE ([username] =N'" + UserName.Text.Trim() + "')";
            // Create the connection and the SQL command.
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                // Open the connection, execute the INSERT query and close the connection.
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }


            MemberGridView.DataBind();

        }
    
        
    }
    protected void DisableButton_Click(object sender, EventArgs e)
    {

        MembershipUser user = Membership.GetUser(UserName.Text.Trim());
        if (user != null)
        {
            user.IsApproved = false;
            Membership.UpdateUser(user);

            string connectionString = "AsiaWebShopDBConnectionString";
            string query = "UPDATE [Member]" + "SET [active]=" + 0 + "WHERE ([username] =N'" + UserName.Text.Trim() + "')";
            // Create the connection and the SQL command.
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                // Open the connection, execute the INSERT query and close the connection.
                command.Connection.Open();
                command.ExecuteNonQuery();
                command.Connection.Close();
            }

            MemberGridView.DataBind();
        }

    }


    protected void MemberCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        MembershipUser user = Membership.GetUser(UserName.Text.Trim());

        if (user != null)
        {
            args.IsValid = true;
        }
        else
            args.IsValid = false;
    }

    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {

        UserName.Text = MemberGridView.SelectedDataKey.Value.ToString();
       
       
    }
}
