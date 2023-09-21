<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmOutOfOfficePendingReqApproval.aspx.vb" Inherits="EmployeeProfile_frmOutOfOfficePendingReqApproval"
    Title=".:HRM:Out Of Office Request Approval:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlRequestList" runat="server" SkinID="pnlInner">
                    <table style="width: 100%">
                        <tr align="left">
                            <td>
                                <div class="widget-title">
                                    Out Of Office Pending Req<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                <div style="max-height: 300px; max-width: 100%; overflow: auto">
                                    <asp:GridView ID="grdOutOfOfficeRequest" runat="server" CssClass="mGrid" AutoGenerateColumns="False"
                                        EmptyDataText="NO REQUEST AVAILABLE">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                        CssClass="chkText" Text="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="OutOfOfficeReqID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblOutOfOfficeReqID" runat="server" Text='<%# Bind("OutOfOfficeReqID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Employee">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Cause" HeaderText="Cause" />
                                            <asp:BoundField DataField="DateFrom" HeaderText="DateFrom" />
                                            <asp:BoundField DataField="DateTo" HeaderText="DateTo" />
                                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                            <asp:TemplateField HeaderText="Attachment">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="hpDocument" runat="server" CssClass="linkbtn" NavigateUrl='<%#"~/Attachments/"+ Eval("Attachment") %>'
                                                        Target="_blank">View</asp:HyperLink>
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
            <td>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlReqApproval" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width: 200px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Remarks
                            </td>
                            <td>
                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="250px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldRemarks" runat="server" ControlToValidate="txtRemarks"
                                    Display="None" ErrorMessage="Required: Remarks" 
                                    ValidationGroup="ApproveReq"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldRemarks_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldRemarks" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
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
                                <asp:Button ID="btnApprove" runat="server" CssClass="styled-button-1" Text="Approve"
                                    ValidationGroup="ApproveReq" />
                                &nbsp;<asp:Button ID="btnReject" runat="server" CssClass="styled-button-1" 
                                    Text="Reject" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="styled-button-1" />
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
            </td>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
