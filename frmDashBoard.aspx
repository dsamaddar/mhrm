<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmDashBoard.aspx.vb" Inherits="frmDashBoard" Title="m-HRM:HR Dash-Board" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td style="margin-left: 40px">
                <asp:Panel ID="pnlDashBoard" runat="server" SkinID="pnlInner" Width="90%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    m-HRM Dash-Board
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 30px">
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
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                License Expiry Date</td>
                            <td>
                                <asp:Label ID="lblLicenseExpiryDate" runat="server" Font-Names="Verdana" 
                                    Font-Size="X-Large" ForeColor="Red"></asp:Label>
                            </td>
                            <td>
                                Maximum User Limit</td>
                            <td>
                                <asp:Label ID="lblMaximumUserLimit" runat="server" Font-Names="Verdana" 
                                    Font-Size="X-Large" ForeColor="#FF9900"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
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
                                Active Users</td>
                            <td>
                                <asp:Label ID="lblActiveUsers" runat="server" Font-Names="Verdana" 
                                    Font-Size="Large" ForeColor="Blue"></asp:Label>
                            </td>
                            <td>
                                In-Active Users</td>
                            <td>
                                <asp:Label ID="lblInActiveUsers" runat="server" Font-Names="Verdana" 
                                    Font-Size="Large" ForeColor="#993300"></asp:Label>
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
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Available Users</td>
                            <td>
                                <asp:Label ID="lblAvailableUsers" runat="server" Font-Names="Verdana" 
                                    Font-Size="Large" ForeColor="#339933"></asp:Label>
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
            </td>
        </tr>
    </table>
</asp:Content>
