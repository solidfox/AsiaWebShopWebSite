<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ManageCreditCard.aspx.cs" Inherits="MemberOnly_ManageCreditCard_ManageCreditCard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h3>
        Edit Credit Card</h3>
    <p>
        <asp:GridView ID="gvCreditCard" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataKeyNames="userName,number" DataSourceID="CreditCardList" 
            ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="userName" HeaderText="userName" ReadOnly="True" 
                    SortExpression="userName" />
                <asp:BoundField DataField="number" HeaderText="number" ReadOnly="True" 
                    SortExpression="number" />
                <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />
                <asp:BoundField DataField="cardHolderName" HeaderText="cardHolderName" 
                    SortExpression="cardHolderName" />
                <asp:BoundField DataField="expiryMonth" HeaderText="expiryMonth" 
                    SortExpression="expiryMonth" />
                <asp:BoundField DataField="expiryYear" HeaderText="expiryYear" 
                    SortExpression="expiryYear" />
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
        <asp:DetailsView ID="dvCreditCard" runat="server" Height="50px" Width="125px" 
            AutoGenerateRows="False" CellPadding="4" DataKeyNames="userName,number" 
            DataSourceID="SelectedCreditCard" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="userName" HeaderText="userName" ReadOnly="True" 
                    SortExpression="userName" />
                <asp:BoundField DataField="number" HeaderText="number" ReadOnly="True" 
                    SortExpression="number" />
                <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />
                <asp:BoundField DataField="cardHolderName" HeaderText="cardHolderName" 
                    SortExpression="cardHolderName" />
                <asp:BoundField DataField="expiryMonth" HeaderText="expiryMonth" 
                    SortExpression="expiryMonth" />
                <asp:BoundField DataField="expiryYear" HeaderText="expiryYear" 
                    SortExpression="expiryYear" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                    ShowInsertButton="True" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </p>
    <p>
        <asp:SqlDataSource ID="CreditCardList" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT * FROM [CreditCard] WHERE ([userName] = @userName)">
            <SelectParameters>
                <asp:Parameter Name="userName" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SelectedCreditCard" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            DeleteCommand="DELETE FROM [CreditCard] WHERE [userName] = @userName AND [number] = @number" 
            InsertCommand="INSERT INTO [CreditCard] ([userName], [number], [type], [cardHolderName], [expiryMonth], [expiryYear]) VALUES (@userName, @number, @type, @cardHolderName, @expiryMonth, @expiryYear)" 
            SelectCommand="SELECT * FROM [CreditCard] WHERE (([userName] = @userName) AND ([number] = @number))" 
            UpdateCommand="UPDATE [CreditCard] SET [type] = @type, [cardHolderName] = @cardHolderName, [expiryMonth] = @expiryMonth, [expiryYear] = @expiryYear WHERE [userName] = @userName AND [number] = @number">
            <DeleteParameters>
                <asp:Parameter Name="userName" Type="String" />
                <asp:Parameter Name="number" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="userName" Type="String" />
                <asp:Parameter Name="number" Type="String" />
                <asp:Parameter Name="type" Type="String" />
                <asp:Parameter Name="cardHolderName" Type="String" />
                <asp:Parameter Name="expiryMonth" Type="String" />
                <asp:Parameter Name="expiryYear" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="gvCreditCard" Name="userName" 
                    PropertyName="SelectedDataKey.Values[0]" Type="String" />
                <asp:ControlParameter ControlID="gvCreditCard" Name="number" 
                    PropertyName="SelectedDataKey.Values[1]" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="type" Type="String" />
                <asp:Parameter Name="cardHolderName" Type="String" />
                <asp:Parameter Name="expiryMonth" Type="String" />
                <asp:Parameter Name="expiryYear" Type="String" />
                <asp:Parameter Name="userName" Type="String" />
                <asp:Parameter Name="number" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

