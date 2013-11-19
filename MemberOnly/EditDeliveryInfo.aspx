<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="EditDeliveryInfo.aspx.cs" Inherits="MemberOnly_DeliveryAndPayment" %>

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
        .style10
        {
            width: 275px;
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
        .style16
        {
            width: 121px;
            text-align: right;
        }
        .style17
        {
            width: 84px;
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
                    ErrorMessage="The earliest delivery time-slot must be at least 24 hours after the purchase time." 
                    ForeColor="Red" onservervalidate="cvDeliveryDate_ServerValidate1">*</asp:CustomValidator>
            </td>
            <td class="style14">
                Delivery Time:</td>
            <td colspan="3">
                <asp:DropDownList ID="SelectTime" runat="server">
                </asp:DropDownList>
                <asp:CustomValidator ID="cvDeliveryTime" runat="server" 
                    ControlToValidate="SelectTime" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="The earliest delivery time-slot must be at least 24 hours after the purchase time." 
                    ForeColor="Red" onservervalidate="cvDeliveryDate_ServerValidate">*</asp:CustomValidator>
            </td>
        </tr>
        </table>
    <br />
    <span class="style5">Payment Information</span><br />
    <table class="style4">
                <tr>
            <td class="style16">
                Card Number:</td>
            <td class="style10">
                <asp:Label ID="cardNum" runat="server"></asp:Label>
            </td>
            <td class="style17">
                Card Type:</td>
            <td>
                <asp:Label ID="cardType" runat="server"></asp:Label>
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

