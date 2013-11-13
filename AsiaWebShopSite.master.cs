using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    private static string connectionString = "AsiaWebShopDBConnectionString";
    private List<string> UserNames = new List<string> { };
    
    protected void Page_Load(object sender, EventArgs e)
    {
        Microsoft.Win32.SystemEvents.SessionEnded += new Microsoft.Win32.SessionEndedEventHandler(ReserveForUser);
        GetAllUser(connectionString);
        foreach(string username in UserNames)
        CheckOutOfTime(connectionString, username);
        UpdateLastSeenTime(connectionString, HttpContext.Current.User.Identity.Name);
        if (HttpContext.Current.User.Identity.Name != null)
        {
            ShoppingCart.GetShoppingCart(HttpContext.Current.User.Identity.Name);
        }
    }

    public void ReserveForUser (object sender, Microsoft.Win32.SessionEndedEventArgs e)
    {
        if (HttpContext.Current.User.Identity.Name != null)
        {
            UpdateLastSeenTime(connectionString, HttpContext.Current.User.Identity.Name);
        }
    }

    protected void LoginStatus_LoggingOut(object sender, EventArgs e)
    {
        string userName = HttpContext.Current.User.Identity.Name;
        ShoppingCart cart = ShoppingCart.GetShoppingCart(userName);
        RemoveCart removeall;
        List<string> upc = new List<string>{};
        foreach (CartItem item in cart.Items)
            upc.Add(item.UPC);
        foreach(string UPC in upc)
            removeall = new RemoveCart(cart, userName, UPC, true);
        cart.Items.Clear();
    }

    public void UpdateLastSeenTime (string connectionString, string UserName) 
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

    public void CheckOutOfTime(string connectionString, string UserName) 
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
                if(!reader.IsDBNull(0))
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

    private void GetAllUser(string connectionString) 
    {
        if (UserNames != null ) UserNames.Clear();
        string query = "SELECT [userName] FROM [Member] ";
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
                while(reader.Read())
                    UserNames.Add(reader.GetString(0));
            }
        }
        return;
    }
    
}
