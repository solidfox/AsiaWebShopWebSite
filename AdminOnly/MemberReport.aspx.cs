using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;



public partial class AdminOnly_MemberReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void MemberCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        MembershipUser user = Membership.GetUser(UserName.Text.Trim());

        if (user != null)
        {
            args.IsValid = true;
        }
        else
            args.IsValid = false;
    }


    protected void btnGenerate_Click(object sender, EventArgs e)
    {

        if (UserName.Text.Trim() != null) 
        {
            string SQLCmd = "SELECT [lastName], [firstName], [userName], [email], [phoneNumber], [renewalDate] FROM [Member] WHERE ( userName =N'"+ UserName.Text.Trim() + "')";
            MemberSqlDataSource.SelectCommand = SQLCmd + " ORDER BY [lastName] ";
            DataList1.DataBind();
        }
    }

 
}