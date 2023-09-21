<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmEmpAttendanceStatus.aspx.vb" Inherits="EmployeeProfile_frmEmpAttendanceStatus"
    Title=".:HRM:Attendance Report:." %>

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
                                    Attendance Report<asp:ScriptManager ID="ScriptManager1" runat="server">
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
                                <asp:RequiredFieldValidator ID="reqFldDateFrom" runat="server" ControlToValidate="txtDateFrom"
                                    Display="None" ErrorMessage="" ValidationGroup="ProcessReport"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDateFrom_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldDateFrom" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                                &nbsp;<asp:CompareValidator ID="dateValidatorJoining" runat="server" ControlToValidate="txtDateFrom"
                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date" ValidationGroup="ProcessReport"></asp:CompareValidator>
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="">
                                <asp:RequiredFieldValidator ID="reqFldDateTo" runat="server" ControlToValidate="txtDateTo"
                                    Display="None" ErrorMessage="" ValidationGroup="ProcessReport"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldDateTo" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                                &nbsp;<asp:CompareValidator ID="compvalDateTo" runat="server" ControlToValidate="txtDateTo"
                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date" ValidationGroup="ProcessReport">
                                </asp:CompareValidator>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Date From
                            </td>
                            <td class="label">
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateFrom_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateFrom">
                                </cc1:CalendarExtender>
                                &nbsp;(MM/DD/YYYY)
                            </td>
                            <td class="label">
                                Date To
                            </td>
                            <td class="label">
                                <asp:TextBox ID="txtDateTo" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="calExtDateTo" runat="server" Enabled="True" TargetControlID="txtDateTo">
                                </cc1:CalendarExtender>
                                &nbsp;(MM/DD/YYYY)
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
                    <asp:GridView ID="grdEmpAttendanceReport" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="UserID" HeaderText="UserID" />
                            <asp:BoundField DataField="Designation" HeaderText="Designation" />
                            <asp:BoundField DataField="Department" HeaderText="Department" />
                            <asp:BoundField DataField="Branch" HeaderText="Branch" />
                            <asp:BoundField DataField="WorkStation" HeaderText="WorkStation" />
                            <asp:BoundField DataField="LogInTime" HeaderText="LogInTime" />
                            <asp:BoundField DataField="LogOutTime" HeaderText="LogOutTime" />
                            <asp:BoundField DataField="AttSystem" HeaderText="AttSystem" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                        </Columns>
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
