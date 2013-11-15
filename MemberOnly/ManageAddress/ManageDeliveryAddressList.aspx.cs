using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MemberOnly_ManageDeliveryAddressList : System.Web.UI.Page
{
    string userName;
    protected void Page_Load(object sender, EventArgs e)
    {
        userName = User.Identity.Name;
        Generate_Address_List();
    }

    protected void Generate_Address_List()
    {
        // Execute the SQL statement;
        string SQLCmd = "SELECT [userName], [nickname], [buildingAddress], [streetAddress], [district] FROM [Address] WHERE ([userName] = N'"+ userName +"')";
        sqlAddressList.SelectCommand = SQLCmd;
        sqlAddressList.Select(DataSourceSelectArguments.Empty);
        // Bind the search result to the Grid control
        gvAddressList.DataBind();
    }
}