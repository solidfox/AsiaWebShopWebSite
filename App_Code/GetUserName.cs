using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for GetUserName
/// </summary>
public class GetUserName
{
    public static string UserName;
	public GetUserName(string username)
	{
        UserName = username;
	}

    public static string GiveMe()
    {
        return UserName;
    }
}