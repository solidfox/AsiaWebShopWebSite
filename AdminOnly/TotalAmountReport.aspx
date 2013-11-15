<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="TotalAmountReport.aspx.cs" Inherits="AdminOnly_MemberReport" %>


<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            width: 100%;
        }
        .style5
        {
            width: 148px;
        }
        .style6
        {
            width: 149px;
        }
        .style7
        {
            color: #FF0000;
        }
    </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        <strong style="font-size: large; color: #000080;">TOTAL AMOUNT PURCHASE </strong></p>
    <p>
        <strong style="color: #FF0000">No username, search all members.</strong></p>
    <p class="style7">
        Date Formate : MM/DD/YYYY&nbsp; ,M =month,D=day, Y=year</p>
<p>
    
                <table class="style4">
                    <tr>
                        <td class="style6">
        Member&#39;s UserName :</td>
                        <td class="style5">
                            <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
        <asp:CustomValidator ID="MemberCustomValidator" runat="server" 
            Display="Dynamic" ErrorMessage="Please enter existed username." ForeColor="Red" 
            onservervalidate="MemberCustomValidator_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td>
                            &nbsp;</td>
                        <td>
                <asp:CheckBox ID="cbGroupByDistrict" runat="server" 
            Text="Group By District" oncheckedchanged="btnGenerate_Click" 
             />
                        </td>
                        <td>
                            <asp:RadioButtonList ID="OrderRadioButtonList" runat="server">
                                <asp:ListItem Value="0" Selected="True">Order By Member LastName</asp:ListItem>
                                <asp:ListItem Value="1">Order By Total Purchase Amount</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td class="style6">
                            Date Range:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                            From</td>
                        <td class="style5">
                            <asp:TextBox ID="StartDayTextBox" runat="server" Width="116px"></asp:TextBox>
    <asp:Button ID="StartCalendarButton" runat="server" onclick="StartCalendarButton_Click" Text=".." />
                        </td>
                        <td>
                            To</td>
                        <td>
                            <asp:TextBox ID="EndDayTextBox" runat="server" Width="116px"></asp:TextBox>
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
    </p>
    <p>
      
        <asp:GridView ID="TotalAmountGridView" runat="server" 
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="userName" 
            DataSourceID="MemberSqlDataSource" ForeColor="#333333" 
            style="margin-right: 11px">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="District" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("district") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="DistrictLabel" runat="server" Text='<%# Bind("district") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="lastName" HeaderText="lastName" 
                    SortExpression="lastName" />
                <asp:BoundField DataField="firstName" HeaderText="firstName" 
                     />
                <asp:BoundField DataField="userName" HeaderText="userName" 
                    ReadOnly="True" />
                <asp:BoundField DataField="TotalAmount" HeaderText="TotalAmount" 
                    ReadOnly="True" SortExpression="TotalAmount" />
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
        <asp:SqlDataSource ID="MemberSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        
            
            
            SelectCommand="SELECT Result1.userName, Result1.firstName, Result1.lastName, Result1.district, SUM(OrderItem.quantity * OrderItem.PriceWhenAdded) AS TotalAmount FROM OrderItem INNER JOIN (SELECT Result0.userName, Result0.firstName, Result0.lastName, [Order].orderNum, Result0.district FROM [Order] INNER JOIN (SELECT Member.userName, Member.firstName, Member.lastName, Address.district FROM Member INNER JOIN Address ON Member.userName = Address.userName WHERE (Address.nickname = N'Mailing')) AS Result0 ON Result0.userName = [Order].userName WHERE ([Order].confirmationNumber IS NOT NULL)) AS Result1 ON OrderItem.orderNum = Result1.orderNum GROUP BY Result1.userName, Result1.firstName, Result1.lastName, Result1.district" 
           >
        </asp:SqlDataSource>
      
    </p>
    <p>
      
        <br />
    </p>
</asp:Content>

