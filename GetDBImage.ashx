<%@ WebHandler Language="C#" Class="GetDBImage" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public class GetDBImage : IHttpHandler {
    
    
    public void ProcessRequest (HttpContext context) {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            SqlCommand command = new SqlCommand("Select [picture] from [Item] where [upc] = N'" + context.Request.QueryString["upc"] + "'", connection);

            connection.Open();
            SqlDataReader dr = command.ExecuteReader(CommandBehavior.CloseConnection);
            while (dr.Read())
            {
                if (dr["picture"].ToString().Length > 0)
                {
                    context.Response.BinaryWrite((byte[])dr["picture"]);
                }
            }
        }

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}