<%@ Page Language="VB" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmEmployeeLeaveManagement.aspx.vb" Inherits="EmployeeProfile_frmEmployeeLeaveManagement"
    Title="::Employee Leave Management::" Theme="CommonSkin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table width="100%">
        <tr id="idRecommendation" runat="server">
            <td>
                <asp:Panel ID="pnlRecommendation" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <div class="widgettitle">
                                    Recommendation<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblHolder" runat="server" Text="" Visible="false"></asp:Label>
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
                                            <asp:TemplateField HeaderText="LeaveTypeID" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLeaveTypeIDRecom" runat="server" Text='<%# Bind("LeaveTypeID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="LeaveType" HeaderText="Leave Type" ReadOnly="True" />
                                            <asp:TemplateField HeaderText="Employee" SortExpression="EmployeeName">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("EmployeeName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Leave From" SortExpression="LeaveFrom">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("LeaveFrom") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Leave To" SortExpression="LeaveTo">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("LeaveTo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Days" SortExpression="TotalDays">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("TotalDays") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="TotalWorkingDays" HeaderText="Total Working Days" ReadOnly="True" />
                                            <asp:TemplateField HeaderText="Attachment" ShowHeader="true">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="hpDocument" runat="server" CssClass="linkbtn" NavigateUrl='<%# ConfigurationManager.AppSettings("OutputEHRMFiles")+ Eval("Attachment") %>'
                                                        Target="_blank">View</asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="PurposeOfLeave" HeaderText="Purpose Of Leave" ReadOnly="True" />
                                            <asp:BoundField DataField="EmergencyAddress" HeaderText="Address" ReadOnly="True" />
                                            <asp:BoundField DataField="EmergencyContactNo" HeaderText="Contact No" ReadOnly="True" />
                                            <asp:BoundField DataField="EntryDate" HeaderText="Requested Date" ReadOnly="True" />
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
                                            Recommendation Remarks
                                        </td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtRecommendationRemarks" runat="server" TextMode="MultiLine" Width="250px"
                                                CssClass="InputTxtBox" Height="50px">N\A</asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="reqFldRecommendationRemarks" runat="server" ControlToValidate="txtRecommendationRemarks"
                                                Display="None" ErrorMessage="Required: Recommendation Remarks" ValidationGroup="LeaveRecommendation"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="reqFldRecommendationRemarks_ValidatorCalloutExtender"
                                                runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                                Enabled="True" TargetControlID="reqFldRecommendationRemarks" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                            </cc1:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnRecommendedLeave" runat="server" CssClass="styled-button-1" OnClientClick="return confirm('Are you sure you want to Recommend selected items?');"
                                    Text="Recommend" ValidationGroup="LeaveRecommendation" />
                                &nbsp;
                                <asp:Button ID="btnRecommendedReject" runat="server" CssClass="styled-button-1" OnClientClick="return confirm('Are you sure you want to Reject selected items?');"
                                    Text="Reject" ValidationGroup="LeaveRecommendation" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr id="idApprovalList" runat="server">
            <td>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlApprovalList" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <div class="widgettitle">
                                    Approval List</div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="max-height: 200px; max-width: 100%; overflow: auto">
                                    <div style="max-height: 100%; max-width: 100%; overflow: auto;">
                                        <asp:GridView ID="grdLeaveApproval" runat="server" AutoGenerateColumns="False" CellPadding="0"
                                            DataKeyNames="LeaveRequestID" EmptyDataText="No Records Available" Font-Names="Arial"
                                            Font-Size="12px" PageSize="20" CssClass="mGrid">
                                            <Columns>
                                                <asp:TemplateField HeaderText="LeaveRequestID" Visible="False">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblLeaveRequestID" runat="server" Text='<%# Bind("LeaveRequestID") %>'></asp:Label></ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Select">
                                                    <HeaderTemplate>
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chkSelect" runat="server" /></ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Leave Type ID" Visible="false">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblLeaveTypeIDApp" runat="server" Text='<%# Bind("LeaveTypeID") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="LeaveType" HeaderText="Leave Type" />
                                                <asp:BoundField DataField="EmployeeName" HeaderText="Employee" />
                                                <asp:BoundField DataField="LeaveFrom" HeaderText="Leave From" />
                                                <asp:BoundField DataField="LeaveTo" HeaderText="Leave To" />
                                                <asp:BoundField DataField="TotalDays" HeaderText="Total Days" />
                                                <asp:BoundField DataField="TotalWorkingDays" HeaderText="Total Working Days" />
                                                <asp:TemplateField HeaderText="Attachment" ShowHeader="true">
                                                    <ItemTemplate>
                                                        <asp:HyperLink ID="hpDocument" runat="server" CssClass="linkbtn" NavigateUrl='<%# ConfigurationManager.AppSettings("OutputEHRMFiles")+ Eval("Attachment") %>'
                                                            Target="_blank">View</asp:HyperLink>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="PurposeOfLeave" HeaderText="Purpose Of Leave" ReadOnly="True" />
                                                <asp:BoundField DataField="EmergencyAddress" HeaderText="Address" ReadOnly="True" />
                                                <asp:BoundField DataField="EmergencyContactNo" HeaderText="Contact No" ReadOnly="True"
                                                    SortExpression="EmergencyContactNo" />
                                                <asp:BoundField DataField="EntryDate" HeaderText="Requested Date" ReadOnly="True"
                                                    SortExpression="EntryDate" />
                                                <asp:BoundField DataField="LeaveBalance" HeaderText="LeaveBalance" />
                                            </Columns>
                                        </asp:GridView>
                                    </div>
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
                                            Approver Remarks
                                        </td>
                                        <td style="width: 250px">
                                            <asp:TextBox ID="txtApproverRemarks" runat="server" TextMode="MultiLine" Width="250px"
                                                CssClass="InputTxtBox" Height="50px">N\A</asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="reqFldApproverRemarks" runat="server" ControlToValidate="txtApproverRemarks"
                                                Display="None" ErrorMessage="Required: Approver Remarks" ValidationGroup="LeaveApprove"></asp:RequiredFieldValidator>
                                            <cc1:ValidatorCalloutExtender ID="reqFldApproverRemarks_ValidatorCalloutExtender"
                                                runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                                Enabled="True" TargetControlID="reqFldApproverRemarks" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                            </cc1:ValidatorCalloutExtender>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnLeaveApproval" runat="server" CssClass="styled-button-1" OnClientClick="return confirm('Are you sure you want to Approve selected items?');"
                                    Text="Approved" ValidationGroup="LeaveApprove" />
                                &nbsp;
                                <asp:Button ID="btnLeaveApprovalReject" runat="server" CssClass="styled-button-1"
                                    EnableTheming="True" OnClientClick="return confirm('Are you sure you want to Reject selected items?');"
                                    Text="Reject" ValidationGroup="LeaveApprove" />
                            </td>
                        </tr>
                        <tr>
                            <td>
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
        <tr>
            <td>
                <asp:Panel ID="pnlApprovedLeaveRejectionReq" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td class="widget-title">
                                Approved Leave Rejection Request
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="max-height: 200px; max-width: 100%; overflow: auto">
                                    <asp:GridView ID="grdPendingAppLvRejReq" runat="server" AutoGenerateColumns="False"
                                        CssClass="mGrid">
                                        <Columns>
                                            <asp:CommandField ShowSelectButton="True" />
                                            <asp:TemplateField HeaderText="AppLeaveRejectionID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAppLeaveRejectionID" runat="server" Text='<%# Bind("AppLeaveRejectionID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="LeaveRequestID" HeaderText="LeaveRequestID" Visible="False" />
                                            <asp:BoundField DataField="Employee" HeaderText="Employee" />
                                            <asp:BoundField DataField="RequestedOn" HeaderText="RequestedOn" />
                                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                                            <asp:BoundField DataField="PrevDetails" HeaderText="PrevDetails" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtRemarksAppLvRejReq" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="250px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldRemarksAppLvRejReq" runat="server" ControlToValidate="txtRemarksAppLvRejReq"
                                    ErrorMessage="*" ValidationGroup="AppLvRejReq"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnApproveAppLvRejReq" runat="server" CssClass="styled-button-1"
                                    Text="Approve" ValidationGroup="AppLvRejReq" />
                                &nbsp;<asp:Button ID="btnRejectAppLvRejReq" runat="server" CssClass="styled-button-1"
                                    Text="Reject" ValidationGroup="AppLvRejReq" />
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
        <tr>
            <td>
                <asp:Panel ID="pnlLeaveRequest" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <div class="widgettitle">
                                    Leave Request</div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="Panel4" runat="server" SkinID="pnlInner">
                                    <table width="100%">
                                        <tr align="left">
                                            <td style="width: 20px;">
                                            </td>
                                            <td style="width: 150px;">
                                            </td>
                                            <td colspan="4">
                                                <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td class="label ">
                                                Leave Type
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlLeaveTypeForRequest" runat="server" CssClass="InputTxtBox "
                                                    Width="200px">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td class="label ">
                                                Date From
                                            </td>
                                            <td>
                                                <asp:TextBox ID="dtLeaveRequestDateFrom" runat="server" Width="80px" CssClass="InputTxtBox"></asp:TextBox>
                                                <cc1:CalendarExtender ID="dtLeaveRequestDateFrom_CalendarExtender" runat="server"
                                                    Enabled="True" TargetControlID="dtLeaveRequestDateFrom">
                                                </cc1:CalendarExtender>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="dtLeaveRequestDateFrom"
                                                    ErrorMessage="*" ValidationGroup="SubmitDate"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                            </td>
                                            <td>
                                                Date To
                                            </td>
                                            <td>
                                                <asp:TextBox ID="dtLeaveRequestDateTo" runat="server" Width="80px" CssClass="InputTxtBox"></asp:TextBox>
                                                <cc1:CalendarExtender ID="dtLeaveRequestDateTo_CalendarExtender" runat="server" Enabled="True"
                                                    TargetControlID="dtLeaveRequestDateTo">
                                                </cc1:CalendarExtender>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="dtLeaveRequestDateTo"
                                                    ErrorMessage="*" ValidationGroup="SubmitDate"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td class="label " valign="top">
                                                Purpose
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPurpose" runat="server" CssClass="InputTxtBox " Width="200px"
                                                    Height="45px" TextMode="MultiLine"></asp:TextBox>
                                                &nbsp;
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtPurpose"
                                                    ErrorMessage="*" ValidationGroup="SubmitDate"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                            </td>
                                            <td colspan="2">
                                                <asp:Button ID="btnCalWorkDay" runat="server" ValidationGroup="SubmitDate" Text="Calculate Working Days & Add"
                                                    CssClass="styled-button-1 " />
                                            </td>
                                        </tr>
                                        <tr id="idLabel" runat="server">
                                            <td id="Td1" colspan="2" style="background-color: #0A50A1;" runat="server">
                                                <asp:Label ID="Label1" runat="server" Font-Size="10pt" ForeColor="Yellow" Font-Names="verdana"
                                                    Text="Total Applied: "></asp:Label>
                                                <asp:Label ID="lblTAplidcnt" runat="server" Font-Size="10pt" ForeColor="Yellow" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td id="Td2" colspan="2" style="background-color: #0A50A1;" runat="server">
                                                <asp:Label ID="lblWorkingDay" runat="server" Font-Size="10pt" ForeColor="Yellow"
                                                    Font-Names="verdana" Text="Working Day: "></asp:Label>
                                                <asp:Label ID="lblWorkDycnt" runat="server" Font-Size="10pt" ForeColor="Yellow" Font-Names="verdana"></asp:Label>
                                            </td>
                                            <td id="Td3" style="background-color: #0A50A1;" colspan="2" runat="server">
                                                <asp:Label ID="lblHoliday" runat="server" Font-Size="10pt" ForeColor="Yellow" Font-Names="verdana"
                                                    Text="Holiday: "></asp:Label>
                                                <asp:Label ID="lblHlidayCnt" runat="server" Font-Size="10pt" ForeColor="Yellow" Font-Names="verdana"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20px;">
                                            </td>
                                            <td style="width: 150px;">
                                            </td>
                                            <td style="width: 230px;">
                                            </td>
                                            <td style="width: 20px;">
                                            </td>
                                            <td style="width: 150px;">
                                            </td>
                                            <td style="width: 230px;">
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="pnlLeaveReq" runat="server" SkinID="pnlInner">
                                    <table align="center" width="100%">
                                        <tr align="center">
                                            <td>
                                                <asp:GridView ID="grdCalculationDay" runat="server" AutoGenerateColumns="False" CssClass="mGrid"
                                                    SkinID="grdNoFooter" Width="100%">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Sl">
                                                            <ItemTemplate>
                                                                <font style="font-size: 12px"><b>
                                                                    <%#CType(Container, GridViewRow).RowIndex + 1%></b> </font>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Leave From">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLeaveFrom" runat="server" Text='<%#Eval("LeaveFrom", "{0:D}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Leave To">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblLeaveTo" runat="server" Text='<%#Eval("LeaveTo", "{0:D}") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Total Applied Days">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTotalDays0" runat="server" Text='<%#Eval("TotalDays") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Working Days">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTotalWorkingDays0" runat="server" Text='<%#Eval("TotalWorkingDays") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="PurposeOfLeave">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPurposeOfLeave" runat="server" Text='<%#Eval("PurposeOfLeave") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Delete">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imgDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                                                    ImageUrl="~/Sources/images/erase.png" OnClientClick="return confirm('Are You Sure You Want to Delete?')"
                                                                    Width="20" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr align="center">
                            <td>
                                <asp:Panel ID="Panel5" SkinID="pnlInner" runat="server">
                                    <table width="100%">
                                        <tr>
                                            <td align="left" colspan="6">
                                                <div class="widgettitle">
                                                    Emergency Contact Information</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" style="width: 20px;">
                                            </td>
                                            <td align="center" style="width: 150px;">
                                            </td>
                                            <td align="center" style="width: 230px;">
                                            </td>
                                            <td align="center" style="width: 20px;">
                                            </td>
                                            <td align="center" style="width: 150px;">
                                            </td>
                                            <td align="center" style="width: 230px;">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td align="left" class="label ">
                                                Address
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtAddress" runat="server" CssClass="InputTxtBox" Height="38px"
                                                    TextMode="MultiLine" Width="200px"></asp:TextBox>
                                                &nbsp;
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtAddress"
                                                    ErrorMessage="*" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                                            </td>
                                            <td>
                                            </td>
                                            <td align="left" class="label">
                                                Attachment
                                            </td>
                                            <td align="left">
                                                <asp:FileUpload ID="flUpAttachment" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td class="label " align="left">
                                                Email
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtEmail" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                                &nbsp;
                                                <asp:RegularExpressionValidator ID="regExpEmailAddress" runat="server" ControlToValidate="txtEmail"
                                                    ErrorMessage="Input Correct E-mail Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                    ValidationGroup="Submit"></asp:RegularExpressionValidator>
                                            </td>
                                            <td>
                                            </td>
                                            <td align="left" class="label ">
                                                Phone No
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtPhoneNo" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                                                &nbsp;
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtPhoneNo"
                                                    ErrorMessage="*" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr align="center">
                            <td>
                                <asp:Panel ID="Panel6" runat="server" SkinID="pnlInner">
                                    <table width="100%">
                                        <tr>
                                            <td style="width: 20px">
                                            </td>
                                            <td align="left" class="label " style="width: 150px">
                                                Approver :
                                            </td>
                                            <td align="left" style="width: 230px">
                                                <asp:Label ID="lblApprover" runat="server" CssClass="label"></asp:Label>
                                                <asp:Label ID="lblApproverID" runat="server" Visible="False"></asp:Label>
                                            </td>
                                            <td style="width: 20px">
                                            </td>
                                            <td class="label " style="width: 150px">
                                                Recommender :
                                            </td>
                                            <td align="left" style="width: 230px">
                                                <asp:Label ID="lblRecommender" runat="server" CssClass="label"></asp:Label>
                                                <asp:Label ID="lblRecommenderID" runat="server" Visible="False"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Button ID="btnSubmitLeaveRequest" runat="server" CssClass="styled-button-1"
                                    Text="Submit" ValidationGroup="Submit" />
                                &nbsp;<asp:Button ID="btnLeaveRequestClear" runat="server" CssClass="styled-button-1"
                                    Text="Clear" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlApprovedLeave" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td colspan="6">
                                <div class="widgettitle">
                                    Approved Leave</div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label" style="width: 20px">
                            </td>
                            <td class="label" style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                                &#160;&#160;
                            </td>
                            <td style="width: 212px">
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label">
                            </td>
                            <td class="label">
                                Approval date from
                            </td>
                            <td>
                                <asp:TextBox ID="dtApprovedLeaveDateFrom" runat="server" CssClass="InputTxtBox" TabIndex="10"
                                    Width="100px"></asp:TextBox><cc1:CalendarExtender ID="dtApprovedLeaveDateFrom_CalendarExtender"
                                        runat="server" Enabled="True" TargetControlID="dtApprovedLeaveDateFrom">
                                    </cc1:CalendarExtender>
                                &#160;&#160;
                            </td>
                            <td>
                            </td>
                            <td class="label">
                                Approval date To
                            </td>
                            <td align="left">
                                <asp:TextBox ID="dtApprovedLeaveDateTo" runat="server" CssClass="InputTxtBox" TabIndex="10"
                                    Width="100px"></asp:TextBox><cc1:CalendarExtender ID="dtApprovedLeaveDateTo_CalendarExtender"
                                        runat="server" Enabled="True" TargetControlID="dtApprovedLeaveDateTo">
                                    </cc1:CalendarExtender>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &#160;&#160;
                            </td>
                            <td align="left" class="label">
                                Leave Type
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlLeaveTypeApproved" runat="server" CssClass="InputTxtBox "
                                    Width="200px">
                                </asp:DropDownList>
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
                                <asp:Button ID="btnSearchApprovedLeave" runat="server" CssClass="styled-button-1"
                                    Text="Search" />
                            </td>
                            <td>
                            </td>
                            <td>
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
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                            </td>
                            <td align="center" colspan="5">
                                <div style="max-width: 100%; max-height: 200px; overflow: auto">
                                    <asp:GridView ID="grdApprovedLeave" runat="server" AutoGenerateColumns="False" CellPadding="0"
                                        DataKeyNames="LeaveRequestID" EmptyDataText="No Records Available" Font-Names="Arial"
                                        Font-Size="12px" PageSize="20" CssClass="mGrid" ShowFooter="True">
                                        <Columns>
                                            <asp:TemplateField HeaderText="LeaveType">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("LeaveType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Leave From" SortExpression="LeaveFrom">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("LeaveFrom") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Leave To" SortExpression="LeaveTo">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("LeaveTo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Days" SortExpression="TotalDays">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalDays" runat="server" Text='<%# Bind("TotalDays") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Total Working Days" SortExpression="TotalWorkingDays">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotalWorkingDays" runat="server" Text='<%# Bind("TotalWorkingDays") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Requested Date" SortExpression="EntryDate">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Approved Date" SortExpression="ApprovalDate">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("ApprovalDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Purpose">
                                                <ItemTemplate>
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("PurposeOfLeave") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Attachment" ShowHeader="true">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="hpDocument" runat="server" CssClass="linkbtn" NavigateUrl='<%# ConfigurationManager.AppSettings("OutputEHRMFiles")+ Eval("Attachment") %>'
                                                        Target="_blank">View</asp:HyperLink>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="LeaveStatus">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLeaveStatus" runat="server" Text='<%# Bind("LeaveStatus") %>'></asp:Label>
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
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
