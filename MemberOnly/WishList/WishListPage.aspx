<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="WishListPage.aspx.cs" Inherits="MemberOnly_WishList_WishListPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            font-size: large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <span class="style4"><strong>Wish List</strong></span><br />
    <a href="../../ItemSearch.aspx"><-Back to Item Search</a><br />
    <br />
    <asp:GridView ID="gvWishList" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataKeyNames="userName,upc" DataSourceID="SqlDataSource1" 
        ForeColor="#333333" GridLines="None" AutoGenerateEditButton="True">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="userName" HeaderText="userName" ReadOnly="True" 
                SortExpression="userName" Visible="False" />
            <asp:BoundField DataField="upc" HeaderText="upc" SortExpression="upc" 
                ReadOnly="True" Visible="False" />
            <asp:BoundField DataField="name" HeaderText="name" 
                SortExpression="name" ReadOnly="True" />
            <asp:BoundField DataField="discountPrice" HeaderText="discountPrice" 
                ReadOnly="True" SortExpression="discountPrice" />
            <asp:BoundField DataField="quantityAvailable" HeaderText="quantityAvailable" 
                ReadOnly="True" SortExpression="quantityAvailable" />
            <asp:BoundField DataField="comment" HeaderText="comment" 
                SortExpression="comment" />
            <asp:TemplateField HeaderText="emailSent" SortExpression="emailSent">
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("emailSent") %>' 
                        />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("emailSent") %>' 
                        Enabled="false" />
                </ItemTemplate>
            </asp:TemplateField>
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="SELECT WishListItem.userName, WishListItem.upc, Item.name, Item.discountPrice, Item.quantityAvailable, WishListItem.comment, WishListItem.emailSent FROM WishListItem INNER JOIN Item ON WishListItem.upc = Item.upc WHERE (WishListItem.userName = @userName)"
        
        
        
        UpdateCommand="UPDATE [WishListItem] SET [comment] = @comment, [emailSent] = @emailSent WHERE [userName] = @userName AND [upc] = @upc" >
        <SelectParameters>
            <asp:Parameter Name="userName" Type="String" />
        </SelectParameters>
        <UpdateParameters>
                <asp:Parameter Name="userName" Type="String" />
                <asp:Parameter Name="upc" Type="String" />
                <asp:Parameter Name="comment" Type="String" />
                <asp:Parameter Name="emailSent" Type="String" />
            </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

