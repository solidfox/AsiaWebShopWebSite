using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class MemberOnly_ViewMemberInformation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;
        GetMemberData(connectionString, userName);
        GetMemberAddress(connectionString, userName);
        GetMemberCreditCard(connectionString, userName);
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
                    RenewalDate.Text = reader["renewalDate"].ToString().Trim();
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
                    Address.Text = reader["buildingAddress"].ToString().Trim();
                    Street.Text = reader["streetAddress"].ToString().Trim();
                    District.Text = reader["district"].ToString().Trim();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }

    private void GetMemberCreditCard(string connectionString, string userName)
    {
        // Define the SELECT query to get the member's credit card.
        string query = "SELECT [number], [type], [cardHolderName], [expiryMonth], [expiryYear] FROM [CreditCard] WHERE ([username] =N'" + userName + "')";

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
                    CardType.Text = reader["type"].ToString().Trim();
                    Month.Text = reader["expiryMonth"].ToString().Trim();
                    Year.Text = reader["expiryYear"].ToString().Trim();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }
}