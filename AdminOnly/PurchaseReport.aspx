<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="PurchaseReport.aspx.cs" Inherits="AdminOnly_MemberReport" %>

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
            width: 222px;
        }
        .style7
        {
            color: #FF0000;
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
        .style10
        {
            width: 313px;
        }
        .style8
        {
            width: 355px;
        }
        .style16
        {
            height: 21px;
            width: 313px;
        }
        .style17
        {
            width: 100%;
            border-style: solid;
            border-width: 2px;
        }
        .style18
        {
            width: 169px;
        }
        .style19
        {
            height: 21px;
            width: 169px;
        }
        </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        <strong style="font-size: large; color: #000080;">PURCHASE REPORT</strong></p>
    <p>
        <strong style="color: #FF0000">No username, search all members.</strong></p>
    <p class="style7">
        <asp:Label ID="Label1" runat="server" 
            Text="Date Format : MM/DD/YYYY&nbsp; ,M =month,D=day, Y=year" 
            style="color: #0000FF"></asp:Label>
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" ValidationGroup="ReportValidation" />

    
                <table class="style4">
                    <tr>
                        <td class="style6">
        Member&#39;s UserName :</td>
                        <td class="style5">
                            <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
        <asp:CustomValidator ID="MemberCustomValidator" runat="server" 
            Display="Dynamic" ErrorMessage="Please enter existed username." ForeColor="Red" 
            onservervalidate="MemberCustomValidator_ServerValidate" ValidationGroup="ReportValidation">*</asp:CustomValidator>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td class="style10">
                            &nbsp;</td>
                    </tr>
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
                    DataSourceID="MemberSqlDataSource" CellPadding="4" 
        ForeColor="#333333" GridLines="Both" Visible="False">
                    <AlternatingItemStyle BackColor="White" />
                    <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                    <ItemStyle BackColor="#E3EAEB" />
                    <ItemTemplate>
                        <table border="2" class="style17">
                            <tr>
                                <td>
                                    firstName:
                                </td>
                                <td class="style18">
                                    <asp:Label ID="firstNameLabel" runat="server" Text='<%# Eval("firstName") %>' />
                                </td>
                                <td>
                                    lastName:
                                </td>
                                <td>
                                    <asp:Label ID="lastNameLabel" runat="server" Text='<%# Eval("lastName") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    email:
                                </td>
                                <td class="style18">
                                    <asp:Label ID="emailLabel" runat="server" Text='<%# Eval("email") %>' />
                                </td>
                                <td>
                                    phoneNumber:
                                </td>
                                <td>
                                    <asp:Label ID="phoneNumberLabel" runat="server" 
                                        Text='<%# Eval("phoneNumber") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    deliveryAddress:</td>
                                <td class="style18">
                                    <asp:Label ID="deliveryAddressLabel" runat="server" 
                                        Text='<%# Eval("deliveryAddress") %>' />
                                </td>
                                <td>
                                    deliveryDistrict:
                                </td>
                                <td>
                                    <asp:Label ID="deliveryDistrictLabel" runat="server" 
                                        Text='<%# Eval("deliveryDistrict") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    creditCardNumber:
                                </td>
                                <td class="style18">
                                    <asp:Label ID="creditCardNumberLabel" runat="server" 
                                        Text='<%# Eval("creditCardNumber") %>' />
                                </td>
                                <td>
                                    creditCardtype:
                                </td>
                                <td>
                                    <asp:Label ID="creditCardtypeLabel" runat="server" 
                                        Text='<%# Eval("creditCardtype") %>' />
                                </td>
                            </tr>
                            <tr>
                                <td class="style14">
                                    orderNum:
                                </td>
                                <td class="style19">
                                    <asp:Label ID="orderNumLabel" runat="server" Text='<%# Eval("orderNum") %>' />
                                </td>
                                <td class="style14">
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
                            style="margin-right: 11px">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="category" HeaderText="category" 
                                    SortExpression="category" />
                                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                                <asp:BoundField DataField="quantity" HeaderText="quantity" 
                                    SortExpression="quantity" />
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
        
        
            
            
            SelectCommand="SELECT Member.firstName, Member.lastName, Member.email, Member.phoneNumber, [Order].deliveryAddress, [Order].deliveryDistrict, [Order].creditCardNumber, [Order].creditCardtype, [Order].orderNum, [Order].code FROM Member INNER JOIN [Order] ON Member.userName = [Order].userName WHERE ([Order].confirmationNumber IS NOT NULL)" 
           >
        </asp:SqlDataSource>
      
    </p>
    <p>
      
        <br />
    </p>
    <p>
      
        <br />
    </p>
</asp:Content>

