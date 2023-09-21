<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmEmployeeSettings.aspx.vb" Inherits="frmEmployeeSettings" Title=".:m-HRM::Employee Settings:."
    Theme="CommonSkin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Sources/css/UltraCssClass.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        window.onload = function() {
            var strCook = document.cookie;
            if (strCook.indexOf("!~") != 0) {
                var intS = strCook.indexOf("!~");
                var intE = strCook.indexOf("~!");
                var strPos = strCook.substring(intS + 2, intE);
                document.getElementById("divgrd").scrollTop = strPos;
            }
        }
        function SetDivPosition() {
            var intY = document.getElementById("divgrd").scrollTop;
            document.title = intY;
            document.cookie = "yPos=!~" + intY + "~!";
        }

        window.scrollBy(100, 100); 
    </script>

    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlDesignationSettings" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td align="left" class="label" style="height: 20px" colspan="6">
                                <div class="widgettitle">
                                    Designation Settings<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldDesignationName" runat="server" ControlToValidate="txtDesignationName"
                                    Display="None" ErrorMessage="Required" ValidationGroup="InputDesignation"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDesignationName_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldDesignationName" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldNoticePeriod" runat="server" ControlToValidate="txtNoticePeriod"
                                    Display="None" ErrorMessage="Required: Notice Period" ValidationGroup="InputDesignation"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldNoticePeriod_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldNoticePeriod" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td align="left" class="label" style="width: 20px">
                            </td>
                            <td align="left" class="label">
                                Designation
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDesignationName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;
                            </td>
                            <td align="left">
                            </td>
                            <td class="label">
                                Fuel
                            </td>
                            <td>
                                <asp:TextBox ID="txtFuel" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label">
                            </td>
                            <td class="label">
                                Designation Label
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlDesigLabel" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem Value="0" Selected="True">-Select-</asp:ListItem>
                                    <asp:ListItem Value="Management">Management</asp:ListItem>
                                    <asp:ListItem Value="Non-Management">Non-Management</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                            </td>
                            <td class="label">
                                Driver Allowance
                            </td>
                            <td>
                                <asp:TextBox ID="txtDriverAllowance" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label">
                            </td>
                            <td class="label">
                                Designation Type
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="rdoDesignationType" runat="server" CssClass="rbdText" RepeatDirection="Horizontal"
                                    AutoPostBack="True">
                                    <asp:ListItem Enabled="true">Official</asp:ListItem>
                                    <asp:ListItem>Functional</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td align="left">
                            </td>
                            <td class="label">
                                Vehicle Maintenance
                            </td>
                            <td>
                                <asp:TextBox ID="txtVehicleMaintenance" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td align="left" class="label">
                            </td>
                            <td align="left" class="label">
                                Health Plan
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlHealthPlan" runat="server" CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                            </td>
                            <td class="label">
                                Car Subsidy
                            </td>
                            <td>
                                <asp:TextBox ID="txtCarSubsidy" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td align="left" class="label">
                            </td>
                            <td align="left" class="label">
                                <b>Order</b>
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="txtOrder" Width="50px" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                            <td align="left">
                            </td>
                            <td class="label">
                                Notice Period
                            </td>
                            <td>
                                <asp:TextBox ID="txtNoticePeriod" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td align="left" class="label">
                            </td>
                            <td align="left" class="label">
                                Evaluation Group
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpEvaluationGroup" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                            </td>
                            <td class="label">
                                Mobile Allowance
                            </td>
                            <td>
                                <asp:TextBox ID="txtMobileAllowance" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td align="left" class="label">
                            </td>
                            <td align="left" class="label">
                                Is Active
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="chkIsDesigActive" runat="server" CssClass="chkText" Text="         Is Active  " />
                            </td>
                            <td align="left">
                            </td>
                            <td class="label">
                                Transport Allowance
                            </td>
                            <td>
                                <asp:TextBox ID="txtTransportAllowance" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td align="left">
                                <asp:Button ID="btnInsertDesignation" runat="server" CssClass="styled-button-1" Text="Insert"
                                    ValidationGroup="InputDesignation" />
                                &nbsp;<asp:Button ID="btnUpdateDesignation" runat="server" CssClass="styled-button-1"
                                    Text="Update" ValidationGroup="InputDesignation" />
                                &nbsp;<asp:Button ID="btnCancelSelection" runat="server" CssClass="styled-button-1"
                                    Text="Cancel" />
                            </td>
                            <td align="left">
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldFuel" runat="server" ControlToValidate="txtFuel"
                                    Display="None" ErrorMessage="Required: Fuel" ValidationGroup="InputDesignation"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldFuel_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldFuel" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldDriverAllowance" runat="server" ControlToValidate="txtDriverAllowance"
                                    Display="None" ErrorMessage="Required: Driver Allowance" ValidationGroup="InputDesignation"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDriverAllowance_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldDriverAllowance" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td align="left">
                            </td>
                            <td align="left">
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldVehicleMaintenance" runat="server" ControlToValidate="txtVehicleMaintenance"
                                    Display="None" ErrorMessage="Required: Vehicle Maintenance" ValidationGroup="InputDesignation"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldVehicleMaintenance_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldVehicleMaintenance" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldCarSubsidty" runat="server" ControlToValidate="txtCarSubsidy"
                                    Display="None" ErrorMessage="Required: Car Subsidy" ValidationGroup="InputDesignation"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldCarSubsidty_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldCarSubsidty" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td align="left" class="label">
                            </td>
                            <td align="left" class="label">
                                Available Designation
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpAvailableDesignation" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldMobileAllowance" runat="server" ControlToValidate="txtMobileAllowance"
                                    Display="None" ErrorMessage="Required: Mobile Allowance" ValidationGroup="InputDesignation"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldMobileAllowance_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldMobileAllowance" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldTransportAllowance" runat="server" ControlToValidate="txtTransportAllowance"
                                    Display="None" ErrorMessage="Required: Transport Allowance" ValidationGroup="InputDesignation"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldTransportAllowance_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldTransportAllowance" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
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
                                &nbsp;
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlAvailableLeaveType" runat="server" SkinID="pnlInner" Width="100%">
                    <div style="max-height: 200px; max-width: 100%; overflow: auto" id="divgrd" onscroll="SetDivPosition()">
                        <asp:GridView ID="grdDesignation" runat="server" SkinID="grdNoFooter" AutoGenerateColumns="False"
                            CssClass="mGrid">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" CssClass="linkbtn" runat="server" CausesValidation="False"
                                            CommandName="Select" Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DesignationID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDesignationID" runat="server" Text='<%# Bind("DesignationID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Designation">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDesignationName" runat="server" Text='<%# Bind("DesignationName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Designation Label">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDesignationLabel" runat="server" Text='<%# Bind("DesignationLabel") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Designation Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDesignationType" runat="server" Text='<%# Bind("DesignationType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="HealthPlanID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblHealthPlanID" runat="server" Text='<%# Bind("HealthPlanID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Health Plan">
                                    <ItemTemplate>
                                        <asp:Label ID="lblHealthPlanName" runat="server" Text='<%# Bind("HealthPlanName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Order">
                                    <ItemTemplate>
                                        <asp:Label ID="lblintOrder" runat="server" Text='<%# Bind("intOrder") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Fuel">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFuel" runat="server" Text='<%# Bind("Fuel") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Driver's Allowance">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDriverAllowance" runat="server" Text='<%# Bind("DriverAllowance","{0:N2}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vehicle-Maintenance">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVehicleMaintenance" runat="server" Text='<%# Bind("VehicleMaintenance","{0:N2}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Car-Subsidy">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCarSubsidy" runat="server" Text='<%# Bind("CarSubsidy","{0:N2}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Notice Period">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNoticePeriod" runat="server" Text='<%# Bind("NoticePeriod") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="MA">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMobileAllowance" runat="server" Text='<%# Bind("MobileAllowance") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TA">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransportAllowance" runat="server" Text='<%# Bind("TransportAllowance") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EvaluationGroupID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEvaluationGroupID" runat="server" Text='<%# Bind("EvaluationGroupID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EvaluationGroup">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("EvaluationGroup") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblisActive" runat="server" Text='<%# Bind("isActive") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                &nbsp;
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlLateAttendanceCause" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widgettitle">
                                    Late Attendance Cause</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
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
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td class="label">
                                &nbsp;</td>
                            <td>
                                <asp:DropDownList ID="drpAvailableCause" runat="server" CssClass="InputTxtBox" 
                                    Width="200px" Visible="False">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td style="width: 150px" class="label">
                                New Cause
                            </td>
                            <td>
                                <asp:TextBox ID="txtLateAttendanceCause" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldLateAttendanceCauseType" runat="server"
                                    ControlToValidate="txtLateAttendanceCause" ErrorMessage="*" ValidationGroup="LateAttCause"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:HiddenField ID="hdFldLateAttCauseID" runat="server" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td style="width: 150px" class="label">
                                Remarks
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsDetailsMandatory" runat="server" CssClass="chkText" 
                                    Text=" Is Mandatory" />
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td style="width: 150px" class="label">
                                Reportable
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsReportable" runat="server" CssClass="chkText"
                                    Text=" Is Reportable" />
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label" style="width: 150px">
                                Is Active
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsLateAttCauseActive" runat="server" CssClass="chkText" Text="(Check If YES)" />
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
                                <asp:Button ID="btnInsertLateAttendanceCause" runat="server" CssClass="styled-button-1"
                                    Text="Insert" ValidationGroup="LateAttCause" />
                                &nbsp;<asp:Button ID="btnUpdateLateAttCause" runat="server" CssClass="styled-button-1"
                                    Text="Update" />
                                &nbsp;<asp:Button ID="btnCancelLateAttSelection" runat="server" CssClass="styled-button-1"
                                    Text="Cancel" />
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
        <tr align="center">
            <td>
                <asp:Panel ID="pnlLateAttendanceCauseList" runat="server" SkinID="pnlInner" Width="100%">
                    <div style="max-height: 200px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdLateAttendanceCause" runat="server" AutoGenerateColumns="False"
                            CssClass="mGrid">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="LateAttCauseID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLateAttCauseID" runat="server" Text='<%# Bind("LateAttCauseID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Cause">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCause" runat="server" Text='<%# Bind("Cause") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsDetailsMandatory">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsDetailsMandatory" runat="server" Text='<%# Bind("IsDetailsMandatory") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsReportable">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsReportable" runat="server" Text='<%# Bind("IsReportable") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ReportableToDept">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReportableToDept" runat="server" Text='<%# Bind("ReportableToDept") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsActive">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryBy">
                                    <ItemTemplate>
                                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryDate">
                                    <ItemTemplate>
                                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlDocumentType" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td class="label" align="left" colspan="5">
                                <div class="widgettitle">
                                    Document Type Settings</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 250px">
                            </td>
                            <td style="width: 250px">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label" align="left" style="width: 20px">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Document Type :
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtNewDocumentType" runat="server" CssClass="InputTxtBox" ValidationGroup="DocType"
                                    Width="180px"></asp:TextBox>
                            </td>
                            <td class="label">
                                Document Category
                            </td>
                            <td>
                                <asp:DropDownList ID="drpDocumentCategory" runat="server" CssClass="InputTxtBox"
                                    Width="120px">
                                    <asp:ListItem>Document</asp:ListItem>
                                    <asp:ListItem>Evaluation</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label" align="left">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Document For :
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlDocumentFor" runat="server" CssClass="InputTxtBox" Width="180px">
                                    <asp:ListItem>-Select-</asp:ListItem>
                                    <asp:ListItem>Candidate</asp:ListItem>
                                    <asp:ListItem>Employee</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                Is Performance Factor
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsPerformanceFactor" runat="server" CssClass="chkText" Text="Is Active" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label" align="left">
                            </td>
                            <td align="left" class="label">
                                Is Mandatory :
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="chkDocumentTypeIsMandatory" runat="server" Text="Is Mandatory"
                                    CssClass="chkText" />
                            </td>
                            <td class="label">
                                Performance Criteria
                            </td>
                            <td>
                                <asp:CheckBox ID="chkPerfPositive" CssClass="chkText" Text="Positive" runat="server" />
                                <asp:CheckBox ID="chkPerfNegative" CssClass="chkText" Text="Negative" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Is Active :
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="chkText" Text="Is Active" />
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td align="left">
                                <asp:Button ID="btnInsertDocument" runat="server" CssClass="styled-button-1" Text="Insert"
                                    ValidationGroup="DocUpload" />
                                &nbsp;
                                <asp:Button ID="btnUpdateDocument" runat="server" CssClass="styled-button-1" Text="Update"
                                    ValidationGroup="DocUpload" />
                                &nbsp;
                                <asp:Button ID="btnUploadDocumentCancel" runat="server" CssClass="styled-button-1"
                                    Text="Cancel" />
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td align="left">
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
        <tr align="center">
            <td>
                <asp:Panel ID="pnlDocumentTypeList" runat="server" SkinID="pnlInner" Width="100%">
                    <div style="max-height: 200px; max-width: 100%; overflow: auto" id="divDocument"
                        onscroll="SetDivPosition()">
                        <asp:GridView ID="grdDocument" runat="server" SkinID="grdNoFooter" AutoGenerateColumns="False"
                            CssClass="mGrid">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" CssClass="linkbtn" runat="server" CausesValidation="False"
                                            CommandName="Select" Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DocTypeID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDocTypeID" runat="server" Text='<%# Bind("DocTypeID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Document Type">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDocumentType" runat="server" Text='<%# Bind("DocumentType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Document For">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDocumentFor" runat="server" Text='<%# Bind("DocumentFor") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Category">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("DocumentCategory") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mandatory">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsMandatory" runat="server" Text='<%# Bind("IsMandatory") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Perf. Criteria">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPerformanceCriteria" runat="server" Text='<%# Bind("PerformanceCriteria") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Active">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsPerformanceFactor" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsPerformanceFactor" runat="server" Text='<%# Bind("IsPerformanceFactor") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
