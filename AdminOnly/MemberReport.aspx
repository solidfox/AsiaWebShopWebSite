<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="MemberReport.aspx.cs" Inherits="AdminOnly_MemberReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        <strong style="font-size: large; color: #000080;">MEMBER&nbsp; REPORT</strong></p>
    <p>
        Input a username. If no username that search all member.</p>
<p>
        Member&#39;s UserName :<asp:TextBox ID="UserName" runat="server"></asp:TextBox>
        <asp:CustomValidator ID="MemberCustomValidator" runat="server" 
            Display="Dynamic" ErrorMessage="Please enter existed username." ForeColor="Red" 
            onservervalidate="MemberCustomValidator_ServerValidate"></asp:CustomValidator>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:CheckBox ID="cbItemName" runat="server" Text="Group By District" 
             />
    </p>
<p>
                <asp:Button ID="btnGenerate" runat="server" Text="Generate" 
                    onclick="btnGenerate_Click" />
    </p>
    <p>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                    CellPadding="4" DataKeyNames="userName" DataSourceID="MemberSqlDataSource0" 
                    ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="lastName" HeaderText="lastName" 
                            SortExpression="lastName" />
                        <asp:BoundField DataField="district" HeaderText="district" 
                            SortExpression="district" />
                        <asp:BoundField DataField="userName" HeaderText="userName" ReadOnly="True" 
                            SortExpression="userName" />
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
                &nbsp;</p>
        <asp:DataList ID="DataList1" runat="server" CellPadding="4" 
        DataKeyField="userName" DataSourceID="MemberSqlDataSource" 
        style="margin-right: 566px" Width="904px" ForeColor="#333333">
            <AlternatingItemStyle BackColor="White" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <ItemStyle BackColor="#EFF3FB" />
            <ItemTemplate>
                userName:
                <asp:Label ID="userNameLabel" runat="server" Text='<%# Eval("userName") %>' />
                &nbsp;&nbsp; lastName:
                <asp:Label ID="lastNameLabel" runat="server" Text='<%# Eval("lastName") %>' />
                &nbsp;&nbsp; firstName:
                <asp:Label ID="firstNameLabel" runat="server" Text='<%# Eval("firstName") %>' />
                &nbsp;<br /> email:
                <asp:Label ID="emailLabel" runat="server" Text='<%# Eval("email") %>' />
                &nbsp;phoneNumber:
                <asp:Label ID="phoneNumberLabel" runat="server" 
                    Text='<%# Eval("phoneNumber") %>' />
                &nbsp;renewalDate:
                <asp:Label ID="renewalDateLabel" runat="server" 
                    Text='<%# Eval("renewalDate") %>' />
                <br />

                <asp:DataList ID="DataList2" runat="server" DataSourceID="AddressSqlDataSource" 
                    Width="888px">
                    <ItemTemplate>
                        nickname:
                        <asp:Label ID="nicknameLabel" runat="server" Text='<%# Eval("nickname") %>' />
                        &nbsp; buildingAddress:
                        <asp:Label ID="buildingAddressLabel" runat="server" 
                            Text='<%# Eval("buildingAddress") %>' />
                        &nbsp;streetAddress:
                        <asp:Label ID="streetAddressLabel" runat="server" 
                            Text='<%# Eval("streetAddress") %>' />
                        &nbsp;district:
                        <asp:Label ID="districtLabel" runat="server" Text='<%# Eval("district") %>' />
                        <br />
                    </ItemTemplate>
                </asp:DataList>
                <asp:DataList ID="DataList3" runat="server" DataKeyField="userName" 
                    DataSourceID="CreditCardSqlDataSource" Width="888px">
                    <ItemTemplate>
                        number:
                        <asp:Label ID="numberLabel" runat="server" Text='<%# Eval("number") %>' />
                        &nbsp; type:
                        <asp:Label ID="typeLabel" runat="server" Text='<%# Eval("type") %>' />
                        &nbsp; cardHolderName:
                        <asp:Label ID="cardHolderNameLabel" runat="server" 
                            Text='<%# Eval("cardHolderName") %>' />
                        &nbsp; expiryMonth:
                        <asp:Label ID="expiryMonthLabel" runat="server" 
                            Text='<%# Eval("expiryMonth") %>' />
                        &nbsp;expiryYear:
                        <asp:Label ID="expiryYearLabel" runat="server" 
                            Text='<%# Eval("expiryYear") %>' />
                        <br />
                    </ItemTemplate>
                </asp:DataList>
 

                <asp:SqlDataSource ID="CreditCardSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
                    SelectCommand="SELECT * FROM [CreditCard] WHERE ([userName] = @userName)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="userNameLabel" DefaultValue="" Name="userName" 
                            PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="AddressSqlDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
                    SelectCommand="SELECT * FROM [Address] WHERE ([userName] = @userName)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="userNameLabel" Name="username" 
                            PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ItemTemplate>
            <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
    </asp:DataList>
        <asp:SqlDataSource ID="MemberSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        
            
            SelectCommand="SELECT [lastName], [firstName], [userName], [email], [phoneNumber], [renewalDate] FROM [Member] " 
           >
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="MemberSqlDataSource0" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        
            
            SelectCommand="SELECT Member.lastName, Address.district, Member.userName FROM Member INNER JOIN Address ON Member.userName = Address.userName WHERE (Address.nickname = N'Mailing') AND (Member.userName = @userName)" 
           >
            <SelectParameters>
                <asp:Parameter Name="userName" />
            </SelectParameters>
        </asp:SqlDataSource>
    <p>
        <br />
    </p>
</asp:Content>

