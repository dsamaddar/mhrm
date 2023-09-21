<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmQueryOnAttendance.aspx.vb" Inherits="Attendance_frmQueryOnAttendance"
    Title=".:m-HRM::Query on Attendance:." %>

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
                                Select Node
                            </td>
                            <td>
                                <asp:DropDownList ID="drpNodeList" runat="server" CssClass="InputTxtBox" Width="200px">
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
                            <td>
                                Date From
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateFrom_CalendarExtender0" runat="server" Enabled="True"
                                    TargetControlID="txtDateFrom">
                                </cc1:CalendarExtender>
                            </td>
                            <td>
                                Date To
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateTo_CalendarExtender0" runat="server" Enabled="True"
                                    TargetControlID="txtDateTo">
                                </cc1:CalendarExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnProcessReport" runat="server" CssClass="styled-button-1" Text="Process Report" />
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
                <asp:Panel ID="pnlAttendanceReport" runat="server" SkinID="pnlInner">
                    <div style="max-height: 200px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdAttReport" runat="server" CssClass="mGrid">
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
