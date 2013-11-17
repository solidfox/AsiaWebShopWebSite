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
        ConfirmationNumberLabel.Text = ShoppingCart.GetShoppingCart(User.Identity.Name).checkOut();
    }
}