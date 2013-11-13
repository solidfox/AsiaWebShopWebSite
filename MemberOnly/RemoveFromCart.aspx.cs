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
        ShoppingCart cart = (ShoppingCart)HttpContext.Current.Session["MyShoppingCart"];
        // Remove the item from the shopping cart.
        RemoveCart test = new RemoveCart(cart, userName, upc,false);
        // View the shopping cart.
        Response.Redirect("~/MemberOnly/ViewShoppingCart.aspx");

    }
}