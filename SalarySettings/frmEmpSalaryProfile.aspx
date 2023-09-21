<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmEmpSalaryProfile.aspx.vb" Inherits="SalarySettings_frmEmpSalaryProfile"
    Title=".:m-HRM : Emp. Salary Profile:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlEmployeeSelection" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widget-title">
                                    Employee Selection</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 25%">
                            </td>
                            <td style="width: 25%">
                            </td>
                            <td style="width: 25%">
                            </td>
                            <td style="width: 25%">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Select Emloyee
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSelectEmployee" runat="server" Width="200px" CssClass="InputTxtBox"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
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
                <asp:Panel ID="pnlEmpProfile" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="7">
                                <div class="widget-title">
                                    Salary Profile
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                                <asp:HiddenField ID="hdFldEmpSalaryProfileID" runat="server" />
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Basic Salary
                            </td>
                            <td>
                                <asp:TextBox ID="txtBasicSalary" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldBasicSalary" runat="server" ControlToValidate="txtBasicSalary"
                                    ErrorMessage="Required: Basic Salary" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldBasicSalary_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldBasicSalary" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                House Rent
                            </td>
                            <td>
                                <asp:TextBox ID="txtHouseRent" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldHouseRent" runat="server" ControlToValidate="txtHouseRent"
                                    ErrorMessage="Required: House Rent" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldHouseRent_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldHouseRent" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Entertainment
                            </td>
                            <td>
                                <asp:TextBox ID="txtEntertainment" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldEntertainment" runat="server" ControlToValidate="txtEntertainment"
                                    ErrorMessage="Required: Entertainment" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldEntertainment_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldEntertainment" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                Medical
                            </td>
                            <td>
                                <asp:TextBox ID="txtMedical" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldMedical" runat="server" ControlToValidate="txtMedical"
                                    ErrorMessage="Required: Medical" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldMedical_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldMedical" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Conveyence
                            </td>
                            <td>
                                <asp:TextBox ID="txtConveyance" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldConveyance" runat="server" ControlToValidate="txtConveyance"
                                    ErrorMessage="Required: Conveyence" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldConveyance_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldConveyance" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                House Maintenance
                            </td>
                            <td>
                                <asp:TextBox ID="txtHouseMaintenance" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldHouseMaintenance" runat="server" ControlToValidate="txtHouseMaintenance"
                                    ErrorMessage="Required: House Maintenance" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldHouseMaintenance_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldHouseMaintenance" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Consolidated
                            </td>
                            <td>
                                <asp:TextBox ID="txtConsolidated" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldConsolidated" runat="server" ControlToValidate="txtConsolidated"
                                    ErrorMessage="Required: Consolidated" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldConsolidated_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldConsolidated" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                LFA
                            </td>
                            <td>
                                <asp:TextBox ID="txtLFA" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldLFA" runat="server" ControlToValidate="txtLFA"
                                    ErrorMessage="Required: LFA" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldLFA_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldLFA" CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png"
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Special Allowance
                            </td>
                            <td>
                                <asp:TextBox ID="txtSpecialAllowance" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldSpecialAllowance" runat="server" ControlToValidate="txtSpecialAllowance"
                                    ErrorMessage="Required: Special Allowance" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSpecialAllowance_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldSpecialAllowance" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                Mobile Allowance
                            </td>
                            <td>
                                <asp:TextBox ID="txtMobileAllowance" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldMobileAllowance" runat="server" ControlToValidate="txtMobileAllowance"
                                    ErrorMessage="Required: Mobile Allowance" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldMobileAllowance_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldMobileAllowance" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Professional Allowance
                            </td>
                            <td>
                                <asp:TextBox ID="txtProfessionalAllowance" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldProfessionalAllowance" runat="server" ControlToValidate="txtProfessionalAllowance"
                                    ErrorMessage="Required: Professional Allowance" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldProfessionalAllowance_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldProfessionalAllowance" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                Car Allowance</td>
                            <td>
                                <asp:TextBox ID="txtCarAllowance" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldtxtCarAllowance" runat="server" 
                                    ControlToValidate="txtCarAllowance" Display="None" 
                                    ErrorMessage="Required: Car Allowance" ValidationGroup="Update">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldtxtCarAllowance_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldtxtCarAllowance" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Cash</td>
                            <td>
                                <asp:TextBox ID="txtCash" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                            </td>
                            <td>
                                Arrear
                            </td>
                            <td>
                                <asp:TextBox ID="txtArrear" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldArrear" runat="server" 
                                    ControlToValidate="txtArrear" Display="None" ErrorMessage="Required: Arrear" 
                                    ValidationGroup="Update">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldArrear_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldArrear" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
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
        <tr>
            <td>
                <asp:Panel ID="pnlBonus" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="7">
                                <div class="widget-title">
                                    Bonus Settings
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Festival Bonus</td>
                            <td>
                                <asp:TextBox ID="txtFestivalBonus" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldFestivalBonus" runat="server" ControlToValidate="txtFestivalBonus"
                                    ErrorMessage="Required: Festival Bonus" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldFestivalBonus_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldFestivalBonus" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                Performance Bonus
                            </td>
                            <td>
                                <asp:TextBox ID="txtPerformanceBonus" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldPerformanceBonus" runat="server" ControlToValidate="txtPerformanceBonus"
                                    ErrorMessage="Required: Performance Bonus" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldPerformanceBonus_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldPerformanceBonus" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Baishakhi Bonus</td>
                            <td>
                                <asp:TextBox ID="txtBaishakhiBonus" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldBaishakhiBonus" runat="server" ControlToValidate="txtBaishakhiBonus"
                                    ErrorMessage="Required: Baishakhi Allowance" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldBaishakhiBonus_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldBaishakhiBonus" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td>
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
                <asp:Panel ID="pnlDeduction" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="7">
                                <div class="widget-title">
                                    Deduction
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                            <td style="width: 14.285%">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                PF Deduction
                            </td>
                            <td>
                                <asp:TextBox ID="txtPFDeduction" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldPFDeduction" runat="server" ControlToValidate="txtPFDeduction"
                                    ErrorMessage="Required: PF Deduction" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldPFDeduction_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldPFDeduction" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                Accounts Recoverable
                            </td>
                            <td>
                                <asp:TextBox ID="txtAccountsRecoverable" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldAccountsRecoverable" runat="server" ControlToValidate="txtAccountsRecoverable"
                                    ErrorMessage="Required: Accounts Recoverable" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldAccountsRecoverable_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldAccountsRecoverable" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Tax Deduction
                            </td>
                            <td>
                                <asp:TextBox ID="txtTaxDeduction" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldTaxDeduction" runat="server" ControlToValidate="txtTaxDeduction"
                                    ErrorMessage="Required: Tax Deduction" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldTaxDeduction_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldTaxDeduction" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                PB Tax Deduction
                            </td>
                            <td>
                                <asp:TextBox ID="txtPBTaxDeduction" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldPBTaxDeduction" runat="server" ControlToValidate="txtPBTaxDeduction"
                                    ErrorMessage="Required: PB Tax Deduction" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldPBTaxDeduction_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldPBTaxDeduction" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Conveyence Deduction</td>
                            <td>
                                <asp:TextBox ID="txtConveyenceDeduction" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldConveyenceDeductionPer" runat="server" ControlToValidate="txtConveyenceDeduction"
                                    ErrorMessage="Required: Conveyence Deduction" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldConveyenceDeductionPer_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldConveyenceDeductionPer"
                                    CssClass="customCalloutStyle" CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                Loan Deduction
                            </td>
                            <td>
                                <asp:TextBox ID="txtLoanDeduction" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldLoanDeduction" runat="server" ControlToValidate="txtLoanDeduction"
                                    ErrorMessage="Required: Loan Deduction" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldLoanDeduction_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldLoanDeduction" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Donation Deduction
                            </td>
                            <td>
                                <asp:TextBox ID="txtDonationDeduction" runat="server">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldDonationDeduction" runat="server" ControlToValidate="txtDonationDeduction"
                                    ErrorMessage="Required: Donation Deduction" ValidationGroup="Update" Display="None">
                                </asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDonationDeduction_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldDonationDeduction" CssClass="customCalloutStyle"
                                    CloseImageUrl="~/Sources/images/valClose.png" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td>
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
                <asp:Panel ID="pnlSubmission" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td style="width: 33.33%">
                            </td>
                            <td style="width: 33.33%">
                            </td>
                            <td style="width: 33.33%">
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" ValidationGroup="Update" />
                                &nbsp;<asp:Button ID="btnRefresh" runat="server" Text="Refresh" ValidationGroup="Update" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
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
    </table>
</asp:Content>
