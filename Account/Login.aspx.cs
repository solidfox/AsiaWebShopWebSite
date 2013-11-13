using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Web.Security;

public partial class Account_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterHyperLink.NavigateUrl = "Register.aspx?ReturnUrl=" + HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
    }


    protected void LoginUser_LoggingIn(object sender, LoginCancelEventArgs e)
    {
        MembershipUser user = Membership.GetUser(LoginUser.UserName);
        if (user != null)
        {
            if (user.IsApproved == false)
            {
                LoginUser.FailureText = "Your account is disabled. Please contact administrator";
            }
        }
        ShoppingCart.GetShoppingCart(LoginUser.UserName);
    }
}
