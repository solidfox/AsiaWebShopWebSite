using System;
using System.Configuration;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class ItemSearch : System.Web.UI.Page
{
    string userName;
    protected void Page_Load(object sender, EventArgs e)
    {
        userName = User.Identity.Name;
        if (!Page.IsPostBack)
        {

        }
        Generate_Item_List();
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
    
    }
    protected void Generate_Item_List()
    {
        // Code to add inside btnSearch_Click event handler.
        // -----------------------------------------------

        // Get the search string and the category from the search page.
        string itemSearchCondition = "";
        string searchString = "";
        string category = Request.QueryString["category"];
        if (Page.IsPostBack)
        {
            searchString = txtSearchString.Text.Trim();
            category = categoryDropDownList.SelectedValue.Trim();
        }

        // Construct the basic SELECT statement for searching; only visible items should be displayed.
        string SQLCmd = "SELECT [upc], [name], [picture], [normalPrice], [discountPrice], [quantityAvailable] FROM [Item] WHERE (([visible] = 'true')";

        // Hide and clear the search result message.
        lblSearchResultMessage.Visible = false;
        lblSearchResultMessage.Text = "";

        // If a search string is specified, but no radio button is selected, ignore the search string.
        if (searchString != "" & !cbItemName.Checked & !cbItemDescription.Checked)
        {
            searchString = "";
            lblSearchResultMessage.Text = " (Name or Description not selected.)";
        }

        // If no search string is specified, but a category is specified, modify the
        // SELECT statement to search only in the specified category.
        if (searchString == "")
        {
            if (category != "All Categories" && category != null)
            {
                SQLCmd = SQLCmd + " AND ([category] = N'" + category + "')";
            }
        }
        // If a search string is specified, then modify the SELECT statement to retrieve
        // matching items either in all categories or in a specified category. 
        else
        {
            // Determine whether to search in name only, description only or both name
            // and description based on whether only one or both checkboxes are checked.
            if (cbItemName.Checked & !cbItemDescription.Checked)
            {
                // Search in name only.
                itemSearchCondition = " AND ([name] LIKE N'%" + searchString + "%')";
            }
            if (!cbItemName.Checked & cbItemDescription.Checked)
            {
                // Search in description only.
                itemSearchCondition = " AND ([description] LIKE N'%" + searchString + "%')";
            }
            if (cbItemName.Checked & cbItemDescription.Checked)
            // Search in both name and description.
            {
                itemSearchCondition = " AND (([name] LIKE N'%" + searchString + "%') OR ([description] LIKE N'%" + searchString + "%'))";
            }
            if (category == "All Categories" || category == null)
            {
                SQLCmd = SQLCmd + itemSearchCondition;
            }
            else
            {
                SQLCmd = SQLCmd + itemSearchCondition + " AND ([category] = N'" + category + "')";
            }
        }

        // Execute the SQL statement; order the result by item name.
        AsiaWebShopDBSqlDataSource.SelectCommand = SQLCmd + ") ORDER BY [name]";
        AsiaWebShopDBSqlDataSource.Select(DataSourceSelectArguments.Empty);

        // Bind the search result to the GridView control.
        gvItemSearchResult.DataBind();

        // Display a no result message if nothing was retrieved from the database.
        if (gvItemSearchResult.Rows.Count == 0)
        {
            lblSearchResultMessage.Text = "No records match your query." + lblSearchResultMessage.Text;
            lblSearchResultMessage.Visible = true;
        }
        else
        {
            lblSearchResultMessage.Text = "The following records match your query." + lblSearchResultMessage.Text;
            lblSearchResultMessage.Visible = true;
        }


    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        if (userName != "")
        {
            //Get the button that raised the event
            LinkButton LinkButton1 = (LinkButton)sender;

            //Get the row that contains this button
            GridViewRow gvr = (GridViewRow)LinkButton1.NamingContainer;
            string upc = gvItemSearchResult.DataKeys[gvr.RowIndex].Values["upc"].ToString();

            // Check if the quantity is zero.
            bool isZero = false;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
            {
                // Count how many existing records have the student id value.
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [item] WHERE ([upc] = N'" + upc + "')", connection);
                Int32 count = (Int32)command.ExecuteScalar();

                if (count != 0)
                {
                    SqlCommand test = new SqlCommand("SELECT quantityAvailable FROM [item] WHERE ([upc] = N'" + upc + "')", connection);
                    if ((Int32)test.ExecuteScalar() == 0)
                        isZero = true;
                }
                connection.Close();
            }

            // Check if the email alert is already sent.
            bool isAlert = false;
            using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
            {
                // Count how many existing records have the student id value.
                connection.Open();
                SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [WishListItem] WHERE (([userName] = N'" + userName + "') AND ([upc] = N'" + upc + "'))", connection);
                Int32 count = (Int32)command.ExecuteScalar();

                if (count != 0)
                {
                    SqlCommand test = new SqlCommand("SELECT isAlert FROM [WishListItem] WHERE (([userName] = N'" + userName + "') AND ([upc] = N'" + upc + "'))", connection);
                    isAlert = (bool)test.ExecuteScalar();
                }
                connection.Close();
            }

            if (isAlert == false)
            {
                // Create the connection and the SQL command.
                // Define the INSERT query with parameters.
                string query = "INSERT INTO [WishListItem]([userName], [upc], [emailSent], [isAlert])" +
                                       "VALUES (@userName, @upc, @emailSent, @isAlert)";
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Define the INSERT query parameters and their values.
                    command.Parameters.AddWithValue("@UserName", userName);
                    command.Parameters.AddWithValue("@upc", upc);
                    command.Parameters.AddWithValue("@emailSent", false);
                    command.Parameters.AddWithValue("@isAlert", true);

                    // Open the connection, execute the INSERT query and close the connection.
                    command.Connection.Open();
                    command.ExecuteNonQuery();
                    command.Connection.Close();
                }
                //ShowPopUpMsg("Alert added.");
                Response.Redirect("MemberOnly/WishList/WishListPage.aspx");
            }
            else
            {
                ShowPopUpMsg("Alert cannot be added.");
            }
        }
        else
        {
            Response.Redirect("Account/Login.aspx");
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