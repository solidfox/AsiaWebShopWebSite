<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="MemberSelection.aspx.cs" Inherits="_Default" %>

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
            NavigateUrl="~/MemberOnly/ViewMemberInformation.aspx">Manage Your Information</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="ReviewItemLink" runat="server" 
            NavigateUrl="~/MemberOnly/ReviewItem.aspx">Review Item</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="BrowseOwnPurchaseLink" runat="server" 
            NavigateUrl="~/MemberOnly/BrowseAllPurchase.aspx">Browse Own Purchase</asp:HyperLink>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>

