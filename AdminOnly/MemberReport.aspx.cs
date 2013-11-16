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

    protected void MemberCustomValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {

        if (UserName.Text.Trim() == "")
        {
            args.IsValid = true;
            HeaderLabelDataList.Visible = true;
        }
        else
        {
            MembershipUser user = Membership.GetUser(UserName.Text.Trim());
            if (user != null)
            {
                args.IsValid = true;
                HeaderLabelDataList.Visible = true;
            }
            else
            {
                args.IsValid = false;
                HeaderLabelDataList.Visible = false;
            }
        }
    }


    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        string SQLCmd = "SELECT Member.userName, Member.lastName, Member.firstName, Address.district FROM Member INNER JOIN Address ON Member.userName = Address.userName WHERE (Address.nickname = N'Mailing') ";
        string labelmessage = " Member information " ;
        if (UserName.Text.Trim() != "")
        {
            MemberSqlDataSource.SelectCommand = SQLCmd + " AND ( Member.userName = N'" + UserName.Text.Trim() + "')";
            labelmessage = labelmessage +": "+ UserName.Text.Trim();
        }
        else
        {
            labelmessage = labelmessage + ": All Members ";
            if (cbGroupByDistrict.Checked)
            {
                MemberSqlDataSource.SelectCommand = SQLCmd + " ORDER BY Address.district,LastName  ";
                labelmessage = labelmessage + " Group By District ";
                MemberReportGridView.Columns[0].Visible = true;
            }
            else
            {
                MemberSqlDataSource.SelectCommand = SQLCmd + " ORDER BY Member.lastName ";
                MemberReportGridView.Columns[0].Visible = false;
            }

        }
        HeaderLabelDataList.Text = labelmessage;
        MemberReportGridView.DataBind();
         MergeRows(MemberReportGridView);
         
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
}

