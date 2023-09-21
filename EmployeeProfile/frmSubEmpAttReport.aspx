<%@ Page Language="VB" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    Theme="CommonSkin" AutoEventWireup="false" CodeFile="frmSubEmpAttReport.aspx.vb"
    Inherits="EmployeeProfile_frmSubEmpAttReport" Title=".:MHRM:Team/Branch Report:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlEmpAttendanceStatus" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Team/Branch Attendance Report<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 250px">
                                <asp:RequiredFieldValidator ID="reqFldDateFrom" runat="server" ControlToValidate="txtDateFrom"
                                    Display="None" ErrorMessage="" ValidationGroup="ProcessReport"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDateFrom_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldDateFrom" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                                &nbsp;<asp:CompareValidator ID="dateValidatorJoining" runat="server" ControlToValidate="txtDateFrom"
                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date" ValidationGroup="ProcessReport"></asp:CompareValidator>
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="">
                                <asp:RequiredFieldValidator ID="reqFldDateTo" runat="server" ControlToValidate="txtDateTo"
                                    Display="None" ErrorMessage="" ValidationGroup="ProcessReport"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldDateTo" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                                &nbsp;<asp:CompareValidator ID="compvalDateTo" runat="server" ControlToValidate="txtDateTo"
                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date" ValidationGroup="ProcessReport">
                                </asp:CompareValidator>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Team Members</td>
                            <td class="label">
                                <asp:DropDownList ID="drpEmployeeList" runat="server" CssClass="InputTxtBox" 
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                &nbsp;</td>
                            <td class="label">
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Date From</td>
                            <td class="label">
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="InputTxtBox" 
                                    Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateFrom_CalendarExtender" runat="server" 
                                    Enabled="True" TargetControlID="txtDateFrom">
                                </cc1:CalendarExtender>
                                &nbsp;(MM/DD/YYYY)
                            </td>
                            <td class="label">
                                Date To</td>
                            <td class="label">
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="calExtDateTo" runat="server" Enabled="True" 
                                    TargetControlID="txtDateTo">
                                </cc1:CalendarExtender>
                                &nbsp;(MM/DD/YYYY)&nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Attendance Status</td>
                            <td class="label">
                                <asp:DropDownList ID="drpAttStatus" runat="server" CssClass="InputTxtBox" 
                                    Width="120px">
                                    <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                                    <asp:ListItem Text="Early" Value="Early"></asp:ListItem>
                                    <asp:ListItem Text="Late" Value="Late"></asp:ListItem>
                                    <asp:ListItem Text="Absent" Value="Absent"></asp:ListItem>
                                    <asp:ListItem Text="Regular" Value="Regular"></asp:ListItem>
                                    <asp:ListItem Text="Late,Early" Value="Late,Early"></asp:ListItem>
                                    <asp:ListItem Text="on Leave" Value="on Leave"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                Export Format</td>
                            <td class="label">
                                <asp:DropDownList ID="drpExportFormat" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem Text="PDF" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Rich Text" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Word for Windows" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Excel" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Excel Record" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="HTML 3.2" Value="6"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnProcessReport" runat="server" CssClass="styled-button-1" 
                                    Text="Process Team Report" ValidationGroup="ProcessReport" />
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
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
