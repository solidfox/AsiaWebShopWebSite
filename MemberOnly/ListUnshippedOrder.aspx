<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ListUnshippedOrder.aspx.cs" Inherits="MemberOnly_ListUnshippedOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            font-size: large;
            color: #0000FF;
            text-decoration: underline;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style4">
        <strong>Unshipped Order</strong></p>
    <p>
        <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" AutoGenerateSelectButton="true"
            GridLines="None">
            <AlternatingRowStyle BackColor="White" />
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
        <asp:DetailsView ID="DetailsView1" runat="server" CellPadding="4" 
            ForeColor="#333333" GridLines="None" Height="88px" Width="161px" 
            AutoGenerateRows="False" DataKeyNames="orderNum" 
            DataSourceID="SqlDataSource1" onitemupdated="DetailsView1_ItemUpdated">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="orderNum" HeaderText="orderNum" 
                    InsertVisible="False" ReadOnly="True" SortExpression="orderNum" />
                <asp:BoundField DataField="deliveryDateOffset" HeaderText="deliveryDateOffset" 
                    SortExpression="deliveryDateOffset" />
                <asp:BoundField DataField="timeSlotID" HeaderText="timeSlotID" 
                    SortExpression="timeSlotID" />
                <asp:BoundField DataField="deliveryAddress" HeaderText="deliveryAddress" 
                    SortExpression="deliveryAddress" />
                <asp:BoundField DataField="deliveryDistrict" HeaderText="deliveryDistrict" 
                    SortExpression="deliveryDistrict" />
                <asp:CommandField ShowEditButton="True" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>

    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            SelectCommand="SELECT [orderNum], [deliveryDateOffset], [timeSlotID], [deliveryAddress], [deliveryDistrict] FROM [Order] WHERE (([userName] = @userName)  AND ([orderNum] = @orderNum))" 
            
            UpdateCommand="UPDATE [Order] SET deliveryDateOffset = @deliveryDateOffset, timeSlotID = @timeSlotID, deliveryAddress = @deliveryAddress, deliveryDistrict = @deliveryDistrict WHERE (orderNum = @orderNum)">
            <SelectParameters>
                <asp:Parameter Name="userName" />
                <asp:ControlParameter ControlID="GridView1" PropertyName="SelectedRow.Cells[1].Text" Name="orderNum" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="deliveryDateOffset" Type="Byte" />
                <asp:Parameter Name="timeSlotID" Type="Int32" />
                <asp:Parameter Name="deliveryAddress" Type="String" />
                <asp:Parameter Name="deliveryDistrict" Type="String" />
                <asp:Parameter Name="orderNum" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
    </p>
</asp:Content>

