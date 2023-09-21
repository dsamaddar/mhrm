<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmHRServiceRequest.aspx.vb" Inherits="EmployeeProfile_frmHRServiceRequest"
    Title=".:HRM:HR Service Request:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlHRServiceRequest" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="4">
                                <div class="widget-title">
                                    HR Service Request<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 250px">
                                <asp:RequiredFieldValidator ID="reqFldSelectHRServices" runat="server" ControlToValidate="drpHRServices"
                                    Display="None" ErrorMessage="Required: HR Services" ValidationGroup="HRServices"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldSelectHRServices_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldSelectHRServices" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldEffectiveDate" runat="server" ControlToValidate="txtEffectiveDate"
                                    Display="None" ErrorMessage="Required: Effective Date" ValidationGroup="HRServices"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldEffectiveDate_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldEffectiveDate" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Select Service
                            </td>
                            <td>
                                <asp:DropDownList ID="drpHRServices" runat="server" CssClass="InputTxtBox" Width="200px"
                                    AutoPostBack="True">
                                </asp:DropDownList>
                            </td>
                            <td rowspan="4">
                                <asp:Label ID="lblHRServiceReqInstruction" runat="server" CssClass="chkText" Height="109px"
                                    Width="316px"></asp:Label>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Effective Date
                            </td>
                            <td>
                                <asp:TextBox ID="txtEffectiveDate" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtEffectiveDate_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtEffectiveDate">
                                </cc1:CalendarExtender>
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
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldHRServiceRemarks" runat="server" ControlToValidate="txtRemarks"
                                    Display="None" ErrorMessage="Required: Remarks" ValidationGroup="HRServices"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldHRServiceRemarks_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldHRServiceRemarks" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" CssClass="styled-button-1" Text="Submit"
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
                <asp:Panel ID="pnlEmpWiseServiceRequest" runat="server" Width="100%" SkinID="pnlInner">
                    <div>
                        <asp:GridView ID="grdEmpWiseHRServices" runat="server" AutoGenerateColumns="False"
                            CssClass="mGrid">
                            <Columns>
                                <asp:TemplateField HeaderText="HRServiceIssueID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("HRServiceIssueID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="HRService">
                                    <ItemTemplate>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("HRService") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="EffectiveDate">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("EffectiveDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="RequestedOn">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("RequestedOn") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="HRRemarks">
                                    <ItemTemplate>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("HRRemarks") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="ServiceStatus">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("ServiceStatus") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("ServiceStatus") %>'></asp:Label>
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
