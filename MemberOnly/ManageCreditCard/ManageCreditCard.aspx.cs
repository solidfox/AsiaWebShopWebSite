using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MemberOnly_ManageCreditCard_ManageCreditCard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        CreditCardList.SelectParameters["userName"].DefaultValue = User.Identity.Name;
    }
}