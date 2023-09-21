<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    Theme="CommonSkin" CodeFile="frmEditEmpLeaveBalance.aspx.vb" Inherits="LeaveManagement_frmEditEmpLeaveBalance"
    Title="m-HRM:Edit Employee Leave Balance" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">
        window.onload = function() {
            var strCook = document.cookie;
            if (strCook.indexOf("!~") != 0) {
                var intS = strCook.indexOf("!~");
                var intE = strCook.indexOf("~!");
                var strPos = strCook.substring(intS + 2, intE);
                document.getElementById("divgrd").scrollTop = strPos;
            }
        }
        function SetDivPosition() {
            var intY = document.getElementById("divgrd").scrollTop;
            document.title = intY;
            document.cookie = "yPos=!~" + intY + "~!";
        }

        window.scrollBy(100, 100); 
    </script>

    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlEmpLeaveBalanceEntry" runat="server" Width="900px" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Manage Employee Leave Balance<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 120px">
                            </td>
                            <td style="width: 200px">
                                <asp:RequiredFieldValidator ID="reqFldCasualLeave" runat="server" ControlToValidate="txtCasualLeave"
                                    Display="None" ErrorMessage="Required: Casual Leave" ValidationGroup="LeaveBalance"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldCasualLeave_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldCasualLeave" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldMedicalLeave" runat="server" ControlToValidate="txtMedicalLeave"
                                    Display="None" ErrorMessage="Required: Medical Leave" ValidationGroup="LeaveBalance"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldMedicalLeave_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldMedicalLeave" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldMaternityLeave" runat="server" ControlToValidate="txtMaternityLeave"
                                    Display="None" ErrorMessage="Required: Maternity Leave" ValidationGroup="LeaveBalance"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldMaternityLeave_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldMaternityLeave" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Employee
                            </td>
                            <td>
                                <asp:DropDownList ID="drpUserList" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldAnnualLeave" runat="server" ControlToValidate="txtAnnualLeve"
                                    Display="None" ErrorMessage="Required: Annual Leave" ValidationGroup="LeaveBalance"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldAnnualLeave_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldAnnualLeave" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldLeaveWithOutPay" runat="server" ControlToValidate="txtLeaveWithOutPay"
                                    Display="None" ErrorMessage="Required: Leave Without Pay" ValidationGroup="LeaveBalance"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldLeaveWithOutPay_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldLeaveWithOutPay" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Casual Leave
                            </td>
                            <td>
                                <asp:TextBox ID="txtCasualLeave" runat="server" CssClass="InputTxtBox">10</asp:TextBox>
                            </td>
                            <td>
                                Maternity Leave
                            </td>
                            <td>
                                <asp:TextBox ID="txtMaternityLeave" runat="server" CssClass="InputTxtBox">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Medical Leave
                            </td>
                            <td>
                                <asp:TextBox ID="txtMedicalLeave" runat="server" CssClass="InputTxtBox">0</asp:TextBox>
                            </td>
                            <td>
                                Leave Without Pay
                            </td>
                            <td>
                                <asp:TextBox ID="txtLeaveWithOutPay" runat="server" CssClass="InputTxtBox">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Annual Leave
                            </td>
                            <td>
                                <asp:TextBox ID="txtAnnualLeve" runat="server" CssClass="InputTxtBox">0</asp:TextBox>
                            </td>
                            <td>
                                Special Leave
                            </td>
                            <td>
                                <asp:TextBox ID="txtSpecialLeave" runat="server" CssClass="InputTxtBox">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Leave Year</td>
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
                                Sick Leave</td>
                            <td>
                                <asp:TextBox ID="txtSickLeave" runat="server" CssClass="InputTxtBox">0</asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                                &nbsp;</td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldSpecialLeave" runat="server" 
                                    ControlToValidate="txtSpecialLeave" Display="None" 
                                    ErrorMessage="Required: Special Leave" ValidationGroup="LeaveBalance"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSpecialLeave_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldSpecialLeave" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldSickLeave" runat="server" 
                                    ControlToValidate="txtSickLeave" Display="None" 
                                    ErrorMessage="Required: Sick Leave" ValidationGroup="LeaveBalance"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSickLeave_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldSickLeave" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
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
                            </td>
                            <td>
                                <asp:HiddenField ID="hdFldEmpLeaveBalanceID" runat="server" />
                            </td>
                            <td>
                                <asp:Button ID="btnInsert" runat="server" CssClass="styled-button-1" 
                                    Text="Insert" ValidationGroup="LeaveBalance" />
                                &nbsp;<asp:Button ID="btnUpdate" runat="server" CssClass="styled-button-1" 
                                    Text="Update" ValidationGroup="LeaveBalance" />
                                &nbsp;<asp:Button ID="btnRefresh" runat="server" CssClass="styled-button-1" 
                                    Text="Refresh" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;</td>
                            <td>
                            </td>
                            <td>
                                &nbsp;
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
                    <div id="divgrd" onscroll="SetDivPosition()" style="max-height: 200px; max-width: 100%;
                        overflow: auto">
                        <asp:GridView ID="grdLeaveBalance" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
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
                                <asp:TemplateField HeaderText="Sick Leave">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSickLeave" runat="server" Text='<%# Bind("SickLeave") %>'></asp:Label>
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
