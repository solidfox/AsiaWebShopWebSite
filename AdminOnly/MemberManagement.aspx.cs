using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Text;

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

            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
            {
                // start to connect sql server
                connection.Open();

                Int32 count = 0;
                int emailSentNum = 0;
                do
                {
                    SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [WishListItem] WHERE (([userName]= N'" + UserName.Text.Trim() + "') AND ([emailSent] = N'" + false + "')  AND ([isAlert] = N'" + true + "') AND ([userName] in (SELECT userName FROM [member] WHERE [active] = N'" + true + "')))", connection);
                    count = (Int32)command.ExecuteScalar();

                    if (count != 0)
                    {
                        SqlCommand test = new SqlCommand("SELECT upc FROM [WishListItem] WHERE (([userName]= N'" + UserName.Text.Trim() + "') AND ([emailSent] = N'" + false + "')  AND ([isAlert] = N'" + true + "') AND ([userName] in (SELECT userName FROM [member] WHERE [active] = N'" + true + "')))", connection);
                        String upcNum = test.ExecuteScalar().ToString().Trim();
                        SqlCommand name = new SqlCommand("SELECT name FROM [Item] WHERE (([upc] = N'" + upcNum + "'))", connection);
                        String itemName = name.ExecuteScalar().ToString().Trim();
                        SqlCommand userEmail = new SqlCommand("SELECT email FROM [member] WHERE (([userName] = N'" + UserName.Text.Trim() + "'))", connection);
                        String email = userEmail.ExecuteScalar().ToString().Trim();


                        EmailAlert instance = new EmailAlert();
                        bool isEmailSent = instance.sendEmail(email, itemName + " is now availiable. Come to AisaWebShop.", "Dear customer " + UserName.Text.Trim() + ":\n\n  "
                            + itemName + " is now on stock. Visit our website and You will find products you want are all in our shop.\n\nBest wishes, \nASiaWebShop");
                        if (isEmailSent == true)
                        {
                            SqlCommand alertEmailSent = new SqlCommand("UPDATE [WishListItem] SET [isAlert]=N'" + false + "' AND [emailSent]= N'" + true + "' WHERE (([upc] = N'" + upcNum + "') AND ([userName] = N'" + UserName.Text.Trim() + "'))", connection);
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
    private void ShowPopUpMsg(string msg)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("alert('");
        sb.Append(msg.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'"));
        sb.Append("');");
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showalert", sb.ToString(), true);
    }
}
