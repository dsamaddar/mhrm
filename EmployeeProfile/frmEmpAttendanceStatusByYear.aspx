<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmEmpAttendanceStatusByYear.aspx.vb" Inherits="EmployeeProfile_frmEmpAttendanceStatusByYear"
    Title=".:HRM:Attendance Status Report:." %>

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
                                    Attendance Status ny Year<asp:ScriptManager ID="ScriptManager1" runat="server">
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
                                &nbsp;</td>
                            <td style="width: 150px">
                            </td>
                            <td style="">
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Select Report Year</td>
                            <td class="label">
                                <asp:DropDownList ID="drpReportYear" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem Text="2030" Value="2030"></asp:ListItem>
                                    <asp:ListItem Text="2029" Value="2029"></asp:ListItem>
                                    <asp:ListItem Text="2028" Value="2028"></asp:ListItem>
                                    <asp:ListItem Text="2027" Value="2027"></asp:ListItem>
                                    <asp:ListItem Text="2026" Value="2026"></asp:ListItem>
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
                            <td class="label">
                                Attendance Status</td>
                            <td class="label">
                                <asp:DropDownList ID="drpAttStatus" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem Text="ALL" Value="ALL"></asp:ListItem>
                                    <asp:ListItem Text="Early" Value="Early"></asp:ListItem>
                                    <asp:ListItem Text="Late" Value="Late"></asp:ListItem>
                                    <asp:ListItem Text="Absent" Value="Absent"></asp:ListItem>
                                    <asp:ListItem Text="Regular" Value="Regular"></asp:ListItem>
                                    <asp:ListItem Text="Late,Early" Value="Late,Early"></asp:ListItem>
                                    <asp:ListItem Text="on Leave" Value="on Leave"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnProcessReport" runat="server" CssClass="styled-button-1" Text="Process Report"
                                    ValidationGroup="ProcessReport" />
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <div style="max-height: 500px; max-width: 100%; overflow: auto">
                    <asp:GridView ID="grdEmpAttendanceReport" runat="server" CssClass="mGrid">
                    </asp:GridView>
                </div>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
