<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmCancelLeaveRequest.aspx.vb" Inherits="EmployeeProfile_frmCancelLeaveRequest"
    Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="pnlRecommendation" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <div class="widgettitle">
                                    Cancel Leave Request<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="max-height: 100%; max-width: 100%; overflow: auto;">
                                    <asp:GridView ID="grdRecommendedLeave" runat="server" AutoGenerateColumns="False"
                                        CellPadding="0" CssClass="mGrid" DataKeyNames="LeaveRequestID" EmptyDataText="No Records Available"
                                        Font-Names="Arial" Font-Size="12px" PageSize="20">
                                        <Columns>
                                            <asp:TemplateField HeaderText="LeaveRequestID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLeaveRequestIDRecom" runat="server" Text='<%# Bind("LeaveRequestID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Select">
                                                <HeaderTemplate>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkSelectRecommend" runat="server" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Leave Type ID" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLeaveTypeIDRecom" runat="server" Text='<%# Bind("LeaveTypeID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="LeaveType" HeaderText="Leave Type" />
                                            <asp:BoundField DataField="LeaveFrom" HeaderText="Leave From" />
                                            <asp:BoundField DataField="LeaveTo" HeaderText="Leave To" />
                                            <asp:BoundField DataField="TotalDays" HeaderText="Total Days" />
                                            <asp:BoundField DataField="TotalWorkingDays" HeaderText="Total Working Days" ReadOnly="True"
                                                SortExpression="TotalWorkingDays" />
                                            <asp:BoundField DataField="PurposeOfLeave" HeaderText="Purpose Of Leave" ReadOnly="True"
                                                SortExpression="PurposeOfLeave" />
                                            <asp:BoundField DataField="EmergencyAddress" HeaderText="Address" ReadOnly="True"
                                                SortExpression="EmergencyAddress" />
                                            <asp:BoundField DataField="EmergencyContactNo" HeaderText="Contact No" ReadOnly="True"
                                                SortExpression="EmergencyContactNo" />
                                            <asp:BoundField DataField="EntryDate" HeaderText="Requested Date" ReadOnly="True"
                                                SortExpression="EntryDate" />
                                            <asp:BoundField DataField="LeaveBalance" HeaderText="LeaveBalance" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="100%">
                                    <tr align="left">
                                        <td style="width: 20px">
                                        </td>
                                        <td class="label" style="width: 200px">
                                            &nbsp;Remarks For Cancellation
                                        </td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtCancellationRemarks" runat="server" TextMode="MultiLine" Width="250px"
                                                CssClass="InputTxtBox" Height="50px">N\A</asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="reqFldCancellationRemarks" runat="server" ControlToValidate="txtCancellationRemarks"
                                                Display="None" ErrorMessage="Required: Leave Cancellation Remarks" ValidationGroup="LeaveCancellation"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="reqFldCancellationRemarks_ValidatorCalloutExtender"
                                                runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                                Enabled="True" TargetControlID="reqFldCancellationRemarks" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                            </cc1:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                    <tr align="left">
                                        <td style="width: 20px">
                                            &nbsp;
                                        </td>
                                        <td class="label" style="width: 200px">
                                            &nbsp;
                                        </td>
                                        <td style="width: 250px">
                                            <asp:Button ID="btnLeaveReqReject" runat="server" CssClass="styled-button-1" OnClientClick="return confirm('Are you sure you want to Reject selected items?');"
                                                Text="Reject" ValidationGroup="LeaveCancellation" />
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
