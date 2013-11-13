using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for RemoveCart
/// </summary>
public class RemoveCart
{
    private static string connectionString = "AsiaWebShopDBConnectionString";

	public RemoveCart (ShoppingCart cart,string UserName, string upc, bool inactivity)
	{
            if (upc != "")
            {
                /******
                * TODO: Remove the item from the shopping cart in the database.
                */
                int OrderNum = GetOrderNumber(connectionString, UserName);
                int _release = GetModifiedQuantity(connectionString, OrderNum, upc);
                if (inactivity) PreRemoveFromDBOrderItem(connectionString, upc, OrderNum);
                else 
                    RemoveFromDBOrderItem(connectionString, upc, OrderNum);
                    UpdateDBItem(connectionString, upc, _release);
                    // Save the shopping cart in the Session variable "MyShoppingCart".
                    cart.RemoveItem(upc);
                    HttpContext.Current.Session["MyShoppingCart"] = cart;
            
            }
            else
            {
                Debug.Fail("ERROR : We should never get to RemoveFromCart.aspx without a UPC.");
                throw new Exception("ERROR : It is illegal to load RemoveFromCart.aspx without setting a UPC.");
            }
        
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

    public void PreRemoveFromDBOrderItem (string connectionString, string UPC, int OrderNum)
    {
        //query
        string query = "UPDATE [OrderItem] SET [removed]=@Removed WHERE [upc]=@UPC AND [orderNum]=@OrderNum";
        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            command.Parameters.AddWithValue("@Removed", 1);
            command.Parameters.AddWithValue("@UPC", UPC);
            command.Parameters.AddWithValue("@OrderNum", OrderNum);
            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
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

    public void UpdateDBItem(string connectionString, string UPC, int releaseQuantity)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [Item] SET quantityAvailable = quantityAvailable + @Quantity " +
                       "WHERE [upc]=@UPC";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@Quantity", releaseQuantity);
            command.Parameters.AddWithValue("@UPC", UPC);
            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    public int GetModifiedQuantity(string connectionString, int OrderNum, string UPC)
    {
        string query = "SELECT [quantity] FROM [OrderItem] WHERE ([upc] =N'" + UPC + "' AND [orderNum] = N'" + OrderNum + " ')";
        int release = 0;
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
                    release = reader.GetInt32(0);
                }
                command.Connection.Close(); // Close the connection and the DataReader.
                reader.Close();
            }
        }
        return release;

    }
}