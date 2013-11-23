<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="EditAddress.aspx.cs" Inherits="MemberOnly_ManageDeliveryAddress_EditAddress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h3>
        Edit Delivery Address</h3>
    <p>
        <asp:GridView ID="gvAddress" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataKeyNames="userName,nickname" 
            DataSourceID="DeliveryAddressList" ForeColor="#333333" GridLines="None" 
            style="margin-right: 0px">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="userName" HeaderText="userName" ReadOnly="True" 
                    SortExpression="userName" />
                <asp:BoundField DataField="nickname" HeaderText="nickname" ReadOnly="True" 
                    SortExpression="nickname" />
                <asp:BoundField DataField="buildingAddress" HeaderText="buildingAddress" 
                    SortExpression="buildingAddress" />
                <asp:BoundField DataField="streetAddress" HeaderText="streetAddress" 
                    SortExpression="streetAddress" />
                <asp:BoundField DataField="district" HeaderText="district" 
                    SortExpression="district" />
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
    <asp:DetailsView ID="dvAddress" runat="server" AutoGenerateRows="False" 
        CellPadding="4" DataKeyNames="userName,nickname" DataSourceID="SelectedDeliveryAddress" 
        ForeColor="#333333" GridLines="None" Height="50px" Width="297px"
        OnItemInserted="dvAddress_ItemInserted" 
        OnItemUpdated="dvAddress_ItemUpdated" 
        OnItemDeleted="dvAddress_ItemDeleted" >
        <AlternatingRowStyle BackColor="White" />
        <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
        <EditRowStyle BackColor="#2461BF" />
        <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
        <Fields>
            <asp:TemplateField HeaderText="userName" InsertVisible="False" 
                SortExpression="userName">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("userName") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("userName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="nickname" SortExpression="nickname">
                <EditItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("nickname") %>'></asp:Label>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="InsertNickName" runat="server" Text='<%# Bind("nickname") %>' 
                        MaxLength="10"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rvInsertNickName" runat="server" 
                        ControlToValidate="InsertNickName" Display="Dynamic" EnableClientScript="False" 
                        ErrorMessage="NickName is required." ForeColor="#CC0000">*</asp:RequiredFieldValidator>
                    <asp:CustomValidator ID="cvInsertNickName" runat="server" 
                        ControlToValidate="InsertNickName" Display="Dynamic" 
                        ErrorMessage="NickName must be unique." ForeColor="#CC0000" 
                        onservervalidate="CustomValidator1_ServerValidate">*</asp:CustomValidator>
                    <asp:RegularExpressionValidator ID="revInsertNickname" runat="server" 
                        ControlToValidate="InsertNickName" Display="Dynamic" EnableClientScript="False" 
                        ErrorMessage="NickName should be  alphanumeric." ForeColor="#CC0000" 
                        ValidationExpression="^[a-zA-Z0-9]*$">*</asp:RegularExpressionValidator>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("nickname") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="buildingAddress" 
                SortExpression="buildingAddress">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("buildingAddress") %>' 
                        MaxLength="30"></asp:TextBox>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("buildingAddress") %>' 
                        MaxLength="30"></asp:TextBox>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("buildingAddress") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="streetAddress" SortExpression="streetAddress">
                <EditItemTemplate>
                    <asp:TextBox ID="edStreetAdress" runat="server" 
                        Text='<%# Bind("streetAddress") %>' MaxLength="30"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rvStreetAddress" runat="server" 
                        ControlToValidate="edStreetAdress" Display="Dynamic" EnableClientScript="False" 
                        ErrorMessage="Street Address is required." ForeColor="#CC0000">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:TextBox ID="InsertStreetAdress" runat="server" 
                        Text='<%# Bind("streetAddress") %>' MaxLength="30"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rvStreetAdress" runat="server" 
                        ControlToValidate="InsertStreetAdress" Display="Dynamic" 
                        EnableClientScript="False" ErrorMessage="Street Adress is required." 
                        ForeColor="#CC0000">*</asp:RequiredFieldValidator>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("streetAddress") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="district" SortExpression="district">
                <EditItemTemplate>
                    <asp:TextBox ID="ddlDistrict" runat="server" Text='<%# Bind("district") %>'></asp:TextBox>
                    <asp:RegularExpressionValidator ID="rfvDistrict" runat="server" 
                        ControlToValidate="ddlDistrict" Display="Dynamic" 
                        ErrorMessage="Wrong District Type" ForeColor="#CC0000" 
                        ValidationExpression="^(Central and Western|Eastern|Islands|Kowloon City|Kwai Tsing|Kwun Tong|North|Sai Kung|Sha Tin|Sham Shui Po|Southern|Tai Po|Tsuen Wan|Tuen Mun|Wan Chai|Wong Tai Sin|Yau Tsim Mong|Yuen Long)\s*$">*</asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="rfvDistrictNull" runat="server" 
                        ControlToValidate="ddlDistrict" Display="Dynamic" EnableClientScript="False" 
                        ErrorMessage="District is required." ForeColor="#CC0000">*</asp:RequiredFieldValidator>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <asp:DropDownList ID="InsertDistrict" runat="server" 
                        SelectedValue='<%# Bind("district") %>'>
                        <asp:ListItem>Central and Western</asp:ListItem>
                        <asp:ListItem>Eastern</asp:ListItem>
                        <asp:ListItem>Islands</asp:ListItem>
                        <asp:ListItem>Kowloon City</asp:ListItem>
                        <asp:ListItem>Kwai Tsing</asp:ListItem>
                        <asp:ListItem>Kwun Tong</asp:ListItem>
                        <asp:ListItem>North</asp:ListItem>
                        <asp:ListItem>Sai Kung</asp:ListItem>
                        <asp:ListItem>Sha Tin</asp:ListItem>
                        <asp:ListItem>Sham Shui Po</asp:ListItem>
                        <asp:ListItem>Southern</asp:ListItem>
                        <asp:ListItem>Tai Po</asp:ListItem>
                        <asp:ListItem>Tsuen Wan</asp:ListItem>
                        <asp:ListItem>Tuen Mun</asp:ListItem>
                        <asp:ListItem>Wan Chai</asp:ListItem>
                        <asp:ListItem>Wong Tai Sin</asp:ListItem>
                        <asp:ListItem>Yau Tsim Mong</asp:ListItem>
                        <asp:ListItem>Yuen Long</asp:ListItem>
                    </asp:DropDownList>
                </InsertItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("district") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                ShowInsertButton="True" />
        </Fields>
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
    </asp:DetailsView>
    <asp:ValidationSummary ID="smDvAddress" runat="server" 
        CssClass="failureNotification" EnableClientScript="False" ForeColor="#CC0000" 
        HeaderText="The following errors occured:" />
    <p>
        <asp:SqlDataSource ID="DeliveryAddressList" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT * FROM [Address] WHERE ([userName] = @userName)">
            <SelectParameters>
                <asp:Parameter Name="userName" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
        <asp:SqlDataSource ID="SelectedDeliveryAddress" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT userName, nickname, buildingAddress, streetAddress, district FROM Address WHERE (userName = @userName) AND (nickname = @nickname)" 
        DeleteCommand="DELETE FROM [Address] WHERE [userName] = @userName AND [nickname] = @nickname AND [userName] IN (SELECT [userName] FROM [Address] GROUP BY [userName] HAVING COUNT(*) > 1)" 
        InsertCommand="INSERT INTO [Address] ([userName], [nickname], [buildingAddress], [streetAddress], [district]) VALUES (@userName, @nickname, @buildingAddress, @streetAddress, @district)" 
        
        UpdateCommand="UPDATE [Address] SET [buildingAddress] = @buildingAddress, [streetAddress] = @streetAddress, [district] = @district WHERE [userName] = @userName AND [nickname] = @nickname">
            <DeleteParameters>
                <asp:Parameter Name="userName" Type="String" />
                <asp:Parameter Name="nickname" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="userName" Type="String" />
                <asp:Parameter Name="nickname" Type="String" />
                <asp:Parameter Name="buildingAddress" Type="String" />
                <asp:Parameter Name="streetAddress" Type="String" />
                <asp:Parameter Name="district" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="gvAddress" Name="userName" 
                    PropertyName="SelectedDataKey.Values[0]" Type="String" />
                <asp:ControlParameter ControlID="gvAddress" Name="nickname" 
                    PropertyName="SelectedDataKey.Values[1]" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="buildingAddress" Type="String" />
                <asp:Parameter Name="streetAddress" Type="String" />
                <asp:Parameter Name="district" Type="String" />
                <asp:Parameter Name="userName" Type="String" />
                <asp:Parameter Name="nickname" Type="String" />
            </UpdateParameters>
    </asp:SqlDataSource>
    <p>
        
    </p>
    <p>
    </p>
</asp:Content>

