﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MemberOnly_ListUnshippedOrder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SqlDataSource1.SelectParameters["userName"].DefaultValue = User.Identity.Name;
        SqlDataSource2.SelectParameters["userName"].DefaultValue = User.Identity.Name;
    }
    
}