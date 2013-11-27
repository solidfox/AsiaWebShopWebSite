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
        if (!Page.IsPostBack)
        {
            StartDayTextBox.Text = DateTime.Now.ToShortDateString();
            EndDayTextBox.Text = DateTime.Now.ToShortDateString();
        }
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
       
    
        if (StartDayTextBox.Text.Trim() != "")
        {
            dateRangQuery += " AND (DATEDIFF(day,CAST('" + StartDayTextBox.Text.Trim() + "' AS SMALLDATETIME),[Order].orderDateTime) >=0 ) ";
            //SELECT DATEDIFF(day,'2008-12-29','2008-12-30') AS DiffDate  =>   DiffDate=1     orderDateTime >= StartDay
        }

        if (EndDayTextBox.Text.Trim() != "")
        {
            dateRangQuery += " AND (DATEDIFF(day,CAST('" + EndDayTextBox.Text.Trim() + "' AS SMALLDATETIME),[Order].orderDateTime) <=0 ) ";
            //SELECT DATEDIFF(day,'2008-12-30','2008-12-29') AS DiffDate  =>   DiffDate=-1     orderDateTime <= EndDay
        }



        string SQLCmd = " SELECT Member.firstName, Member.lastName, Member.email, Member.phoneNumber, [Order].deliveryAddress, [Order].deliveryDistrict, "+
            " { fn REPEAT('*', LEN([Order].creditCardNumber) - 4) } + RIGHT (LTRIM(RTRIM([Order].creditCardNumber)), 4) AS creditCardNumber,"
            +" [Order].creditCardtype, [Order].code, [Order].orderNum FROM Member INNER JOIN [Order] ON Member.userName = [Order].userName WHERE ([Order].confirmationNumber IS NOT NULL)"
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

