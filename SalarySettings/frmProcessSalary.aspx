﻿<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmProcessSalary.aspx.vb" Inherits="SalarySettings_frmProcessSalary"
    Title=".:m-HRM:Process Salary:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlSalaryOptions" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Process Salary
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td colspan="5">
                                <br />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Salary Month
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSalaryMonth" runat="server">
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
                            <td>
                                Salary Year
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSalaryYear" runat="server">
                                    <asp:ListItem Value="2015" Text="2015"></asp:ListItem>
                                    <asp:ListItem Value="2016" Text="2016"></asp:ListItem>
                                    <asp:ListItem Value="2017" Text="2017"></asp:ListItem>
                                    <asp:ListItem Value="2018" Text="2018"></asp:ListItem>
                                    <asp:ListItem Value="2019" Text="2019"></asp:ListItem>
                                    <asp:ListItem Value="2020" Text="2020"></asp:ListItem>
                                    <asp:ListItem Value="2021" Text="2021"></asp:ListItem>
                                    <asp:ListItem Value="2022" Text="2022"></asp:ListItem>
                                    <asp:ListItem Value="2023" Text="2023"></asp:ListItem>
                                    <asp:ListItem Value="2024" Text="2024"></asp:ListItem>
                                    <asp:ListItem Value="2025" Text="2025"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Processing Entry Point
                            </td>
                            <td>
                                <asp:Label ID="lblProcessingEntryPoint" runat="server"></asp:Label>
                            </td>
                            <td>
                                <br />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <td colspan="5">
                            <br />
                        </td>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlSalaryProcess" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <td colspan="3">
                            <br />
                        </td>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 300px">
                                Select Employee Type
                            </td>
                            <td>
                                <asp:DropDownList ID="drpEmployeeType" runat="server" CssClass="InputTxtBox" Width="200px"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                <asp:CheckBox ID="chkSelectAllEmployee" runat="server" AutoPostBack="True" Text="Select All Employees" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td valign="top">
                                <div style="max-height: 200px;width: 380px; overflow: auto">
                                    <asp:CheckBoxList ID="chkBxLstEmployees" runat="server">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                            <td>
                                <asp:CheckBox ID="chkProcessSalary" runat="server" Text="Process Salary" Checked="True" />
                                <br />
                                <asp:CheckBox ID="chkProcessFestivalBonus" runat="server" Text="Process Festival Bonus" />
                                <br />
                                <asp:CheckBox ID="chkProcessBaishakhiAllowance" runat="server" Text="Process Baishakhi Allowance" />
                                <br />
                                <asp:CheckBox ID="chkProcessPB" runat="server" Text="Process Performance Bonus" />
                                <br />
                                <asp:CheckBox ID="chkProcessTaxDeduction" runat="server" Text="Process Tax Deduction"
                                    Checked="True" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnCheckSystem" runat="server" Text="Check System" />
                                &nbsp;<asp:Button ID="btnProcessSalary" runat="server" Text="Process Salary" />
                                &nbsp;<asp:Button ID="btnRefresh" runat="server" Text="Refresh" />
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
