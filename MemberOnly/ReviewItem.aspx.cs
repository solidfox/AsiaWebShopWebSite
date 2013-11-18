using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text.RegularExpressions;

public partial class MemberOnly_AllPurchase : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReviewedItemDataSource.SelectParameters["userName"].DefaultValue = User.Identity.Name;
        UniquePurchaseDataSource.SelectParameters["userName"].DefaultValue = User.Identity.Name;
    }


    protected void SubmitReview_Click(object sender, EventArgs e)
    {

        string selectedUpc =((Label)UniquePurchaseGridView.SelectedRow.FindControl("upcLabel")).Text.ToString().Trim();
           

        string connectionString = "AsiaWebShopDBConnectionString";
        string query = "INSERT INTO [Review]([userName], [upc], [quality], [features], [performance], [appearance], [durability],[comment])" +
                       "VALUES (@Username, @Upc, @Quality, @Features,@Performance, @Appearance, @Durability, @Comment)";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the INSERT query parameters and their values.
            command.Parameters.AddWithValue("@Username", User.Identity.Name);
            command.Parameters.AddWithValue("@Upc", selectedUpc);
            command.Parameters.AddWithValue("@Quality", qualityDropDownList.SelectedValue);
            command.Parameters.AddWithValue("@Features", featuresDropDownList.SelectedValue);
            command.Parameters.AddWithValue("@Performance", performanceDropDownList.SelectedValue);
            command.Parameters.AddWithValue("@Appearance", appearanceDropDownList.SelectedValue);
            command.Parameters.AddWithValue("@Durability", durabilityDropDownList.SelectedValue);
            command.Parameters.AddWithValue("@Comment", commentTextBox.Text.ToString().Trim());

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
        UniquePurchaseGridView.DataBind();
        ReviewedItemGridView.DataBind();
        ReviewPanel.Visible = false;
    }


    protected void OnItemIndexChanged(object sender, EventArgs e)
    {
        ReviewPanel.Visible = true;
        ItemNameLabel.Text = ((Label)UniquePurchaseGridView.SelectedRow.FindControl("ItemNameGrid")).Text;
    }



}