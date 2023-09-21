<%@ Page Language="VB" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmEmployeeDetails.aspx.vb" Inherits="EmployeeProfile_frmEmployeeDetails"
    Title=".:MHRM:Employee Details:." Theme="CommonSkin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlEmpBasicData" runat="server" SkinID="pnlInner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="6">
                                <div class="widgettitle">
                                    Basic Employee Data<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                                <asp:Label ID="lblHolder" runat="server" Text="" Visible="false"></asp:Label>
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Employee ID
                            </td>
                            <td>
                                <asp:Label ID="lblEmployeeID" runat="server" CssClass="label"></asp:Label>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Joining Date<span class="RequiredLabel">*</span>
                            </td>
                            <td class="label">
                                <asp:TextBox ID="txtJoiningDate" runat="server" CssClass="InputTxtBox" Width="100px"
                                    TabIndex="1"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtJoiningDate_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtJoiningDate">
                                </cc1:CalendarExtender>
                                &nbsp;(MM/DD/YYYY)
                                <asp:CompareValidator ID="dateValidatorJoining" runat="server" ControlToValidate="txtJoiningDate"
                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date" ValidationGroup="SubmitCanDef">
                                </asp:CompareValidator>
                                <asp:RequiredFieldValidator ID="reqFldJoiningDate" runat="server" ControlToValidate="txtJoiningDate"
                                    ErrorMessage="Joining Date Required" ValidationGroup="SubmitCanDef" Display="None">
                                </asp:RequiredFieldValidator><cc1:ValidatorCalloutExtender ID="reqFldJoiningDate_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldJoiningDate" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Employee Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="InputTxtBox" Width="200px"
                                    TabIndex="2"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldEmployeeName" runat="server" ControlToValidate="txtEmployeeName"
                                    ErrorMessage="Name Required" ValidationGroup="SubmitCanDef" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldEmployeeName_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldEmployeeName" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Confirmation Date
                            </td>
                            <td class="label">
                                <asp:TextBox ID="txtConfirmationDate" runat="server" CssClass="InputTxtBox" Width="100px"
                                    TabIndex="2"></asp:TextBox>
                                &nbsp;(MM/DD/YYYY)
                                <cc1:CalendarExtender ID="txtConfirmationDate_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtConfirmationDate">
                                </cc1:CalendarExtender>
                                <asp:CompareValidator ID="dateValidatorConfirmation" runat="server" ControlToValidate="txtConfirmationDate"
                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date" ValidationGroup="SubmitCanDef">
                                </asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Designation<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlOfficialDesignation" runat="server" CssClass="InputTxtBox"
                                    Width="200px" TabIndex="3" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Date Of Birth As per S.S.C<span class="RequiredLabel">*</span>
                            </td>
                            <td class="label">
                                <asp:TextBox ID="txtDateOfBirthAsPerSSC" runat="server" CssClass="InputTxtBox" Width="100px"
                                    TabIndex="4"></asp:TextBox>
                                &nbsp;(MM/DD/YYYY)<cc1:CalendarExtender ID="txtDateOfBirthAsPerSSC_CalendarExtender"
                                    runat="server" Enabled="True" TargetControlID="txtDateOfBirthAsPerSSC">
                                </cc1:CalendarExtender>
                                <asp:CompareValidator ID="dateValidatorDOB" runat="server" ControlToValidate="txtDateOfBirthAsPerSSC"
                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date" ValidationGroup="SubmitCanDef">
                                </asp:CompareValidator>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldDateOfBirthAsPerSSC" runat="server" ControlToValidate="txtDateOfBirthAsPerSSC"
                                    ErrorMessage="Date of Birth Required" ValidationGroup="SubmitCanDef" Display="None">
                                </asp:RequiredFieldValidator><cc1:ValidatorCalloutExtender ID="reqFldDateOfBirthAsPerSSC_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldDateOfBirthAsPerSSC" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Role
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlFunctionalDesignation" runat="server" CssClass="InputTxtBox"
                                    Width="200px" TabIndex="5">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Actual Birth Date<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="drpActualBirthDay" runat="server" CssClass="InputTxtBox" Width="60px"
                                    TabIndex="6">
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                    <asp:ListItem>6</asp:ListItem>
                                    <asp:ListItem>7</asp:ListItem>
                                    <asp:ListItem>8</asp:ListItem>
                                    <asp:ListItem>9</asp:ListItem>
                                    <asp:ListItem>10</asp:ListItem>
                                    <asp:ListItem>11</asp:ListItem>
                                    <asp:ListItem>12</asp:ListItem>
                                    <asp:ListItem>13</asp:ListItem>
                                    <asp:ListItem>14</asp:ListItem>
                                    <asp:ListItem>15</asp:ListItem>
                                    <asp:ListItem>16</asp:ListItem>
                                    <asp:ListItem>17</asp:ListItem>
                                    <asp:ListItem>18</asp:ListItem>
                                    <asp:ListItem>19</asp:ListItem>
                                    <asp:ListItem>20</asp:ListItem>
                                    <asp:ListItem>21</asp:ListItem>
                                    <asp:ListItem>22</asp:ListItem>
                                    <asp:ListItem>23</asp:ListItem>
                                    <asp:ListItem>24</asp:ListItem>
                                    <asp:ListItem>25</asp:ListItem>
                                    <asp:ListItem>26</asp:ListItem>
                                    <asp:ListItem>27</asp:ListItem>
                                    <asp:ListItem>28</asp:ListItem>
                                    <asp:ListItem>29</asp:ListItem>
                                    <asp:ListItem>30</asp:ListItem>
                                    <asp:ListItem>31</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;&nbsp;<asp:DropDownList ID="drpActualBirthMonth" runat="server" CssClass="InputTxtBox"
                                    TabIndex="7">
                                    <asp:ListItem Value="1">JAN</asp:ListItem>
                                    <asp:ListItem Value="2">FEB</asp:ListItem>
                                    <asp:ListItem Value="3">MAR</asp:ListItem>
                                    <asp:ListItem Value="4">APR</asp:ListItem>
                                    <asp:ListItem Value="5">MAY</asp:ListItem>
                                    <asp:ListItem Value="6">JUN</asp:ListItem>
                                    <asp:ListItem Value="7">JUL</asp:ListItem>
                                    <asp:ListItem Value="8">AUG</asp:ListItem>
                                    <asp:ListItem Value="9">SEP</asp:ListItem>
                                    <asp:ListItem Value="10">OCT</asp:ListItem>
                                    <asp:ListItem Value="11">NOV</asp:ListItem>
                                    <asp:ListItem Value="12">DEC</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Supervisor Name
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlCurrentSupervisor" runat="server" CssClass="InputTxtBox"
                                    Width="200px" TabIndex="7">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Gender<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:RadioButtonList ID="rdbtnGender" runat="server" CssClass="rbdText" RepeatDirection="Horizontal"
                                    TabIndex="9">
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                    <asp:ListItem>Others</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ID="reqFldGender" runat="server" ControlToValidate="rdbtnGender"
                                    Display="None" ErrorMessage="Gender Required" ValidationGroup="SubmitCanDef">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldGender_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldGender" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Nationality<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtNationality" runat="server" CssClass="InputTxtBox" Width="200px"
                                    TabIndex="10"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Blood Group
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlBloodGrp" runat="server" CssClass="InputTxtBox" Width="200px"
                                    TabIndex="11">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                National ID
                            </td>
                            <td>
                                <asp:TextBox ID="txtNationalID" runat="server" CssClass="InputTxtBox" Width="200px"
                                    TabIndex="12"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Religion<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlReligion" runat="server" CssClass="InputTxtBox" Width="200px"
                                    TabIndex="13">
                                    <asp:ListItem>-Select-</asp:ListItem>
                                    <asp:ListItem Value="Islam">Islam</asp:ListItem>
                                    <asp:ListItem Value="Hindu">Hindu</asp:ListItem>
                                    <asp:ListItem Value="Buddhist">Buddhist</asp:ListItem>
                                    <asp:ListItem Value="Christian">Christian</asp:ListItem>
                                    <asp:ListItem Value="Christian">Others</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                E-mail<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="InputTxtBox" Width="200px" TabIndex="12"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldEmail" runat="server" ControlToValidate="txtEmail"
                                    ErrorMessage="E-Mail Required" ValidationGroup="SubmitCanDef" Display="None"></asp:RequiredFieldValidator><cc1:ValidatorCalloutExtender
                                        ID="reqFldEmail_ValidatorCalloutExtender" runat="server" Enabled="True" TargetControlID="reqFldEmail"
                                        CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                    </cc1:ValidatorCalloutExtender>
                                &nbsp;<asp:RegularExpressionValidator ID="regExpEmailAddress" runat="server" ControlToValidate="txtEMail"
                                    ErrorMessage="Input Correct E-mail Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ValidationGroup="SubmitCanDef" Display="None"></asp:RegularExpressionValidator><cc1:ValidatorCalloutExtender
                                        ID="regExpEmailAddress_ValidatorCalloutExtender" runat="server" Enabled="True"
                                        TargetControlID="regExpEmailAddress" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png"
                                        WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                    </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Alternate Email
                            </td>
                            <td>
                                <asp:TextBox ID="txtAlterEmail" runat="server" CssClass="InputTxtBox" Width="200px"
                                    TabIndex="12"></asp:TextBox>
                                &nbsp;<asp:RegularExpressionValidator ID="regExptAlterEmail" runat="server" ControlToValidate="txtAlterEmail"
                                    ErrorMessage="Input Correct E-mail Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                    ValidationGroup="SubmitCanDef" Display="None"></asp:RegularExpressionValidator><cc1:ValidatorCalloutExtender
                                        ID="regExptAlterEmail_ValidatorCalloutExtender" runat="server" Enabled="True"
                                        TargetControlID="regExptAlterEmail" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png"
                                        WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                    </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label" visible="False">
                                &nbsp;
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlHealthPlan" runat="server" CssClass="InputTxtBox" Enabled="false">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Insurance No.
                            </td>
                            <td>
                                <asp:TextBox ID="txtInsuranceNo" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Leave Approver
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlLeaveApprover" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Leave Recommender
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlleaveRecommender" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                TIN No
                            </td>
                            <td>
                                <asp:TextBox ID="txtTINNo" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Passport No
                            </td>
                            <td>
                                <asp:TextBox ID="txtPassportNo" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td class="label">
                                Driving LicenseNo
                            </td>
                            <td>
                                <asp:TextBox ID="txtDrivingLicenseNo" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td class="label">
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
                <asp:Panel ID="pnlEvaluator" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widget-title">
                                    Evaluator Settings</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Primary Evaluator
                            </td>
                            <td>
                                <asp:DropDownList ID="drpPrimaryEvaluator" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Secondary Evaluator
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSecondaryEvaluator" runat="server" Width="200px" CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
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
                <asp:Panel ID="pnlPrimaryBankAccount" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="6">
                                <div class="widgettitle">
                                    Primary Bank Account</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label" style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                        </tr>
                        <tr>
                            <td class="label" style="width: 20px">
                                &nbsp;
                            </td>
                            <td class="label" style="width: 150px">
                                Bank<span class="RequiredLabel">*</span>
                            </td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlBankName" runat="server" CssClass="InputTxtBox" Width="200px"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                                Branch<span class="RequiredLabel">*</span>
                            </td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlBranchName" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Account No<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" CssClass="InputTxtBox" Width="200px" ID="txtAccountNo"
                                    TabIndex="14"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldAccountNo" runat="server" ControlToValidate="txtAccountNo"
                                    ErrorMessage="Account No Required" ValidationGroup="SubmitCanDef" Display="None"></asp:RequiredFieldValidator><cc1:ValidatorCalloutExtender
                                        ID="reqFldAccountNo_ValidatorCalloutExtender" runat="server" Enabled="True" TargetControlID="reqFldAccountNo"
                                        CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                    </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td class="label">
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
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlPrimaryBankAccount0" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="6">
                                <div class="widgettitle">
                                    Secondary Bank Account</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label" style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                        </tr>
                        <tr>
                            <td class="label" style="width: 20px">
                                &nbsp;
                            </td>
                            <td class="label" style="width: 150px">
                                Bank<span class="RequiredLabel">*</span>
                            </td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlSecBankName" runat="server" CssClass="InputTxtBox" Width="200px"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                                Branch<span class="RequiredLabel">*</span>
                            </td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlSecBranchName" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Account No<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" CssClass="InputTxtBox" Width="200px" ID="txtSecAccountNo"
                                    TabIndex="14"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqSecFldAccountNo" runat="server" ControlToValidate="txtSecAccountNo"
                                    ErrorMessage="Account No Required" ValidationGroup="SubmitCanDef" Display="None"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqSecFldAccountNo_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqSecFldAccountNo" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td class="label">
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
                <asp:Panel ID="pnlOtherInfo" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="6">
                                <div class="widgettitle">
                                    Placement</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label" style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                        </tr>
                        <tr>
                            <td class="label" style="width: 20px">
                                &nbsp;
                            </td>
                            <td class="label" style="width: 150px">
                                Department
                            </td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                                Employee Type<span class="RequiredLabel">*</span>
                            </td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlEmpType" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Location
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlULCBranch" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td class="label">
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
                <asp:Panel ID="pnlFamilyInformation" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="6">
                                <div class="widgettitle">
                                    Family Information</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label" style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                        </tr>
                        <tr>
                            <td class="label" style="width: 20px">
                                &nbsp;
                            </td>
                            <td class="label" style="width: 150px">
                                Father&#39;s Name<span class="RequiredLabel">*</span>
                            </td>
                            <td style="width: 200px">
                                <asp:TextBox ID="txtFatherName" runat="server" CssClass="InputTxtBox" TabIndex="14"
                                    Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldFatherName" runat="server" ControlToValidate="txtFatherName"
                                    Display="None" ErrorMessage="Father's Name Required" ValidationGroup="SubmitCanDef"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldFatherName_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldFatherName" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                                Father&#39;s Occupation<span class="RequiredLabel">*</span>
                            </td>
                            <td style="width: 200px">
                                <asp:DropDownList ID="ddlFathersOccupation" runat="server" CssClass="InputTxtBox"
                                    TabIndex="15" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Mother&#39;s Name<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" CssClass="InputTxtBox" Width="200px" ID="txtMotherName"
                                    TabIndex="16"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldMotherName" runat="server" ControlToValidate="txtMotherName"
                                    ErrorMessage="Mother's Name Required" ValidationGroup="SubmitCanDef" Display="None"></asp:RequiredFieldValidator><cc1:ValidatorCalloutExtender
                                        ID="reqFldMotherName_ValidatorCalloutExtender" runat="server" Enabled="True"
                                        TargetControlID="reqFldMotherName" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png"
                                        WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                    </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Mother&#39;s Occupation<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:DropDownList runat="server" CssClass="InputTxtBox" Width="200px" ID="ddlMotherOccupation"
                                    TabIndex="17">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td class="label">
                                Marital Status<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:DropDownList runat="server" AutoPostBack="True" CssClass="InputTxtBox" Width="200px"
                                    ID="ddlRelStatus" TabIndex="18">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td class="label">
                                Spouse&#39;s Name
                            </td>
                            <td>
                                <asp:TextBox runat="server" CssClass="InputTxtBox" Width="200px" ID="txtSpouseName"
                                    TabIndex="19"></asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Spouse&#39;s Occupation
                            </td>
                            <td>
                                <asp:DropDownList runat="server" CssClass="InputTxtBox" Width="200px" ID="ddlSpouseOccupation"
                                    TabIndex="20">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
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
                <asp:Panel ID="pnlContactInformation" runat="server" SkinID="pnlInner">
                    <table style="width: 100%">
                        <tr>
                            <td colspan="6">
                                <div class="widgettitle">
                                    Contact Information</div>
                            </td>
                        </tr>
                        <tr>
                            <td class="label" style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                        </tr>
                        <tr>
                            <td class="label" style="width: 20px">
                                &nbsp;
                            </td>
                            <td class="label" style="width: 150px">
                                Mobile No<span class="RequiredLabel">*</span>
                            </td>
                            <td style="width: 200px">
                                <asp:TextBox runat="server" CssClass="InputTxtBox" Width="200px" ID="txtMobileNo"
                                    TabIndex="21"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldMobileNumber" runat="server" ControlToValidate="txtMobileNo"
                                    ErrorMessage="Mobile Number Reqiured" ValidationGroup="SubmitCanDef" Display="None"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldMobileNumber_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldMobileNumber" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                                Office Phone
                            </td>
                            <td style="width: 200px" class="label">
                                <asp:TextBox ID="txtOfficePhone" runat="server" Width="80px" CssClass="InputTxtBox">+88</asp:TextBox>
                                &nbsp;Ext
                                <asp:TextBox ID="txtOfficeExtension" runat="server" Width="50px" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                Emergency contact person name<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox runat="server" CssClass="InputTxtBox" Width="200px" ID="txtEmrgContactPersonName"
                                    TabIndex="22"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldEmrgContactPersonName" runat="server"
                                    ControlToValidate="txtEmrgContactPersonName" ErrorMessage="Person Name Reqiured"
                                    ValidationGroup="SubmitCanDef" Display="None"></asp:RequiredFieldValidator><cc1:ValidatorCalloutExtender
                                        ID="reqFldEmrgContactPersonName_ValidatorCalloutExtender" runat="server" Enabled="True"
                                        TargetControlID="reqFldEmrgContactPersonName" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png"
                                        WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                    </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Relation with Emergency Contact Person<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtRelWithEmrgContactPerson" runat="server" CssClass="InputTxtBox"
                                    TabIndex="23" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldRelWithEmrgContactPerson" runat="server"
                                    ControlToValidate="txtRelWithEmrgContactPerson" Display="None" ErrorMessage="Relation Reqiured"
                                    ValidationGroup="SubmitCanDef"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldRelWithEmrgContactPerson_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldRelWithEmrgContactPerson" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td class="label">
                                Emg. Contact person &#39;s phone no<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmrgContactPersonPhnNo" runat="server" CssClass="InputTxtBox"
                                    TabIndex="24" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldEmrgContactPersonPhnNo" runat="server"
                                    ControlToValidate="txtEmrgContactPersonPhnNo" Display="None" ErrorMessage="Phone No. Reqiured"
                                    ValidationGroup="SubmitCanDef"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldEmrgContactPersonPhnNo_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldEmrgContactPersonPhnNo" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <%-- <asp:UpdatePanel ID="UpPanel" runat="server">
                            <ContentTemplate>--%>
                        <tr>
                            <td>
                            </td>
                            <td colspan="2">
                                <div class="widgettitle">
                                    Present Addr.</div>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                <asp:CheckBox ID="chkSamePreAdd" runat="server" AutoPostBack="True" ForeColor="Green"
                                    TabIndex="19" Text=" Same As Present" />
                            </td>
                            <td>
                                <div class="widgettitle">
                                    Permanent Addr.</div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td class="label">
                                Address<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPreAdd" runat="server" CssClass="InputTxtBox" Height="45px" TabIndex="25"
                                    TextMode="MultiLine" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="ReqFldPreAdd" runat="server" ControlToValidate="txtPreAdd"
                                    Display="None" ErrorMessage="Present Address Required" ValidationGroup="SubmitCanDef"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="ReqFldPreAdd_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="ReqFldPreAdd" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Address<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPerAddress" runat="server" CssClass="InputTxtBox" Height="45px"
                                    TabIndex="28" TextMode="MultiLine" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="ReqFldPerAddress" runat="server" ControlToValidate="txtPerAddress"
                                    Display="None" ErrorMessage="Permanent Address Required" ValidationGroup="SubmitCanDef"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="ReqFldPerAddress_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="ReqFldPerAddress" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td class="label">
                                District<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlPreDistrict" runat="server" CssClass="InputTxtBox" TabIndex="26"
                                    Width="200px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                District<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlperDistrict" runat="server" CssClass="InputTxtBox" TabIndex="29"
                                    Width="200px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td class="label">
                                Thana/Upazila<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlPreThana" runat="server" CssClass="InputTxtBox" TabIndex="27"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Thana/Upazila<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlPerThana" runat="server" CssClass="InputTxtBox" TabIndex="30"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <%--    </ContentTemplate>
                        </asp:UpdatePanel>--%>
                        <tr>
                            <td colspan="6">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlPermission" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                                <asp:Label ID="lblImg" runat="server" Visible="false"></asp:Label>
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label" colspan="2">
                                Do you want to change your photo or signature ?
                            </td>
                            <td colspan="3">
                                <asp:RadioButtonList ID="rdbtnIsChange" runat="server" RepeatDirection="Horizontal"
                                    AutoPostBack="true" CssClass="rbdText">
                                    <asp:ListItem>YES</asp:ListItem>
                                    <asp:ListItem>NO</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
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
                <asp:Panel ID="pnlImages" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widgettitle">
                                    Profile Image & Signature</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Select Profile Image<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:FileUpload ID="FileUpImage" runat="server" />
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Select Signature
                            </td>
                            <td>
                                <asp:FileUpload ID="FileUpSign" runat="server" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
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
                <asp:Panel ID="pnlButtons" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td id="btnArea" runat="server" align="center">
                                <asp:Button ID="btnUpdateEmployee" runat="server" CssClass="styled-button-1" Text="Update"
                                    ValidationGroup="SubmitCanDef" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
