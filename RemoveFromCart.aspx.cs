using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RemoveFromCart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Get the upc from the query string.
        string upc = Request.QueryString["upc"].Trim();

        // Remove the item from the shopping cart.
        if (upc != "")
        {
            ShoppingCart cart = ShoppingCart.GetShoppingCart();
            cart.RemoveItem(upc);
            /******
            * TODO: Remove the item from the shopping cart in the database.
            */
            // Save the shopping cart in the Session variable "MyShoppingCart".
            HttpContext.Current.Session["MyShoppingCart"] = cart;
        }
        else
        {
            Debug.Fail("ERROR : We should never get to RemoveFromCart.aspx without a UPC.");
            throw new Exception("ERROR : It is illegal to load RemoveFromCart.aspx without setting a UPC.");
        }

        // View the shopping cart.
        Response.Redirect("ViewShoppingCart.aspx");

    }
}