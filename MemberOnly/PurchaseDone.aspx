<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="PurchaseDone.aspx.cs" Inherits="MemberOnly_ViewMemberInformation" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    </asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Thank you!</h2>
    <p>
        After a long and surely dreadful journey through the thorny interfaces of this 
        Visual Studio concocted site you have now successfully made your purchase. 
        Congrats. Here&#39;s your confirmation number:</p>
    <p>
        <asp:Label ID="ConfirmationNumberLabel" runat="server" Text="Label"></asp:Label>
    </p>
    <div id="email">
        <asp:DetailsView ID="orderDetailsView" runat="server" Height="50px" Width="461px" 
        AutoGenerateRows="False" DataKeyNames="Order Number" 
        DataSourceID="orderDataSource">
        <Fields>
            <asp:BoundField DataField="Order Number" HeaderText="Order Number" 
                InsertVisible="False" ReadOnly="True" SortExpression="Order Number" />
            <asp:BoundField DataField="Delivery Date" HeaderText="Delivery Date" 
                SortExpression="Delivery Date" ReadOnly="True" />
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
    <asp:SqlDataSource ID="orderDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="SELECT [Order].orderNum AS 'Order Number', DATEADD(day, [Order].deliveryDateOffset, CAST([Order].orderDateTime AS smalldatetime)) AS 'Delivery Date', TimeSlot.slot AS 'Delivery Time Slot', [Order].deliveryAddress AS 'Delivery Address', [Order].deliveryDistrict AS 'District', [Order].creditCardNumber AS 'Card Number', [Order].creditCardtype AS 'Card Type' FROM [Order] INNER JOIN TimeSlot ON [Order].timeSlotID = TimeSlot.id WHERE ([Order].confirmationNumber = @confirmationNumber)" 
        onselecting="orderDataSource_Selecting">
        <SelectParameters>
            <asp:Parameter Name="confirmationNumber" Type="String" />
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
            <table id="Table1" runat="server" style="">
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
                            <tr id="Tr1" runat="server" style="">
                                <th id="Th1" runat="server">
                                    Item</th>
                                <th id="Th2" runat="server">
                                    Quantity</th>
                                <th id="Th3" runat="server">
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
    <asp:SqlDataSource ID="orderItemsDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        onselecting="orderItemsDataSource_Selecting" SelectCommand="SELECT Item.name AS Item, OrderItem.quantity AS Quantity, OrderItem.PriceWhenAdded AS Price 
FROM OrderItem, Item, [Order]
WHERE 
Item.upc = OrderItem.upc AND 
OrderItem.orderNum = [Order].orderNum AND
[Order].confirmationNumber = @confirmationNumber">
        <SelectParameters>
            <asp:Parameter Name="confirmationNumber" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    </div>
    </asp:Content>
