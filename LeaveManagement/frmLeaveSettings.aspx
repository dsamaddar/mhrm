<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmLeaveSettings.aspx.vb" Inherits="LeaveManagement_frmLeaveSettings"
    Title=".:HRM:Leave Settings:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlLeaveType" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="4" align="left">
                                <div class="widgettitle">
                                    Define Leave Type<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20px; height: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 300px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Leave Type
                            </td>
                            <td>
                                <asp:DropDownList ID="drpLeaveType" runat="server" CssClass="InputTxtBox" 
                                    Width="150px">
                                    <asp:ListItem>Annual Leave</asp:ListItem>
                                    <asp:ListItem>Casual Leave</asp:ListItem>
                                    <asp:ListItem>Leave Without Pay</asp:ListItem>
                                    <asp:ListItem>Maternity Leave</asp:ListItem>
                                    <asp:ListItem>Medical Leave</asp:ListItem>
                                    <asp:ListItem>Special Leave</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Applicable For
                            </td>
                            <td>
                                <asp:CheckBox ID="chkOnlyForMale" runat="server" Text="  Male" 
                                    CssClass="chkText" />
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
                                <asp:CheckBox ID="chkOnlyForFemale" runat="server" Text=" Female" 
                                    CssClass="chkText" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Is Deductible
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsDeductibleFromLeaveBalance" runat="server" CssClass="chkText"
                                    Text=" Is Deductible From Leave Balance" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Carry Forward
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsCarryForwardEnabled" runat="server" CssClass="chkText" 
                                    Text=" YES" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Yearly Forward
                            </td>
                            <td>
                                <asp:TextBox ID="txtYearlyForward" runat="server" CssClass="InputTxtBox">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldYearlyForward" runat="server" 
                                    ControlToValidate="txtYearlyForward" Display="None" 
                                    ErrorMessage="Required : Yearly Forward" ValidationGroup="LeaveType"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldYearlyForward_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldYearlyForward" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Max Balance
                            </td>
                            <td>
                                <asp:TextBox ID="txtMaxBalance" runat="server" CssClass="InputTxtBox">0</asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldMaxBalance" runat="server" 
                                    ControlToValidate="txtMaxBalance" Display="None" 
                                    ErrorMessage="Required : Max Balance" ValidationGroup="LeaveType"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldMaxBalance_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldMaxBalance" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Active</td>
                            <td>
                                <asp:CheckBox ID="chkIsLeaveTypeActive" runat="server" CssClass="chkText" 
                                    Text=" Is Active" Checked="True" />
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
                                <asp:Button ID="btnInsertLeaveType" runat="server" CssClass="styled-button-1" Text="Insert"
                                    ValidationGroup="LeaveType" />
                                &nbsp;
                                <asp:Button ID="btnUpdate" runat="server" CssClass="styled-button-1" Text="Update"
                                    ValidationGroup="LeaveType" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
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
                <asp:Panel ID="pnlAvailableLeaveType" runat="server" SkinID="pnlInner" 
                    Width="100%">
                    <table style="width: 100%;">
                        <tr align="center">
                            <td>
                                <div style="max-height: 300px; overflow: auto">
                                    <asp:GridView ID="grdLeaveType" runat="server" SkinID="grdNoFooter" AutoGenerateColumns="False"
                                        CssClass="mGrid">
                                        <Columns>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" CssClass="linkbtn" runat="server" CausesValidation="False"
                                                        CommandName="Select" Text="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="LeaveTypeID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLeaveTypeID" runat="server" Text='<%# Bind("LeaveTypeID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Leave Type">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("LeaveType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Only For Male">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("OnlyForMale") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Only For Female">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("OnlyForFemale") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Deductible From Leave">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" 
                                                        Text='<%# Bind("IsDedFrmLeaveBalance") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" 
                                                        Text='<%# Bind("IsDedFrmLeaveBalance") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="IsCarryForwardEnabled">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox2" runat="server" 
                                                        Text='<%# Bind("IsCarryForwardEnabled") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label7" runat="server" 
                                                        Text='<%# Bind("IsCarryForwardEnabled") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="YearlyBalanceForward">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox3" runat="server" 
                                                        Text='<%# Bind("YearlyBalanceForward") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label8" runat="server" 
                                                        Text='<%# Bind("YearlyBalanceForward") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="MaxBalance">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("MaxBalance") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("MaxBalance") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="IsActive">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("IsActive") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="EntryBy">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("EntryBy") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="EntryDate">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>
