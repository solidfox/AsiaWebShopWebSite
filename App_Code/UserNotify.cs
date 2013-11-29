using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;

/// <summary>
/// Summary description for GetUserName
/// </summary>
public class UserNotify
{
    public static string Inform = "Have Fun!!";
    public static string item = "";
    public static string add = "";
    public UserNotify(string Msg) 
    {
        Inform = Msg;
    }

    public static void outstock(string msg)
    {
        if(item != "")
        {
            item += " AND ";
        }

        item += msg;
    }

    public static void clearitem()
    {
        item = "";
    }
    public static void clearadd()
    {
        add = "";
    }
   

}