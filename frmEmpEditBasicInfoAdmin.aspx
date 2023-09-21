<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmEmpEditBasicInfoAdmin.aspx.vb" Inherits="Administration_frmEmpEditBasicInfoAdmin"
    Title=".:HRM:Edit Basic Information:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        window.onload = function() {
            var strCook = document.cookie;
            if (strCook.indexOf("!~") != 0) {
                var intS = strCook.indexOf("!~");
                var intE = strCook.indexOf("~!");
                var strPos = strCook.substring(intS + 2, intE);
                document.getElementById("divEmpList").scrollTop = strPos;
                }
        }
        function SetDivPosition() {
            var intY = document.getElementById("divEmpList").scrollTop;
            document.title = intY;
            document.cookie = "yPos=!~" + intY + "~!";
        }
    </script>

    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlAssignExam" runat="server" SkinID="pnlInner" Width="100%">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="6" align="left">
                                <div class="widgettitle">
                                    Search Employee<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Name/Code
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmpIDOrName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label" style="width: 20px">
                            </td>
                            <td class="label">
                                Select Department
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSelectDepartment" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Select Designation
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSelectDesignation" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label" style="width: 20px">
                            </td>
                            <td class="label">
                                District
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlPerDistrict" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Select Branch
                            </td>
                            <td>
                                <asp:DropDownList ID="drpULCBranch" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td tyle="width:20px">
                            </td>
                            <td class="label">
                                Gender
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="rdbtnGender" runat="server" class="label" CssClass="rbdText"
                                    RepeatDirection="Horizontal" TabIndex="9">
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                    <asp:ListItem>Others</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Blood Group
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlBloodGrp" runat="server" CssClass="InputTxtBox" TabIndex="11"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td tyle="width:20px">
                                &nbsp;
                            </td>
                            <td class="label">
                                Emplyee Type
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpEmployeeType" runat="server" CssClass="InputTxtBox" Width="200px">
                                    <asp:ListItem Value="N\A">N\A</asp:ListItem>
                                    <asp:ListItem Value="EMP">Regular Employee</asp:ListItem>
                                    <asp:ListItem Value="DA"></asp:ListItem>
                                    <asp:ListItem Value="OA">Office Assistant</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                <b>Employee Status</b>&nbsp;
                            </td>
                            <td>
                                <asp:DropDownList ID="drpEmployeeStatus" runat="server" CssClass="InputTxtBox" Width="80px">
                                    <asp:ListItem Value="1">Active</asp:ListItem>
                                    <asp:ListItem Value="0">In-Active</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td tyle="width:20px">
                                &nbsp;
                            </td>
                            <td class="label">
                                &nbsp;
                            </td>
                            <td align="left">
                                <asp:Button ID="btnSearch" runat="server" CssClass="styled-button-1" Text="Search" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
                            </td>
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label" style="width: 20px">
                            </td>
                            <td class="label">
                            </td>
                            <td align="left">
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
        <tr align="center">
            <td>
                <asp:Panel ID="pnlFoundEmpList" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%">
                        <tr align="left">
                            <td>
                                <div class="widget-title">
                                    Employee List</div>
                            </td>
                            <td>
                                <div class="widget-title">
                                    Edit Basic Info</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 30%" valign="top">
                                <div id="divEmpList" onscroll="SetDivPosition()" style="max-height: 200px; max-width: 100%;
                                    overflow: auto">
                                    <asp:GridView ID="grdEmployeeList" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                        Text="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="EmployeeID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmployeeID" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Employee">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </td>
                            <td valign="top" align="left">
                                <asp:Panel ID="pnlEmpBasicInfo" runat="server" SkinID="pnlInner">
                                    <table style="width: 100%;">
                                        <tr>
                                            <td class="label" style="width: 150px">
                                                Employee Code
                                            </td>
                                            <td style="width: 180px">
                                                <asp:TextBox ID="txtEmpCode" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                                &nbsp;<asp:RequiredFieldValidator ID="reqFldEmpCode" runat="server" ControlToValidate="txtEmpCode"
                                                    Display="None" ErrorMessage="Required: Employee Code" ValidationGroup="UpdateEmp"></asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="reqFldEmpCode_ValidatorCalloutExtender" runat="server"
                                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                                    TargetControlID="reqFldEmpCode" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                                </cc1:ValidatorCalloutExtender>
                                            </td>
                                            <td class="label">
                                                Emp. Status
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpEmpStatus" runat="server" CssClass="InputTxtBox" Width="80px">
                                                    <asp:ListItem Value="1">Active</asp:ListItem>
                                                    <asp:ListItem Value="0">In-Active</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">
                                                User Type
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpUserType" runat="server" CssClass="InputTxtBox" 
                                                    Width="120px">
                                                    <asp:ListItem>User</asp:ListItem>
                                                    <asp:ListItem>Admin</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td class="label">
                                                Permitted To Edit Own Info
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpPermittedOnEdtOwn" runat="server" CssClass="InputTxtBox"
                                                    Width="80px">
                                                    <asp:ListItem Value="1">YES</asp:ListItem>
                                                    <asp:ListItem Value="0">NO</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">
                                                User ID
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtUserID" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                            </td>
                                            <td class="label">
                                                Permitted To Edit Othres
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="drpPermittedToEditOthers" runat="server" CssClass="InputTxtBox"
                                                    Width="80px">
                                                    <asp:ListItem Value="1">YES</asp:ListItem>
                                                    <asp:ListItem Value="0">NO</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">
                                                Password</td>
                                            <td>
                                                <asp:TextBox ID="txtUserPassword" runat="server" CssClass="InputTxtBox" 
                                                    TextMode="Password" Width="120px"></asp:TextBox>
                                            </td>
                                            <td class="label">
                                                Attendance ID
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAttendanceID" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                                &nbsp;<asp:RequiredFieldValidator ID="reqFldAttendanceID" runat="server" ControlToValidate="txtAttendanceID"
                                                    Display="None" ErrorMessage="Required : Attendance ID" ValidationGroup="UpdateEmp"></asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="reqFldAttendanceID_ValidatorCalloutExtender" runat="server"
                                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                                    TargetControlID="reqFldAttendanceID" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                                </cc1:ValidatorCalloutExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">
                                                Adv. Tax Deduction</td>
                                            <td>
                                                <asp:CheckBox ID="chkAutoAdvTaxDeduction" runat="server" CssClass="label" 
                                                    Text="(Check If YES)" />
                                            </td>
                                            <td class="label">
                                                Probation Start Date
                                            </td>
                                            <td class="label">
                                                <asp:TextBox ID="txtProbationEffectiveDate" runat="server" CssClass="InputTxtBox"
                                                    Width="120px"></asp:TextBox>
                                                <cc1:CalendarExtender ID="txtProbationEffectiveDate_CalendarExtender" runat="server"
                                                    Enabled="True" TargetControlID="txtProbationEffectiveDate">
                                                </cc1:CalendarExtender>
                                                &nbsp;(MM/DD/YYYY)
                                                <asp:CompareValidator ID="dateValidatorProbationDate" runat="server" ControlToValidate="txtProbationEffectiveDate"
                                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date" ValidationGroup="UpdateEmp">
                                                </asp:CompareValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">
                                                Included In Payroll</td>
                                            <td>
                                                <asp:CheckBox ID="chkIncludedInPayroll" runat="server" CssClass="label" 
                                                    Text="(Check If YES)" />
                                            </td>
                                            <td class="label">
                                                Probation Period
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtProbationPeriod" runat="server" CssClass="InputTxtBox" Width="80px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">
                                                &nbsp;</td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="reqFldEmpUserID" runat="server" 
                                                    ControlToValidate="txtUserID" Display="None" ErrorMessage="Required : User ID" 
                                                    ValidationGroup="UpdateEmp"></asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="reqFldEmpUserID_ValidatorCalloutExtender" 
                                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldEmpUserID" 
                                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                                </cc1:ValidatorCalloutExtender>
                                            </td>
                                            <td class="label">
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="reqFldProbationEffectiveDate" runat="server" 
                                                    ControlToValidate="txtProbationEffectiveDate" Display="None" 
                                                    ErrorMessage="Probation Effective Date" ValidationGroup="UpdateEmp">
                                                </asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="reqFldProbationEffectiveDate_ValidatorCalloutExtender" 
                                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                                    CssClass="customCalloutStyle" Enabled="True" 
                                                    TargetControlID="reqFldProbationEffectiveDate" 
                                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                                </cc1:ValidatorCalloutExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                            <td>
                                                <asp:Button ID="btnUpdate" runat="server" CssClass="styled-button-1" 
                                                    Text="Update" ValidationGroup="UpdateEmp" />
                                                &nbsp;<asp:Button ID="btnCancelSelection" runat="server" CssClass="styled-button-1" 
                                                    Text="Cancel" />
                                            </td>
                                            <td>
                                                <asp:HiddenField ID="hdFldEmployeeID" runat="server" />
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="reqFldEmpPassword" runat="server" 
                                                    ControlToValidate="txtUserPassword" Display="None" 
                                                    ErrorMessage="Required : Password" ValidationGroup="UpdateEmp"></asp:RequiredFieldValidator>
                                                <cc1:ValidatorCalloutExtender ID="reqFldEmpPassword_ValidatorCalloutExtender" 
                                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                                    CssClass="customCalloutStyle" Enabled="True" 
                                                    TargetControlID="reqFldEmpPassword" 
                                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                                </cc1:ValidatorCalloutExtender>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
