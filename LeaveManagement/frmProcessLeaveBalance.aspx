<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmProcessLeaveBalance.aspx.vb" Inherits="LeaveManagement_frmProcessLeaveBalance"
    Theme="CommonSkin" Title="m-HRM:Process Leave Balance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlProcessLeaveBalance" runat="server" SkinID="pnlInner" Width="900px">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Process Yearly Leave Balance
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
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
                            <td style="width: 150px">
                            </td>
                            <td>
                                Leave Year
                            </td>
                            <td>
                                <asp:DropDownList ID="drpLeaveYear" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem Text="2030" Value="2030"></asp:ListItem>
                                    <asp:ListItem Text="2029" Value="2029"></asp:ListItem>
                                    <asp:ListItem Text="2028" Value="2028"></asp:ListItem>
                                    <asp:ListItem Text="2027" Value="2027"></asp:ListItem>
                                    <asp:ListItem Text="2026" Value="2026"></asp:ListItem>
                                    <asp:ListItem Text="2025" Value="2025"></asp:ListItem>
                                    <asp:ListItem Text="2024" Value="2024"></asp:ListItem>
                                    <asp:ListItem Text="2023" Value="2023"></asp:ListItem>
                                    <asp:ListItem Text="2022" Value="2022"></asp:ListItem>
                                    <asp:ListItem Text="2021" Value="2021"></asp:ListItem>
                                    <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                                    <asp:ListItem Text="2019" Value="2019"></asp:ListItem>
                                    <asp:ListItem Text="2018" Value="2018"></asp:ListItem>
                                    <asp:ListItem Text="2017" Value="2017"></asp:ListItem>
                                    <asp:ListItem Text="2016" Value="2016"></asp:ListItem>
                                    <asp:ListItem Text="2015" Value="2015"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:Button ID="btnProcessLeaveYear" runat="server" CssClass="styled-button-1" Text="Process Yearly Leave " />
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
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlListLeaveBalance" runat="server" SkinID="pnlInner" Width="900px">
                    <div id="divgrd" onscroll="SetDivPosition()" style="max-height: 350px; max-width: 100%;
                        overflow: auto">
                        <asp:GridView ID="grdLeaveBalance" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                            <Columns>
                                <asp:TemplateField HeaderText="EmpLeaveBalanceID " Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmpLeaveBalanceID" runat="server" Text='<%# Bind("EmpLeaveBalanceID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EmployeeID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmployeeID" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="EmployeeName" HeaderText="Employee" />
                                <asp:TemplateField HeaderText="Casual">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCasualLeave" runat="server" Text='<%# Bind("CasualLeave") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Medical">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMedicalLeave" runat="server" Text='<%# Bind("MedicalLeave") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Annual">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAnnualLeave" runat="server" Text='<%# Bind("AnnualLeave") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Maternity">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMaternityLeave" runat="server" Text='<%# Bind("MaternityLeave") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="LeaveWithOutPay">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLeaveWithOutPay" runat="server" Text='<%# Bind("LeaveWithOutPay") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Special">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSpecialLeave" runat="server" Text='<%# Bind("SpecialLeave") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="LeaveYear">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLeaveYear" runat="server" Text='<%# Bind("LeaveYear") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryBy">
                                    <ItemTemplate>
                                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EntryDate">
                                    <ItemTemplate>
                                        <asp:Label ID="Label10" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
