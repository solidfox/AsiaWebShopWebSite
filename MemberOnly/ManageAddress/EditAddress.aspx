<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="EditAddress.aspx.cs" Inherits="MemberOnly_ManageDeliveryAddress_EditAddress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h3>
        Edit Delivery Address</h3>
    <p>
        <asp:GridView ID="gvAddress" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataKeyNames="userName,nickname" 
            DataSourceID="DeliveryAddressList" ForeColor="#333333" GridLines="None" 
            style="margin-right: 0px">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
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
    </p>
    <asp:DetailsView ID="dvAddress" runat="server" AutoGenerateRows="False" 
        CellPadding="4" DataKeyNames="userName,nickname" DataSourceID="DeliveryAddress" 
        ForeColor="#333333" GridLines="None" Height="50px" Width="125px">
        <AlternatingRowStyle BackColor="White" />
        <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
        <EditRowStyle BackColor="#2461BF" />
        <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
        <Fields>
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
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                ShowInsertButton="True" />
        </Fields>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
    </asp:DetailsView>
    <p>
        <asp:SqlDataSource ID="DeliveryAddressList" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT * FROM [Address]"></asp:SqlDataSource>
    </p>
    <p>
        
    </p>
    <p>
    </p>
</asp:Content>

