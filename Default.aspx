<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2>
        Make a Selection</h2>
    <p>
        <asp:HyperLink ID="SearchLink" runat="server" NavigateUrl="~/ItemSearch.aspx">Search For Items</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="ManageInformationLink" runat="server" 
            NavigateUrl="~/MemberOnly/ViewMemberInformation.aspx">Manage Your Information</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="AdminLink" runat="server" 
            NavigateUrl="~/AdminOnly/AdminSelection.aspx">Admin Use Only</asp:HyperLink>
    </p>
</asp:Content>

