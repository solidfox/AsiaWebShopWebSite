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
            DataSourceID="SelectedCreditCard" ForeColor="#333333" GridLines="None"
            OnItemInserted="dvCreditCard_ItemInserted" 
            OnItemUpdated="dvCreditCard_ItemUpdated" 
            OnItemDeleted="dvCreditCard_ItemDeleted" >
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
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("userName") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("userName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="number" SortExpression="number">
                    <EditItemTemplate>
                        <asp:Label ID="editNumber" runat="server" Text='<%# Eval("number") %>'></asp:Label>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertNumber" runat="server" Text='<%# Bind("number") %>' 
                            MaxLength="16"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rvNumber" runat="server" 
                            ControlToValidate="InsertNumber" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Credit Card Number is requirement." ForeColor="#CC0000">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertNumber" runat="server" 
                            ControlToValidate="InsertNumber" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Credit Card Number shoud be 16 digit." ForeColor="#CC0000" 
                            ValidationExpression="^\d{14,16}$">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("number") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="type" SortExpression="type">
                    <EditItemTemplate>
                        <asp:TextBox ID="creditCardType" runat="server" 
                            ontextchanged="creditCardType_TextChanged" Text='<%# Bind("Type") %>'></asp:TextBox>
                        <asp:RegularExpressionValidator ID="rfvCreditCardList" runat="server" 
                            ControlToValidate="creditCardType" ErrorMessage="Wrong Credit card type" 
                            ValidationExpression="^((American Express)|(Diners Club)|(Discover)|(MasterCard)|(Visa))\s*$">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList4" runat="server" 
                            SelectedValue='<%# Bind("type") %>'>
                            <asp:ListItem>American Express</asp:ListItem>
                            <asp:ListItem>Dinner Club</asp:ListItem>
                            <asp:ListItem>Discover</asp:ListItem>
                            <asp:ListItem>MasterCard</asp:ListItem>
                            <asp:ListItem>Visa</asp:ListItem>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("type") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="cardHolderName" SortExpression="cardHolderName">
                    <EditItemTemplate>
                        <asp:TextBox ID="editCardHolderName" runat="server" 
                            Text='<%# Bind("cardHolderName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rvCardHolderName" runat="server" 
                            ControlToValidate="editCardHolderName" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Card Holder Name is requirement." 
                            ForeColor="#CC0000">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="insertCardHolderName" runat="server" 
                            Text='<%# Bind("cardHolderName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rvInsertCardHolderName" runat="server" 
                            ControlToValidate="insertCardHolderName" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Card Holder Name is required." 
                            ForeColor="#CC0000">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("cardHolderName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="expiryMonth" SortExpression="expiryMonth">
                    <EditItemTemplate>
                        <asp:DropDownList ID="editExpiryMonth" runat="server" 
                            SelectedValue='<%# Bind("expiryMonth") %>'>
                            <asp:ListItem>01</asp:ListItem>
                            <asp:ListItem>02</asp:ListItem>
                            <asp:ListItem>03</asp:ListItem>
                            <asp:ListItem>04</asp:ListItem>
                            <asp:ListItem>05</asp:ListItem>
                            <asp:ListItem>06</asp:ListItem>
                            <asp:ListItem>07</asp:ListItem>
                            <asp:ListItem>08</asp:ListItem>
                            <asp:ListItem>09</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                            <asp:ListItem>11</asp:ListItem>
                            <asp:ListItem>12</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" 
                            SelectedValue='<%# Bind("expiryMonth") %>'>
                            <asp:ListItem>01</asp:ListItem>
                            <asp:ListItem>02</asp:ListItem>
                            <asp:ListItem>03</asp:ListItem>
                            <asp:ListItem>04</asp:ListItem>
                            <asp:ListItem>05</asp:ListItem>
                            <asp:ListItem>06</asp:ListItem>
                            <asp:ListItem>07</asp:ListItem>
                            <asp:ListItem>08</asp:ListItem>
                            <asp:ListItem>09</asp:ListItem>
                            <asp:ListItem>10</asp:ListItem>
                            <asp:ListItem>11</asp:ListItem>
                            <asp:ListItem>12</asp:ListItem>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("expiryMonth") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="expiryYear" SortExpression="expiryYear">
                    <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server" 
                            SelectedValue='<%# Bind("expiryYear") %>'>
                            <asp:ListItem>2013</asp:ListItem>
                            <asp:ListItem>2014</asp:ListItem>
                            <asp:ListItem>2015</asp:ListItem>
                            <asp:ListItem>2016</asp:ListItem>
                            <asp:ListItem>2017</asp:ListItem>
                            <asp:ListItem>2018</asp:ListItem>
                            <asp:ListItem>2019</asp:ListItem>
                            <asp:ListItem>2020</asp:ListItem>
                            <asp:ListItem>2021</asp:ListItem>
                            <asp:ListItem>2022</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="DropDownList5" runat="server" 
                            SelectedValue='<%# Bind("expiryYear") %>'>
                            <asp:ListItem>2013</asp:ListItem>
                            <asp:ListItem>2014</asp:ListItem>
                            <asp:ListItem>2015</asp:ListItem>
                            <asp:ListItem>2016</asp:ListItem>
                            <asp:ListItem>2017</asp:ListItem>
                            <asp:ListItem>2018</asp:ListItem>
                            <asp:ListItem>2019</asp:ListItem>
                            <asp:ListItem>2020</asp:ListItem>
                            <asp:ListItem>2021</asp:ListItem>
                            <asp:ListItem>2022</asp:ListItem>
                        </asp:DropDownList>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("expiryYear") %>'></asp:Label>
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
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ForeColor="#CC0000" HeaderText="The following errors occurred:" 
        ShowMessageBox="True" />
    <p>
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

