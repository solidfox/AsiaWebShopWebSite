<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="AdminSelection.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            font-size: large;
            text-decoration: underline;
            font-family: Arial, Helvetica, sans-serif;
            color: #3333CC;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style4">
        Make a Selection</p>
    <p>
        <asp:HyperLink ID="ManageInformationLink" runat="server" 
            NavigateUrl="~/AdminOnly/ItemManagement.aspx">Item Management</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="AdminLink" runat="server" 
            NavigateUrl="~/AdminOnly/MemberManagement.aspx">Member Management</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="AdminLink1" runat="server" 
            NavigateUrl="~/AdminOnly/MemberReport.aspx">Generate Member Infomartion Report</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="AdminLink2" runat="server" 
            NavigateUrl="~/AdminOnly/MemberReport.aspx">Generate Total Purchase Report</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="AdminLink3" runat="server" 
            NavigateUrl="~/AdminOnly/MemberReport.aspx">Generate Member Purchase Report</asp:HyperLink>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>

