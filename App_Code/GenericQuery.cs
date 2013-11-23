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
    private static string connectionString = "AsiaWebShopDBConnectionString";
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
        string query = "SELECT [orderNum] FROM [Order] WHERE ([username] =N'" + userName + "' AND [confirmationNumber] IS NULL)";
        int OrderNum = 0;
        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Open the connection.
            command.Connection.Open();

            object result = command.ExecuteScalar();

            if (result != null)
            {
                OrderNum = (Int32)result;
                command.Connection.Close(); // Close the connection and the DataReader.
            }
            else
            {
                command.Connection.Close(); // Close the connection and the DataReader.
                GenerateOrderNumber(connectionString, userName);
                OrderNum = GetOrderNumber(connectionString, userName);
            }
        }
        return OrderNum;
    }

    protected static void GenerateOrderNumber(string connectionString, string userName)
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

    public static void CheckDelivered (string connectionString, string UserName)
    {
        int test;
        string query = "SELECT [orderDateTime],[orderNum],[deliveryDateOffset],[timeSlotID] FROM [Order] WHERE ([userName] = N'" + UserName + "') AND ( [Order].confirmationNumber IS NOT NULL)";
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            command.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            SqlDataReader reader = command.ExecuteReader();
            if (reader.HasRows)
            {
                // Iterate through the table to get the retrieved values.
                while(reader.Read())
                {
                    test = reader.GetInt32(3);
                    DateTime NoMoreChange = reader.GetDateTime(0).Date.AddDays(reader.GetByte(2) - 1);
                    switch (reader.GetInt32(3))
                    {
                        case 1:
                            NoMoreChange = NoMoreChange.AddHours(9);
                            break;
                        case 2:
                            NoMoreChange = NoMoreChange.AddHours(12);
                            break;
                        case 3:
                            NoMoreChange = NoMoreChange.AddHours(15);
                            break;
                        case 4:
                            NoMoreChange = NoMoreChange.AddHours(18);
                            break;
                    }

                    if (DateTime.Now >= NoMoreChange)
                    {
                        PreForShippment(connectionString, reader.GetInt32(1));
                    }
                }


                command.Connection.Close(); // Close the connection and the DataReader.
                reader.Close();
            }

        }

        return;
    }

    private static void PreForShippment(string connectionString, int OrderNum) 
    {
        string query = "UPDATE [Order] SET shipped=@SHIP " +
                       "WHERE [orderNum]=@OrderNum";
        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@SHIP", true);
            command.Parameters.AddWithValue("@OrderNum", OrderNum);
            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }

    }

    public static int GetCurrentHourID()
    {
        int hour = DateTime.Now.Hour;
        int hourID = 0;
        if (hour >= 9 && hour < 12) { hourID = 1; }//Time Slot 1
        else if (hour >= 12 && hour < 15) { hourID = 2; }//Time Slot 2
        else if (hour >= 15 && hour < 18) { hourID = 3; }//Time Slot 3
        else { hourID = 4; }//Time Slot 4
        return hourID;
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

    public static string getUserEmail(string userName)
    {
        string query = "SELECT [email] FROM [Member] WHERE ([userName] = N'" + userName + "')";
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString);
        SqlCommand command = new SqlCommand(query, connection);
        command.Connection.Open();
        Object raw = command.ExecuteScalar();
        if (raw == null) { return null; }
        return raw.ToString();
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