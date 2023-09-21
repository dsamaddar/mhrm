<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmRolwWiseMenuPermission.aspx.vb" Inherits="Administration_frmRolwWiseMenuPermission"
    Title=".:MHRM:Role Wise Menu Permission:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
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
        <tr align="center">
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Panel ID="pnlAvailableProfile" runat="server" Width="700px" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="4">
                                <div class="widgettitle">
                                    Role Wise Menu Permission</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                            <td style="width: 150px">
                                &nbsp;
                            </td>
                            <td style="width: 230px">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Select Role
                            </td>
                            <td>
                                <asp:DropDownList ID="drpRoleList" runat="server" CssClass="InputTxtBox" Width="200px"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnSave" runat="server" CssClass="styled-button-1" Text="Save Changes" />
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
                    </table>
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlMenuPermission" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td class="label">
                                Administration
                            </td>
                            <td class="label">
                                HR Services</td>
                            <td class="label">
                                Salary Process</td>
                            <td class="label">
                                Leave Management</td>
                            <td class="label">
                                Attendance Reports</td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <asp:GridView ID="grdAdministrationMenu" runat="server" AutoGenerateColumns="False"
                                    CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectAdminMenu" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAdminMenuID" runat="server" Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td valign="top">
                                <asp:GridView ID="grdHRServices" runat="server" AutoGenerateColumns="False" 
                                    CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectHRServices" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblHRServicesMenuID" runat="server" 
                                                    Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label8" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td valign="top">
                                <asp:GridView ID="grdSalarySetup" runat="server" AutoGenerateColumns="False" 
                                    CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectSalarySetupMenu" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblSalarySetupMenuID" runat="server" 
                                                    Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label9" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td valign="top">
                                <asp:GridView ID="grdLeaveManagement" runat="server" 
                                    AutoGenerateColumns="False" CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectLeaveManagement" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblLeaveManagementMenuID" runat="server" 
                                                    Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td valign="top">
                                <asp:GridView ID="grdAttendanceReports" runat="server" 
                                    AutoGenerateColumns="False" CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectAttendanceReportsMenu" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblAttendanceReportsMenuID" runat="server" 
                                                    Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td class="label">
                                Miscellaneous</td>
                            <td class="label">
                                &nbsp;</td>
                            <td class="label">
                                &nbsp;</td>
                            <td class="label">
                                &nbsp;</td>
                            <td class="label">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td valign="top">
                                <asp:GridView ID="grdMiscellaneous" runat="server" AutoGenerateColumns="False" 
                                    CssClass="mGrid">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select">
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chkSelectMiscellaneousMenu" runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMiscellaneousMenuID" runat="server" 
                                                    Text='<%# Bind("MenuID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="MenuName">
                                            <ItemTemplate>
                                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("MenuName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                            <td valign="top">
                                &nbsp;</td>
                            <td valign="top">
                                &nbsp;</td>
                            <td valign="top">
                                &nbsp;</td>
                            <td valign="top">
                                &nbsp;</td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
