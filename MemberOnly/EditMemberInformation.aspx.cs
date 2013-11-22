using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;

using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class _Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        if (!Page.IsPostBack)
        {
            PopulateDistrictDropDownList();
            // Populate the YearDropDownList from current year to plus 10 years.
            YearDropDownList.Items.Add("Year");
            for (int year = DateTime.Now.Year; year <= DateTime.Now.Year + 10; year++)
            {
                YearDropDownList.Items.Add(year.ToString());
            }
            
            GetMemberData(connectionString, userName);
            GetMemberAddress(connectionString, userName);
            GetMemberCreditCard(connectionString, userName);
        }
    }

    private void PopulateDistrictDropDownList()
    {
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

    private void GetMemberData(string connectionString, string userName)
    {
        // Define the SELECT query to get the member's personal data.
        string query = "SELECT [userName], [email], [firstName], [lastName], [phoneNumber], [renewalDate] FROM [Member] WHERE ([username] =N'" + userName + "')";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Open the connection.
            command.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            SqlDataReader reader = command.ExecuteReader();
            // Check if a result was returned.   
            if (reader.HasRows)
            {
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    // Assign the data values to the web form labels.
                    UserName.Text = reader["userName"].ToString().Trim();
                    Email.Text = reader["email"].ToString().Trim();
                    FirstName.Text = reader["firstName"].ToString().Trim();
                    LastName.Text = reader["lastName"].ToString().Trim();
                    PhoneNumber.Text = reader["phoneNumber"].ToString().Trim();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }

    private void GetMemberAddress(string connectionString, string userName)
    {
        // Define the SELECT query to get the member's address.
        string query = "SELECT [buildingAddress], [streetAddress], [district] FROM [Address] WHERE ([username] =N'" + userName + "')";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Open the connection.
            command.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            SqlDataReader reader = command.ExecuteReader();
            // Check if a result was returned.
            if (reader.HasRows)
            {
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    // Assign the data values to the web form labels.
                    String buildingAddress = reader["buildingAddress"].ToString().Trim();
                    String[] splitBuildingAddress = buildingAddress.Split(" ".ToCharArray());
                    switch (splitBuildingAddress.Length) 
                    {
                        case 4: 
                            BlockTower.Text = splitBuildingAddress[3];
                            goto case 3;
                        case 3:
                            FlatSuite.Text = splitBuildingAddress[2];
                            goto case 2;
                        case 2:
                            Floor.Text = splitBuildingAddress[1];
                            goto case 1;
                        case 1: 
                            Building.Text = splitBuildingAddress[0];
                            break;
                        default: 
                            Building.Text = buildingAddress;
                            break;
                    }
                    Street.Text = reader["streetAddress"].ToString().Trim();
                    SelectDropDownItemByValue(DistrictDropDownList, reader["district"].ToString().Trim());
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }

    private void SelectDropDownItemByValue(DropDownList list, String value)
    {
        ListItemCollection items = list.Items;
        int index = items.IndexOf(items.FindByValue(value));
        if (index >= 0)
        {
            list.SelectedIndex = index;
        }
        else
        {
            Debug.WriteLine(value + " could not be selected from DropDownList " + list.ID);
        }
    }

    private void GetMemberCreditCard(string connectionString, string userName)
    {
        // Define the SELECT query to get the member's credit card.
        string query = "SELECT [number], [type], [cardHolderName], [expiryMonth], [expiryYear] FROM [CreditCard] " + 
            "WHERE ([username] =N'" + userName + "')";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Open the connection.
            command.Connection.Open();
            // Execute the SELECT query and place the result in a DataReader.
            SqlDataReader reader = command.ExecuteReader();
            // Check if a result was returned.
            if (reader.HasRows)
            {
                // Iterate through the table to get the retrieved values.
                while (reader.Read())
                {
                    // Assign the data values to the web form labels.
                    CardHolderName.Text = reader["cardHolderName"].ToString().Trim();
                    CardNumber.Text = reader["number"].ToString().Trim();
                    SelectDropDownItemByValue(CardTypeDropDownList, reader["type"].ToString().Trim());
                    SelectDropDownItemByValue(MonthDropDownList, reader["expiryMonth"].ToString().Trim());
                    SelectDropDownItemByValue(YearDropDownList, reader["expiryYear"].ToString().Trim());
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }

    protected void UpdateMember(string connectionString, string userName, string email, string firstName, string lastName, string phoneNumber)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [Member] SET email=@Email, firstName=@FirstName, lastName=@LastName, phoneNumber=@PhoneNumber " +
                       "WHERE [userName]=@UserName";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@UserName", userName);
            command.Parameters.AddWithValue("@Email", email);
            command.Parameters.AddWithValue("@FirstName", firstName);
            command.Parameters.AddWithValue("@LastName", lastName);
            command.Parameters.AddWithValue("@PhoneNumber", phoneNumber);

            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    protected void UpdateAddress(string connectionString, string userName, string buildingAddress, string streetAddress, string district)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [Address] SET buildingAddress=@BuildingAddress, streetAddress=@StreetAddress, district=@District " +
                               "WHERE [userName]=@UserName";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@UserName", userName);
            command.Parameters.AddWithValue("@BuildingAddress", buildingAddress);
            command.Parameters.AddWithValue("@StreetAddress", streetAddress);
            command.Parameters.AddWithValue("@District", district);

            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    protected void UpdateCreditCard(string connectionString, string userName, string number, string type, string cardHolderName, string expiryMonth, string expiryYear)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [CreditCard] SET userName=@Username, number=@Number, type=@Type, cardHolderName=@CardHolderName, expiryMonth=@ExpiryMonth, expiryYear=@ExpiryYear " +
                       "WHERE [userName]=@Username";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@Username", userName);
            command.Parameters.AddWithValue("@Number", number);
            command.Parameters.AddWithValue("@Type", type);
            command.Parameters.AddWithValue("@CardHolderName", cardHolderName);
            command.Parameters.AddWithValue("@ExpiryMonth", expiryMonth);
            command.Parameters.AddWithValue("@ExpiryYear", expiryYear);

            // Open the connection, execute the UPDATE query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }
    protected void Register_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid) {
            return;
        }
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;
        // After the registration information is validated, add the member data into the database.
        UpdateMember(connectionString,
            userName,
            Email.Text.Trim(),
            FirstName.Text.Trim(),
            LastName.Text.Trim(),
            PhoneNumber.Text.Trim());

        // After the registration information is validated, add the address data into the database.
        UpdateAddress(connectionString,
            userName,
            (Building.Text.Trim() + " " +
            Floor.Text.Trim() + " " +
            FlatSuite.Text.Trim() + " " +
            BlockTower.Text.Trim()),
            Street.Text.Trim(),
            DistrictDropDownList.SelectedItem.Text.Trim());

        // After the registration information is validated, add the credit card data into the database.
        UpdateCreditCard(connectionString,
            userName,
            CardNumber.Text.Trim(),
            CardTypeDropDownList.SelectedItem.Text.Trim(),
            CardHolderName.Text.Trim(),
            MonthDropDownList.SelectedItem.Text.Trim(),
            YearDropDownList.SelectedItem.Text.Trim());

        Response.Redirect("MemberSelection.aspx");
    }
}
