using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
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
            // Populate the YearDropDownList from current year to plus 10 years.
            YearDropDownList.Items.Add("Year");
            for (int year = DateTime.Now.Year; year <= DateTime.Now.Year + 10; year++)
            {
                YearDropDownList.Items.Add(year.ToString());
            }
        }
    }
}
