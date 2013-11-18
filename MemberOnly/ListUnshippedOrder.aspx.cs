using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class MemberOnly_ListUnshippedOrder : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            SqlDataSource1.SelectParameters["userName"].DefaultValue = User.Identity.Name;
        }
        AddUnshippedOrderToGrid();

    }

    protected void AddUnshippedOrderToGrid()
    {
        DateTime currentDT = DateTime.Now.Date;
        int currentid = GenericQuery.GetCurrentHourID();

        DataTable UnshippedOrder = new DataTable();
        // Define the columns of the DataTable.
        UnshippedOrder.Columns.Add("orderNum", typeof(int));
        UnshippedOrder.Columns.Add("orderDate", typeof(string));
        UnshippedOrder.Columns.Add("deliveryDate", typeof(string));
        UnshippedOrder.Columns.Add("TimeSlot", typeof(string));
        UnshippedOrder.Columns.Add("deliveryAddress", typeof(string));
        UnshippedOrder.Columns.Add("deliveryDistrict", typeof(string));


        string connectionString = "AsiaWebShopDBConnectionString";
        string userName = User.Identity.Name;

        string query = "SELECT  [Order].orderNum, [Order].orderDateTime, [Order].deliveryDateOffset, [Order].timeSlotID,[Order].deliveryAddress,[Order].deliveryDistrict, timeSlot.slot FROM [Order] INNER JOIN timeSlot ON timeSlot.id=[Order].timeSlotID   WHERE (userName = N'" + userName + "') AND (confirmationNumber IS NOT NULL)";

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
                    int orderNum = (int)reader["orderNum"];
                    DateTime orderDateTime = (DateTime)reader["orderDateTime"];
                    int deliveryDateOffset = (byte)reader["deliveryDateOffset"];
                    int timeSlotID = (int)reader["timeSlotID"];
                    string timeSlot = (string)reader["slot"];
                    string deliveryAddress = (string)reader["deliveryAddress"];
                    string deliveryDistrict = (string)reader["deliveryDistrict"];
                    bool OKAddRow = false;

                    if (orderDateTime.AddDays(7).Date > currentDT.Date)
                    {
                        if (orderDateTime.AddDays(deliveryDateOffset).Date > currentDT.AddDays(1).Date)
                        {
                            OKAddRow = true;

                        }
                        else if (orderDateTime.AddDays(deliveryDateOffset).Date == currentDT.AddDays(1).Date)
                        {
                            if (currentid < timeSlotID)
                            { OKAddRow = true; }
                        }
                    }

                    if (OKAddRow)
                    {
                        DataRow UnshippedOrderRow = UnshippedOrder.NewRow();
                        UnshippedOrderRow["orderNum"] = orderNum;
                        UnshippedOrderRow["orderDate"] = orderDateTime.ToShortDateString();
                        UnshippedOrderRow["deliveryDate"] = orderDateTime.AddDays(deliveryDateOffset).ToShortDateString();
                        UnshippedOrderRow["TimeSlot"] = timeSlot;
                        UnshippedOrderRow["deliveryAddress"] = deliveryAddress;
                        UnshippedOrderRow["deliveryDistrict"] = deliveryDistrict;
                        UnshippedOrder.Rows.Add(UnshippedOrderRow);
                    }
                }


            }

            // Close the connection and the DataReader.
            command.Connection.Close();
            reader.Close();

            // Set the DataTable as the datasource for the shopping cart Gridview.

            GridView1.DataSource = UnshippedOrder;
            GridView1.DataBind();
        }


    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        AddUnshippedOrderToGrid();
    }
}