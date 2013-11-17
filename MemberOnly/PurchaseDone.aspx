<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="PurchaseDone.aspx.cs" Inherits="MemberOnly_ViewMemberInformation" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    </asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Thank you!</h2>
    <p>
        After a long and surely dreadful journey through the thorny interfaces of this 
        Visual Studio concocted site you have now successfully made your purchase. 
        Congrats. Here&#39;s your confirmation number:</p>
    <p>
        <asp:Label ID="ConfirmationNumberLabel" runat="server" Text="Label"></asp:Label>
    </p>
    </asp:Content>
