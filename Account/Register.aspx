<%@ Page Title="Register" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Account_Register" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style3
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: large;
            color: #000080;
            text-transform: uppercase;
            text-decoration: underline;
            font-weight: normal;
        }
    .style5
    {
        width: 159px;
    }
    .style7
    {
        width: 136px;
    }
    .style8
    {
        width: 166px;
    }
    .style9
    {
        width: 194px;
    }
    .style10
    {
        width: 226px;
    }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:CreateUserWizard ID="RegisterUser" runat="server" 
        style="margin-right: 80px" oncreateduser="RegisterUser_CreatedUser" >
        <LayoutTemplate>
            <asp:PlaceHolder ID="wizardStepPlaceholder" runat="server"></asp:PlaceHolder>
            <asp:PlaceHolder ID="navigationPlaceholder" runat="server"></asp:PlaceHolder>
        </LayoutTemplate>
        <WizardSteps>
            <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                <ContentTemplate>
                    <h2 class="style3">
                        REGISTRATION PAGE</h2>
                    <p>
                        Use the form below to create a new account.
                    </p>
                    <p>
                        Passwords are required to be a minimum of <%= Membership.MinRequiredPasswordLength %> characters in length.
                    </p>
                    <span class="failureNotification">
                        <asp:Literal ID="ErrorMessage" runat="server" 
                        Text="The following errors occurred:"></asp:Literal>
                    </span>
                    <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification" 
                         ValidationGroup="RegisterUserValidationGroup" EnableClientScript="False"/>
                    <div class="accountInfo">
                        
                        <p>
                            <p class="style19">
                            <strong>Member Information</strong></p>
                        <table class="style11">
                            <tr>
                                <td align="right" class="style10">
                                    User Name:</td>
                                <td class="style8">
                                    <asp:TextBox ID="UserName" runat="server" MaxLength="10"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvUserName" runat="server" 
                                        ControlToValidate="UserName" CssClass="style28" Display="Dynamic" 
                                        EnableClientScript="False" ErrorMessage="User Name is required." 
                                        ForeColor="Red" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revUserName" runat="server" 
                                        ControlToValidate="UserName" Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="User Name must be alphanumeric and between 6 and 10 characters." 
                                        ForeColor="Red" ValidationGroup="RegisterUserValidationGroup" 
                                        ValidationExpression="^[A-Za-z\d]{6,10}$">*</asp:RegularExpressionValidator>
                                </td>
                                <td align="right" class="style5">
                                    Email Address:</td>
                                <td class="style16">
                                    <asp:TextBox ID="Email" runat="server" MaxLength="30"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                        ControlToValidate="Email" Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="Email Address is required." ForeColor="Red" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Email" CssClass="footer" Display="Dynamic" EnableClientScript="False" ErrorMessage="Please input valid Email address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="RegisterUserValidationGroup">*</asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style10">
                                    Password:</td>
                                <td class="style8">
                                    <asp:TextBox ID="Password" runat="server" TextMode="Password" MaxLength="15"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                                        ControlToValidate="Password" Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="Password is required." ForeColor="Red" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                </td>
                                <td align="right" class="style5">
                                    Confirm Password:</td>
                                <td class="style16">
                                    <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" 
                                        MaxLength="15"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                                        ControlToValidate="ConfirmPassword" Display="Dynamic" 
                                        EnableClientScript="False" ErrorMessage="Confirm Password is required." 
                                        ForeColor="Red" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="cvConfirmPassword" runat="server" 
                                        ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                                        Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="Password and Confirm Password must be the same." 
                                        ForeColor="Red" ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style10">
                                    First Name:</td>
                                <td class="style8">
                                    <asp:TextBox ID="FirstName" runat="server" MaxLength="20"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                                        ControlToValidate="FirstName" Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="First Name is required." ForeColor="Red" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                </td>
                                <td align="right" class="style5">
                                    Last Name:</td>
                                <td class="style17">
                                    <asp:TextBox ID="LastName" runat="server" MaxLength="30"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                                        ControlToValidate="LastName" Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="Last Name is required." ForeColor="Red" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style10">
                                    Phone Number:</td>
                                <td class="style8">
                                    <asp:TextBox ID="PhoneNumber" runat="server" MaxLength="8"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="revPhoneNumber" runat="server" 
                                        ControlToValidate="PhoneNumber" Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="Phone Number must be numeric and exactly 8 digits." 
                                        ForeColor="Red" ValidationExpression="^\d{8}$" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" 
                                        ControlToValidate="PhoneNumber" Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="Phone Number is required." ForeColor="Red" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                </td>
                                <td class="style5">
                                    &nbsp;</td>
                                <td class="style16">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td align="right" class="style10">
                                    Building:</td>
                                <td class="style8">
                                    <asp:TextBox ID="Building" runat="server" MaxLength="20"></asp:TextBox>
                                </td>
                                <td class="style5">
                                    <table class="style11">
                                        <tr>
                                            <td align="right">
                                                Floor:</td>
                                            <td>
                                                <asp:TextBox ID="Floor" runat="server" Width="65px" MaxLength="3"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td class="style16">
                                    <table class="style11">
                                        <tr>
                                            <td align="right">
                                                Flat/Suite:</td>
                                            <td class="style7">
                                                <asp:TextBox ID="FlatSuite" runat="server" MaxLength="5"></asp:TextBox>
                                            </td>
                                            <td align="right">
                                                Block/Tower:</td>
                                            <td>
                                                <asp:TextBox ID="BlockTower" runat="server" MaxLength="2"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style10">
                                    Street:</td>
                                <td class="style8">
                                    <asp:TextBox ID="Street" runat="server" MaxLength="30"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvStreet" runat="server" 
                                        ControlToValidate="Street" Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="Street is required." ForeColor="Red" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                </td>
                                <td align="right" class="style5">
                                    District:</td>
                                <td class="style16">
                                    <asp:DropDownList ID="DistrictDropDownList" runat="server">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" 
                                        ControlToValidate="DistrictDropDownList" Display="Dynamic" 
                                        EnableClientScript="False" ErrorMessage="Please select a district." 
                                        ForeColor="Red" InitialValue="-- Select district --" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                        </table>
                        <p class="style19">
                            <strong>Credit Card Information</strong></p>
                        <table class="style11">
                            <tr>
                                <td align="right" class="style24">
                                    CardHolder Name:</td>
                                <td class="style29">
                                    <asp:TextBox ID="CardHolderName" runat="server" MaxLength="50"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                                        ControlToValidate="CardHolderName" Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="Cardholder Name is required." ForeColor="Red" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                </td>
                                <td align="right" class="style26">
                                    Card Type:</td>
                                <td class="style27">
                                    <asp:DropDownList ID="CardTypeDropDownList" runat="server">
                                        <asp:ListItem>-- Select credit card --</asp:ListItem>
                                        <asp:ListItem>American Express</asp:ListItem>
                                        <asp:ListItem>Diners Club</asp:ListItem>
                                        <asp:ListItem>Discover</asp:ListItem>
                                        <asp:ListItem>MasterCard</asp:ListItem>
                                        <asp:ListItem>Visa</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvCardTypeDropDownList" runat="server" 
                                        ControlToValidate="CardTypeDropDownList" Display="Dynamic" 
                                        EnableClientScript="False" ErrorMessage="Please select a credit card." 
                                        ForeColor="Red" InitialValue="-- Select credit card --" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="style23">
                                    Card Number:</td>
                                <td class="style30">
                                    <asp:TextBox ID="CardNumber" runat="server" MaxLength="16"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="revCardNumber" runat="server" 
                                        ControlToValidate="CardNumber" Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="Card Number must be numeric and between 14 and 16 digits." 
                                        ForeColor="Red" ValidationExpression="^\d{14,16}$" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" 
                                        ControlToValidate="CardNumber" Display="Dynamic" EnableClientScript="False" 
                                        ErrorMessage="Card Number is required." ForeColor="Red" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                </td>
                                <td align="right" class="style22">
                                    Expiry Date:</td>
                                <td class="style20">
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
                                        ControlToValidate="MonthDropDownList" Display="Dynamic" 
                                        EnableClientScript="False" ErrorMessage="Please select a month." 
                                        ForeColor="Red" InitialValue="00" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                        &nbsp;/
                                    <asp:DropDownList ID="YearDropDownList" runat="server" >
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvYear" runat="server" 
                                        ControlToValidate="YearDropDownList" Display="Dynamic" 
                                        EnableClientScript="False" ErrorMessage="Please select a year." ForeColor="Red" 
                                        InitialValue="Year" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:CustomValidator ID="cvExpiryDate" runat="server" 
                                        ControlToValidate="MonthDropDownList" Display="Dynamic" 
                                        EnableClientScript="False" ErrorMessage="Credit card is expired. " 
                                        ForeColor="Red" onservervalidate="cvExpiryDate_ServerValidate" 
                                        ValidationGroup="RegisterUserValidationGroup">*</asp:CustomValidator>
                                </td>
                            </tr>
                        </table>
                            <p>
                            </p>
                            <p class="submitButton">
                                <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" 
                                    Text="Create User" ValidationGroup="RegisterUserValidationGroup" />
                            </p>
                            <p>
                            </p>
                            <p>
                            </p>
                            <p>
                            </p>
                            <p>
                            </p>
                            <p>
                            </p>
                        </p>

                    </div>
                </ContentTemplate>
                <CustomNavigationTemplate>
                </CustomNavigationTemplate>
            </asp:CreateUserWizardStep>
<asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server"></asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
</asp:Content>