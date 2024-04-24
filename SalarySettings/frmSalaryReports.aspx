<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmSalaryReports.aspx.vb" Inherits="SalarySettings_frmSalaryReports"
    Theme="CommonSkin" Title=".:MHRM:Salary Reports:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlSalaryReports" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widget-title">
                                    Salary Certificates : Employee Centric
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 400px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Employee
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSelectEmployee" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Salary Year/Month
                            </td>
                            <td>
                                &nbsp;<asp:DropDownList ID="drpSalaryYear" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem Text="2015" Value="2015"></asp:ListItem>
                                    <asp:ListItem Text="2016" Value="2016"></asp:ListItem>
                                    <asp:ListItem Text="2017" Value="2017"></asp:ListItem>
                                    <asp:ListItem Text="2018" Value="2018"></asp:ListItem>
                                    <asp:ListItem Text="2019" Value="2019"></asp:ListItem>
                                    <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                                    <asp:ListItem Text="2021" Value="2021"></asp:ListItem>
                                    <asp:ListItem Text="2022" Value="2022"></asp:ListItem>
                                    <asp:ListItem Text="2023" Value="2023"></asp:ListItem>
                                    <asp:ListItem Text="2024" Value="2024"></asp:ListItem>
                                    <asp:ListItem Text="2025" Value="2025"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpSalaryMonth" runat="server" Width="100px" CssClass="InputTxtBox">
                                    <asp:ListItem Text="January" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="February" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="March" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="April" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="May" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="June" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="July" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="August" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="September" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="October" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="November" Value="11"></asp:ListItem>
                                    <asp:ListItem Text="December" Value="12"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Select Report
                            </td>
                            <td>
                                <asp:DropDownList ID="drpExportFormat" runat="server" Width="100px" CssClass="InputTxtBox">
                                    <asp:ListItem Text="PDF" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Rich Text" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Word for Windows" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Excel" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Excel Record" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="HTML 3.2" Value="6"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;
                                <asp:DropDownList ID="drpReportList" runat="server" CssClass="InputTxtBox" Width="200px">
                                    <asp:ListItem Value="rptSalaryCertificate.rpt">Salary Certificate</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
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
                <asp:Panel ID="Panel1" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widget-title">
                                    Salary Reports
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 400px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Salary Entry Point
                            </td>
                            <td>
                                <asp:DropDownList ID="drpEntryPoint" runat="server" AutoPostBack="True" CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Salary Year/Month
                            </td>
                            <td>
                                &nbsp;<asp:DropDownList ID="drpSalaryReportYear" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem Text="2015" Value="2015"></asp:ListItem>
                                    <asp:ListItem Text="2016" Value="2016"></asp:ListItem>
                                    <asp:ListItem Text="2017" Value="2017"></asp:ListItem>
                                    <asp:ListItem Text="2018" Value="2018"></asp:ListItem>
                                    <asp:ListItem Text="2019" Value="2019"></asp:ListItem>
                                    <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                                    <asp:ListItem Text="2021" Value="2021"></asp:ListItem>
                                    <asp:ListItem Text="2022" Value="2022"></asp:ListItem>
                                    <asp:ListItem Text="2023" Value="2023"></asp:ListItem>
                                    <asp:ListItem Text="2024" Value="2024"></asp:ListItem>
                                    <asp:ListItem Text="2025" Value="2025"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpSalaryReportMonth" runat="server" Width="100px" CssClass="InputTxtBox">
                                    <asp:ListItem Text="January" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="February" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="March" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="April" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="May" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="June" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="July" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="August" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="September" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="October" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="November" Value="11"></asp:ListItem>
                                    <asp:ListItem Text="December" Value="12"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;
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
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Select Report
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSalaryReportExportFormat" runat="server" Width="100px" CssClass="InputTxtBox">
                                    <asp:ListItem Text="PDF" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="Rich Text" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Word for Windows" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="Excel" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="Excel Record" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="HTML 3.2" Value="6"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;
                                <asp:DropDownList ID="drpSalaryReportList" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                    <asp:ListItem Value="rptSalBankInstSCBMS.rpt">SCB RTGS MAIN SALARY</asp:ListItem>
                                    <asp:ListItem Value="rptSalBankInstBRACMS.rpt">BRAC RTGS MAIN SALARY</asp:ListItem>
                                    <asp:ListItem Value="rptSalBankInstBRACSP.rpt">BRAC RTGS SPECIAL ALLOWANCE</asp:ListItem>
                                    <asp:ListItem Value="rptSalBankInstBRACMA.rpt">BRAC RTGS MOBILE ALLOWANCE</asp:ListItem>
                                    <asp:ListItem Value="rptSalStatement.rpt">Salary Statement - General</asp:ListItem>
                                    <asp:ListItem Value="rptSalStatementMD.rpt">Salary Statement - MD</asp:ListItem>
                                    <asp:ListItem Value="rptSalBranchWise.rpt">Branch wise Salary</asp:ListItem>
                                    <asp:ListItem Value="rptSalDepartmentWise.rpt">Department wise Salary</asp:ListItem>
                                    <asp:ListItem Value="rptSalDesignationWise.rpt">Designation wise Salary</asp:ListItem>
                                    <asp:ListItem Value="rptSalEmpTypeWise.rpt">Emp Type wise Salary</asp:ListItem>
                                    <asp:ListItem Value="rptSalDistributionBankWise.rpt">Sal. Distribution Bank Wise</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
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
                                <asp:Button ID="btnProcessSalaryReport" runat="server" Text="Process Report" />
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
