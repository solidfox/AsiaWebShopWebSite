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
    String connectionstring = "AsiaWebShopDBConnectionString";
    protected void Page_Load(object sender, EventArgs e)
    {
        userName = User.Identity.Name;
        SqlDataSource1.SelectParameters["userName"].DefaultValue = User.Identity.Name;
        SqlDataSource1.SelectParameters["orderNum"].DefaultValue = GenericQuery.GetOrderNumber(connectionstring, userName).ToString().Trim();
        
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
        string Quantity_r = ((Label)gr.Cells[4].FindControl("Label2")).Text;
        if (Quantity != "0" || (Quantity == "0" && Quantity_r != ""))
        {
                ((CheckBox)sender).Checked = false;
                ShowPopUpMsg("You can add Alert only when the item is out of stock");
        }
    }
}