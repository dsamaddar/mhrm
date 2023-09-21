<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmHRServicesReport.aspx.vb" Inherits="frmHRServicesReport" Title=".:HRM:HR-Services Report:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
            </td>
            <td>
                <asp:Panel ID="pnlHRServiceReportParam" runat="server" Width="70%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="6">
                                <div class="widget-title">
                                    HR-Services Report</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Employee List
                            </td>
                            <td>
                                <asp:DropDownList ID="drpUserList" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
                                Service Provided
                            </td>
                            <td>
                                <asp:DropDownList ID="drpIsServiceProvided" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem>N\A</asp:ListItem>
                                    <asp:ListItem Value="1">YES</asp:ListItem>
                                    <asp:ListItem Value="0">NO</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Service List
                            </td>
                            <td>
                                <asp:DropDownList ID="drpHRServices" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
                                Service Status
                            </td>
                            <td>
                                <asp:DropDownList ID="drpServiceStatus" runat="server" CssClass="InputTxtBox">
                                    <asp:ListItem>N\A</asp:ListItem>
                                    <asp:ListItem>Requested</asp:ListItem>
                                    <asp:ListItem>Provided</asp:ListItem>
                                    <asp:ListItem>Rejected</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                            </td>
                            <td>
                                <asp:Button ID="btnShowReport" runat="server" CssClass="styled-button-1" Text="Show Report" />
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
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
                <div style="max-height: 500px; max-width: 100%; overflow: auto">
                    <asp:GridView ID="grdHRServicesReport" runat="server" AutoGenerateColumns="False"
                        CssClass="mGrid" EmptyDataText="No Support Found" Font-Size="Smaller">
                        <Columns>
                            <asp:TemplateField HeaderText="SL.No">
                                <ItemTemplate>
                                    <font style="font-size: 12px">
                                        <%#CType(Container, GridViewRow).RowIndex + 1%>
                                    </font>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="HRService">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("HRService") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Employee">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
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
                            <asp:TemplateField HeaderText="S.Provided">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("IsServiceProvided") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="S.Provider">
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("ServiceProvider") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="S.P.Remarks">
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("ServiceProviderRemarks") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ServingDate">
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("ServingDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IsRejected">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox9" runat="server" Text='<%# Bind("IsRejected") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("IsRejected") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RejectedBy">
                                <ItemTemplate>
                                    <asp:Label ID="Label10" runat="server" Text='<%# Bind("RejectedBy") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RejectionRemarks">
                                <ItemTemplate>
                                    <asp:Label ID="Label11" runat="server" Text='<%# Bind("RejectionRemarks") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="RejectionDate">
                                <ItemTemplate>
                                    <asp:Label ID="Label12" runat="server" Text='<%# Bind("RejectionDate") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ServiceStatus">
                                <ItemTemplate>
                                    <asp:Label ID="Label13" runat="server" Text='<%# Bind("ServiceStatus") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
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
