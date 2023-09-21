<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master" AutoEventWireup="false" CodeFile="frmEmpChangePassword.aspx.vb" Inherits="EmployeeProfile_frmEmpChangePassword" Title=".:HRM:Change Password:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlChangePassword" runat="server" Width="100%" 
                    SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4" align="left">
                                <div class="widgettitle">
                                    Change Password</div>
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 250px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Old Password<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtOldPassword" runat="server" CssClass="InputTxtBox" TextMode="Password"
                                    Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldOldPassword" runat="server" ControlToValidate="txtOldPassword"
                                    Display="None" ErrorMessage="Required" ValidationGroup="ChangePassword"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldOldPassword_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldOldPassword" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                New Password<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="InputTxtBox" TextMode="Password"
                                    Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldNewPassword" runat="server" ControlToValidate="txtNewPassword"
                                    Display="None" ErrorMessage="Required" ValidationGroup="ChangePassword"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldNewPassword_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldNewPassword" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RegularExpressionValidator ID="regExpNewPassword" runat="server" 
                                    ControlToValidate="txtNewPassword" Display="None" 
                                    ErrorMessage="Validates a strong password. It must be between 6 and 15 characters, contain at least one digit and one alphabetic character, and must not contain special characters." 
                                    ValidationExpression="((?=.*\d)(?=.*[a-z])(?=.*[\W]).{6,20})" 
                                    ValidationGroup="ChangePassword"></asp:RegularExpressionValidator>
                                <cc1:ValidatorCalloutExtender ID="regExpNewPassword_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="regExpNewPassword" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Re-Type Password<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtReTypePassword" runat="server" CssClass="InputTxtBox" TextMode="Password"
                                    Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldReTypePassword" runat="server" ControlToValidate="txtReTypePassword"
                                    Display="None" ErrorMessage="Required" ValidationGroup="ChangePassword"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldReTypePassword_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldReTypePassword" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RegularExpressionValidator ID="regExpReTypePassowrd" runat="server" 
                                    ControlToValidate="txtReTypePassword" Display="None" 
                                    ErrorMessage="Validates a strong password. It must be between 6 and 15 characters, contain at least one digit and one alphabetic character, and must not contain special characters." 
                                    ValidationExpression="((?=.*\d)(?=.*[a-z])(?=.*[\W]).{6,20})" 
                                    ValidationGroup="ChangePassword"></asp:RegularExpressionValidator>
                                <cc1:ValidatorCalloutExtender ID="regExpReTypePassowrd_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="regExpReTypePassowrd" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnChangePassword" runat="server" CssClass="DButton" 
                                    Text="Change Password" ValidationGroup="ChangePassword" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="DButton" Text="Cancel" />
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
