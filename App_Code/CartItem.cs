using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/*
 * The CartItem Class
 * Defines a structure for holding the item data.
 */
public class CartItem:IEquatable<CartItem>
{
    #region Properties
    // An item in the cart has a upc, name, quantity, discount price and total price.
    public string UPC { get; set; }
    public string ItemName {get; set; }
    public int Quantity { get; set; }
    public decimal DiscountPrice { get; set; }
    public decimal TotalPrice
    {
        get{return DiscountPrice * Quantity;}
    }
    #endregion

    // CartItem constructor just needs a upc.
    public CartItem(string upc)
    {
        this.UPC = upc;
    }

    /*
     * Equals() is needed to implement the IEquatable interface.
     * It tests whether or not this item is equal to the parameter.
     * This method is called by the Contains() method in the List class.
     * This Contains() method is used in the ShoppingCart AddItem() method.
     */
    public bool Equals(CartItem item)
    {
        return item.UPC == this.UPC;
    }
}