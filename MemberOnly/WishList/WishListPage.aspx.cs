using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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

    private void ShowPopUpMsg(string msg)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("alert('");
        sb.Append(msg.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'"));
        sb.Append("');");
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showalert", sb.ToString(), true);
    }

    
    protected void CheckBox2_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chk = (CheckBox)sender;
        GridViewRow gr = (GridViewRow)chk.Parent.Parent;
        string Quantity = ((Label)gr.Cells[3].FindControl("ItemQuantity")).Text;
        if (Quantity != "0")
        {
            ((CheckBox)sender).Checked = false;
            ShowPopUpMsg("You can add Alert only when the item is out of stock");
        }
    }
}