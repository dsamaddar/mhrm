<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmAddNewEmployee.aspx.vb" Inherits="Administration_frmAddNewEmployeeaspx"
    Title=".:m-HRM:Add New Employee:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlAddNewEmp" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Adding New Employee
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldEmployeeName" runat="server" ControlToValidate="txtEmployeeName"
                                    Display="None" ErrorMessage="Required: Employee Name" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldEmpID" runat="server" ControlToValidate="txtEmployeeID"
                                    Display="None" ErrorMessage="Required: Employee ID" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldLogInID" runat="server" ControlToValidate="txtLoginID"
                                    Display="None" ErrorMessage="Required: Login ID" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Employee Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmployeeName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                Employee Code
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmployeeID" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Login ID
                            </td>
                            <td>
                                <asp:TextBox ID="txtLoginID" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                            <td>
                                Login Password
                            </td>
                            <td>
                                <asp:TextBox ID="txtLoginPassword" runat="server" CssClass="InputTxtBox" Text="Standard@1"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqFldLoginPassword" runat="server" ControlToValidate="txtLoginPassword"
                                    Display="None" ErrorMessage="Required: Login Password" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlSubmission" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
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
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" ValidationGroup="Submit" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
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
    </table>
</asp:Content>
