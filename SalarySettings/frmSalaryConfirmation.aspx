<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmSalaryConfirmation.aspx.vb" Inherits="SalarySettings_frmSalaryConfirmation"
    Title=".:MHRM:Salary Confirmation:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlSalaryReports" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Salary Finalization/Reversal</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 100px;">
                            </td>
                            <td style="width: 200px">
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
                            <td class="label">
                                Select Entry Point
                            </td>
                            <td>
                                <asp:DropDownList ID="drpEntryPoint" runat="server">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnFinalizeSalary" runat="server" Text="Finalize Salary" OnClientClick="return confirm('Are you sure to finalize the salary?');" />
                                &nbsp;<asp:Button ID="btnReverseSalary" runat="server" Text="Reverse Salary" OnClientClick="return confirm('Are you sure reverse the salary?');" />
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
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
