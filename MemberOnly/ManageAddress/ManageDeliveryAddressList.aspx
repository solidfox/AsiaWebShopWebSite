<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ManageDeliveryAddressList.aspx.cs" Inherits="MemberOnly_ManageDeliveryAddressList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h3>Delivery Address Information</h3>
    <p><a href="CreateAddress.aspx">Create a new delivery address</a></p>
    <p><a href="EditAddress.aspx">Edit a new delivery address</a>
    </p>
    <asp:GridView ID="gvAddressList" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataKeyNames="userName,nickname" DataSourceID="sqlAddressList" 
        ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="userName" HeaderText="userName" ReadOnly="True" 
                SortExpression="userName" />
            <asp:BoundField DataField="nickname" HeaderText="nickname" ReadOnly="True" 
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
    <br />
    <asp:SqlDataSource ID="sqlAddressList" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="SELECT * FROM [Address]">
    </asp:SqlDataSource>
    <br />

</asp:Content>

