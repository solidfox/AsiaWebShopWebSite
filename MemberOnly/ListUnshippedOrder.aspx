<%@ Page Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ListUnshippedOrder.aspx.cs" Inherits="MemberOnly_ListUnshippedOrder" %>

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

        
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="orderNum" DataSourceID="SqlDataSource2" CellPadding="4" ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="orderNum" HeaderText="Order Number" InsertVisible="False" ReadOnly="True" SortExpression="orderNum" />
                <asp:BoundField DataField="orderDateTime" HeaderText="Order Time" SortExpression="orderDateTime" />
                <asp:BoundField DataField="Column1" HeaderText="Delivery Time" ReadOnly="True" SortExpression="Column1" />
                <asp:BoundField DataField="slot" HeaderText="Time Slot" SortExpression="slot" />
                <asp:BoundField DataField="deliveryAddress" HeaderText="Delivery Address" SortExpression="deliveryAddress" />
                <asp:BoundField DataField="deliveryDistrict" HeaderText="Delivery District" SortExpression="deliveryDistrict" />
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
    <p>

        
        Please select to modify...<p>
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" CellPadding="4" DataKeyNames="orderNum" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" Height="16px" Width="180px">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="orderNum" HeaderText="orderNum" InsertVisible="False" ReadOnly="True" SortExpression="orderNum" />
                <asp:BoundField DataField="deliveryDateOffset" HeaderText="deliveryDateOffset" SortExpression="deliveryDateOffset" />
                <asp:BoundField DataField="timeSlotID" HeaderText="timeSlotID" SortExpression="timeSlotID" />
                <asp:BoundField DataField="deliveryAddress" HeaderText="deliveryAddress" SortExpression="deliveryAddress" />
                <asp:BoundField DataField="deliveryDistrict" HeaderText="deliveryDistrict" SortExpression="deliveryDistrict" />
                <asp:CommandField ShowEditButton="True" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" SelectCommand="SELECT [orderNum], [deliveryDateOffset], [timeSlotID], [deliveryAddress], [deliveryDistrict] FROM [Order] WHERE (([userName] = @userName)  AND ([orderNum] = @orderNum))" UpdateCommand="UPDATE [Order] SET deliveryDateOffset = @deliveryDateOffset, timeSlotID = @timeSlotID, deliveryAddress = @deliveryAddress, deliveryDistrict = @deliveryDistrict WHERE (orderNum = @orderNum)">
            <SelectParameters>
                <asp:Parameter Name="userName" />
                <asp:ControlParameter ControlID="GridView1" Name="orderNum" PropertyName="SelectedRow.Cells[1].Text" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="deliveryDateOffset" Type="Byte" />
                <asp:Parameter Name="timeSlotID" Type="Int32" />
                <asp:Parameter Name="deliveryAddress" Type="String" />
                <asp:Parameter Name="deliveryDistrict" Type="String" />
                <asp:Parameter Name="orderNum" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p>

        
       
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT [orderNum], [orderDateTime], DATEADD(day, [Order].deliveryDateOffset, CAST([Order].orderDateTime AS smalldatetime)) , [deliveryAddress], [deliveryDistrict], TimeSlot.slot FROM [Order] INNER JOIN TimeSlot ON [Order].timeSlotID = TimeSlot.id WHERE ([shipped] = @shipped) AND ([userName]) = @userName">
            <SelectParameters>
                <asp:Parameter DefaultValue="false" Name="shipped" Type="Boolean" />
                <asp:Parameter Name="userName" />
            </SelectParameters>
        </asp:SqlDataSource>
        &nbsp;</asp:Content>
