<%@ Page Title="Register" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Account_Register" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:CreateUserWizard ID="RegisterUser" runat="server" 
        OnCreatedUser="RegisterUser_CreatedUser" 
        oncreatinguser="RegisterUser_CreatingUser" style="margin-right: 203px">
        <LayoutTemplate>
            <asp:PlaceHolder ID="wizardStepPlaceholder" runat="server"></asp:PlaceHolder>
            <asp:PlaceHolder ID="navigationPlaceholder" runat="server"></asp:PlaceHolder>
        </LayoutTemplate>
        <WizardSteps>
            <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                <ContentTemplate>
                    <h2>
                        REGISTRATION PAGE</h2>
                    <p>
                        Use the form below to create a new account.
                    </p>
                    <p>
                        Passwords are required to be a minimum of <%= Membership.MinRequiredPasswordLength %> characters in length.
                    </p>
                    <span class="failureNotification">
                        <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                    </span>
                    <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification" 
                         ValidationGroup="RegisterUserValidationGroup"/>
                    <div class="accountInfo">
    <h3>Member Information</h3>
    <table>
        <tr>
            <td>
                User Name:</td>
            <td>
                <asp:TextBox ID="UserName" runat="server" MaxLength="10"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUserName" runat="server" 
                    ControlToValidate="UserName" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="User Name is required">*</asp:RequiredFieldValidator>
&nbsp;<asp:RegularExpressionValidator ID="revUserName" runat="server" 
                    ControlToValidate="UserName" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" 
                    ErrorMessage="User Name must be alphanumeric and at least 6 characters" 
                    ValidationExpression="^[A-Za-z\d]{6,10}$">*</asp:RegularExpressionValidator>
            </td>
            <td>
                Email Address:</td>
            <td>
                <asp:TextBox ID="Email" runat="server" MaxLength="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                    ControlToValidate="Email" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Email Address is required">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                Password:</td>
            <td>
                <asp:TextBox ID="Password" TextMode="Password" runat="server" MaxLength="15"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="Password" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Password is required">*</asp:RequiredFieldValidator>
            </td>
            <td>
                Confirm Password:</td>
            <td>
                <asp:TextBox ID="ConfirmPassword" TextMode="Password" runat="server" 
                    MaxLength="15"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                    ControlToValidate="ConfirmPassword" CssClass="failureNotification" 
                    Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Please enter your password twice">*</asp:RequiredFieldValidator>
&nbsp;<asp:CompareValidator ID="cvComparePassword" runat="server" ControlToCompare="Password" 
                    ControlToValidate="ConfirmPassword" CssClass="failureNotification" 
                    Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Passwords did not match">*</asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td class="style4">
                First Name</td>
            <td class="style4">
                <asp:TextBox ID="FirstName" runat="server" MaxLength="20"></asp:TextBox>
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
&nbsp;<asp:RegularExpressionValidator ID="revPhoneNumber" runat="server" 
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
&nbsp;<asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
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
                /<asp:DropDownList ID="YearDropDownList" runat="server">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvYear" runat="server" 
                    ControlToValidate="YearDropDownList" CssClass="failureNotification" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Please select a year" 
                    InitialValue="Year">*</asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
                        <p class="submitButton">
                            <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="Create User" 
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
                    </div>
                </ContentTemplate>
                <CustomNavigationTemplate>
                </CustomNavigationTemplate>
            </asp:CreateUserWizardStep>
<asp:CompleteWizardStep runat="server"></asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
</asp:Content>