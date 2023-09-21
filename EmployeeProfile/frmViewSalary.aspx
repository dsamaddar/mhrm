<%@ Page Language="VB" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    Theme="CommonSkin" AutoEventWireup="false" CodeFile="frmViewSalary.aspx.vb" Inherits="EmployeeProfile_frmViewSalary"
    Title=".:m-HRM:View Salary:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlTopPanel" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Salary View</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 150px">
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
                            <td style="width: 200px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="max-width: 10px">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="font-weight: bold">
                                Basic Salary
                            </td>
                            <td style="font-weight: bold">
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblBasicSalary" runat="server" Font-Bold="true"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="font-weight: bold">
                                Add :
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                Consolidated
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblConsolidated" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                House Rent Allowance
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblHouseRentAllowance" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                Medical Allowance
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblMedicalAllowance" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                Entertainment Allowance
                            </td>
                            <td>
                                :</td>
                            <td>
                                <asp:Label ID="lblEntertainmentAllowance" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                Conveyance Allowance
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblConveyanceAllowance" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                House Maintenance &amp; Utilities
                            </td>
                            <td>
                                :</td>
                            <td>
                                <asp:Label ID="lblHouseMaintenance" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                ---------------------------------------------
                            </td>
                            <td>
                                -</td>
                            <td>
                                ---------------------</td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="font-weight: bold">
                                Monthly Gross Salary
                            </td>
                            <td style="font-weight: bold">
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblMonthlyGross" runat="server" Font-Bold="True" Font-Overline="False"
                                    Font-Underline="True"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="font-weight: bold">
                                Less :
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                Contribution in PF
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblPFContribution" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                Loan Deduction
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblLoanDeduction" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                TAX
                            </td>
                            <td>
                                :
                            </td>
                            <td>
                                <asp:Label ID="lblTAX" runat="server"></asp:Label>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                                ---------------------------------------------
                            </td>
                            <td>
                                -</td>
                            <td>
                                ---------------------</td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td style="font-weight: bold">
                                Monthly Net Salary
                            </td>
                            <td style="font-weight: bold">
                                :</td>
                            <td>
                                <asp:Label ID="lblNetMonthlySalary" runat="server" Font-Bold="True" Font-Underline="True"></asp:Label>
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
