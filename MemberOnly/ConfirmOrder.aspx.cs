using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class MemberOnly_ViewMemberInformation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void orderDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

        e.Command.Parameters[0].Value = User.Identity.Name;

        //Label1.Text = Membership.GetUser().ProviderUserKey.ToString()

    }
    protected void orderItemsDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters[0].Value = User.Identity.Name;
    }
    protected String total()
    {
        string userName = User.Identity.Name;
        string connectionString = "AsiaWebShopDBConnectionString";
        string query = "SELECT  SUM(OrderItem.quantity * OrderItem.PriceWhenAdded) AS Total " +
                        "FROM   OrderItem INNER JOIN [Order] ON OrderItem.orderNum = [Order].orderNum " +
                        "WHERE  ([Order].userName = '" + userName + "') AND ([Order].confirmationNumber IS NULL) ";

        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Open the connection.
            command.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            String total = command.ExecuteScalar().ToString();
            // Close the connection and the DataReader.
            command.Connection.Close();
            return total;
        }
    }
}