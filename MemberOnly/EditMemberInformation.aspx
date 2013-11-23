<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="EditMemberInformation.aspx.cs" Inherits="_Default" %>

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
        Change Your Information</h2>
    <h3>Member Information</h3>
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
                <asp:TextBox ID="Email" runat="server" MaxLength="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                    ControlToValidate="Email" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Email Address is required">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ControlToValidate="Email" CssClass="footer" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Please input valid Email address" 
                    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="style4">
                First Name</td>
            <td class="style4">
                <asp:TextBox ID="FirstName" runat="server" MaxLength="20" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                    ControlToValidate="FirstName" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="First Name is required">*</asp:RequiredFieldValidator>
            </td>
            <td class="style4">
                Last Name:</td>
            <td class="style4">
                <asp:TextBox ID="LastName" runat="server" MaxLength="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                    ControlToValidate="LastName" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Last Name is required">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Phone Number:</td>
            <td>
                <asp:TextBox ID="PhoneNumber" runat="server" MaxLength="8"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" 
                    ControlToValidate="PhoneNumber" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Phone Number is required">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPhoneNumber" runat="server" 
                    ControlToValidate="PhoneNumber" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" 
                    ErrorMessage="Phone Number must be numeric and exactly 8 digits" 
                    ValidationExpression="^\d{8}$">*</asp:RegularExpressionValidator>
            </td>
            <td>
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        </table>
    <br />
    <asp:Button ID="Save" runat="server" Text="Save" 
        onclick="Register_Click" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        CssClass="failureNotification" EnableClientScript="False" 
        HeaderText="The following errors occurred:" />
</asp:Content>
