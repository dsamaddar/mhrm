<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmRetrieveZKAttendanceLog.aspx.vb" Inherits="frmRetrieveZKAttendanceLog"
    Title=".:m-HRM:ZK Attendance Log:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td align="left">
                <asp:Panel ID="pnlAttendanceLog" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td class="widget-title">
                                ZK-Attendance Log
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="max-width: 100%; max-height: 400px; overflow: auto">
                                    <asp:GridView ID="grdAttendanceLog" runat="server" CssClass="mGrid" EmptyDataText="No Data Found"
                                        AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select">
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="chkSelectAll" runat="server" AutoPostBack="True" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkItems" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="logindex">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbllogindex" runat="server" Text='<%# Bind("logindex") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="logtime">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbllogtime" runat="server" Text='<%# Bind("logtime") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="userid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbluserid" runat="server" Text='<%# Bind("userid") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="nodeid">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblnodeid" runat="server" Text='<%# Bind("nodeid") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="authtype">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblauthtype" runat="server" Text='<%# Bind("authtype") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="slogtime">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblslogtime" runat="server" Text='<%# Bind("slogtime") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnImportData" runat="server" Text="Import Data" />
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
