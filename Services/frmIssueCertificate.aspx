<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmIssueCertificate.aspx.vb" Inherits="Services_frmIssueCertificate"
    Theme="CommonSkin" Title=".:m-HRM:Issue Certificate:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td align="left">
                <asp:Panel ID="pnlIssueCertificate" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="6">
                                <div class="widget-title">
                                    Issue Certificate</div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:20px">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                Select Employee
                            </td>
                            <td>
                                <asp:DropDownList ID="drpEmpList" runat="server" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                Salary Month/Year</td>
                            <td>
                                <asp:DropDownList ID="drpSalaryYear" runat="server" CssClass="InputTxtBox">
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
                                &nbsp;<asp:DropDownList ID="drpSalaryMonth" runat="server" CssClass="InputTxtBox" 
                                    Width="100px">
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
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                Select Certificate Option</td>
                            <td>
                                <asp:DropDownList ID="drpCertificateOptions" runat="server" Width="200px">
                                    <asp:ListItem Text="NOC for VISA" Value="rptNOCforVISA.rpt"></asp:ListItem>
                                    <asp:ListItem Text="Experience Certificate" 
                                        Value="rptExperienceCertificate.rpt"></asp:ListItem>
                                    <asp:ListItem Text="Release Order" Value="rptReleaseOrder.rpt"></asp:ListItem>
                                    <asp:ListItem Text="Salary Certificate" Value="rptSalaryCertificate.rpt"></asp:ListItem>
                                    <asp:ListItem Text="Salary Payslip" Value="rptSalaryPayslip.rpt"></asp:ListItem>
                                    <asp:ListItem Text="NOC for Passport" Value="rptNOCforPASSPORT.rpt"></asp:ListItem>
                                    <asp:ListItem Text="Job Continuation" Value="rptJobContinuingCertificate.rpt"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:Button ID="btnProcessReport" runat="server" Text="Process Report" />
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
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
