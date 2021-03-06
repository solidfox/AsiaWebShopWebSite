﻿<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
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
    <a href="EditMemberInformation.aspx">Edit Member information</a><br />
    <a href="../Account/ChangePassword.aspx">Change password</a><br />
    <a href="ManageAddress/EditAddress.aspx">Manage delivery address List</a><br />
    <a href="ManageCreditCard/ManageCreditCard.aspx">Manage credit card List</a><br />
    <br />
    Edit Member&#39;s Address and Credit Card. Please Edit in Credit Card List and 
    Delivery List respectively. <h3>Member Information</h3>
    <table>
        <tr>
            <td>
                User Name:</td>
            <td>
                <asp:Label ID="UserName" runat="server"></asp:Label>
            </td>
            <td>
                Email Address:</td>
            <td>
                <asp:Label ID="Email" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style4">
                First Name</td>
            <td class="style4">
                <asp:Label ID="FirstName" runat="server"></asp:Label>
            </td>
            <td class="style4">
                Last Name:</td>
            <td class="style4">
                <asp:Label ID="LastName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                Phone Number:</td>
            <td>
                <asp:Label ID="PhoneNumber" runat="server"></asp:Label>
            </td>
            <td>
                </td>
            <td>
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
    <br />
    </asp:Content>
