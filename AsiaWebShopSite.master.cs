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
        foreach (string username in UserNames)
        {
            GenericQuery.CheckOutOfTime(connectionString, username);
            GenericQuery.CheckDelivered(connectionString, username);
        }
        GenericQuery.UpdateLastSeenTime(connectionString, HttpContext.Current.User.Identity.Name);
        if (HttpContext.Current.User.Identity.Name != null)
        {
            ShoppingCart.GetShoppingCart(HttpContext.Current.User.Identity.Name);
        }
    }

    public void ReserveForUser (object sender, Microsoft.Win32.SessionEndedEventArgs e)
    {
        if (HttpContext.Current.User.Identity.Name != null)
        {
            GenericQuery.UpdateLastSeenTime(connectionString, HttpContext.Current.User.Identity.Name);
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
