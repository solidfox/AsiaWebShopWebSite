<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="MemberManagement.aspx.cs" Inherits="AdminOnly_MemberManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">


    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        <strong style="font-size: large; color: #000080;">MEMBER MANAGEMENT</strong></p>
<p>
        Member&#39;s Name :&nbsp;
        <asp:Label ID="UserName" runat="server" Text="[None]"></asp:Label>
&nbsp;
        <asp:CustomValidator ID="MemberCustomValidator" runat="server" 
            Display="Dynamic" ErrorMessage="A username is required." ForeColor="Red" 
            onservervalidate="MemberCustomValidator_ServerValidate"></asp:CustomValidator>
    </p>
<p>
        <asp:Button ID="EnableButton" runat="server" onclick="EnableButton_Click" 
            Text="Enable" PostBackUrl="~/AdminOnly/MemberManagement.aspx" />
&nbsp;
        <asp:Button ID="DisableButton" runat="server" onclick="DisableButton_Click" 
            Text="Disable" PostBackUrl="~/AdminOnly/MemberManagement.aspx" 
            style="width: 63px" />
    </p>
    <p>
        &nbsp;</p>
<p>
    <asp:GridView ID="MemberGridView" runat="server" AutoGenerateColumns="False" 
        DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333" 
        GridLines="None" AllowSorting="True" DataKeyNames="userName" 
        onselectedindexchanged="OnSelectedIndexChanged">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:CommandField ShowSelectButton="True" />
            <asp:BoundField DataField="userName" HeaderText="userName" 
                SortExpression="userName" ReadOnly="True" />
            <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
            <asp:CheckBoxField DataField="active" HeaderText="active" 
                SortExpression="active" />
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
    </p>
<p>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        SelectCommand="SELECT [userName], [email], [active] FROM [Member]">
    </asp:SqlDataSource>
    </p>
<p>
        <br />
    </p>
</asp:Content>

