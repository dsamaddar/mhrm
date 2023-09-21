<%@ Page Title=".:HRM::Employee Wise Attendance Settings:." Theme="CommonSkin" Language="VB"
    MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false" CodeFile="frmEmpWiseAttSettings.aspx.vb"
    Inherits="Administration_frmEmpWiseAttSettings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlAttSettings" runat="server" SkinID="pnlInner" Width="80%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widget-title">
                                    Employee-wise Attendance Settings</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td>
                                <asp:CheckBox ID="chkInheritDefaultSettings" runat="server" CssClass="chkText" Text="Inherit Default Settings" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td>
                                Log In Time
                            </td>
                            <td>
                                Log Out Time
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 450px">
                                <asp:CheckBox ID="chkSelectAllEmployees" runat="server" AutoPostBack="True" CssClass="chkText"
                                    Text="Select All" />
                                <br />
                                <div style="max-height: 300px; max-width: 100%; overflow: auto">
                                    <asp:CheckBoxList ID="chkEmpList" runat="server" CssClass="label">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                            <td valign="top">
                                <asp:DropDownList ID="drpHour" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                    <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpMin" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem Text="00" Value="00"></asp:ListItem>
                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="20" Value="20"></asp:ListItem>
                                    <asp:ListItem Text="30" Value="30"></asp:ListItem>
                                    <asp:ListItem Text="40" Value="40"></asp:ListItem>
                                    <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpAMPM" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                                    <asp:ListItem Text="PM" Value="PM"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td valign="top">
                                <asp:DropDownList ID="drpHourO" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                    <asp:ListItem Text="9" Value="9"></asp:ListItem>
                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="11" Value="11"></asp:ListItem>
                                    <asp:ListItem Text="12" Value="12"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpMinO" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem Text="00" Value="00"></asp:ListItem>
                                    <asp:ListItem Text="10" Value="10"></asp:ListItem>
                                    <asp:ListItem Text="20" Value="20"></asp:ListItem>
                                    <asp:ListItem Text="30" Value="30"></asp:ListItem>
                                    <asp:ListItem Text="40" Value="40"></asp:ListItem>
                                    <asp:ListItem Text="50" Value="50"></asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpAMPMO" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem Text="AM" Value="AM"></asp:ListItem>
                                    <asp:ListItem Text="PM" Value="PM"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td valign="top">
                                <asp:Button ID="btnProcess" runat="server" CssClass="styled-button-1" Text="Update Settings" />
                            </td>
                            <td valign="top">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
