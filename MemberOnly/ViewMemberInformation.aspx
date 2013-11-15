<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="ViewMemberInformation.aspx.cs" Inherits="MemberOnly_ViewMemberInformation" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style4
        {
            height: 34px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Your account</h2>
    <a href="EditMemberInformation.aspx">Edit my information</a><br />
    <a href="../Account/ChangePassword.aspx">Change password</a><br />
    <a href="ManageDeliveryAddress/ManageDeliveryAddressList.aspx">Manage delivery address List</a><br />
    <a href="../Account/ChangePassword.aspx">Manage credit card List</a><br />
&nbsp;<h3>Member Information</h3>
    <table>
        <tr>
            <td>
                User Name:</td>
            <td>
                <asp:Label ID="UserName" runat="server" MaxLength="10"></asp:Label>
            </td>
            <td>
                Email Address:</td>
            <td>
                <asp:Label ID="Email" runat="server" MaxLength="30"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style4">
                First Name</td>
            <td class="style4">
                <asp:Label ID="FirstName" runat="server" MaxLength="20"></asp:Label>
            </td>
            <td class="style4">
                Last Name:</td>
            <td class="style4">
                <asp:Label ID="LastName" runat="server" MaxLength="30"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Phone Number:</td>
            <td>
                <asp:Label ID="PhoneNumber" runat="server" MaxLength="8"></asp:Label>
            </td>
            <td>
                </td>
            <td>
                </td>
        </tr>
        <tr>
            <td>
                Address:</td>
            <td colspan="3">
                <asp:Label ID="Address" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Street:</td>
            <td>
                <asp:Label ID="Street" runat="server" MaxLength="30"></asp:Label>
            </td>
            <td>
                District</td>
            <td>
                <asp:Label ID="District" runat="server">
                </asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Renewal Date:</td>
            <td colspan="3">
                <asp:Label ID="RenewalDate" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <h3>Credit Card Information</h3>
    <table>
        <tr>
            <td>
                Cardholder Name:</td>
            <td>
                <asp:Label ID="CardHolderName" runat="server" MaxLength="50"></asp:Label>
            </td>
            <td>
                Card Type:</td>
            <td>
                <asp:Label ID="CardType" runat="server">
                </asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Card Number:</td>
            <td style="margin-left: 40px">
                <asp:Label ID="CardNumber" runat="server" MaxLength="16"></asp:Label>
&nbsp;</td>
            <td>
                Expiry Date:</td>
            <td>
                <asp:Label ID="Month" runat="server"> </asp:Label>
                /<asp:Label ID="Year" runat="server">
                </asp:Label>
            </td>
        </tr>
    </table>
    </asp:Content>
