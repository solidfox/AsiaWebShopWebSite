using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AddToCart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Get the upc, item name and discount price from the query string.
        string upc = Request.QueryString["upc"].Trim();
        string name = Request.QueryString["name"].Trim();
        decimal discountPrice = Convert.ToDecimal(Request.QueryString["discountPrice"].Trim());

        // Add the item to the shopping cart with default quantity = 1.
        if (upc != "")
        {
            ShoppingCart cart = ShoppingCart.GetShoppingCart();
            cart.AddItem(upc, name, discountPrice);
            /******
             * TODO: Add the item to the shopping cart in the database.
             */
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