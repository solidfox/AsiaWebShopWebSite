using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MemberOnly_WishList_AddToWishList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String userName = User.Identity.Name;

        if (!Page.IsPostBack)
        {
            string upc = Request.QueryString["upc"].Trim();
            bool check = true;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
            {
                // Count how many existing records have the student id value.
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [WishListItem] WHERE (([userName] = N'" + userName + "') AND ([upc] = N'" + upc + "'))", connection);
                Int32 count = (Int32)command.ExecuteScalar();

                if (count != 0)
                {
                    //SqlCommand test = new SqlCommand("SELECT isAlert FROM [WishListItem] WHERE (([userName] = N'" + userName + "') AND ([upc] = N'" + upc + "'))", connection);
                    check = false;
                }
                connection.Close();
            }

            if (check)
            {
                // Create the connection and the SQL command.
                // Define the INSERT query with parameters.
                string query = "INSERT INTO [WishListItem]([userName], [upc])" +
                                       "VALUES (@userName, @upc)";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Define the INSERT query parameters and their values.
                    command.Parameters.AddWithValue("@UserName", userName);
                    command.Parameters.AddWithValue("@upc", upc);
                    //command.Parameters.AddWithValue("@emailSent", false);
                    //command.Parameters.AddWithValue("@isAlert", false);

                    // Open the connection, execute the INSERT query and close the connection.
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
                //ShowPopUpMsg("Alert added.");
                Response.Redirect("~/MemberOnly/WishList/WishListPage.aspx");
            }

            else
            {
                UserNotify.add = "Wish";
                Response.Redirect("~/ItemSearch.aspx");
            }
        }
    }
}