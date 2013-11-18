using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;



public partial class AdminOnly_MemberReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
        {
            DataList1.Visible = false;
            return;
        }

        string userNameQuery = "";
        string dateRangQuery = "";

        userNameQuery = "AND ( [Order].userName =N'"+User.Identity.Name + "')";
       
    
        if (StartDayTextBox.Text != "")
        {
            dateRangQuery = "AND (([Order].orderDateTime >= CAST('" + StartDayTextBox.Text.Trim() + "' AS SMALLDATETIME)))";

        }

        if (EndDayTextBox.Text != "")
        {
            dateRangQuery += "AND (([Order].orderDateTime <= CAST('" + EndDayTextBox.Text.Trim() + "' AS SMALLDATETIME)))";
        }



        string SQLCmd = " SELECT Member.firstName, Member.lastName, Member.email, Member.phoneNumber, [Order].deliveryAddress, [Order].deliveryDistrict, [Order].creditCardNumber, [Order].creditCardtype, [Order].confirmationNumber, [Order].orderNum FROM Member INNER JOIN [Order] ON Member.userName = [Order].userName WHERE ([Order].confirmationNumber IS NOT NULL)"
                        + userNameQuery+ dateRangQuery;
         
        MemberSqlDataSource.SelectCommand = SQLCmd;
        DataList1.Visible = true;
        DataList1.DataBind();
        MemberSqlDataSource.Select(DataSourceSelectArguments.Empty);

        // Display a no result message if nothing was retrieved from the database.
        if (DataList1.Items.Count == 0)
        {
            lblGeneratedResultMessage.Text = "No records.";
            lblGeneratedResultMessage.Visible = true;
        }
        else
            lblGeneratedResultMessage.Visible = false;

    }

}

