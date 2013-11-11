using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/*
 * The ShoppingCart class
 * It holds the items that are in the cart and provides methods for their manipulation. 
 */
public class ShoppingCart
{

#region Properties
    // A shopping cart is a List of CartItem.
    public List<CartItem> Items {get; private set;}
    string connectionString = "AsiaWebShopDBConnectionString";
#endregion

#region Singleton Implementation of ShoppingCart
    // Readonly properties can only be set in initialization or in a constructor.
    public static readonly ShoppingCart Instance;

    // The static constructor is called as soon as the class is loaded into memory.
    public static ShoppingCart GetShoppingCart()
    {
        // If the cart is not in the session, create one and put it there.
        if (HttpContext.Current.Session["MyShoppingCart"] == null)
        {
            ShoppingCart cart = new ShoppingCart();
            cart.Items = new List<CartItem>();
            /******
             * TODO: Load any previously saved items into the shopping cart from the database.
             */
            // Save the shopping cart in the Session variable "MyShoppingCart".
            HttpContext.Current.Session["MyShoppingCart"] = cart;
        }
        return (ShoppingCart)HttpContext.Current.Session["MyShoppingCart"];
    }

    // A protected constructor ensures that an object cannot be created from outside.
    protected ShoppingCart() { }
#endregion

#region Shopping Cart Item Modification Methods
    /*
     * AddItem() adds an item to the shopping cart.
     */
    public void AddItem(string upc, string name, decimal discountPrice)
    {
        // Create a new item to add to the cart.
        CartItem newItem = new CartItem(upc);

        // If this item already exists in the list of items, increase the quantity.
        // Otherwise, add the new item to the list of items with quantity 1;
        if (Items.Contains(newItem))
        {
            foreach (CartItem item in Items)
            {
                if (item.Equals(newItem))
                {
                    int test = item.Quantity + 1;
                    if (CheckItemStock(connectionString, newItem, test))
                    {
                        item.Quantity++;
                        return;
                    }
                    
                }
            }
        }

        else if (CheckItemStock(connectionString, newItem, 1))
        {
            newItem.UPC = upc;
            newItem.ItemName = name;
            newItem.DiscountPrice = discountPrice;
            newItem.Quantity = 1;
            Items.Add(newItem);
        }

        else
        {
            // Inform the user the quantity is alreadt exceed the stock
            return;
        }
    }

    /*
     * SetItemQuantity() changes the quantity of an item in the shopping cart.
     */
    public void SetItemQuantity(string upc, int quantity)
    {
        // If the quantity is set to 0, remove the item entirely.
        if (quantity == 0)
        {
            RemoveItem(upc);
            return;
        }

        // Find the item and update the quantity.
        CartItem updatedItem = new CartItem(upc);
        foreach (CartItem item in Items)
        {
            if (item.Equals(updatedItem) && CheckItemStock (connectionString, updatedItem, quantity))
            {
                item.Quantity = quantity;
                return;
            }
        }
            // Inform the user the quantity is alreadt exceed the stock
            return;
    }

    // need to debug
    public int GetItemQuantity (string upc)
    {
        CartItem updatedItem = new CartItem(upc);
        foreach (CartItem item in Items)
        {
            if (item.Equals(updatedItem))
            {
                return item.Quantity;
            }
        }
        return 0;
    }

    /*
     * RemoveItem() removes an item from the shopping cart.
     */
    public void RemoveItem(string upc)
    {
        CartItem removedItem = new CartItem(upc);
        Items.Remove(removedItem);
    }

    // query on the database, check the stock
    public bool CheckItemStock(string connectionString, CartItem item, int Comparision)
    {
        string query = "SELECT [quantityAvailable] FROM [Item] WHERE ([upc] =N'" + item.UPC + "')";
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
                    // ToAsk: what happens when there are two rows ?
                    if ( reader.GetInt32(0) >= Comparision) 
                    {
                        return true;
                    }
                }
                command.Connection.Close(); // Close the connection and the DataReader.
                reader.Close();
            }
        }
        return false;
    }
#endregion

#region Reporting Methods
    /*
     * GetCartTotal() returns the total price of all of the items in the shopping cart.
     */
    public decimal GetCartTotal()
    {
        decimal cartTotal = 0;
        foreach (CartItem item in Items)
            cartTotal += item.TotalPrice;
        return cartTotal;
    }
#endregion
}

