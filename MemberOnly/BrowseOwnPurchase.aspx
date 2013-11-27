<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="BrowseOwnPurchase.aspx.cs" Inherits="AdminOnly_MemberReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">

        .style4
        {
            color: #000000;
            font-size: medium;
        }
        .style10
        {
            width: 313px;
        }
        .style12
        {
            width: 180px;
            height: 21px;
        }
        .style13
        {
            width: 222px;
            height: 21px;
        }
        .style14
        {
            height: 21px;
        }
        .style16
        {
            height: 21px;
            width: 313px;
        }
        .style8
        {
            width: 355px;
        }
        .style17
        {
            width: 100%;
            border-style: solid;
            border-width: 2px;
        }
        .style21
        {
            height: 21px;
            width: 164px;
        }
        .style23
        {
            width: 287px;
            height: 21px;
        }
        .style25
        {
            height: 21px;
            width: 147px;
        }
        .style27
        {
            width: 164px;
        }
        .style28
        {
            width: 287px;
        }
        .style29
        {
            width: 147px;
        }
    </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        <strong style="font-size: large; color: #000080;">&nbsp;BROWSER OWN PURCHASE</strong></p>
    <p>
        <strong style="color: #FF0000">No date range is specified, then search all 
        dates.</strong></p>
    <p class="style7">
        <asp:Label ID="Label1" runat="server" 
            Text="Date Format : MM/DD/YYYY&nbsp; ,M =month,D=day, Y=year" 
            style="color: #0000FF"></asp:Label>
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" ValidationGroup="ReportValidation" />

    
                <table class="style4">
                    <tr>
                        <td class="style12">
                            Date Range:&nbsp;&nbsp;From</td>
                        <td class="style13">

    
                <table class="style4">
                    <tr>
                        <td class="style10">
                            <asp:TextBox ID="StartDayTextBox" runat="server" Width="116px"></asp:TextBox>
    &nbsp;
                        <asp:CompareValidator ID="CompareValidatorStart" runat="server" ControlToValidate="StartDayTextBox"
                            ControlToCompare="EndDayTextBox" Type="Date" 
                            ErrorMessage="Invalid Date Range" Display="Dynamic" EnableClientScript="False" 
                                ForeColor="Red" Operator="LessThanEqual" ValidationGroup="ReportValidation">*</asp:CompareValidator>
                            <asp:RegularExpressionValidator ID="DateFormatStartValidator" runat="server" 
                                ControlToValidate="StartDayTextBox" Display="Dynamic" 
                                EnableClientScript="False" ErrorMessage="Wrong Date Format" ForeColor="Red" 
                                ValidationExpression="(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d" 
                                ValidationGroup="ReportValidation">*</asp:RegularExpressionValidator>
                        </td>
                    </tr>
        </table>
                        </td>
                        <td class="style14">
                            To</td>
                        <td class="style16">

    
                <table class="style4">
                    <tr>
                        <td class="style8">
                            <asp:TextBox ID="EndDayTextBox" runat="server" Width="116px"></asp:TextBox>
                        &nbsp;
                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="EndDayTextBox"
                        ControlToCompare="StartDayTextBox" Type="Date" 
                        ErrorMessage="Invalid Date Range" Display="Dynamic" EnableClientScript="False" 
                                ForeColor="Red" Operator="GreaterThanEqual" ValidationGroup="ReportValidation">*</asp:CompareValidator>
                
                            <asp:RegularExpressionValidator ID="DateFormatEndValidator" runat="server" 
                                ControlToValidate="EndDayTextBox" Display="Dynamic" EnableClientScript="False" 
                                ErrorMessage="Wrong Date Format" ForeColor="Red" 
                                ValidationExpression="(0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])[- /.](19|20)\d\d" 
                                ValidationGroup="ReportValidation">*</asp:RegularExpressionValidator>
                
                        </td>
                    </tr>
        </table>
                        </td>
                    </tr>
        </table>
&nbsp;
                <asp:Button ID="btnGenerate" runat="server" Text="Generate" 
                    onclick="btnGenerate_Click" 
        ValidationGroup="ReportValidation" />
                <br />
    <br />
    <asp:Label ID="lblGeneratedResultMessage" runat="server" Font-Bold="True" 
        ForeColor="Red" style="color: #0000FF"></asp:Label>
    <br />
                <asp:DataList ID="DataList1" runat="server" DataKeyField="orderNum" 
                    DataSourceID="MemberSqlDataSource" CellPadding="3" 
        ForeColor="Black" GridLines="Vertical" Visible="False" Width="828px" 
        BorderWidth="1px" BackColor="White" BorderColor="#999999" 
        BorderStyle="Solid">
                    <AlternatingItemStyle BackColor="#CCCCCC" />
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <ItemTemplate>
                        <table border="2" class="style17">
                            <tr>
                                <td class="style27">
                                    firstName:
                                </td>
                                <td class="style28">
                                    <asp:Label ID="firstNameLabel" runat="server" Text='<%# Eval("firstName") %>' />
                                </td>
                                <td class="style29">
                                    lastName:
                                </td>
                                <td>
                                    <asp:Label ID="lastNameLabel" runat="server" Text='<%# Eval("lastName") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="style27">
                                    email:
                                </td>
                                <td class="style28">
                                    <asp:Label ID="emailLabel" runat="server" Text='<%# Eval("email") %>' />
                                </td>
                                <td class="style29">
                                    phoneNumber:
                                </td>
                                <td>
                                    <asp:Label ID="phoneNumberLabel" runat="server" 
                                        Text='<%# Eval("phoneNumber") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="style27">
                                    deliveryAddress:</td>
                                <td class="style28">
                                    <asp:Label ID="deliveryAddressLabel" runat="server" 
                                        Text='<%# Eval("deliveryAddress") %>' />
                                </td>
                                <td class="style29">
                                    deliveryDistrict:
                                </td>
                                <td>
                                    <asp:Label ID="deliveryDistrictLabel" runat="server" 
                                        Text='<%# Eval("deliveryDistrict") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="style27">
                                    creditCardNumber:
                                </td>
                                <td class="style28">
                                    <asp:Label ID="creditCardNumberLabel" runat="server" 
                                        Text='<%# Eval("creditCardNumber") %>' />
                                </td>
                                <td class="style29">
                                    creditCardtype:
                                </td>
                                <td>
                                    <asp:Label ID="creditCardtypeLabel" runat="server" 
                                        Text='<%# Eval("creditCardtype") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="style21">
                                    orderNum:
                                </td>
                                <td class="style23">
                                    <asp:Label ID="orderNumLabel" runat="server" Text='<%# Eval("orderNum") %>' />
                                </td>
                                <td class="style25">
                                    code:
                                </td>
                                <td class="style14">
                                    <asp:Label ID="codeLabel" runat="server" Text='<%# Eval("code") %>' />
                                </td>
                            </tr>
                        </table>
                        <asp:GridView ID="TotalAmountGridView" runat="server" 
                            AutoGenerateColumns="False" CellPadding="4" 
                            DataSourceID="OrderItemSqlDataSource" ForeColor="#333333" 
                            style="margin-right: 11px" Width="806px">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="category" HeaderText="category" 
                                    SortExpression="category" />
                                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                                <asp:BoundField DataField="quantity" HeaderText="quantity" 
                                    SortExpression="quantity" />
                                <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" 
                                    SortExpression="UnitPrice" />
                                <asp:BoundField DataField="UnitSavings" HeaderText="UnitSavings" 
                                    SortExpression="UnitSavings" />
                                <asp:BoundField DataField="TotalPurchasePrice" HeaderText="TotalPurchasePrice" 
                                    ReadOnly="True" SortExpression="TotalPurchasePrice" />
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
                            
                            SelectCommand="SELECT Item.category, Item.name, OrderItem.quantity, OrderItem.PriceWhenAdded AS UnitPrice, OrderItem.amountSavedForOne AS UnitSavings, OrderItem.quantity * OrderItem.PriceWhenAdded AS TotalPurchasePrice, OrderItem.quantity * OrderItem.amountSavedForOne AS TotalAmountSaved FROM OrderItem INNER JOIN Item ON OrderItem.upc = Item.upc WHERE (OrderItem.orderNum = @orderNum) ORDER BY Item.category, Item.name">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="orderNumLabel" Name="orderNum" 
                                    PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                    <SelectedItemStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                </asp:DataList>
    
    <p>
      
        <asp:SqlDataSource ID="MemberSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        
            
            
            SelectCommand="SELECT Member.firstName, Member.lastName, Member.email, Member.phoneNumber, [Order].deliveryAddress, [Order].deliveryDistrict, { fn REPEAT('#', LEN([Order].creditCardNumber) - 4) } + RIGHT (LTRIM(RTRIM([Order].creditCardNumber)), 4) AS creditCardNumber, [Order].creditCardtype, [Order].code, [Order].orderNum FROM Member INNER JOIN [Order] ON Member.userName = [Order].userName WHERE ([Order].confirmationNumber IS NOT NULL)" 
           >
        </asp:SqlDataSource>
      
    </p>
    <p>
      
        <br />
    </p>
</asp:Content>

