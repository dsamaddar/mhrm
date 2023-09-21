<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmDeptSettings.aspx.vb" Inherits="Administration_frmDeptSettings" Title=".:HRM:Dept. Settings:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlDepartmentSettings" runat="server" Width="80%" 
                    SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td align="left" class="label" colspan="4">
                                <div class="widgettitle">
                                    Department Settings<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label" style="width: 20px">
                            </td>
                            <td align="left" class="label">
                                <asp:HiddenField ID="hdFldDepartmentID" runat="server" />
                            </td>
                            <td align="left">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label" style="width: 20px">
                            </td>
                            <td align="left" class="label">
                                Department Name<span class="RequiredLabel">*</span>
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDepartmentName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldDepartmentName" runat="server" ControlToValidate="txtDepartmentName"
                                    Display="None" ErrorMessage="Required" ValidationGroup="InputDept"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDepartmentName_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldDepartmentName" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label" style="width: 20px">
                            </td>
                            <td align="left" class="label">
                                Dept Code</td>
                            <td align="left">
                                <asp:TextBox ID="txtDeptCode" runat="server" CssClass="InputTxtBox"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldDeptCode" runat="server" 
                                    ControlToValidate="txtDeptCode" Display="None" ErrorMessage="Required" 
                                    ValidationGroup="InputDept"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDeptCode_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldDeptCode" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                            </td>
                            <td align="left" class="label">
                                Is Active
                            </td>
                            <td align="left">
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="chkText" 
                                    Text="         Is Active  " />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td align="left">
                                <asp:Button ID="btnInsertDepartment" runat="server" CssClass="styled-button-1" 
                                    Text="Insert" ValidationGroup="InputDept" />
                                &nbsp;<asp:Button ID="btnUpdate" runat="server" CssClass="styled-button-1" 
                                    Text="Update" />
                                &nbsp;<asp:Button ID="btnCancelSelection" runat="server" CssClass="styled-button-1" 
                                    Text="Cancel" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                            </td>
                            <td align="left" class="label">
                            </td>
                            <td align="left">
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
                <asp:Panel ID="pnlExistingDepartment" runat="server" Width="80%" 
                    SkinID="pnlInner">
                    <div style="max-height: 400px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdDeptInfo" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DepartmentID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDepartmentID" runat="server" Text='<%# Bind("DepartmentID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Department">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDeptName" runat="server" Text='<%# Bind("DeptName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Code">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDeptCode" runat="server" Text='<%# Bind("DeptCode") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsActive">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="EntryBy" HeaderText="EntryBy" />
                                <asp:BoundField DataField="EntryDate" HeaderText="EntryDate" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
