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
            <asp:TemplateField HeaderText="userName" SortExpression="userName" 
                Visible="False">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("userName") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="60px" 
                        ImageUrl='<%# Eval("upc", "GetDBImage.ashx?upc={0}") %>' Width="60px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="upc" HeaderText="upc" ReadOnly="True" 
                SortExpression="upc" Visible="False" />
            <asp:BoundField DataField="name" HeaderText="Product" SortExpression="name" />
            <asp:TemplateField HeaderText="Picture">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image2" runat="server" Height="60px" Width="60px" 
                        ImageUrl='<%# Eval("upc", "GetDBImage.ashx?upc={0}") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="comment" HeaderText="comment" 
                SortExpression="comment" />
            <asp:CheckBoxField DataField="emailSent" HeaderText="emailSent" 
                SortExpression="emailSent" />
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
        SelectCommand="SELECT WishListItem.userName, WishListItem.upc, WishListItem.comment, WishListItem.emailSent, Item.name, Item.picture FROM WishListItem INNER JOIN Item ON WishListItem.upc = Item.upc WHERE (WishListItem.userName = @userName)"
        
        
        UpdateCommand="UPDATE [WishListItem] SET [userName] = @userName, [upc] = @upc, [comment] = @comment, [emailSent] = @emailSent WHERE [userName] = @userName AND [upc] = @upc" >
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

