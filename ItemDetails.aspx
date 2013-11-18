<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ItemDetails.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            font-size: large;
            color: #0000FF;
            font-family: Arial, Helvetica, sans-serif;
            text-decoration: underline;
        }
        .style5
        {
            color: #0000FF;
        }
        .style6
        {
            width: 100%;
        }
        .style7
        {
            font-size: large;
            color: #0000FF;
            font-family: Arial, Helvetica, sans-serif;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; text-decoration: underline" 
        class="style5">
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
    <p class="style4">
        <strong>REVIEW</strong></p>
    <p class="style7">
        <asp:FormView ID="FormView1" runat="server" CellPadding="4" 
            DataSourceID="AsiaWebShopDBSqlMemberTotalCount" ForeColor="#333333">
            <EditItemTemplate>
                NumPeople:
                <asp:TextBox ID="NumPeopleTextBox" runat="server" 
                    Text='<%# Bind("NumPeople") %>' />
                <br />
                quality:
                <asp:TextBox ID="qualityTextBox" runat="server" Text='<%# Bind("quality") %>' />
                <br />
                features:
                <asp:TextBox ID="featuresTextBox" runat="server" 
                    Text='<%# Bind("features") %>' />
                <br />
                performance:
                <asp:TextBox ID="performanceTextBox" runat="server" 
                    Text='<%# Bind("performance") %>' />
                <br />
                appearance:
                <asp:TextBox ID="appearanceTextBox" runat="server" 
                    Text='<%# Bind("appearance") %>' />
                <br />
                durability:
                <asp:TextBox ID="durabilityTextBox" runat="server" 
                    Text='<%# Bind("durability") %>' />
                <br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                    CommandName="Update" Text="Update" />
                &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" 
                    CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </EditItemTemplate>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderTemplate>
                Overall Ratings
            </HeaderTemplate>
            <InsertItemTemplate>
                NumPeople:
                <asp:TextBox ID="NumPeopleTextBox" runat="server" 
                    Text='<%# Bind("NumPeople") %>' />
                <br />
                quality:
                <asp:TextBox ID="qualityTextBox" runat="server" Text='<%# Bind("quality") %>' />
                <br />
                features:
                <asp:TextBox ID="featuresTextBox" runat="server" 
                    Text='<%# Bind("features") %>' />
                <br />
                performance:
                <asp:TextBox ID="performanceTextBox" runat="server" 
                    Text='<%# Bind("performance") %>' />
                <br />
                appearance:
                <asp:TextBox ID="appearanceTextBox" runat="server" 
                    Text='<%# Bind("appearance") %>' />
                <br />
                durability:
                <asp:TextBox ID="durabilityTextBox" runat="server" 
                    Text='<%# Bind("durability") %>' />
                <br />
                <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                    CommandName="Insert" Text="Insert" />
                &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                    CausesValidation="False" CommandName="Cancel" Text="Cancel" />
            </InsertItemTemplate>
            <ItemTemplate>
                <table border="2" class="style6">
                    <tr>
                        <td>
                            Quality:</td>
                        <td>
                            <asp:Label ID="qualityLabel" runat="server" Text='<%# Bind("quality") %>' />
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Features:
                        </td>
                        <td>
                            <asp:Label ID="featuresLabel" runat="server" Text='<%# Bind("features") %>' />
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Performance:
                        </td>
                        <td>
                            <asp:Label ID="performanceLabel" runat="server" 
                                Text='<%# Bind("performance") %>' />
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Appearance:
                        </td>
                        <td>
                            <asp:Label ID="appearanceLabel" runat="server" 
                                Text='<%# Bind("appearance") %>' />
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            Durability:
                        </td>
                        <td>
                            <asp:Label ID="durabilityLabel" runat="server" 
                                Text='<%# Bind("durability") %>' />
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            People Review:
                        </td>
                        <td>
                            <asp:Label ID="NumPeopleLabel" runat="server" Text='<%# Bind("NumPeople") %>' />
                            &nbsp;</td>
                    </tr>
                </table>
            </ItemTemplate>
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:FormView>
    </p>
    <p class="style4">
        <asp:GridView ID="MemberReviewGridView" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="AsiaWebShopDBSqlMemberReview" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="userName" HeaderText="userName" 
                    SortExpression="userName" />
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
                    SortExpression="comment" />
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <EmptyDataTemplate>
                No Review
            </EmptyDataTemplate>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" Wrap="True" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
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
    <asp:SqlDataSource ID="AsiaWebShopDBSqlMemberReview" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        SelectCommand="SELECT [userName], [quality], [features], [performance], [appearance], [durability], [comment] FROM [Review] WHERE ([upc] = @upc)">
        <SelectParameters>
            <asp:ControlParameter ControlID="dvItemDetails" Name="upc" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="AsiaWebShopDBSqlMemberTotalCount" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        SelectCommand="SELECT COUNT(userName) AS NumPeople, AVG(quality) AS quality, AVG(features) AS features, AVG(performance) AS performance, AVG(appearance) AS appearance, AVG(durability) AS durability  FROM Review WHERE (upc = @upc)">
        <SelectParameters>
            <asp:ControlParameter ControlID="dvItemDetails" Name="upc" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

