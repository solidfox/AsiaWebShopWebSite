using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/*
 * The CreditCardConfirmation class
 * In reality this should probably be an interface. 
 */
public class CreditCardAuthorization
{
    // A protected constructor ensures that an object cannot be created from outside.
    protected CreditCardAuthorization() { }
    
    public static string chargeCard(string cardNumber, decimal purchaseAmount)
    {
        return (new Random()).Next(1000, 9999).ToString();
    }


}

