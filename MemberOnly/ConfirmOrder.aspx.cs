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
        //string userName = User.Identity.Name;
    }

    protected void orderDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

        e.Command.Parameters[0].Value = User.Identity.Name;

        //Label1.Text = Membership.GetUser().ProviderUserKey.ToString()

    }
    protected void orderItemsDataSource_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        e.Command.Parameters[0].Value = User.Identity.Name;
    }
    protected void orderDetailsView_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
    {

    }
}