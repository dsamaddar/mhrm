<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmNodeSettings.aspx.vb" Inherits="Administration_frmNodeSettings"
    Title="m-HRM::Node Settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlNodeInput" runat="server" SkinID="pnlInner" Width="80%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Attendance Node Administration
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:HiddenField ID="hdFldNodeID" runat="server" />
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Node Code
                            </td>
                            <td>
                                <asp:TextBox ID="txtNodeCode" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                            <td>
                                Node Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtNodeName" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Node Branch
                            </td>
                            <td>
                                <asp:DropDownList ID="drpBranchList" runat="server" CssClass="InputTxtBox">
                                </asp:DropDownList>
                            </td>
                            <td>
                                Node Description
                            </td>
                            <td>
                                <asp:TextBox ID="txtNodeDescription" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                IsActive
                            </td>
                            <td>
                                <asp:CheckBox ID="chkNodeIsActive" runat="server" Text=" YES" Checked="True" />
                            </td>
                            <td>
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
                                <asp:Button ID="btnInsert" runat="server" CssClass="styled-button-1" Text="Insert" />
                                &nbsp;<asp:Button ID="btnUpdate" runat="server" CssClass="styled-button-1" Text="Update" />
                            </td>
                            <td>
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
        <tr align="center">
            <td>
                <asp:Panel ID="pnlNodeList" runat="server" SkinID="pnlInner" Width="80%">
                    <div>
                        <asp:GridView ID="grdNodeList" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:TemplateField HeaderText="NodeID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNodeID" runat="server" Text='<%# Bind("NodeID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="NodeCode">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNodeCode" runat="server" Text='<%# Bind("NodeCode") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="NodeName">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNodeName" runat="server" Text='<%# Bind("NodeName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="NodeBranchID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNodeBranchID" runat="server" Text='<%# Bind("NodeBranchID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Branch">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBranch" runat="server" Text='<%# Bind("Branch") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="NodeDescription">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNodeDescription" runat="server" Text='<%# Bind("NodeDescription") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsActive">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryBy">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntryBy" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
