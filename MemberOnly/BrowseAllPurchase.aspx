<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="BrowseAllPurchase.aspx.cs" Inherits="AdminOnly_MemberReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            color: #000000;
            font-size: medium;
        }
        .style6
        {
            width: 180px;
        }
        .style5
        {
            width: 148px;
        }
        .style7
        {
            color: #FF0000;
        }
        </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        <strong style="font-size: large; color: #000080;">PURCHASE REPORT</strong></p>
    <p class="style7">
        <asp:Label ID="Label1" runat="server" 
            Text="Date Formate : MM/DD/YYYY&nbsp; ,M =month,D=day, Y=year" Visible="False"></asp:Label>
    </p>

    
                <table class="style4">
                    <tr>
                        <td class="style6">
                            Date Range:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            From</td>
                        <td class="style5">
                            <asp:TextBox ID="StartDayTextBox" runat="server" Width="116px" ReadOnly="True"></asp:TextBox>
    <asp:Button ID="StartCalendarButton" runat="server" onclick="StartCalendarButton_Click" Text=".." />
                        </td>
                        <td>
                            To</td>
                        <td>
                            <asp:TextBox ID="EndDayTextBox" runat="server" Width="116px" ReadOnly="True"></asp:TextBox>
    <asp:Button ID="EndCalendarButton" runat="server" onclick="EndCalendarButton_Click" Text=".." />
                        </td>
                        <td>
                            <asp:Button ID="ClearRangeButton" runat="server" 
                                onclick="ClearRangeButton_Click" Text="ClearRange" />
                        </td>
                    </tr>
                    <tr>
                        <td class="style6">
                            &nbsp;</td>
                        <td class="style5">
        <asp:Calendar ID="StartCalendar" runat="server" onselectionchanged="StartCalendar_SelectionChanged"></asp:Calendar>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
        <asp:Calendar ID="EndCalendar" runat="server" onselectionchanged="EndCalendar_SelectionChanged"></asp:Calendar>
                        </td>
                        <td>
                            &nbsp;</td>
                    </tr>
        </table>
&nbsp;
                <asp:Button ID="btnGenerate" runat="server" Text="Generate" 
                    onclick="btnGenerate_Click" />
                <asp:DataList ID="DataList1" runat="server" DataKeyField="orderNum" 
                    DataSourceID="MemberSqlDataSource" CellPadding="4" 
        ForeColor="#333333" GridLines="Both">
                    <AlternatingItemStyle BackColor="White" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <ItemStyle BackColor="#E3EAEB" />
                    <ItemTemplate>
                        firstName:
                        <asp:Label ID="firstNameLabel" runat="server" Text='<%# Eval("firstName") %>' />
                        &nbsp;lastName:
                        <asp:Label ID="lastNameLabel" runat="server" Text='<%# Eval("lastName") %>' />
                        &nbsp;email:
                        <asp:Label ID="emailLabel" runat="server" Text='<%# Eval("email") %>' />
                        &nbsp;phoneNumber:
                        <asp:Label ID="phoneNumberLabel" runat="server" 
                            Text='<%# Eval("phoneNumber") %>' />
                        <br />
                        deliveryAddress:
                        <asp:Label ID="deliveryAddressLabel" runat="server" 
                            Text='<%# Eval("deliveryAddress") %>' />
                        &nbsp;deliveryDistrict:
                        <asp:Label ID="deliveryDistrictLabel" runat="server" 
                            Text='<%# Eval("deliveryDistrict") %>' />
                        <asp:Label ID="orderNumLabel" runat="server" Text='<%# Eval("orderNum") %>' 
                            Visible="False" />
                        <br />
                        creditCardNumber:
                        <asp:Label ID="creditCardNumberLabel" runat="server" 
                            Text='<%# Eval("creditCardNumber") %>' />
                        &nbsp;creditCardtype:
                        <asp:Label ID="creditCardtypeLabel" runat="server" 
                            Text='<%# Eval("creditCardtype") %>' />
                        &nbsp;confirmationNumber:
                        <asp:Label ID="confirmationNumberLabel" runat="server" 
                            Text='<%# Eval("confirmationNumber") %>' />
                        <asp:GridView ID="TotalAmountGridView" runat="server" 
                            AutoGenerateColumns="False" CellPadding="4" 
                            DataSourceID="OrderItemSqlDataSource" ForeColor="#333333" 
                            style="margin-right: 11px">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="category" HeaderText="category" 
                                    SortExpression="category" />
                                <asp:BoundField DataField="name" HeaderText="name" 
                                    SortExpression="name" />
                                <asp:BoundField DataField="quantity" HeaderText="quantity" 
                                    SortExpression="quantity" />
                                <asp:BoundField DataField="TotalPurchasePrice" HeaderText="TotalPurchasePrice" 
                                    SortExpression="TotalPurchasePrice" ReadOnly="True" />
                                <asp:BoundField DataField="TotalAmountSaved" HeaderText="TotalAmountSaved" 
                                    ReadOnly="True" SortExpression="TotalAmountSaved" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" BorderWidth="2px" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="OrderItemSqlDataSource" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
                            
                            
                            SelectCommand="SELECT Item.category, Item.name, OrderItem.quantity, OrderItem.quantity * OrderItem.PriceWhenAdded AS TotalPurchasePrice, OrderItem.quantity * OrderItem.amountSavedForOne AS TotalAmountSaved FROM OrderItem INNER JOIN Item ON OrderItem.upc = Item.upc WHERE (OrderItem.orderNum = @orderNum) ORDER BY Item.category, Item.name">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="orderNumLabel" Name="orderNum" 
                                    PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <SelectedItemStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                </asp:DataList>
    
    <p>
      
        <asp:SqlDataSource ID="MemberSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        
            
            
            SelectCommand="SELECT Member.firstName, Member.lastName, Member.email, Member.phoneNumber, [Order].deliveryAddress, [Order].deliveryDistrict, [Order].creditCardNumber, [Order].creditCardtype, [Order].confirmationNumber, [Order].orderNum FROM Member INNER JOIN [Order] ON Member.userName = [Order].userName WHERE ([Order].confirmationNumber IS NOT NULL)" 
           >
        </asp:SqlDataSource>
      
    </p>
    <p>
      
        <br />
    </p>
</asp:Content>

