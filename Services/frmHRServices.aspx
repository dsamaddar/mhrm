<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmHRServices.aspx.vb" Inherits="frmHRServices" Title=".:HRM:HR Services:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlHRServicesInput" runat="server" Width="60%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widget-title">
                                    HR Services Settings<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:HiddenField ID="hdFldHRServiceID" runat="server" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Service Title
                            </td>
                            <td>
                                <asp:TextBox ID="txtServiceTitle" runat="server" CssClass="InputTxtBox" Width="250px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldHRServiceTitle" runat="server" ControlToValidate="txtServiceTitle"
                                    Display="None" ErrorMessage="Required: Service Title" ValidationGroup="HRServices"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldHRServiceTitle_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldHRServiceTitle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Service Req. Instruction
                            </td>
                            <td>
                                <asp:TextBox ID="txtServiceReqInstruction" runat="server" CssClass="InputTxtBox"
                                    Height="50px" TextMode="MultiLine" Width="250px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldHRServiceReqInstruction" runat="server" ControlToValidate="txtServiceReqInstruction"
                                    Display="None" ErrorMessage="Required: Service Request Instruction" ValidationGroup="HRServices"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldHRServiceReqInstruction_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldHRServiceReqInstruction" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Is Active
                            </td>
                            <td>
                                <asp:CheckBox ID="chkIsActive" runat="server" CssClass="label" Text="(Check If YES)" />
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Sequence Priority
                            </td>
                            <td>
                                <asp:TextBox ID="txtSeqPriority" runat="server" CssClass="InputTxtBox" Width="50px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldSeqPriority" runat="server" ControlToValidate="txtSeqPriority"
                                    Display="None" ErrorMessage="Required: Sequence Priority" ValidationGroup="HRServices"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSeqPriority_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldSeqPriority" WarningIconImageUrl="~/Sources/images/Valwarning.png">
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
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" CssClass="styled-button-1" Text="Submit"
                                    ValidationGroup="HRServices" />
                                &nbsp;<asp:Button ID="btnUpdate" runat="server" CssClass="styled-button-1" Text="Update"
                                    ValidationGroup="HRServices" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
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
                <asp:Panel ID="pnlHRServiceList" runat="server" Width="70%" SkinID="pnlInner">
                    <div style="max-height: 300px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdHRServiceList" runat="server" AutoGenerateColumns="False" CssClass="mGrid"
                            EmptyDataText="No Data Found">
                            <Columns>
                                <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="Select"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="HRServiceID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblHRServiceID" runat="server" Text='<%# Bind("HRServiceID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="HRService">
                                    <ItemTemplate>
                                        <asp:Label ID="lblHRService" runat="server" Text='<%# Bind("HRService") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Service-Instruction">
                                    <ItemTemplate>
                                        <asp:Label ID="lblHRServiceReqInstruction" runat="server" Text='<%# Bind("HRServiceReqInstruction") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="IsActive">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsActive" runat="server" Text='<%# Bind("IsActive") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="SeqPriority">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSeqPriority" runat="server" Text='<%# Bind("SeqPriority") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="EntryBy" HeaderText="EntryBy" />
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
