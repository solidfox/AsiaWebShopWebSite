<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="ConfirmOrder.aspx.cs" Inherits="MemberOnly_ViewMemberInformation" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    </asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Confirm order details</h2>
    <asp:DetailsView ID="orderDetailsView" runat="server" Height="50px" Width="461px" 
        AutoGenerateRows="False" DataKeyNames="Order Number" 
        DataSourceID="orderDataSource">
        <Fields>
            <asp:BoundField DataField="Order Number" HeaderText="Order Number" 
                InsertVisible="False" ReadOnly="True" SortExpression="Order Number" />
            <asp:BoundField DataField="Delivery Date" HeaderText="Delivery Date" 
                SortExpression="Delivery Date" ReadOnly="True" DataFormatString="{0:d}" />
            <asp:BoundField DataField="Delivery Time Slot" HeaderText="Delivery Time Slot" 
                SortExpression="Delivery Time Slot" />
            <asp:BoundField DataField="Delivery Address" HeaderText="Delivery Address" 
                SortExpression="Delivery Address" />
            <asp:BoundField DataField="District" HeaderText="District" 
                SortExpression="District" />
            <asp:BoundField DataField="Card Number" HeaderText="Card Number" 
                SortExpression="Card Number" />
            <asp:BoundField DataField="Card Type" HeaderText="Card Type" 
                SortExpression="Card Type" />
        </Fields>
    </asp:DetailsView>
    <br />
    <asp:Button ID="Button1" runat="server" 
        PostBackUrl="~/MemberOnly/DeliveryAndPayment.aspx" 
        Text="Edit Delivery &amp; Payment Details" />
    <asp:SqlDataSource ID="orderDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="SELECT [Order].orderNum AS 'Order Number', DATEADD(day, [Order].deliveryDateOffset, CAST([Order].orderDateTime AS smalldatetime)) AS 'Delivery Date', TimeSlot.slot AS 'Delivery Time Slot', [Order].deliveryAddress AS 'Delivery Address', [Order].deliveryDistrict AS 'District', [Order].creditCardNumber AS 'Card Number', [Order].creditCardtype AS 'Card Type' FROM [Order] INNER JOIN TimeSlot ON [Order].timeSlotID = TimeSlot.id WHERE ([Order].userName = @userName) AND ([Order].confirmationNumber IS NULL)" 
        onselecting="orderDataSource_Selecting">
        <SelectParameters>
            <asp:Parameter Name="userName" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
    <asp:ListView ID="orderItemsView" runat="server" 
        DataSourceID="orderItemsDataSource" >
        <AlternatingItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="ItemLabel" runat="server" Text='<%# Eval("Item") %>' />
                </td>
                <td>
                    <asp:Label ID="QuantityLabel" runat="server" Text='<%# Eval("Quantity") %>' />
                </td>
                <td>
                    <asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("Price") %>' />
                </td>
            </tr>
        </AlternatingItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>
                        No items in cart.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="ItemLabel" runat="server" Text='<%# Eval("Item") %>' />
                </td>
                <td>
                    <asp:Label ID="QuantityLabel" runat="server" Text='<%# Eval("Quantity") %>' />
                </td>
                <td>
                    <asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("Price") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
                        <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
                        <tbody>
                            <tr runat="server" style="">
                                <th runat="server">
                                    Item</th>
                                <th runat="server">
                                    Quantity</th>
                                <th runat="server">
                                    Price</th>
                            </tr>
                            <tr ID="itemPlaceholder" runat="server">
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="2">Total</td>
                                <td><%:total()%></td>
                            </tr>
                        </tfoot>
                        </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="">
                <td>
                    <asp:Label ID="ItemLabel" runat="server" Text='<%# Eval("Item") %>' />
                </td>
                <td>
                    <asp:Label ID="QuantityLabel" runat="server" Text='<%# Eval("Quantity") %>' />
                </td>
                <td>
                    <asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("Price") %>' />
                </td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
    <br />
    <asp:Button ID="editItemsButton" runat="server" 
        PostBackUrl="~/MemberOnly/ViewShoppingCart.aspx" Text="Edit items" 
        UseSubmitBehavior="False" />
    <asp:Button ID="confirmButton" runat="server" 
        PostBackUrl="~/MemberOnly/PurchaseDone.aspx" Text="Confirm Purchase" 
        UseSubmitBehavior="False" />
    <asp:SqlDataSource ID="orderItemsDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        onselecting="orderItemsDataSource_Selecting" SelectCommand="SELECT Item.name AS Item, OrderItem.quantity AS Quantity, OrderItem.PriceWhenAdded AS Price 
FROM OrderItem, Item, [Order]
WHERE 
Item.upc = OrderItem.upc AND 
OrderItem.orderNum = [Order].orderNum AND
[Order].confirmationNumber IS NULL AND
[Order].userName = @userName">
        <SelectParameters>
            <asp:Parameter Name="userName" />
        </SelectParameters>
    </asp:SqlDataSource>
    </asp:Content>
