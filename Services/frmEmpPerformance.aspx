<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmEmpPerformance.aspx.vb" Inherits="Services_frmEmpPerformance" Title=".:m-HRM:Employee Performance:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlParameters" runat="server">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widget-title">
                                    Employee Performance Report</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px;">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Year
                            </td>
                            <td>
                                <asp:DropDownList ID="drpYear" runat="server">
                                    <asp:ListItem>2016</asp:ListItem>
                                    <asp:ListItem>2017</asp:ListItem>
                                    <asp:ListItem>2018</asp:ListItem>
                                    <asp:ListItem>2019</asp:ListItem>
                                    <asp:ListItem>2020</asp:ListItem>
                                    <asp:ListItem>2021</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnProcessReport" runat="server" Text="Process Report" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlResults" runat="server">
                    <div>
                        <asp:GridView ID="grdEmpPerformance" runat="server" CssClass="mGrid">
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
