using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class MemberOnly_DeliveryAndPayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //DB connection
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        GetMemberAddress(connectionString, userName);
        GetMemberCreditCard(connectionString, userName);
        PopulateDropdownList();

    }
    private void GetMemberAddress(string connectionString, string userName)
    {
        //Define the SQL query to get the addresses of the member
        string query = "SELECT [nickname] FROM [Address] WHERE ([username] =N'" + userName + "')";
        
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
                    SelectAddress.DataSource = reader;
                    SelectAddress.DataValueField = "nickname";
                    SelectAddress.DataTextField = "nickname";
                    SelectAddress.DataBind();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }
    private void GetMemberCreditCard(string connectionString, string userName)
    {
        //Define the SQL query to get the credit card no. of the member
        string query = "SELECT [number] FROM [CreditCard] WHERE ([username] =N'" + userName + "')";

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
                    SelectCreditCard.DataSource = reader;
                    SelectCreditCard.DataValueField = "number";
                    SelectCreditCard.DataTextField = "number";
                    SelectCreditCard.DataBind();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }
    protected void PopulateDropdownList()
    {
        //Populate the SelectDate dropdown list 7 days from current day
        for (DateTime date = DateTime.Now.Date.AddDays(1); date <= DateTime.Now.Date.AddDays(7); date.AddDays(1))
        {
            SelectDate.Items.Add(new ListItem(date.ToString(), date.ToString()));
        }
        //Populate the SelectDate dropdown list
        SelectTime.Items.Add(new ListItem("09:00-12:00", "09:00:00"));
        SelectTime.Items.Add(new ListItem("12:00-15:00", "12:00:00"));
        SelectTime.Items.Add(new ListItem("15:00-18:00", "15:00:00"));
        SelectTime.Items.Add(new ListItem("18:00-21:00", "18:00:00"));

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //DB connection
        string connectionString = "AsiaWebShopDBConnectionString";
        
        //Get Data
        string userName = User.Identity.Name;
        string selectedAddress = SelectAddress.SelectedValue;
        string selectedTime = SelectDate.SelectedValue + " " + SelectTime.SelectedValue;

        //Update DB
        InsertDeliveryAddress(connectionString, userName, selectedAddress);
        //UpdateDeliveryTime(connectionString, orderNum, selectedTime);        

    }
    private void InsertDeliveryAddress(string connectionString, string userName, string address)
    {
        //Define the query to get the address of member
        string GETquery = "SELECT [buildingAddress], [streetAddress], [district] FROM [Address] WHERE ([username] =N'" + userName + "' AND [nickname] =N'" + address + "')";

        //Define the string storing the address temporarily
        string buildingAddress;
        string streetAddress;
        string district;

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(GETquery, connection))
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
                    // Assign the data values to the temp strings.
                    buildingAddress = reader["buildingAddress"].ToString().Trim();
                    streetAddress = reader["streetAddress"].ToString().Trim();
                    district = reader["district"].ToString().Trim();
                }
            }
            
            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }

        //UpdateDeliveryAddress(connectionString, orderNum, buildingAddress, streetAddress, district);
    }
    private void UpdateDeliveryAddress(string connectionString, int orderNum, string buildingAddress, string streetAddress, string district)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [Order] SET deliveryAddress=@DeliveryAddress, deliveryDistrict=@District " +
                       "WHERE [orderNum]=@OrderNum";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            //Combine the address
            string deliveryAddress = buildingAddress + " " + streetAddress;
            
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@DeliveryAddress", deliveryAddress);
            command.Parameters.AddWithValue("@District", district);

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }
    
    private void UpdateDeliveryTime(string connectionString, int orderNum, string selectedTime)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [Order] SET deliveryTime=@DeliveryTime " +
                       "WHERE [orderNum]=@OrderNum";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@DeliveryTime", selectedTime);

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    protected void cvDeliveryDate_ServerValidate1(object source, ServerValidateEventArgs args)
    {
        string selected = SelectDate.SelectedValue + " " + SelectTime.SelectedValue;
        DateTime selectedTime = DateTime.Parse(selected);

        if (DateTime.Compare(DateTime.Now.Date.AddDays(1), selectedTime) >= 0)
        {
            args.IsValid = false;
        }
    }
    protected void cvDeliveryDate_ServerValidate(object source, ServerValidateEventArgs args)
    {
        string selected = SelectDate.SelectedValue + " " + SelectTime.SelectedValue;
        DateTime selectedTime = DateTime.Parse(selected);

        if (DateTime.Compare(DateTime.Now.Date.AddDays(1), selectedTime) >= 0)
        {
            args.IsValid = false;
        }
    }
}