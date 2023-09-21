<%@ Page Language="VB" Theme="CommonSkin"  MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false" CodeFile="frmUserRoleManagement.aspx.vb" Inherits="Administration_frmUserRoleManagement" title=".:Help Desk:User Wise Role Management:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:100%;">
        <tr align="center" >
            <td>
                <asp:Panel ID="pnlUserWiseRoleManagement" runat="server" Width="100%" 
                    SkinID="pnlInner" >
                    <table style="width:100%;">
                        <tr align="left" >
                            <td colspan="4">
                                <div class="widgettitle">User Wise Role Management</div>
                            </td>
                        </tr>
                        <tr align="left" >
                            <td style="width:20px">
                                </td>
                            <td style="width:150px">
                                </td>
                            <td style="width:230px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left" >
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                User List</td>
                            <td>
                                <asp:DropDownList ID="drpUserList" runat="server" CssClass="InputTxtBox" 
                                    Width="200px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left" >
                            <td>
                                &nbsp;</td>
                            <td class="label">
                                Role List</td>
                            <td>
                                <asp:DropDownList ID="drpRoleList" runat="server" CssClass="InputTxtBox" 
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;</td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnApplyRole" runat="server" CssClass="styled-button-1" 
                                    Text="Apply Role" />
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center" >
            <td>
                <asp:Panel ID="pnlUserWiseRole" runat="server" Width="100%"  SkinID="pnlInner" >
                    <div style="max-height:300px;max-width:680px;overflow:auto">
                        <asp:GridView ID="grdUserRole" runat="server" AutoGenerateColumns="False" 
                            CellPadding="4" ForeColor="#333333" GridLines="None" 
                            EmptyDataText="No Permission Available" CssClass="mGrid">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:TemplateField HeaderText="UserWiseRoleID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblUserWiseRoleID" runat="server" Text='<%# Bind("UserWiseRoleID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("UserWiseRoleID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RoleID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRoleID" runat="server" Text='<%# Bind("RoleID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("RoleID") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RoleName">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("RoleName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("RoleName") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" ImageUrl="~/Sources/icons/erase.png"   OnClientClick="if (!confirm('Are you Sure to Delete The Permission ?')) return false"    CommandName="Delete"  runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#999999" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center" >
            <td>
            </td>
        </tr>
    </table>
</asp:Content>

