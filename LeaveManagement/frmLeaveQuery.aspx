<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmLeaveQuery.aspx.vb" Inherits="LeaveManagement_frmLeaveQuery" Theme="CommonSkin"
    Title=".:MHRM:Leave Query:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <table style="width: 100%;">
            <tr>
                <td>
                    <asp:Panel ID="pnlLeaveQuery" runat="server" SkinID="pnlInner">
                        <table style="width: 100%;">
                            <tr>
                                <td colspan="6">
                                    <div class="widgettitle">
                                        Leave Query</div>
                                </td>
                            </tr>
                            <tr align="left">
                                <td class="label" style="width: 20px">
                                </td>
                                <td class="label" style="width: 150px">
                                </td>
                                <td style="width: 200px">
                                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </td>
                                <td style="width: 20px">
                                </td>
                                <td style="width: 150px">
                                    &#160;&#160;
                                </td>
                                <td style="width: 212px">
                                </td>
                            </tr>
                            <tr align="left">
                                <td class="label" style="width: 20px">
                                    &nbsp;
                                </td>
                                <td class="label" style="width: 150px">
                                    Employee
                                </td>
                                <td style="width: 200px">
                                    <asp:DropDownList ID="drpSelectEmployee" runat="server" Width="200px" CssClass="InputTxtBox">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 20px">
                                </td>
                                <td style="width: 150px" class="label">
                                    Leave Type
                                </td>
                                <td style="width: 212px">
                                    <asp:DropDownList ID="ddlLeaveTypeApproved" runat="server" CssClass="InputTxtBox "
                                        Width="200px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr align="left">
                                <td class="label">
                                </td>
                                <td class="label">
                                    Approval date from
                                </td>
                                <td>
                                    <asp:TextBox ID="dtApprovedLeaveDateFrom" runat="server" CssClass="InputTxtBox" TabIndex="10"
                                        Width="100px"></asp:TextBox>
                                    <cc1:CalendarExtender ID="dtApprovedLeaveDateFrom_CalendarExtender0" runat="server"
                                        Enabled="True" TargetControlID="dtApprovedLeaveDateFrom">
                                    </cc1:CalendarExtender>
                                </td>
                                <td>
                                </td>
                                <td class="label">
                                    Approval date To
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="dtApprovedLeaveDateTo" runat="server" CssClass="InputTxtBox" TabIndex="10"
                                        Width="100px"></asp:TextBox>
                                    <cc1:CalendarExtender ID="dtApprovedLeaveDateTo_CalendarExtender0" runat="server"
                                        Enabled="True" TargetControlID="dtApprovedLeaveDateTo">
                                    </cc1:CalendarExtender>
                                </td>
                            </tr>
                            <tr align="left">
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                    <asp:Button ID="btnSearchApprovedLeave" runat="server" CssClass="styled-button-1"
                                        Text="Search" />
                                    &nbsp;</td>
                                <td>
                                    <asp:ImageButton ID="imgBtnExport" runat="server" Height="30px" 
                                        ImageUrl="~/Sources/icons/excel.png" />
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
                    <div class="datagrid" style="max-height: 250px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdApprovedLeave" runat="server" AutoGenerateColumns="False" CellPadding="0"
                            CssClass="mGrid" DataKeyNames="LeaveRequestID" EmptyDataText="No Records Available"
                            Font-Names="Arial" Font-Size="12px" PageSize="20" ShowFooter="True">
                            <Columns>
                                <asp:TemplateField HeaderText="Employee">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Designation">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("OfficialDesignation") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Dept">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("DeptName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Branch">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("ULCBranchName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="LeaveType">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("LeaveType") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Leave From" SortExpression="LeaveFrom">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("LeaveFrom") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Leave To" SortExpression="LeaveTo">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("LeaveTo") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Days" SortExpression="TotalDays">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalDays" runat="server" Text='<%# Bind("TotalDays") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Working Days" SortExpression="TotalWorkingDays">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalWorkingDays" runat="server" Text='<%# Bind("TotalWorkingDays") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Requested Date" SortExpression="EntryDate">
                                    <ItemTemplate>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Approved Date" SortExpression="ApprovalDate">
                                    <ItemTemplate>
                                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("ApprovalDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Purpose">
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("PurposeOfLeave") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="LeaveStatus">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLeaveStatus" runat="server" Text='<%# Bind("LeaveStatus") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Attachment" ShowHeader="true">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hpDocument" runat="server" CssClass="linkbtn" NavigateUrl='<%# ConfigurationManager.AppSettings("OutputEHRMFiles")+ Eval("Attachment") %>'
                                            Target="_blank">View</asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
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
    </div>
</asp:Content>
