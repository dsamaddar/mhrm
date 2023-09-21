<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmSellRaffleTicket.aspx.vb" Inherits="Administration_frmSellRaffleTicket"
    Theme="CommonSkin" Title=".:m-HRM::Sell Raffle Ticket:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlTicketChooser" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widget-title">
                                    Sell Raffle Ticket</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
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
                            <td style="width: 20px">
                            </td>
                            <td>
                                Select Department
                            </td>
                            <td>
                                <asp:DropDownList ID="drpSelectDepartment" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
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
                                Select Employee
                            </td>
                            <td>
                                <asp:DropDownList ID="drpEmployeeList" runat="server" CssClass="InputTxtBox" 
                                    Width="200px" AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnConfirmTicket" runat="server" CssClass="styled-button-1" Text="Confirm Ticket" />
                            </td>
                            <td>
                                <asp:Button ID="btnExportTicket" runat="server" CssClass="styled-button-1" Text="Export Ticket" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Available Tickets</td>
                            <td colspan="3">
                                <div style="max-height: 300px; overflow: auto">
                                    <asp:CheckBoxList ID="chkTicketList" runat="server" RepeatColumns="20" RepeatDirection="Horizontal"
                                        RepeatLayout="Flow">
                                    </asp:CheckBoxList>
                                </div>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Already Owned By Employee</td>
                            <td>
                                <asp:Label ID="lblTicketsOwnedByEmp" runat="server" Font-Bold="True" 
                                    Font-Size="Medium" ForeColor="#009933"></asp:Label>
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
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
