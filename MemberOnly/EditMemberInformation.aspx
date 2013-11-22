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
        <tr>
            <td>
                Building:</td>
            <td>
                <asp:TextBox ID="Building" runat="server" MaxLength="20"></asp:TextBox>
            </td>
            <td>
                Floor:
                <asp:TextBox ID="Floor" runat="server" MaxLength="3"></asp:TextBox>
            </td>
            <td>
                Flat/Suite:
                <asp:TextBox ID="FlatSuite" runat="server" MaxLength="5"></asp:TextBox>
&nbsp;Block/Tower:
                <asp:TextBox ID="BlockTower" runat="server" MaxLength="2"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Street:</td>
            <td>
                <asp:TextBox ID="Street" runat="server" MaxLength="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvStreet" runat="server" 
                    ControlToValidate="Street" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Street is required">*</asp:RequiredFieldValidator>
            </td>
            <td>
                District</td>
            <td>
                <asp:DropDownList ID="DistrictDropDownList" runat="server">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" 
                    ControlToValidate="DistrictDropDownList" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="District is required" 
                    InitialValue="-- Select district --">*</asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    <h3>Credit Card Information</h3>
    <table>
        <tr>
            <td>
                Cardholder Name:</td>
            <td>
                <asp:TextBox ID="CardHolderName" runat="server" MaxLength="50"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                    ControlToValidate="CardHolderName" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Cardholder Name is required">*</asp:RequiredFieldValidator>
            </td>
            <td>
                Card Type:</td>
            <td>
                <asp:DropDownList ID="CardTypeDropDownList" runat="server">
                    <asp:ListItem>-- Select credit card --</asp:ListItem>
                    <asp:ListItem>American Express</asp:ListItem>
                    <asp:ListItem>Diners Club</asp:ListItem>
                    <asp:ListItem>Discover</asp:ListItem>
                    <asp:ListItem>MasterCard</asp:ListItem>
                    <asp:ListItem>Visa</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCardTypeDropDownList" runat="server" 
                    ControlToValidate="CardTypeDropDownList" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Please select a credit card" 
                    InitialValue="-- Select credit card --">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Card Number:</td>
            <td style="margin-left: 40px">
                <asp:TextBox ID="CardNumber" runat="server" MaxLength="16"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" 
                    ControlToValidate="CardNumber" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Card Number is required">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="CardNumber" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" 
                    ErrorMessage="Card Number must be numeric and between 14 and 16 digits" 
                    ValidationExpression="^\d{14,16}$">*</asp:RegularExpressionValidator>
            </td>
            <td>
                Expiry Date:</td>
            <td>
                <asp:DropDownList ID="MonthDropDownList" runat="server">
                    <asp:ListItem Value="00">Month</asp:ListItem>
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                    <asp:ListItem>07</asp:ListItem>
                    <asp:ListItem>08</asp:ListItem>
                    <asp:ListItem>09</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvMonth" runat="server" 
                    ControlToValidate="MonthDropDownList" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Please select a month" 
                    InitialValue="00">*</asp:RequiredFieldValidator>
                /
                <asp:DropDownList ID="YearDropDownList" runat="server">
                    <asp:ListItem Value="0">Year</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvYear" runat="server" 
                    ControlToValidate="YearDropDownList" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Please select a year" 
                    InitialValue="Year">*</asp:RequiredFieldValidator>
                <asp:CustomValidator ID="cvExpiryDate" runat="server" 
                    ControlToValidate="MonthDropDownList" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Credit card is expired. " 
                    ForeColor="Red" onservervalidate="cvExpiryDate_ServerValidate">*</asp:CustomValidator>
            </td>
        </tr>
    </table>
    <br />
    <asp:Button ID="Save" runat="server" Text="Save" 
        onclick="Register_Click" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        CssClass="failureNotification" EnableClientScript="False" 
        HeaderText="The following errors occurred:" />
</asp:Content>
