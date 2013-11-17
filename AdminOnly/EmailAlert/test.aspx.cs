using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;


public partial class AdminOnly_EmailAlert_test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        EmailAlert instance = new EmailAlert();
        bool test = instance.sendEmail("mycheungac@cse.ust.hk", "Very Important thing", "DO IT NOW");
        if (test == true)
        {
            ShowPopUpMsg("True");
        }
        else
        {
            ShowPopUpMsg("False");
        }
    }
    private void ShowPopUpMsg(string msg)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("alert('");
        sb.Append(msg.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'"));
        sb.Append("');");
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showalert", sb.ToString(), true);
    }
}