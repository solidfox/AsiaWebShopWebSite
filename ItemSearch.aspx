<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ItemSearch.aspx.cs" Inherits="ItemSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; color: Navy; text-decoration: underline;">
        ITEM SEARCH</p>
    <table class="style4">
        <tr>
            <td>
                Search for:</td>
            <td style="margin-left: 40px">
                <asp:TextBox ID="txtSearchString" runat="server"></asp:TextBox>
            </td>
            <td>
                in</td>
            <td>
                <asp:CheckBox ID="cbItemName" runat="server" 
                    oncheckedchanged="CheckBox1_CheckedChanged" Text="Name" />
            </td>
            <td>
                <asp:CheckBox ID="cbItemDescription" runat="server" Text="Description" />
            </td>
            <td>
                Category:</td>
            <td>
                <asp:DropDownList ID="categoryDropDownList" runat="server" EnableTheming="True">
                    <asp:ListItem>All Categories</asp:ListItem>
                    <asp:ListItem>Appliances</asp:ListItem>
                    <asp:ListItem>Baby and Children</asp:ListItem>
                    <asp:ListItem>Computer and Electronics</asp:ListItem>
                    <asp:ListItem>Jewelery and Watches</asp:ListItem>
                    <asp:ListItem>Luggage</asp:ListItem>
                    <asp:ListItem>Men</asp:ListItem>
                    <asp:ListItem>Toys and Games</asp:ListItem>
                    <asp:ListItem>Women</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                    onclick="btnSearch_Click" />
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <br />
    <asp:Label ID="lblSearchResultMessage" runat="server" Font-Bold="True" 
        ForeColor="Red"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="gvItemSearchResult" runat="server" 
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="upc" 
        DataSourceID="AsiaWebShopDBSqlDataSource" ForeColor="#333333" GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="upc" HeaderText="upc" ReadOnly="True" 
                SortExpression="upc" Visible="False" />
            <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
            <asp:TemplateField HeaderText="Picture">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("upc") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="60px" 
                        ImageUrl='<%# Eval("upc", "GetDBImage.ashx?upc={0}") %>' Width="60px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="normalPrice" HeaderText="Normal Price" 
                SortExpression="normalPrice" />
            <asp:BoundField DataField="discountPrice" HeaderText="Discount Price" 
                SortExpression="discountPrice" />
            <asp:BoundField DataField="quantityAvailable" HeaderText="Quantity Available" 
                SortExpression="quantityAvailable" />
            <asp:HyperLinkField DataNavigateUrlFields="upc" 
                DataNavigateUrlFormatString="ItemDetails.aspx?upc={0}" 
                Text="View item details" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:HyperLink ID="AddItemLink" runat="server" NavigateUrl='<%# string.Format("~/AddToCart.aspx?upc={0}&name={1}&discountPrice={2}", HttpUtility.UrlEncode(Eval("upc").ToString()), HttpUtility.UrlEncode(Eval("name").ToString()), HttpUtility.UrlEncode(Eval("discountPrice").ToString())) %>' Text="Add to cart"></asp:HyperLink>
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
    <asp:SqlDataSource ID="AsiaWebShopDBSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="">
    </asp:SqlDataSource>
</asp:Content>

