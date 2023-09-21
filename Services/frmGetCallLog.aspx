<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmGetCallLog.aspx.vb" Inherits="Services_frmGetCallLog" Title=".:MHRM: Call Log:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="Panel1" runat="server">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="3">
                                <div class="widget-title">
                                    Call Log</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                <asp:Button ID="btnReloadCallLog" runat="server" Text="Reload Call Log" Width="200px" />
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
                <div>
                    <div style="max-height: 400px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdCallLog" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                            <Columns>
                                <asp:TemplateField HeaderText="Employee">
                                    <ItemTemplate>
                                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CallDate">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("CallDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="CallTime">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("CallTime") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ext">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Ext") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Co">
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("Co") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DialNumber">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("DialNumber") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RingDuration">
                                    <ItemTemplate>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("RingDuration") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FullLog">
                                    <ItemTemplate>
                                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("FullLog") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
