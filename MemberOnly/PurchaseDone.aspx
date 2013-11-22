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
    <p>The following receipt has been sent to your email:</p>
    <div id="email" runat="server">
    <h2>Asia Web Shop Receipt</h2>
        <asp:DetailsView ID="orderDetailsView" runat="server" Height="50px" Width="461px" 
        AutoGenerateRows="False" 
        DataSourceID="orderDataSource">
        <Fields>
            <asp:BoundField DataField="Confirmation number" 
                HeaderText="Confirmation number" SortExpression="Confirmation number" />
            <asp:BoundField DataField="Authorization code" HeaderText="Authorization code" 
                SortExpression="Authorization code" />
            <asp:BoundField DataField="Delivery Date" HeaderText="Delivery Date" 
                SortExpression="Delivery Date" ReadOnly="True" />
            <asp:BoundField DataField="Delivery Time Slot" HeaderText="Delivery Time Slot" 
                SortExpression="Delivery Time Slot" />
            <asp:BoundField DataField="Delivery Address" HeaderText="Delivery Address" 
                SortExpression="Delivery Address" />
            <asp:BoundField DataField="District" HeaderText="District" 
                SortExpression="District" />
            <asp:BoundField DataField="Card Number" HeaderText="Card Number" 
                SortExpression="Card Number" ReadOnly="True" />
            <asp:BoundField DataField="Card Type" HeaderText="Card Type" 
                SortExpression="Card Type" />
            <asp:BoundField DataField="Savings" HeaderText="Savings" ReadOnly="True" 
                SortExpression="Savings" />
            <asp:BoundField DataField="Order Total" HeaderText="Order Total" 
                ReadOnly="True" SortExpression="Order Total" />
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="orderDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="SELECT [Order].confirmationNumber AS [Confirmation number], [Order].code AS [Authorization code], DATEADD(day, [Order].deliveryDateOffset, CAST([Order].orderDateTime AS smalldatetime)) AS 'Delivery Date', TimeSlot.slot AS 'Delivery Time Slot', [Order].deliveryAddress AS 'Delivery Address', [Order].deliveryDistrict AS 'District', { fn CONCAT('**** **** **** ', RIGHT ([Order].creditCardNumber, 4)) } AS 'Card Number', [Order].creditCardtype AS 'Card Type', (SELECT SUM(Item.normalPrice) - SUM(Item.discountPrice) AS 'savings' FROM OrderItem INNER JOIN Item ON OrderItem.upc = Item.upc WHERE (OrderItem.orderNum = [Order].orderNum)) AS 'Savings', (SELECT SUM(Item_1.discountPrice * OrderItem_1.quantity) AS 'total' FROM OrderItem AS OrderItem_1 INNER JOIN Item AS Item_1 ON OrderItem_1.upc = Item_1.upc WHERE (OrderItem_1.orderNum = [Order].orderNum)) AS 'Order Total' FROM [Order] INNER JOIN TimeSlot ON [Order].timeSlotID = TimeSlot.id WHERE ([Order].confirmationNumber = @confirmationNumber)" 
        onselecting="orderDataSource_Selecting">
        <SelectParameters>
            <asp:Parameter Name="confirmationNumber" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <br />
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="orderItemsDataSource" Width="460px">
            <Columns>
                <asp:BoundField DataField="Item" HeaderText="Item" SortExpression="Item" />
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                    SortExpression="Quantity" />
                <asp:BoundField DataField="Unit Price" HeaderText="Unit Price" 
                    SortExpression="Unit Price" />
                <asp:BoundField DataField="Total Price" HeaderText="Total Price" 
                    ReadOnly="True" SortExpression="Total Price" />
            </Columns>
        </asp:GridView>
        
    <asp:SqlDataSource ID="orderItemsDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        onselecting="orderItemsDataSource_Selecting" SelectCommand="SELECT Item.name AS Item, OrderItem.quantity AS Quantity, OrderItem.PriceWhenAdded AS [Unit Price] , OrderItem.PriceWhenAdded * OrderItem.quantity AS [Total Price]
FROM OrderItem, Item, [Order]
WHERE 
Item.upc = OrderItem.upc AND 
OrderItem.orderNum = [Order].orderNum AND
[Order].confirmationNumber = @confirmationNumber">
        <SelectParameters>
            <asp:Parameter Name="confirmationNumber" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <p>Thank you for shopping!</p>
    </div>
    </asp:Content>
