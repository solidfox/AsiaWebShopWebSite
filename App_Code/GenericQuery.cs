using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GenericQuery
/// </summary>
public class GenericQuery
{
	public GenericQuery()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region DBOrderItem
    public static void RemoveFromDBOrderItem(string connectionString, string UPC, int OrderNum)
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

    public static int GetOrderNumber(string connectionString, string userName)
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
                GenerateOrder(connectionString, userName);
                OrderNum = GetOrderNumber(connectionString, userName);
            }
        }
        return OrderNum;
    }


    protected static void GenerateOrder(string connectionString, string userName)
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

/*    public static DateTime GetOrderDateTime(string connectionString, string userName)
    {
        //get the orderNum from DB
        int orderNum = GetOrderNumber(connectionString, userName);
        //define query to get orderDateTime from Order table
        string query = "SELECT [orderDateTime] FROM [Order] WHERE ([orderNum] =N'" + orderNum + "')";

        DateTime orderDateTime = DateTime.Now.AddYears(1);//define orderDateTime

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
                    //assign the value to orderDateTime
                    orderDateTime = DateTime.Parse(reader["orderDateTime"].ToString());
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }

        return orderDateTime;
    }*/

    /*protected static void GenerateOrderDateTime(string connectionString, int orderNum)
    {

    }*/

    public static bool CheckItemDulplicate(string connectionString, int OrderNum, string UPC)
    {
        string query = "SELECT [quantity] FROM [OrderItem] WHERE ([upc] =N'" + UPC + "' AND [orderNum] = N'" + OrderNum + " ')";
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
                reader.Read();
                int quantity = reader.GetInt32(0) + 1;
                // Iterate through the table to get the retrieved values.8
                command.Connection.Close(); // Close the connection and the DataReader.
                reader.Close();
                UpdateOrderItem(connectionString, OrderNum, UPC, quantity);
                return true;
            }
        }
        return false;
    }

    public static void UpdateOrderItem(string connectionString, int OrderNum, string UPC, int Quantity)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [OrderItem] SET quantity=@Quantity " +
                       "WHERE [orderNum]=@OrderNum AND [upc]=@UPC";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@Quantity", Quantity);
            command.Parameters.AddWithValue("@OrderNum", OrderNum);
            command.Parameters.AddWithValue("@UPC", UPC);
            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    public static void SubUpdateOrderItem(string connectionString, int OrderNum, string UPC, int Quantity, decimal Price)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [OrderItem] SET quantity=@Quantity, removed=@Removed, PriceWhenAdded=@price " +
                       "WHERE [orderNum]=@OrderNum AND [upc]=@UPC";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@Quantity", Quantity);
            command.Parameters.AddWithValue("@OrderNum", OrderNum);
            command.Parameters.AddWithValue("@Removed", 0);
            command.Parameters.AddWithValue("@price", Price);
            command.Parameters.AddWithValue("@UPC", UPC);
            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    public static void InsertToShoppingCart(string connectionString, int Quantity, int OrderNum, string upc, string name, decimal discountPrice, decimal amountSavedForOne)
    {

        if (GenericQuery.CheckItemDulplicate(connectionString, OrderNum, upc))
        {
            return;
        }

        string query = "INSERT INTO [OrderItem] ([orderNum], [upc], [quantity], [PriceWhenAdded], [amountSavedForOne], [removed])" +
                       "VALUES (@OrderNumber, @UPC, @Quantity, @Price, @amountSaved, @removed)";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@OrderNumber", OrderNum);
            command.Parameters.AddWithValue("@UPC", upc);
            command.Parameters.AddWithValue("@Quantity", Quantity);
            command.Parameters.AddWithValue("@Price", discountPrice);
            command.Parameters.AddWithValue("@amountSaved", amountSavedForOne);
            command.Parameters.AddWithValue("@removed", 0);
            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }

    }
    #endregion

    #region DBItem
    public static void UpdateDBItem(string connectionString, string UPC, int releaseQuantity)
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

    // query on the database, check the stock
    public static bool CheckItemStock(string connectionString, CartItem item, int Comparision)
    {
        string query = "SELECT [quantityAvailable], [visible] FROM [Item] WHERE ([upc] =N'" + item.UPC + "')";
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
                    if (reader.GetInt32(0) > Comparision && reader.GetBoolean(1))
                    {
                        return true;
                    }
                }
                command.Connection.Close(); // Close the connection and the DataReader.
                reader.Close();
            }
        }
        return false;
    }

    #endregion

    #region DBMember
    public static void UpdateLastSeenTime(string connectionString, string UserName)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [Member] SET lastSeen=@LastSeen " +
                       "WHERE [userName]=@UserName";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@UserName", UserName);
            command.Parameters.AddWithValue("@LastSeen", (DateTime.Now.ToString().Trim()));
            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    public static void CheckOutOfTime(string connectionString, string UserName)
    {
        string query = "SELECT [lastSeen] FROM [Member] WHERE ([userName] = N'" + UserName + "')";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            command.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                // Iterate through the table to get the retrieved values.
                reader.Read();
                if (!reader.IsDBNull(0))
                {
                    DateTime Expiry = DateTime.Now.AddMinutes(-15);
                    DateTime LastSeen = reader.GetDateTime(0);
                    if (Expiry > LastSeen)
                    {
                        ShoppingCart cart = ShoppingCart.GetShoppingCart(UserName);
                        RemoveCart removeall;
                        List<string> upc = new List<string> { };
                        foreach (CartItem item in cart.Items)
                            upc.Add(item.UPC);
                        foreach (string UPC in upc)
                            removeall = new RemoveCart(cart, UserName, UPC, false);
                        cart.Items.Clear();
                    }
                }


                command.Connection.Close(); // Close the connection and the DataReader.
                reader.Close();
            }

        }

        return;
    }
    #endregion

}