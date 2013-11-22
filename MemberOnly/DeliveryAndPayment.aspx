<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="DeliveryAndPayment.aspx.cs" Inherits="MemberOnly_DeliveryAndPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            width: 100%;
        }
        .style5
        {
            font-size: large;
        }
        .style6
        {
            width: 115px;
            text-align: right;
        }
        .style7
        {
            width: 210px;
        }
        .style9
        {
            width: 161px;
            text-align: right;
        }
        .style10
        {
            width: 218px;
        }
        .style11
        {
            width: 117px;
            text-align: right;
        }
        .style13
        {
            width: 189px;
        }
        .style14
        {
            width: 156px;
            text-align: right;
        }
        .style15
        {
            text-align: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style5">
        Delivery Information</p>
    <table class="style4">
        <tr>
            <td class="style6">
                Name:</td>
            <td class="style7">
                <asp:Label ID="FirstName" runat="server"></asp:Label>
&nbsp;<asp:Label ID="LastName" runat="server"></asp:Label>
            </td>
            <td class="style14">
                Email Address: </td>
            <td colspan="3">
                <asp:Label ID="EmailAddress" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Address:</td>
            <td class="style7">
                <asp:DropDownList ID="SelectAddress" runat="server" AutoPostBack="True" >
                </asp:DropDownList>
            </td>
            <td class="style14">
                Telephone Number:</td>
            <td colspan="3">
                <asp:Label ID="TelephoneNo" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Building:</td>
            <td class="style7">
                <asp:TextBox ID="Building" runat="server" MaxLength="20"></asp:TextBox>
            </td>
            <td class="style14">
                Floor:</td>
            <td class="style13">
                <asp:TextBox ID="Floor" runat="server" MaxLength="3"></asp:TextBox>
            </td>
            <td class="style11">
                Flat/Suite:</td>
            <td>
                <asp:TextBox ID="FlatSuite" runat="server" MaxLength="5"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Street:</td>
            <td class="style7">
                <asp:TextBox ID="Street" runat="server" MaxLength="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvStreet" runat="server" 
                    ControlToValidate="Street" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Street is required">*</asp:RequiredFieldValidator>
            </td>
            <td class="style14">
                District:</td>
            <td class="style13">
                <asp:DropDownList ID="DistrictDropDownList" runat="server">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" 
                    ControlToValidate="DistrictDropDownList" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="District is required" 
                    InitialValue="-- Select district --">*</asp:RequiredFieldValidator>
            </td>
            <td class="style11">
                Block/Tower:</td>
            <td>
                <asp:TextBox ID="BlockTower" runat="server" MaxLength="2"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Delivery Date:</td>
            <td class="style7">
                <asp:DropDownList ID="SelectDate" runat="server">
                </asp:DropDownList>
                <asp:CustomValidator ID="cvDeliveryDate" runat="server" 
                    ControlToValidate="SelectDate" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Date: The earliest delivery time-slot must be at least 24 hours after the purchase time." 
                    ForeColor="Red" onservervalidate="cvDeliveryDate_ServerValidate1">*</asp:CustomValidator>
            </td>
            <td class="style14">
                Delivery Time:</td>
            <td colspan="3">
                <asp:DropDownList ID="SelectTime" runat="server">
                </asp:DropDownList>
                <asp:CustomValidator ID="cvDeliveryTime" runat="server" 
                    ControlToValidate="SelectTime" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Time: The earliest delivery time-slot must be at least 24 hours after the purchase time." 
                    ForeColor="Red" onservervalidate="cvDeliveryDate_ServerValidate">*</asp:CustomValidator>
            </td>
        </tr>
        </table>
    <br />
    <span class="style5">Payment Information</span><br />
    <table class="style4">
        <tr>
            <td class="style9">
                Credit Card Number:</td>
            <td class="style10">
                <asp:DropDownList ID="SelectCreditCard" runat="server" AutoPostBack="True">
                </asp:DropDownList>
            </td>
        </tr>
                <tr>
            <td class="style15">
                Cardholder Name:</td>
            <td class="style10">
                <asp:TextBox ID="CardHolderName" runat="server" MaxLength="50"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                    ControlToValidate="CardHolderName" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Cardholder Name is required">*</asp:RequiredFieldValidator>
            </td>
            <td class="style15">
                Card Type:</td>
            <td>
                <asp:DropDownList ID="CardTypeDropDownList" runat="server">
                    <asp:ListItem>-- Select credit card --</asp:ListItem>
                    <asp:ListItem>American Express</asp:ListItem>
                    <asp:ListItem>Diners Club</asp:ListItem>
                    <asp:ListItem>Discover</asp:ListItem>
                    <asp:ListItem>MasterCard</asp:ListItem>
                    <asp:ListItem>Visa</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCardTypeDropDownList" runat="server" 
                    ControlToValidate="CardTypeDropDownList" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Please select a credit card type." 
                    InitialValue="-- Select credit card --">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style15">
                Card Number:</td>
            <td style="margin-left: 40px" class="style10">
                <asp:TextBox ID="CardNumber" runat="server" MaxLength="16"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" 
                    ControlToValidate="CardNumber" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Card Number is required">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="CardNumber" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" 
                    ErrorMessage="Card Number must be numeric and between 14 and 16 digits" 
                    ValidationExpression="^\d{14,16}$">*</asp:RegularExpressionValidator>
            </td>
            <td class="style15">
                Expiry Date:</td>
            <td>
                <asp:DropDownList ID="MonthDropDownList" runat="server">
                    <asp:ListItem Value="00">Month</asp:ListItem>
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
                <asp:RequiredFieldValidator ID="rfvMonth" runat="server" 
                    ControlToValidate="MonthDropDownList" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Please select a month" 
                    InitialValue="00">*</asp:RequiredFieldValidator>
                /
                <asp:DropDownList ID="YearDropDownList" runat="server">
                    <asp:ListItem Value="0">Year</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvYear" runat="server" 
                    ControlToValidate="YearDropDownList" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Please select a year" 
                    InitialValue="Year">*</asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    <br />
    <asp:Button ID="btnSubmit" runat="server" onclick="btnSubmit_Click" 
        Text="Submit" />
    <asp:ValidationSummary ID="ValidationSummary" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="The following errors occured:" />
    <br />
</asp:Content>

