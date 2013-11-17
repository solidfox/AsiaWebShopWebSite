<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ChangeDeliveryInfo.aspx.cs" Inherits="MemberOnly_ChangeDeliveryInfo" %>

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
            width: 104px;
        }
        .style7
        {
            width: 277px;
        }
        .style8
        {
            width: 137px;
        }
        .style9
        {
            width: 161px;
        }
        .style10
        {
            width: 765px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style5">
        Change
        Delivery Information</p>
    <table class="style4">
        <tr>
            <td class="style6">
                Name:</td>
            <td class="style7">
                <asp:Label ID="FirstName" runat="server"></asp:Label>
&nbsp;<asp:Label ID="LastName" runat="server"></asp:Label>
            </td>
            <td class="style8">
                Email Address:</td>
            <td>
                <asp:Label ID="EmailAddress" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Address:</td>
            <td class="style7">
                <asp:DropDownList ID="SelectAddress" runat="server" >
                </asp:DropDownList>
            </td>
            <td class="style8">
                Telephone Number:</td>
            <td>
                <asp:Label ID="TelephoneNo" runat="server"></asp:Label>
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
            <td class="style8">
                Delivery Time:</td>
            <td>
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
    <span class="style5">Change Payment Information</span><br />
    <table class="style4">
        <tr>
            <td class="style9">
                Credit Card Number:</td>
            <td class="style10">
                <asp:DropDownList ID="SelectCreditCard" runat="server">
                </asp:DropDownList>
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

