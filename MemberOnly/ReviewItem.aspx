<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ReviewItem.aspx.cs" Inherits="MemberOnly_AllPurchase" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            font-size: medium;
        }
        .style6
        {
            width: 100%;
        }
        .style10
        {
            width: 140px;
        }
        .style11
        {
            width: 149px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>
        Review item</h2>
    <p class="style4">
        <strong>Make a&nbsp; Review (Please select a Item)</strong></p>
        <asp:GridView ID="UniquePurchaseGridView" runat="server" 
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="upc" 
        DataSourceID="UniquePurchaseDataSource" ForeColor="#333333" GridLines="None" 
        onselectedindexchanged="OnItemIndexChanged">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:TemplateField HeaderText="ItemName" SortExpression="ItemName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ItemName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="ItemNameGrid" runat="server" Text='<%# Bind("ItemName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="upc" SortExpression="upc" Visible="False">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("upc") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="upcLabel" runat="server" Text='<%# Bind("upc") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <EmptyDataTemplate>
                No Item.
            </EmptyDataTemplate>
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
    <br />
    <br />
    <asp:Panel ID="ReviewPanel" runat="server" Visible="False" Width="307px">
        <table class="style6" border="2">
            <tr>
                <td class="style10">
                    <strong>MAKE REVIEW</strong></td>
                <td class="style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style10">
                    ItemName:</td>
                <td class="style11">
                    <asp:Label ID="ItemNameLabel" runat="server" Text="Label"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style10">
                    quality</td>
                <td class="style11">
                    <asp:DropDownList ID="qualityDropDownList" runat="server">
                        <asp:ListItem>0</asp:ListItem>
                        <asp:ListItem Value="1"></asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style10">
                    features</td>
                <td class="style11">
                    <asp:DropDownList ID="featuresDropDownList" runat="server">
                        <asp:ListItem>0</asp:ListItem>
                        <asp:ListItem Value="1"></asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style10">
                    performance</td>
                <td class="style11">
                    <asp:DropDownList ID="performanceDropDownList" runat="server">
                        <asp:ListItem>0</asp:ListItem>
                        <asp:ListItem Value="1"></asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style10">
                    appearance</td>
                <td class="style11">
                    <asp:DropDownList ID="appearanceDropDownList" runat="server">
                        <asp:ListItem>0</asp:ListItem>
                        <asp:ListItem Value="1"></asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style10">
                    durability</td>
                <td class="style11">
                    <asp:DropDownList ID="durabilityDropDownList" runat="server">
                        <asp:ListItem>0</asp:ListItem>
                        <asp:ListItem Value="1"></asp:ListItem>
                        <asp:ListItem>2</asp:ListItem>
                        <asp:ListItem>3</asp:ListItem>
                        <asp:ListItem>4</asp:ListItem>
                        <asp:ListItem>5</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="style10">
                    comment</td>
                <td class="style11">
                    <asp:TextBox ID="commentTextBox" runat="server" MaxLength="140"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style10">
                    <asp:Button ID="SubmitReview" runat="server" 
                onclick="SubmitReview_Click" Text="Submit" />
                </td>
                <td class="style11">
                    &nbsp;</td>
            </tr>
        </table>
    </asp:Panel>
    <p>
        <strong>Item Reviewed:</strong></p>
    <asp:GridView ID="ReviewedItemGridView" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="ReviewedItemDataSource" ForeColor="#333333" 
        GridLines="None" Width="600px">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:TemplateField HeaderText="name" SortExpression="name">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="category" HeaderText="category" 
                SortExpression="category" />
            <asp:BoundField DataField="quality" HeaderText="quality" 
                SortExpression="quality" />
            <asp:BoundField DataField="features" HeaderText="features" 
                SortExpression="features" />
            <asp:BoundField DataField="performance" HeaderText="performance" 
                SortExpression="performance" />
            <asp:BoundField DataField="appearance" HeaderText="appearance" 
                SortExpression="appearance" />
            <asp:BoundField DataField="durability" HeaderText="durability" 
                SortExpression="durability" />
            <asp:BoundField DataField="comment" HeaderText="comment" 
                SortExpression="comment" >
            <ControlStyle Width="100px" />
            <FooterStyle Width="100px" Wrap="True" />
            <HeaderStyle Width="100px" Wrap="True" />
            <ItemStyle Width="100px" Wrap="True" />
            </asp:BoundField>
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <EmptyDataTemplate>
            No Item.
        </EmptyDataTemplate>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" Width="600px"  Wrap="True" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333"  Wrap="True"/>
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    <asp:SqlDataSource ID="ReviewedItemDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        
        
        SelectCommand="SELECT Item.name, Item.category, Review.quality, Review.features, Review.performance, Review.appearance, Review.durability, Review.comment FROM Review INNER JOIN Item ON Review.upc = Item.upc WHERE (Review.userName = @userName)">
        <SelectParameters>
            <asp:Parameter Name="userName" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UniquePurchaseDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        
        
        
        
        SelectCommand="SELECT DISTINCT Item.upc, Item.name AS ItemName FROM [Order] INNER JOIN OrderItem ON [Order].orderNum = OrderItem.orderNum INNER JOIN Item ON OrderItem.upc = Item.upc WHERE ([Order].confirmationNumber IS NOT NULL) AND ([Order].userName = @userName) AND (NOT EXISTS (SELECT upc FROM Review WHERE (userName = @userName) AND (upc = Item.upc)))">
        <SelectParameters>
            <asp:Parameter Name="userName" DefaultValue="" />
        </SelectParameters>
    </asp:SqlDataSource>
    


</asp:Content>

