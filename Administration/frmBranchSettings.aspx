<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmBranchSettings.aspx.vb" Inherits="Administration_frmBranchSettings"
    Theme="CommonSkin" Title=".:m-HRM:Branch Settings:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlBranch" runat="server" SkinID="pnlInner" Width="80%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Branch Settings</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldBranchName" runat="server" 
                                    ControlToValidate="txtBranchName" Display="None" 
                                    ErrorMessage="Required: Branch Name" ValidationGroup="Branch"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldBranchName_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldBranchName" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldBranchLocation" runat="server" 
                                    ControlToValidate="txtBranchLocation" Display="None" 
                                    ErrorMessage="Required: Branch Location" ValidationGroup="Branch"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldBranchLocation_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldBranchLocation" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Branch Name
                            </td>
                            <td>
                                <asp:TextBox ID="txtBranchName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td>
                                Branch Location
                            </td>
                            <td>
                                <asp:TextBox ID="txtBranchLocation" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                                Active
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsActive" runat="server" Text=" YES" />
                            </td>
                            <td>
                                <asp:HiddenField ID="hdFldULCBranchID" runat="server" />
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
                                <asp:Button ID="btnInsert" runat="server" CssClass="styled-button-1" 
                                    Text="Insert" ValidationGroup="Branch" />
                                &nbsp;<asp:Button ID="btnUpdate" runat="server" CssClass="styled-button-1" 
                                    Text="Update" ValidationGroup="Branch" />
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
                <asp:Panel ID="pnlBranchList" runat="server" Width="80%" SkinID="pnlInner">
                    <div>
                        <asp:GridView ID="grdBranchList" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:TemplateField HeaderText="ULCBranchID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblULCBranchID" runat="server" Text='<%# Bind("ULCBranchID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Branch">
                                    <ItemTemplate>
                                        <asp:Label ID="lblULCBranchName" runat="server" Text='<%# Bind("ULCBranchName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBranchLocation" runat="server" Text='<%# Bind("BranchLocation") %>'></asp:Label>
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
                                <asp:TemplateField HeaderText="EntryDate">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntryDate" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
