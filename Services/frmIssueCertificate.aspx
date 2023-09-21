<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmIssueCertificate.aspx.vb" Inherits="Services_frmIssueCertificate"
    Theme="CommonSkin" Title=".:m-HRM:Issue Certificate:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlIssueCertificate" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="6">
                                <div class="widget-title">
                                    Issue Certificate</div>
                            </td>
                        </tr>
                        <tr>
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
                                Select Certificate Option
                            </td>
                            <td>
                                <asp:DropDownList ID="drpCertificateOptions" runat="server" Width="200px">
                                    <asp:ListItem Value="rptNOCforVISA.rpt" Text="NOC for VISA"></asp:ListItem>
                                    <asp:ListItem Value="rptExperienceCertificate.rpt" Text="Experience Certificate"></asp:ListItem>
                                    <asp:ListItem Value="rptReleaseOrder.rpt" Text="Release Order"></asp:ListItem>
                                    <asp:ListItem Value="rptSalaryCertificate.rpt" Text="Salary Certificate"></asp:ListItem>
                                    <asp:ListItem Value="rptNOCforPASSPORT.rpt" Text="NOC for Passport"></asp:ListItem>
                                    <asp:ListItem Value="rptJobContinuingCertificate.rpt" Text="Job Continuation"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnProcessReport" runat="server" Text="Process Report" />
                            </td>
                        </tr>
                        <tr>
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
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
