using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data.SqlClient;
using System.Configuration;
using System.Data;


public partial class Account_Register : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            PopulateDropDownLists();
        }

        RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
    }

    protected void RegisterUser_CreatedUser(object sender, EventArgs e)
    {
        string connectionString = "AsiaWebShopDBConnectionString";
        // After the registration information is validated, add the member data into the database.
        InsertMember(connectionString,
            RegisterUser.UserName.Trim(),
            RegisterUser.Email.Trim(),
            ((TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("FirstName")).Text.Trim(),
            ((TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("LastName")).Text.Trim(),
            ((TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("PhoneNumber")).Text.Trim(),
            (DateTime.Today.AddYears(1).ToString().Trim()));

        // After the registration information is validated, add the address data into the database.
        InsertAddress(connectionString,
            RegisterUser.UserName.Trim(),
            (((TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("Building")).Text.Trim() + " " +
            ((TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("Floor")).Text.Trim() + " " +
            ((TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("FlatSuite")).Text.Trim() + " " +
            ((TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("BlockTower")).Text.Trim()),
            ((TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("Street")).Text.Trim(),
            ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).SelectedItem.Text.Trim());

        // After the registration information is validated, add the credit card data into the database.
        InsertCreditCard(connectionString,
            RegisterUser.UserName.Trim(),
            ((TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("CardNumber")).Text.Trim(),
            ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("CardTypeDropDownList")).SelectedItem.Text.Trim(),
            ((TextBox)RegisterUserWizardStep.ContentTemplateContainer.FindControl("CardHolderName")).Text.Trim(),
            ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("MonthDropDownList")).SelectedItem.Text.Trim(),
            ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("YearDropDownList")).SelectedItem.Text.Trim());

        
        // Assign the user to the Student role.
        Roles.AddUserToRole(RegisterUser.UserName, "Member");

        FormsAuthentication.SetAuthCookie(RegisterUser.UserName, false /* createPersistentCookie */);

        string continueUrl = RegisterUser.ContinueDestinationPageUrl;
        if (String.IsNullOrEmpty(continueUrl))
        {
            continueUrl = "~/";
        }
        Response.Redirect(continueUrl);
    }

    protected void RegisterUser_CreatingUser(object sender, LoginCancelEventArgs e)
    {
        
    }

    protected void InsertMember(string connectionString, string userName, string email, string firstName, string lastName, string phoneNumber, string renewalDate)
    {
        // Define the INSERT query with parameters.
        string query = "INSERT INTO [Member]([userName], [email], [firstName], [lastName], [phoneNumber], [renewalDate])" +
                       "VALUES (@UserName, @Email, @FirstName, @LastName, @PhoneNumber, @RenewalDate)";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the INSERT query parameters and their values.
            command.Parameters.AddWithValue("@UserName", userName);
            command.Parameters.AddWithValue("@Email", email);
            command.Parameters.AddWithValue("@FirstName", firstName);
            command.Parameters.AddWithValue("@LastName", lastName);
            command.Parameters.AddWithValue("@PhoneNumber", phoneNumber);
            command.Parameters.AddWithValue("@RenewalDate", renewalDate);

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    protected void InsertAddress(string connectionString, string userName, string buildingAddress, string streetAddress, string district)
    {
        // Define the INSERT query with parameters.
        string query = "INSERT INTO [Address]([userName], [buildingAddress], [streetAddress], [district])" +
                               "VALUES (@UserName, @BuildingAddress, @StreetAddress, @District)";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the INSERT query parameters and their values.
            command.Parameters.AddWithValue("@UserName", userName);
            command.Parameters.AddWithValue("@BuildingAddress", buildingAddress);
            command.Parameters.AddWithValue("@StreetAddress", streetAddress);
            command.Parameters.AddWithValue("@District", district);

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    protected void InsertCreditCard(string connectionString, string userName, string number, string type, string cardHolderName, string expiryMonth, string expiryYear)
    {
        // Define the INSERT query with parameters.
        string query = "INSERT INTO [CreditCard]([userName], [number], [type], [cardHolderName], [expiryMonth], [expiryYear])" +
                       "VALUES (@Username, @Number, @Type, @CardHolderName, @ExpiryMonth, @ExpiryYear)";

        // Create the connection and the SQL command.
        using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings[connectionString].ConnectionString))
        using (SqlCommand command = new SqlCommand(query, connection))
        {
            // Define the INSERT query parameters and their values.
            command.Parameters.AddWithValue("@Username", userName);
            command.Parameters.AddWithValue("@Number", number);
            command.Parameters.AddWithValue("@Type", type);
            command.Parameters.AddWithValue("@CardHolderName", cardHolderName);
            command.Parameters.AddWithValue("@ExpiryMonth", expiryMonth);
            command.Parameters.AddWithValue("@ExpiryYear", expiryYear);

            // Open the connection, execute the INSERT query and close the connection.
            command.Connection.Open();
            command.ExecuteNonQuery();
            command.Connection.Close();
        }
    }

    protected void PopulateDropDownLists()
    {
        // Populate the DistrictDropDownList.
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Central and Western");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Eastern");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Islands");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Kowloon City");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Kwai Tsing");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Kwun Tong");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("North");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Sai Kung");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Sha Tin");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Sham Shui Po");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Southern");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Tai Po");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Tsuen Wan");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Tuen Mun");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Wan Chai");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Wong Tai Sin");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Yau Tsim Mong");
        ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("DistrictDropDownList")).Items.Add("Yuen Long");

        // Populate the YearDropDownList from current year to plus 10 years.
        for (int year = DateTime.Now.Year; year <= DateTime.Now.Year + 10; year++)
        {
            ((DropDownList)RegisterUserWizardStep.ContentTemplateContainer.FindControl("YearDropDownList")).Items.Add(year.ToString());
        }
    }
}

  