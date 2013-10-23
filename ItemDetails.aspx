<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ItemDetails.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; text-decoration: underline">
    ITEM INFORMATION</p>
<p>
    <asp:DetailsView ID="dvItemDetails" runat="server" AutoGenerateRows="False" 
        CellPadding="4" DataKeyNames="upc" DataSourceID="AsiaWebShopDBSqlDataSource" 
        ForeColor="#333333" GridLines="None" Height="50px" Width="436px">
        <AlternatingRowStyle BackColor="White" />
        <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
        <EditRowStyle BackColor="#2461BF" />
        <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
        <Fields>
            <asp:BoundField DataField="upc" HeaderText="upc" ReadOnly="True" 
                SortExpression="upc" Visible="False" />
            <asp:BoundField DataField="category" HeaderText="Category" 
                SortExpression="category" />
            <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
            <asp:BoundField DataField="description" HeaderText="Description" 
                SortExpression="description" />
            <asp:TemplateField HeaderText="Picture">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("upc") %>'></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("upc") %>'></asp:TextBox>
                </InsertItemTemplate>
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
        </Fields>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
    </asp:DetailsView>
</p>
<p>
    <asp:SqlDataSource ID="AsiaWebShopDBSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="SELECT [upc], [category], [name], [description], [picture], [normalPrice], [discountPrice], [quantityAvailable] FROM [Item] WHERE ([upc] = @upc)">
        <SelectParameters>
            <asp:QueryStringParameter Name="upc" QueryStringField="upc" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</p>
</asp:Content>

