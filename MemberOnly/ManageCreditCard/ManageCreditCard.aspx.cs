using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MemberOnly_ManageCreditCard_ManageCreditCard : System.Web.UI.Page
{
    String userName;
    protected void Page_Load(object sender, EventArgs e)
    {
        userName = User.Identity.Name;
        CreditCardList.SelectParameters["userName"].DefaultValue = User.Identity.Name;
        SelectedCreditCard.InsertParameters["userName"].DefaultValue = User.Identity.Name;
    }
    protected void dvCreditCard_ItemDeleted(object sender, EventArgs e)
    {
        gvCreditCard.DataBind();
    }
    protected void dvCreditCard_ItemInserted(object sender, EventArgs e)
    {
        gvCreditCard.DataBind();
    }
    protected void dvCreditCard_ItemUpdated(object sender, EventArgs e)
    {
        gvCreditCard.DataBind();
    }
}