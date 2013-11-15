using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class createAddress : System.Web.UI.Page
{
    string userName;
    protected void Page_Load(object sender, EventArgs e)
    {
        userName = User.Identity.Name;

        if (!Page.IsPostBack)
        {
            // Populate the DistrictDropDownList.
            DistrictDropDownList.Items.Add("-- Select district --");
            DistrictDropDownList.Items.Add("Central and Western");
            DistrictDropDownList.Items.Add("Eastern");
            DistrictDropDownList.Items.Add("Islands");
            DistrictDropDownList.Items.Add("Kowloon City");
            DistrictDropDownList.Items.Add("Kwai Tsing");
            DistrictDropDownList.Items.Add("Kwun Tong");
            DistrictDropDownList.Items.Add("North");
            DistrictDropDownList.Items.Add("Sai Kung");
            DistrictDropDownList.Items.Add("Sha Tin");
            DistrictDropDownList.Items.Add("Sham Shui Po");
            DistrictDropDownList.Items.Add("Southern");
            DistrictDropDownList.Items.Add("Tai Po");
            DistrictDropDownList.Items.Add("Tsuen Wan");
            DistrictDropDownList.Items.Add("Tuen Mun");
            DistrictDropDownList.Items.Add("Wan Chai");
            DistrictDropDownList.Items.Add("Wong Tai Sin");
            DistrictDropDownList.Items.Add("Yau Tsim Mong");
            DistrictDropDownList.Items.Add("Yuen Long");
        }
    }
    protected void cvNickName_ServerValidate(object source, ServerValidateEventArgs args)
    {
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["AsiaWebShopDBConnectionString"].ConnectionString))
        {
            // Get the value of the new student id from the DetailsView control.
            TextBox AddressList = (TextBox)NickName;

            // Count how many existing records have the student id value.
            connection.Open();
            SqlCommand command = new SqlCommand("SELECT COUNT(*) FROM [Address] WHERE (([nickname] = N'" + AddressList.Text + "') AND ([userName] = N'"+ userName +"'))", connection);
            Int32 count = (Int32)command.ExecuteScalar();
            connection.Close();

            // If the count is not zero the student id already exists, so cancel the insert.
            if (count != 0)
            {
                args.IsValid = false;
            }
        }
    }
    protected void InsertAddress(string connectionString, string userName, string nickname, string buildingAddress, string streetAddress, string district)
    {
        // Define the INSERT query with parameters.
        string query = "INSERT INTO [Address]([userName], [nickname], [buildingAddress], [streetAddress], [district])" +
                               "VALUES (@UserName, @nickname, @BuildingAddress, @StreetAddress, @District)";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the INSERT query parameters and their values.
            command.Parameters.AddWithValue("@UserName", userName);
            command.Parameters.AddWithValue("@nickname", nickname);
            command.Parameters.AddWithValue("@BuildingAddress", buildingAddress);
            command.Parameters.AddWithValue("@StreetAddress", streetAddress);
            command.Parameters.AddWithValue("@District", district);

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }
    protected void Create_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
        {
            return;
        }
        ShowPopUpMsg("!@#");
        string connectionString = "AsiaWebShopDBConnectionString";
        InsertAddress(connectionString,
            userName,
            NickName.Text.Trim(),
            Building.Text.Trim() + " " +
            Floor.Text.Trim() + " " +
            Flat.Text.Trim() + " " +
            Block.Text.Trim(),
            Street.Text.Trim(),
            DistrictDropDownList.SelectedItem.Text.Trim());
        Response.Redirect("ManageDeliveryAddressList.aspx");
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