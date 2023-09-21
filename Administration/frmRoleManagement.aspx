<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmRoleManagement.aspx.vb" Inherits="Administration_frmRoleManagement"
    Title=".:MHRM:Role Management:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlRoleManagement" runat="server" Width="70%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widgettitle">
                                    Role Management<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
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
                                <asp:HiddenField ID="hdFldRoleID" runat="server" />
                            </td>
                            <td style="width: 300px">
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Role Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtRoleName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldRoleName" runat="server" ControlToValidate="txtRoleName"
                                    Display="None" ErrorMessage="Role Name Required" ValidationGroup="AddRole"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldRoleName_ValidatorCalloutExtender" runat="server"
                                    Enabled="True" TargetControlID="reqFldRoleName">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Is Active
                            </td>
                            <td>
                                <asp:CheckBox ID="chkRoleIsActive" runat="server" Text="Is Active" CssClass="chkText" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnInserRole" runat="server" Text="Insert Role" CssClass="styled-button-1"
                                    ValidationGroup="AddRole" />
                                &nbsp;<asp:Button ID="btnUpdateRole" runat="server" Text="Update Role" CssClass="styled-button-1"
                                    Visible="False" ValidationGroup="AddRole" />
                                &nbsp;<asp:Button ID="btnCancelSelection" runat="server" Text="Cancel" CssClass="styled-button-1" />
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlRoleList" runat="server" SkinID="pnlInner" Width="70%">
                    <div style="max-height: 300px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdRoleList" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RoleID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRoleID" runat="server" Text='<%# Bind("RoleID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Role">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRoleName" runat="server" Text='<%# Bind("RoleName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Active">
                                    <ItemTemplate>
                                        <asp:Label ID="lblisActive" runat="server" Text='<%# Bind("isActive") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Created-By">
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("CreatedBy") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Created-on">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("CreatedDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
