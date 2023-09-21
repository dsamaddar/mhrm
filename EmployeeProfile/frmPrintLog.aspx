<%@ Page Language="VB" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmPrintLog.aspx.vb" Inherits="EmployeeProfile_frmPrintLog"
    Title=".:m-HRM:Print Activity:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <div class="widget-title">
                    Print Activity
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlPrintLog" runat="server" SkinID="pnlInner">
                    <div style="max-width: 1000px;max-height:450px;overflow: auto">
                        <asp:GridView ID="grdPrintActivity" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                            <Columns>
                                <asp:BoundField DataField="ClientDate" HeaderText="ClientDate" />
                                <asp:BoundField DataField="UserName" HeaderText="UserName" />
                                <asp:BoundField DataField="PrinterName" HeaderText="PrinterName" />
                                <asp:BoundField DataField="PrintDocument" HeaderText="PrintDocument" ControlStyle-Width="200px" />
                                <asp:BoundField DataField="PrintCopies" HeaderText="PrintCopies" />
                                <asp:BoundField DataField="PrintPages" HeaderText="PrintPages" />
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
