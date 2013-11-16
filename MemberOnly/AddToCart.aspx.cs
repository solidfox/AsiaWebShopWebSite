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
        UserNotify test = new UserNotify("Have Fun !!");
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;
        //string OrderNum = GetOrderNumber(connectionString, userName);
        int OrderNum = GenericQuery.GetOrderNumber(connectionString, userName);

        string upc = Request.QueryString["upc"].Trim();
        string name = Request.QueryString["name"].Trim();
        decimal discountPrice = Convert.ToDecimal(Request.QueryString["discountPrice"].Trim());
        decimal amountSavedForOne = Convert.ToDecimal(Request.QueryString["normalPrice"].Trim());
        // Add the item to the shopping cart with default quantity = 1.
        if (upc != "")
        {
            ShoppingCart cart = ShoppingCart.GetShoppingCart(userName);
            CartItem temp = new CartItem(upc);
            if (GenericQuery.CheckItemStock(connectionString, temp, 0))
            {
                cart.AddItem(upc, name, discountPrice, 1, false);
                GenericQuery.InsertToShoppingCart(connectionString, 1, OrderNum, upc, name, discountPrice, amountSavedForOne);
            }
            ///TODO: Add the item to the shopping cart in the database.
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

}