using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Diagnostics;

public partial class MemberOnly_DeliveryAndPayment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //DB connection
        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        int orderNum = Convert.ToInt32(Request.QueryString["orderNum"].Trim());

        if (!Page.IsPostBack)
        {
            GetMemberData(connectionString, userName);
            GetCreditCard(connectionString, orderNum);
            PopulateMemberAddress(connectionString, userName);
            PopulateDropdownList(connectionString, orderNum);
            PopulateDistrictDropDownList();
        }
        if (Request.Form["ctl00$MainContent$btnSubmit"] == null)
        {
            SelectAddress_SelectedIndexChanged(sender, e);
        }
    }
    private void GetMemberData(string connectionString, string userName)
    {
        // Define the SELECT query to get the member's personal data.
        string query = "SELECT [email], [firstName], [lastName], [phoneNumber] FROM [Member] WHERE ([username] =N'" + userName + "')";

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
                    EmailAddress.Text = reader["email"].ToString().Trim();
                    FirstName.Text = reader["firstName"].ToString().Trim();
                    LastName.Text = reader["lastName"].ToString().Trim();
                    TelephoneNo.Text = reader["phoneNumber"].ToString().Trim();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }
    private void GetCreditCard(string connectionString, int orderNum)
    {
        // Define the SELECT query to get the order's credit card info.
        string query = "SELECT [creditCardtype], [creditCardNumber] FROM [Order] WHERE ([orderNum] =N'" + orderNum + "')";

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
                    cardNum.Text = reader["creditCardNumber"].ToString().Trim();
                    cardType.Text = reader["creditCardtype"].ToString().Trim();
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }
    private void PopulateMemberAddress(string connectionString, string userName)
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
                    SelectAddress.Items.Add(new ListItem(reader["nickname"].ToString().Trim(), reader["nickname"].ToString().Trim()));
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }
    }
    protected void SelectAddress_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DB connection
        string nickname = SelectAddress.SelectedValue;
        string userName = User.Identity.Name;
        string connectionString = "AsiaWebShopDBConnectionString";
        
        // Define the SELECT query to get the member's address.
        string query = "SELECT [buildingAddress], [streetAddress], [district] FROM [Address] WHERE ([username] =N'" + userName + "' AND [nickname] =N'" + nickname +"')";

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
    protected void PopulateDropdownList(string connectionString, int orderNum)
    {
        DateTime orderDateTime = DateTime.Now.AddYears(100);
        
        // Define the SELECT query to get the orderDateTime.
        string query = "SELECT [orderDateTime] FROM [Order] WHERE ([orderNum] =N'" + orderNum + "')";

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
                    orderDateTime = DateTime.Parse(reader["orderDateTime"].ToString().Trim());
                }
            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();
        }

        TimeSpan difference = DateTime.Now.Date.AddDays(1) - orderDateTime;

        //Populate the SelectDate dropdown list 7 days from current day
        for (int count = difference.Days; count <= 7; count++)
        {
            SelectDate.Items.Add(new ListItem(DateTime.Now.Date.AddDays(count).ToShortDateString(), count.ToString()));
        }
        //Populate the SelectDate dropdown list
        SelectTime.Items.Add(new ListItem("09:00-12:00", "1"));
        SelectTime.Items.Add(new ListItem("12:00-15:00", "2"));
        SelectTime.Items.Add(new ListItem("15:00-18:00", "3"));
        SelectTime.Items.Add(new ListItem("18:00-21:00", "4"));

    }
    protected void cvDeliveryDate_ServerValidate1(object source, ServerValidateEventArgs args)
    {
        int selectedDate = Convert.ToInt32(SelectDate.SelectedValue);
        int selectedTime = Convert.ToInt32(SelectTime.SelectedValue);

        int currentHour = GetCurrentHourID();

        if (selectedDate == 1 && currentHour >= selectedTime)
        {
            args.IsValid = false;
        }
    }
    protected void cvDeliveryDate_ServerValidate(object source, ServerValidateEventArgs args)
    {
        int selectedDate = Convert.ToInt32(SelectDate.SelectedValue);
        int selectedTime = Convert.ToInt32(SelectTime.SelectedValue);

        int currentHour = GetCurrentHourID();

        if (selectedDate == 1 && currentHour >= selectedTime)
        {
            args.IsValid = false;
        }
    }
    protected int GetCurrentHourID()
    {
        int hour = DateTime.Now.Hour;
        int hourID = 0;
        if (hour >= 9 && hour < 12) { hourID = 1; }//Time Slot 1
        else if (hour >= 12 && hour < 15) { hourID = 2; }//Time Slot 2
        else if (hour >= 15 && hour < 18) { hourID = 3; }//Time Slot 3
        else if (hour >= 18 && hour < 24) { hourID = 4; }//Time Slot 4
        else { hourID = 0; }
        return hourID;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //for invlaid input, stay at this page
        if (!Page.IsValid)
        {
            return;
        }
        
        //DB connection
        string connectionString = "AsiaWebShopDBConnectionString";
        
        //Get Data
        string userName = User.Identity.Name;
        string buildingAddress = Building.Text.Trim() + " " + Floor.Text.Trim() + " " + FlatSuite.Text.Trim() + " " + BlockTower.Text.Trim();
        string streetAddress = Street.Text.Trim();
        string district = DistrictDropDownList.SelectedValue;
        string selectedDate = SelectDate.SelectedValue; 
        string selectedTime = SelectTime.SelectedValue;
        int orderNum = Convert.ToInt32(Request.QueryString["orderNum"].Trim());

        //Update DB
        /*InsertDeliveryAddress(connectionString, userName, selectedAddress);*/
        UpdateDeliveryAddress(connectionString, orderNum, buildingAddress, streetAddress, district);
        UpdateDeliveryTime(connectionString, orderNum, selectedDate, selectedTime);
        
        //Go to the confirmation page
        Response.Redirect("ListUnshippedOrder.aspx");

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
            command.Parameters.AddWithValue("@OrderNum", orderNum);
            command.Parameters.AddWithValue("@DeliveryAddress", deliveryAddress);
            command.Parameters.AddWithValue("@District", district);

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }
    private void UpdateDeliveryTime(string connectionString, int orderNum, string selectedDate, string selectedTime)
    {
        // Define the UPDATE query with parameters.
        string query = "UPDATE [Order] SET orderDateTime=@OrderDateTime, deliveryDateOffset=@DeliveryDateOffset, timeSlotID=@TimeSlotID " +
                       "WHERE [orderNum]=@OrderNum";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the UPDATE query parameters and their values.
            command.Parameters.AddWithValue("@OrderNum", orderNum);
            command.Parameters.AddWithValue("@DeliveryDateOffset", Convert.ToInt32(selectedDate));
            command.Parameters.AddWithValue("@TimeSlotID", Convert.ToInt32(selectedTime));
            command.Parameters.AddWithValue("@OrderDateTime", DateTime.Now.Date);
            
            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }
}