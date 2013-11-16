<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="MemberReport.aspx.cs" Inherits="AdminOnly_MemberReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            color: #000000;
            font-size: medium;
        }
    </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        <strong style="font-size: large; color: #000080;">MEMBER&nbsp; REPORT</strong></p>
    <p class="style4">
        <strong>No username, search all members.</strong></p>
<p>
        Member&#39;s UserName :<asp:TextBox ID="UserName" runat="server"></asp:TextBox>
        <asp:CustomValidator ID="MemberCustomValidator" runat="server" 
            Display="Dynamic" ErrorMessage="Please enter existed username." ForeColor="Red" 
            onservervalidate="MemberCustomValidator_ServerValidate"></asp:CustomValidator>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:CheckBox ID="cbGroupByDistrict" runat="server" 
            Text="Group By District" oncheckedchanged="btnGenerate_Click" 
             />
    </p>
<p>
                <asp:Button ID="btnGenerate" runat="server" Text="Generate" 
                    onclick="btnGenerate_Click" />
    </p>
    <p>
                &nbsp;</p>
                            <asp:Label ID="HeaderLabelDataList" runat="server" 
                    style="color: #000000; font-size: larger; font-weight: 700; font-family: 'Segoe UI'" />
    <p>
      
        <asp:GridView ID="MemberReportGridView" runat="server" 
            AutoGenerateColumns="False" CellPadding="4" DataKeyNames="userName" 
            DataSourceID="MemberSqlDataSource" ForeColor="#333333">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="District" SortExpression="district" 
                    Visible="False">
                   <ItemTemplate>
                        <asp:Label ID="DistrictLabel" runat="server" Text='<%# Eval("district") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="lastName" HeaderText="LastName" 
                    SortExpression="lastName" />
                <asp:BoundField DataField="firstName" HeaderText="FirstName" 
                    SortExpression="firstName" />
                <asp:TemplateField HeaderText="userName" SortExpression="userName" 
                    Visible="False">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("userName") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="userNameLabel" runat="server" Text='<%# Eval("userName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Member information">
                    <ItemTemplate>
                        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" 
                            CellPadding="4" DataSourceID="MemberSqlDataSource" ForeColor="#333333" 
                            DataKeyNames="userName">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="userName" HeaderText="userName" 
                                    SortExpression="userName" ReadOnly="True" />
                                <asp:BoundField DataField="email" HeaderText="email" 
                                    SortExpression="email" />
                                <asp:BoundField DataField="phoneNumber" HeaderText="phoneNumber" 
                                    SortExpression="phoneNumber" />
                                <asp:BoundField DataField="renewalDate" HeaderText="renewalDate" 
                                    SortExpression="renewalDate" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                            CellPadding="4" DataSourceID="AddressSqlDataSource" ForeColor="#333333">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="nickname" HeaderText="nickname" 
                                    SortExpression="nickname" />
                                <asp:BoundField DataField="buildingAddress" HeaderText="buildingAddress" 
                                    SortExpression="buildingAddress" />
                                <asp:BoundField DataField="streetAddress" HeaderText="streetAddress" 
                                    SortExpression="streetAddress" />
                                <asp:BoundField DataField="district" HeaderText="district" 
                                    SortExpression="district" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>
                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                            CellPadding="4" DataSourceID="CreditCardSqlDataSource" ForeColor="#333333">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:BoundField DataField="number" HeaderText="number" 
                                    SortExpression="number" />
                                <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />
                                <asp:BoundField DataField="cardHolderName" HeaderText="cardHolderName" 
                                    SortExpression="cardHolderName" />
                                <asp:BoundField DataField="expiryMonth" HeaderText="expiryMonth" 
                                    SortExpression="expiryMonth" />
                                <asp:BoundField DataField="expiryYear" HeaderText="expiryYear" 
                                    SortExpression="expiryYear" />
                            </Columns>
                            <EditRowStyle BackColor="#2461BF" />
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#EFF3FB" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="CreditCardSqlDataSource" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
                            SelectCommand="SELECT [number], [type], [cardHolderName], [expiryMonth], [expiryYear] FROM [CreditCard]  WHERE ([userName] = @userName)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="userNameLabel" DefaultValue="" Name="userName" 
                                    PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="AddressSqlDataSource" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
                            SelectCommand="SELECT [nickname], [buildingAddress], [streetAddress], [district]  FROM [Address] WHERE ([userName] = @userName)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="userNameLabel" Name="username" 
                                    PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="MemberSqlDataSource" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
                            
                            SelectCommand="SELECT userName, email, phoneNumber, renewalDate FROM Member WHERE (userName = @userName)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="userNameLabel" Name="userName" 
                                    PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ItemTemplate>
                </asp:TemplateField>
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
        
        
            
            SelectCommand="SELECT Member.userName, Member.lastName, Member.firstName, Address.district FROM Member INNER JOIN Address ON Member.userName = Address.userName WHERE (Address.nickname = N'Mailing') ORDER BY Member.lastName" 
           >
        </asp:SqlDataSource>
      
        <br />
    </p>
</asp:Content>

