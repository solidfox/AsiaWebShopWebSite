using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;


public partial class MemberOnly_ManageDeliveryAddress_EditAddress : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        DeliveryAddressList.SelectParameters["userName"].DefaultValue = User.Identity.Name;
    }
    protected void dvItem_ItemDeleted(object sender, EventArgs e)
    {
        gvAddress.DataBind();
    }

    protected void dvItem_ItemInserted(object sender, EventArgs e)
    {
        gvAddress.DataBind();
    }

    protected void dvItem_ItemUpdated(object sender, EventArgs e)
    {
        gvAddress.DataBind();
    }



}