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
    public static string username = ""; 
    protected void Page_Load(object sender, EventArgs e)
    {
        username = User.Identity.Name;
        
    }

    protected void orderDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
       e.Command.Parameters[0].Value = username;
    }
    protected void orderItemsDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
       e.Command.Parameters[0].Value = username;
    }
    protected String total()
    {
        string userName = username;
        string connectionString = "AsiaWebShopDBConnectionString";
        string query = "SELECT  SUM(OrderItem.quantity * OrderItem.PriceWhenAdded) AS Total " +
                        "FROM   OrderItem INNER JOIN [Order] ON OrderItem.orderNum = [Order].orderNum " +
                        "WHERE  ([Order].userName = '" + userName + "') AND ([Order].confirmationNumber IS NULL) ";

        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString);
        SqlCommand command = new SqlCommand(query, connection);
        command.Connection.Open();
        String total = command.ExecuteScalar().ToString();
        command.Connection.Close();
        return total;
    }
}