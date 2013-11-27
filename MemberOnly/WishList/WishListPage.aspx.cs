using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MemberOnly_WishList_WishListPage : System.Web.UI.Page
{
    String userName;
    protected void Page_Load(object sender, EventArgs e)
    {
        userName = User.Identity.Name;
        SqlDataSource1.SelectParameters["userName"].DefaultValue = User.Identity.Name;
    }

}