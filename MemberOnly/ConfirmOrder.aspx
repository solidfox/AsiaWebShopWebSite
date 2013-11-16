<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="ConfirmOrder.aspx.cs" Inherits="MemberOnly_ViewMemberInformation" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    </asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Confirm order details</h2>
    <asp:DetailsView ID="orderDetailsView" runat="server" Height="50px" Width="461px" 
        AutoGenerateRows="False" DataKeyNames="orderNum" 
        DataSourceID="orderDataSource" 
        onpageindexchanging="orderDetailsView_PageIndexChanging">
        <Fields>
            <asp:BoundField DataField="orderNum" HeaderText="orderNum" 
                InsertVisible="False" ReadOnly="True" SortExpression="orderNum" />
            <asp:BoundField DataField="deliveryDateOffset" HeaderText="Delivery Date" 
                SortExpression="deliveryDateOffset" />
            <asp:BoundField DataField="timeSlotID" HeaderText="Time Slot" 
                SortExpression="timeSlotID" />
            <asp:BoundField DataField="deliveryAddress" HeaderText="Delivery Address" 
                SortExpression="deliveryAddress" />
            <asp:BoundField DataField="deliveryDistrict" HeaderText="Delivery District" 
                SortExpression="deliveryDistrict" />
            <asp:BoundField DataField="creditCardNumber" HeaderText="Credit Card Number" 
                SortExpression="creditCardNumber" />
            <asp:BoundField DataField="creditCardtype" HeaderText="Credit Card Type" 
                SortExpression="creditCardtype" />
            <asp:CommandField ShowEditButton="True" ButtonType="Button" />
        </Fields>
    </asp:DetailsView>
    <asp:SqlDataSource ID="orderDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="SELECT [orderNum], [deliveryDateOffset], [timeSlotID], [deliveryAddress], [deliveryDistrict], [creditCardNumber], [creditCardtype] FROM [Order] WHERE (([userName] = @userName) AND ([confirmationNumber] IS NULL))" 
        UpdateCommand="UPDATE [Order] SET [deliveryDateOffset] = @deliveryDateOffset, [timeSlotID] = @timeSlotID, [deliveryAddress] = @deliveryAddress, [deliveryDistrict] = @deliveryDistrict, [creditCardNumber] = @creditCardNumber, [creditCardtype] = @creditCardtype WHERE [orderNum] = @orderNum" 
        onselecting="orderDataSource_Selecting">
        <DeleteParameters>
            <asp:Parameter Name="orderNum" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:Parameter Name="userName" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="deliveryDateOffset" Type="Byte" />
            <asp:Parameter Name="timeSlotID" Type="Int32" />
            <asp:Parameter Name="deliveryAddress" Type="String" />
            <asp:Parameter Name="deliveryDistrict" Type="String" />
            <asp:Parameter Name="creditCardNumber" Type="String" />
            <asp:Parameter Name="creditCardtype" Type="String" />
            <asp:Parameter Name="orderNum" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <asp:ListView ID="orderItemsView" runat="server" 
        DataSourceID="orderItemsDataSource">
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
                        No data was returned.</td>
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
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table ID="itemPlaceholderContainer" runat="server" border="0" style="">
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
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="">
                    </td>
                </tr>
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
