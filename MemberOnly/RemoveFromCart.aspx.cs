using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RemoveFromCart : System.Web.UI.Page
{
    public static string connectionString = "AsiaWebShopDBConnectionString";
    protected void Page_Load(object sender, EventArgs e)
    {
        // Get the upc from the query string.
        string upc = Request.QueryString["upc"].Trim();
        string userName = User.Identity.Name;
        // Remove the item from the shopping cart.
        if (upc != "")
        {
            ShoppingCart cart = ShoppingCart.GetShoppingCart(userName);
            cart.RemoveItem(upc);
            /******
            * TODO: Remove the item from the shopping cart in the database.
            */
            int OrderNum = GetOrderNumber(connectionString, userName);
            RemoveFromDBOrderItem(connectionString, upc, OrderNum);
            // Save the shopping cart in the Session variable "MyShoppingCart".
            HttpContext.Current.Session["MyShoppingCart"] = cart;
        }
        else
        {
            Debug.Fail("ERROR : We should never get to RemoveFromCart.aspx without a UPC.");
            throw new Exception("ERROR : It is illegal to load RemoveFromCart.aspx without setting a UPC.");
        }

        // View the shopping cart.
        Response.Redirect("~/MemberOnly/ViewShoppingCart.aspx");

    }

    public void RemoveFromDBOrderItem(string connectionString, string UPC, int OrderNum) 
    {
        //query
        string query = "DELETE FROM [OrderItem] WHERE ([upc] = N'" + UPC + "' AND [orderNum] = N'" + OrderNum + "')";
        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Open the connection.
            command.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            command.ExecuteReader();
            // Check if a result was returned.
            command.Connection.Close();
        }
    }

    public int GetOrderNumber(string connectionString, string userName)
    {
        string query = "SELECT [orderNum], [confirmationNumber] FROM [Order] WHERE ([username] =N'" + userName + "')";
        int OrderNum = 0;
        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Open the connection.
            command.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            SqlDataReader reader = command.ExecuteReader();
            // Check if a result was returned.
            if (reader.HasRows)
            {
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    // ToAsk: what happens when there are two rows ?
                    if (reader.IsDBNull(1))
                    {
                        OrderNum = int.Parse(reader["orderNum"].ToString());
                    }

                }
                command.Connection.Close(); // Close the connection and the DataReader.
                reader.Close();
            }
        }
        return OrderNum;
    }
}