<%@ Page Language="VB" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    Theme="CommonSkin" AutoEventWireup="false" CodeFile="frmIssueLetter.aspx.vb"
    Inherits="EmployeeProfile_frmIssueLetter" Title=".:MHRM:Issue Letter:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="left">
            <td>
                <asp:Panel ID="pnlUploadLetters" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="6">
                                <div class="widgettitle">
                                    Document Upload</div>
                                <asp:ScriptManager ID="ScriptManager1" runat="server">
                                </asp:ScriptManager>
                                <asp:Label ID="lblHolder" runat="server" Text="" Visible="false"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                            <td style="width: 150px" class="label">
                                &nbsp;
                            </td>
                            <td style="width: 230px">
                                &nbsp;
                            </td>
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                            <td style="width: 150px">
                                &nbsp;
                            </td>
                            <td style="width: 230px">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                            <td style="width: 150px" class="label">
                                Category Of Document <span class="RequiredLabel">*</span>
                            </td>
                            <td style="width: 230px">
                                <asp:DropDownList ID="drpDocumentType" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 20px">
                                &nbsp;
                            </td>
                            <td style="width: 150px">
                                &nbsp;
                            </td>
                            <td style="width: 230px">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                                Issue For <span class="RequiredLabel">*</span>
                            </td>
                            <td style="width: 200px">
                                <asp:TextBox ID="txtFileName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldfileName" runat="server" ControlToValidate="txtFileName"
                                    ErrorMessage="File Title Required" ValidationGroup="IssueLetter" Display="None"></asp:RequiredFieldValidator><cc1:ValidatorCalloutExtender
                                        ID="reqFldfileName_ValidatorCalloutExtender" runat="server" Enabled="True" TargetControlID="reqFldfileName"
                                        CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                    </cc1:ValidatorCalloutExtender>
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                                &nbsp;
                            </td>
                            <td style="width: 200px">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td class="label">
                                Issue Date<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtIssueDate" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtIssueDate_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtIssueDate">
                                </cc1:CalendarExtender>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldIssueDate" runat="server" ControlToValidate="txtIssueDate"
                                    ErrorMessage="Issue Date Required" ValidationGroup="IssueLetter" Display="None"></asp:RequiredFieldValidator><cc1:ValidatorCalloutExtender
                                        ID="reqFldIssueDate_ValidatorCalloutExtender" runat="server" Enabled="True" TargetControlID="reqFldIssueDate"
                                        CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                    </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Effective Date<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEffectiveDate" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtEffectiveDate_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtEffectiveDate">
                                </cc1:CalendarExtender>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldEffectiveDate" runat="server" ControlToValidate="txtEffectiveDate"
                                    Display="None" ErrorMessage="Effective Date Required" ValidationGroup="IssueLetter"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldEffectiveDate_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldEffectiveDate" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td class="label">
                                Details<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldRemarks" runat="server" ControlToValidate="txtRemarks"
                                    Display="None" ErrorMessage="Details Required" ValidationGroup="IssueLetter"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldRemarks_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldRemarks" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Select File<span class="RequiredLabel">*</span>
                            </td>
                            <td>
                                <asp:FileUpload ID="flupFile" runat="server" Width="200px" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnUploadDocuments" runat="server" CssClass="styled-button-1" Text="Upload"
                                    ValidationGroup="IssueLetter" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
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
        <tr align="left">
            <td>
            </td>
        </tr>
        <tr align="left">
            <td>
                <asp:Panel ID="pnlIssuedLetters" runat="server" Width="100%" SkinID="pnlInner">
                    <div class="widgettitle">
                        Issued File/Documents</div>
                    <div style="max-height: 250px; max-width: 100%; overflow: auto;">
                        <asp:GridView ID="grdIssuedLetters" runat="server" AutoGenerateColumns="False" CssClass="mGrid"
                            SkinID="grdNoFooter">
                            <Columns>
                                <asp:TemplateField HeaderText="DocumentID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDocumentID" runat="server" Text='<%# Bind("DocumentID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="DocTypeID" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDocTypeID" runat="server" Text='<%# Bind("DocTypeID") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Category">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDocTypeName" runat="server" Text='<%# Bind("DocTypeName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Document" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDocumentName" runat="server" Text='<%# Bind("DocumentName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Issue For">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFileName" runat="server" Text='<%# Bind("FileName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Issue Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIssueDate" runat="server" Text='<%# Bind("IssueDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Effective Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEffectiveDate" runat="server" Text='<%# Bind("EffectiveDate") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="View" ShowHeader="true">
                                    <ItemTemplate>
                                        <asp:HyperLink ID="hpDocument" runat="server" CssClass="linkbtn" NavigateUrl='<%# ConfigurationManager.AppSettings("OutputEHRMFiles")+ Eval("DocumentName") %>'
                                            Target="_blank">View</asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnDelete" Height="20px" ImageUrl="~/Sources/images/erase.png"
                                            OnClientClick="if (!confirm('Are you Sure to Delete The Document ?')) return false"
                                            CommandName="Delete" runat="server" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr align="left">
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
