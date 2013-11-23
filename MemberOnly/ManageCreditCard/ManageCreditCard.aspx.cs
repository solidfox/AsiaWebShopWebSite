using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class MemberOnly_ManageCreditCard_ManageCreditCard : System.Web.UI.Page
{
    String userName;
    protected void Page_Load(object sender, EventArgs e)
    {
        userName = User.Identity.Name;
        CreditCardList.SelectParameters["userName"].DefaultValue = User.Identity.Name;
        SelectedCreditCard.InsertParameters["userName"].DefaultValue = User.Identity.Name;
    }
    protected void dvCreditCard_ItemDeleted(object sender, EventArgs e)
    {
        gvCreditCard.DataBind();
    }
    protected void dvCreditCard_ItemInserted(object sender, EventArgs e)
    {
        gvCreditCard.DataBind();
    }
    protected void dvCreditCard_ItemUpdated(object sender, EventArgs e)
    {
        gvCreditCard.DataBind();
    }
    protected void cvCreditCard_ServerValidate(object source, ServerValidateEventArgs args)
    {
        String creditCardList = (String)dvCreditCard.FindControl("creditCardType").ToString().Trim();
        if (creditCardList == "American Express")
        {
            ShowPopUpMsg("1");
        }
        if (creditCardList == "Diners Club")
        {
            ShowPopUpMsg("2");
        }
        if (creditCardList == "Discover")
        {
            ShowPopUpMsg("3");
        }
        if (creditCardList == "MasterCard")
        {
            ShowPopUpMsg("4");
        }
        if (creditCardList == "Visa")
        {
            ShowPopUpMsg("5");
        }
        args.IsValid = false;
    }
    private void ShowPopUpMsg(string msg)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("alert('");
        sb.Append(msg.Replace("\n", "\\n").Replace("\r", "").Replace("'", "\\'"));
        sb.Append("');");
        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "showalert", sb.ToString(), true);
    }
    protected void creditCardType_TextChanged(object sender, EventArgs e)
    {

    }
    protected void cvExpire_ServerValidate(object source, ServerValidateEventArgs args)
    {
        Int16 month = Convert.ToInt16((((DropDownList)dvCreditCard.FindControl("insMonthDDL")).SelectedValue.Trim()));
        Int16 year = Convert.ToInt16((((DropDownList)dvCreditCard.FindControl("insYearDDL")).SelectedValue.Trim()));
        if ((month < DateTime.Now.Month) & (year <= DateTime.Now.Year))
        {
            args.IsValid = false;
        }
        else
            args.IsValid = true;
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        Int16 month = Convert.ToInt16((((DropDownList)dvCreditCard.FindControl("editExpiryMonth")).SelectedValue.Trim()));
        Int16 year = Convert.ToInt16((((DropDownList)dvCreditCard.FindControl("editExpiryYear")).SelectedValue.Trim()));
        if ((month < DateTime.Now.Month) & (year <= DateTime.Now.Year))
        {
            args.IsValid = false;
        }
        else
            args.IsValid = true;
    }



    protected void InsertNumber_ServerValidate(object source, ServerValidateEventArgs args)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            // Get the value of the new student id from the DetailsView control.
            TextBox CreditCardNumber = (TextBox)dvCreditCard.FindControl("InsertNumber");

            // Count how many existing records have the student id value.
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [CreditCard] WHERE (([number] = N'" + CreditCardNumber.Text.Trim() + "') AND ([userName] = N'" + userName + "'))", connection);
            Int32 count = (Int32)command.ExecuteScalar();
            connection.Close();

            // If the count is not zero the student id already exists, so cancel the insert.
            if (count != 0)
            {
                args.IsValid = false;
            }
        }
    }
}