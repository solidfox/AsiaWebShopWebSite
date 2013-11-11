using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ItemSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

        }
        Generate_Item_List();
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {

    }
    protected void btnSearch_Click(object sender, EventArgs e){
    }
    protected void Generate_Item_List()
    {
        // Get the search string and the category from the search page.
        string itemSearchCondition = "";
        string category = Request.QueryString["category"];
        string searchString = "";
        if (Page.IsPostBack) {
            searchString = txtSearchString.Text.Trim();
            category = categoryDropDownList.SelectedValue.Trim();
        }

        if (category == "All Categories")
        {
            category = null;
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
            if (category != null)
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
            if (category == "All Categories")
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
}