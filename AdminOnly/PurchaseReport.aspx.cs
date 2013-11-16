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
        if (!IsPostBack)
        {
            StartCalendar.Visible = false;
            EndCalendar.Visible = false;
        }
    }
    protected void StartCalendarButton_Click(object sender, EventArgs e)
    {
        if (StartCalendar.Visible)
        {
            StartCalendar.Visible = false;
        }
        else
        {
            StartCalendar.Visible = true;
        }
    }
    protected void EndCalendarButton_Click(object sender, EventArgs e)
    {
        if (EndCalendar.Visible)
        {
            EndCalendar.Visible = false;
        }
        else
        {
            EndCalendar.Visible = true;
        }

    }


    protected void MemberCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {

        if (UserName.Text.Trim() == "")
        {
            args.IsValid = true;

        }
        else
        {
            MembershipUser user = Membership.GetUser(UserName.Text.Trim());
            if (user != null)
            {
                args.IsValid = true;

            }
            else
            {
                args.IsValid = false;

            }
        }
    }


    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        string userNameQuery = "";
        string dateRangQuery = "";

        if (UserName.Text.Trim() != "")
        {
            userNameQuery = "AND (Member.userName = N'" + UserName.Text.Trim() + "')";
        }
    
        if (StartDayTextBox.Text != "")
        {
            dateRangQuery = "AND (([Order].orderDateTime >= CAST('" + StartDayTextBox.Text.Trim() + "' AS SMALLDATETIME)))";

        }

        if (EndDayTextBox.Text != "")
        {
            dateRangQuery += "AND (([Order].orderDateTime <= CAST('" + EndDayTextBox.Text.Trim() + "' AS SMALLDATETIME)))";
        }



        string SQLCmd = " SELECT Member.firstName, Member.lastName, Member.email, Member.phoneNumber, [Order].deliveryAddress, [Order].deliveryDistrict, [Order].creditCardNumber, [Order].creditCardtype, [Order].confirmationNumber, [Order].orderNum FROM Member INNER JOIN [Order] ON Member.userName = [Order].userName WHERE ([Order].confirmationNumber IS NOT NULL)"
                        + userNameQuery;
         
        MemberSqlDataSource.SelectCommand = SQLCmd;
        DataList1.DataBind();
        MemberSqlDataSource.Select(DataSourceSelectArguments.Empty);

    }





    public static void MergeRows(GridView gridView)
    {
        for (int rowIndex = gridView.Rows.Count - 2; rowIndex >= 0; rowIndex--)
        {
            GridViewRow row = gridView.Rows[rowIndex];
            GridViewRow previousRow = gridView.Rows[rowIndex + 1];

            string rowString = ((Label)row.FindControl("DistrictLabel")).Text;
            string previousRowString = ((Label)previousRow.FindControl("DistrictLabel")).Text;

            if (rowString == previousRowString)
            {
                row.Cells[0].RowSpan = previousRow.Cells[0].RowSpan < 2 ? 2 :
                                       previousRow.Cells[0].RowSpan + 1;
                previousRow.Cells[0].Visible = false;
            }



        }
    }

    protected void StartCalendar_SelectionChanged(object sender, EventArgs e)
    {
        StartDayTextBox.Text = StartCalendar.SelectedDate.ToShortDateString();
        StartCalendar.Visible = false;
    }


    protected void EndCalendar_SelectionChanged(object sender, EventArgs e)
    {
        EndDayTextBox.Text = EndCalendar.SelectedDate.ToShortDateString();
        EndCalendar.Visible = false;
    }
    protected void ClearRangeButton_Click(object sender, EventArgs e)
    {
        StartDayTextBox.Text = null;
        EndDayTextBox.Text = null;
    }


}

