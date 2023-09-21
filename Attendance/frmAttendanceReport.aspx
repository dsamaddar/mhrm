<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmAttendanceReport.aspx.vb" Inherits="Attendance_frmAttendanceReport"
    Title="m-HRM::Attendance Report:.." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlParameters" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Set Attendance Report Parameter</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
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
                                &nbsp;
                            </td>
                            <td>
                                Report Year
                            </td>
                            <td>
                                <asp:DropDownList ID="drpReportYear" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem Text="2025" Value="2025"></asp:ListItem>
                                    <asp:ListItem Text="2024" Value="2024"></asp:ListItem>
                                    <asp:ListItem Text="2023" Value="2023"></asp:ListItem>
                                    <asp:ListItem Text="2022" Value="2022"></asp:ListItem>
                                    <asp:ListItem Text="2021" Value="2021"></asp:ListItem>
                                    <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                                    <asp:ListItem Text="2019" Value="2019"></asp:ListItem>
                                    <asp:ListItem Text="2018" Value="2018"></asp:ListItem>
                                    <asp:ListItem Text="2017" Value="2017"></asp:ListItem>
                                    <asp:ListItem Text="2016" Value="2016"></asp:ListItem>
                                    <asp:ListItem Text="2015" Value="2015"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                Report Month
                            </td>
                            <td>
                                <asp:DropDownList ID="drpReportMonth" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem Value="0" Text="ALL"></asp:ListItem>
                                    <asp:ListItem Value="1" Text="January"></asp:ListItem>
                                    <asp:ListItem Value="2" Text="February"></asp:ListItem>
                                    <asp:ListItem Value="3" Text="March"></asp:ListItem>
                                    <asp:ListItem Value="4" Text="April"></asp:ListItem>
                                    <asp:ListItem Value="5" Text="May"></asp:ListItem>
                                    <asp:ListItem Value="6" Text="June"></asp:ListItem>
                                    <asp:ListItem Value="7" Text="July"></asp:ListItem>
                                    <asp:ListItem Value="8" Text="August"></asp:ListItem>
                                    <asp:ListItem Value="9" Text="September"></asp:ListItem>
                                    <asp:ListItem Value="10" Text="October"></asp:ListItem>
                                    <asp:ListItem Value="11" Text="November"></asp:ListItem>
                                    <asp:ListItem Value="12" Text="December"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Select Employee
                            </td>
                            <td>
                                <asp:DropDownList ID="drpEmployeeList" runat="server" Width="200px" CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                            <td>
                                Select Department
                            </td>
                            <td>
                                <asp:DropDownList ID="drpDepartments" runat="server" Width="200px" CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Select Branch
                            </td>
                            <td>
                                <asp:DropDownList ID="drpBranchList" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                Select Designation
                            </td>
                            <td>
                                <asp:DropDownList ID="drpDesignation" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Date From
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateFrom_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateFrom">
                                </cc1:CalendarExtender>
                            </td>
                            <td>
                                Date To
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateTo_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateTo">
                                </cc1:CalendarExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Attendance Status
                            </td>
                            <td>
                                <asp:DropDownList ID="drpAttStatus" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                                    <asp:ListItem Text="Early" Value="Early"></asp:ListItem>
                                    <asp:ListItem Text="Late" Value="Late"></asp:ListItem>
                                    <asp:ListItem Text="Absent" Value="Absent"></asp:ListItem>
                                    <asp:ListItem Text="Regular" Value="Regular"></asp:ListItem>
                                    <asp:ListItem Text="Late,Early" Value="Late,Early"></asp:ListItem>
                                    <asp:ListItem Text="on Leave" Value="on Leave"></asp:ListItem>
                                    <asp:ListItem Text="Absent,Pending" Value="Absent,Pending"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                Employment Type
                            </td>
                            <td>
                                <asp:DropDownList ID="drpEmploymentType" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Export Format
                            </td>
                            <td>
                                <asp:DropDownList ID="drpExportFormat" runat="server">
                                    <asp:ListItem Text="PDF" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Rich Text" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Word for Windows" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Excel" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Excel Record" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="HTML 3.2" Value="6"></asp:ListItem>
                                </asp:DropDownList>
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
                <asp:Panel ID="pnlGenerateReport" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 33.33%">
                            </td>
                            <td style="width: 33.33%">
                                <asp:Button ID="btnDailyReport" runat="server" Text="Process Daily Report" CssClass="styled-button-1" />
                                &nbsp;<asp:Button ID="btnMonthlySummary" runat="server" Text="Process Monthly Summary"
                                    CssClass="styled-button-1" />
                            </td>
                            <td style="width: 33.33%">
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
