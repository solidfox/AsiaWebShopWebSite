<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="~/MemberOnly/ViewShoppingCart.aspx.cs" Inherits="MemberOnly_ShoppingCart" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    </asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Your SHOPPING CART</h2>
    <p>
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/ItemSearch.aspx">&lt; Back to Item Search Page</asp:HyperLink>
    </p>
    <p>
        <asp:GridView ID="gvShoppingCart" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="upc" EmptyDataText="Your shopping cart is empty." ForeColor="#333333" GridLines="None" ShowFooter="True">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="UPC" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblUPC" runat="server" Text='<%# Bind("upc") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="name" HeaderText="Item Name" />
                <asp:TemplateField HeaderText="Quantity">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" MaxLength="4"></asp:TextBox>
                    </EditItemTemplate>
                    <FooterTemplate>
                        Total:<asp:Label ID="lblTotal" runat="server" Text="<%# GetTotalPrice() %>"></asp:Label>
                    </FooterTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="txtQuantity" runat="server" Columns="5" MaxLength="5" Text='<%# Eval("Quantity") %>' Wrap="False"></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="discountPrice" DataFormatString="{0:F2}" HeaderText="Discount Price" />
                <asp:BoundField DataField="totalPrice" DataFormatString="{0:F2}" HeaderText="Total Price" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HyperLink ID="RemoveItemLink" runat="server" NavigateUrl='<%# Eval("upc", "~/MemberOnly/RemoveFromCart.aspx?upc={0}") %>' Text="Remove"></asp:HyperLink>
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
    </p>
    <p>
        <asp:Label ID="InformUser" runat="server" Font-Size="Medium" ForeColor="#CC0000" Text="Have Fun !!"></asp:Label>
    </p>
    <p>
        <asp:Button ID="btnUpdateCart" runat="server" OnClick="btnUpdateCart_Click" Text="Update Cart" />
    &nbsp;<asp:Button ID="btnSubmitCart" runat="server" Text="Submit Cart" />
    </p>
    </asp:Content>


