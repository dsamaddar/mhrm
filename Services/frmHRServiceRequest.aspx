<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmHRServiceRequest.aspx.vb" Inherits="frmHRServiceRequest" Title=".:HRM: HR-Service Request:." %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                &nbsp;
            </td>
            <td>
                <asp:Panel ID="pnlHRServiceRequests" runat="server" Width="70%" SkinID="pnlInner">
                    <table width="100%">
                        <tr align="left">
                            <td>
                                <div class="widget-title" style="max-width: 100%">
                                    HR Service Request<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                <div style="max-height: 300px; max-width: 100%; overflow: auto">
                                    <asp:GridView ID="grdHRServiceRequest" runat="server" CssClass="mGrid" 
                                        AutoGenerateColumns="False" EmptyDataText="No Service Request Available">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                        Text="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="HRServiceIssueID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblHRServiceIssueID" runat="server" Text='<%# Bind("HRServiceIssueID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee" />
                                            <asp:BoundField DataField="HRService" HeaderText="Service" />
                                            <asp:BoundField DataField="EffectiveDate" HeaderText="EffectiveDate" />
                                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                            <asp:BoundField DataField="RequestedOn" HeaderText="RequestedOn" />
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
                <asp:Panel ID="pnlProvideService" runat="server" SkinID="pnlInner" Width="70%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td style="width:50px">
                            </td>
                            <td style="width:150px">
                            </td>
                            <td>
                                <asp:HiddenField ID="hdFldServiceIssueID" runat="server" />
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
                                <asp:TextBox ID="txtServiceRemarks" CssClass="InputTxtBox" runat="server" 
                                    Height="50px" TextMode="MultiLine" Width="250px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldServiceRemarks" runat="server" 
                                    ControlToValidate="txtServiceRemarks" Display="None" 
                                    ErrorMessage="Required: Remarks" ValidationGroup="ProvideService"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldServiceRemarks_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldServiceRemarks" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
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
                                <asp:Button ID="btnServiceProvided" runat="server" CssClass="styled-button-1" 
                                    Text="Service Provided" ValidationGroup="ProvideService" />
                                &nbsp;<asp:Button ID="btnRejectRequest" runat="server" CssClass="styled-button-1"
                                    Text="Reject" ValidationGroup="ProvideService" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                    CssClass="styled-button-1" />
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
