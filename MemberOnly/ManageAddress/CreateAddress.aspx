<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="CreateAddress.aspx.cs" Inherits="createAddress" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style4
        {
            width: 60%;
            height: 65px;
        }
        .style5
        {
            width: 69px;
        }
        .style6
        {
            width: 250px;
        }
        .style8
        {
        }
        .style9
        {
            width: 30px;
        }
        .style13
        {
            width: 38px;
        }
        .style15
        {
            width: 90px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h3>
        Create New Delivery Address</h3>
    <table class="style4">
        <tr>
            <td class="style5">
                Nick name:</td>
            <td class="style6">
                <asp:TextBox ID="NickName" runat="server" MaxLength="10"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvNickName" runat="server" 
                    ControlToValidate="NickName" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Nick Name is required." ForeColor="#CC0000">*</asp:RequiredFieldValidator>
                <asp:CustomValidator ID="cvNickName" runat="server" 
                    ControlToValidate="NickName" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Nick Name must be unique." ForeColor="#CC0000" 
                    onservervalidate="cvNickName_ServerValidate">*</asp:CustomValidator>
            </td>
            <td class="style13">
                &nbsp;</td>
            <td class="style15">
                &nbsp;</td>
            <td class="style9">
                &nbsp;</td>
            <td class="style15">
                &nbsp;</td>
            <td class="style5">
                &nbsp;</td>
            <td class="style15">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style5">
                Building:</td>
            <td class="style6">
                <asp:TextBox ID="Building" runat="server" MaxLength="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBuilding" runat="server" 
                    ErrorMessage="Building is required" ControlToValidate="Building" 
                    Display="Dynamic" EnableClientScript="False" ForeColor="#CC0000">*</asp:RequiredFieldValidator>
            </td>
            <td class="style13">
                Floor:</td>
            <td class="style15">
                <asp:TextBox ID="Floor" runat="server" Width="30px" MaxLength="3"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFloor" runat="server" 
                    ErrorMessage="Floor is required." ControlToValidate="Floor" 
                    Display="Dynamic" EnableClientScript="False" ForeColor="#CC0000">*</asp:RequiredFieldValidator>
            </td>
            <td class="style9">
                Flat/Suite:</td>
            <td class="style15">
                
                <asp:TextBox ID="Flat" runat="server" Width="40px" MaxLength="5"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="rfvFlat" runat="server" 
                    ErrorMessage="Flat is required." ControlToValidate="Flat" 
                    Display="Dynamic" EnableClientScript="False" ForeColor="#CC0000">*</asp:RequiredFieldValidator>
                
            </td>
            <td class="style5">
                Block/Tower:</td>
            <td class="style15">
                <asp:TextBox ID="Block" runat="server" Width="30px" MaxLength="2"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvBlock" runat="server" 
                    ErrorMessage="Block is required." ControlToValidate="Block" 
                    Display="Dynamic" EnableClientScript="False" ForeColor="#CC0000">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style5">
                Street:</td>
            <td class="style6">
                <asp:TextBox ID="Street" runat="server" MaxLength="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvStreet" runat="server" 
                    ErrorMessage="Street is required." ControlToValidate="Street" 
                    Display="Dynamic" EnableClientScript="False" ForeColor="#CC0000">*</asp:RequiredFieldValidator>
            </td>
            <td class="style13">
                District:</td>
            <td class="style8" colspan="4">
                <asp:DropDownList ID="DistrictDropDownList" runat="server" Width="150px">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" 
                    ErrorMessage="District is required." 
                    ControlToValidate="DistrictDropDownList" Display="Dynamic" 
                    EnableClientScript="False" ForeColor="#CC0000" 
                    InitialValue="-- Select district --">*</asp:RequiredFieldValidator>
            </td>
            <td class="style15">
                &nbsp;</td>
        </tr>
    </table>
    <br />
    <asp:Button ID="Create" runat="server" Text="Create" onclick="Create_Click"/>

    <br />
    <br />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="#CC0000" 
        HeaderText="The following errors occurred:" />

</asp:Content>

