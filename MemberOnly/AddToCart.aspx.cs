using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddToCart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Get the upc, item name and discount price from the query string.
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;
        //string OrderNum = GetOrderNumber(connectionString, userName);
        int OrderNum = GetOrderNumber(connectionString, userName);

        string upc = Request.QueryString["upc"].Trim();
        string name = Request.QueryString["name"].Trim();
        decimal discountPrice = Convert.ToDecimal(Request.QueryString["discountPrice"].Trim());

        // Add the item to the shopping cart with default quantity = 1.
        if (upc != "")
        {
            ShoppingCart cart = ShoppingCart.GetShoppingCart();
            cart.AddItem(upc, name, discountPrice);
            ///TODO: Add the item to the shopping cart in the database.
            InsertToShoppingCart (connectionString, cart, OrderNum, upc, name, discountPrice);
            // Save the shopping cart in the Session variable "MyShoppingCart".
            HttpContext.Current.Session["MyShoppingCart"] = cart;
        }
        else
        {
            Debug.Fail("ERROR : We should never get to AddToCart.aspx without a UPC.");
            throw new Exception("ERROR : It is illegal to load AddToCart.aspx without setting a UPC.");
        }

        // View the shopping cart.
        Response.Redirect("~/MemberOnly/ViewShoppingCart.aspx");

    }

    private void InsertToShoppingCart(string connectionString, ShoppingCart cart, int OrderNum, string upc, string name, decimal discountPrice)
    {
        int quantity = cart.GetItemQuantity(upc);
        string query = "INSERT INTO [OrderItem] ([orderNum], [upc], [quantity], [PriceWhenAdded], [removed])" +
                       "VALUES (@OrderNumber, @UPC, @Quantity, @Price, @removed)";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@OrderNumber", OrderNum);
            command.Parameters.AddWithValue("@UPC", upc);
            command.Parameters.AddWithValue("@Quantity", quantity);
            command.Parameters.AddWithValue("@Price", discountPrice);
            command.Parameters.AddWithValue("@removed", 1);
            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }

    }

    public int GetOrderNumber (string connectionString, string userName) 
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

            else
            {
                command.Connection.Close(); // Close the connection and the DataReader.
                reader.Close();
                GenerateOrderNumber(connectionString, userName);
                OrderNum = GetOrderNumber (connectionString, userName);
            }
        }
        return OrderNum;
    }

    protected void GenerateOrderNumber (string connectionString, string userName )
    {
        // Define the UPDATE query with parameters.
        string query = "INSERT INTO [Order] ( [userName])" +
                       "VALUES ( @Username)";
        //string orderNum = DateTime.Now.ToString("yyyyMMddHHmmss");  //later, may relate to username
        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            //command.Parameters.AddWithValue("@OrderNumber", orderNum);
            command.Parameters.AddWithValue("@Username", userName);
            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }
}