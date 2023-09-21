<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmInputAttendance.aspx.vb" Inherits="Attendance_frmInputAttendance"
    Title=".:MHRM:Manual Att Input:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlEmpInputAttendance" runat="server" SkinID="pnlInner" Width="100%">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Attendance Report<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 320px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Select Employee
                            </td>
                            <td>
                                <asp:DropDownList ID="drpUserList" runat="server" CssClass="InputTxtBox" Width="200px"
                                    AutoPostBack="True">
                                </asp:DropDownList>
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
                                Attendance Date (MM/DD/YYYY)
                            </td>
                            <td class="label">
                                <asp:TextBox ID="txtAttendanceDate" runat="server" CssClass="InputTxtBox" 
                                    Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtAttendanceDate_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtAttendanceDate">
                                </cc1:CalendarExtender>
                                &nbsp;<asp:DropDownList ID="drpAHour" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                    <asp:ListItem>6</asp:ListItem>
                                    <asp:ListItem>7</asp:ListItem>
                                    <asp:ListItem>8</asp:ListItem>
                                    <asp:ListItem>9</asp:ListItem>
                                    <asp:ListItem>10</asp:ListItem>
                                    <asp:ListItem>11</asp:ListItem>
                                    <asp:ListItem>12</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpAMin" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem>00</asp:ListItem>
                                    <asp:ListItem>10</asp:ListItem>
                                    <asp:ListItem>20</asp:ListItem>
                                    <asp:ListItem>30</asp:ListItem>
                                    <asp:ListItem>40</asp:ListItem>
                                    <asp:ListItem>50</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpAAMPM" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem>AM</asp:ListItem>
                                    <asp:ListItem>PM</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                <asp:RequiredFieldValidator ID="reqFldAttendanceDate" runat="server" ControlToValidate="txtAttendanceDate"
                                    Display="None" ErrorMessage="" ValidationGroup="InputAtt"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldAttendanceDate_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldAttendanceDate" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                <asp:CompareValidator ID="dateValidateAttendanceDate0" runat="server" ControlToValidate="txtAttendanceDate"
                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date" ValidationGroup="InputAtt"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                To Date (MM/DD/YYYY)
                            </td>
                            <td class="label">
                                <asp:TextBox ID="txtAttendanceDateTo" runat="server" CssClass="InputTxtBox"
                                    Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtAttendanceDateTo_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtAttendanceDateTo">
                                </cc1:CalendarExtender>
                            </td>
                            <td class="label">
                                <asp:RequiredFieldValidator ID="reqFldAttendanceDateTo" runat="server" ControlToValidate="txtAttendanceDateTo"
                                    Display="None" ErrorMessage="" ValidationGroup="InputAtt"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldAttendanceDateTo_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldAttendanceDateTo" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                                <asp:CompareValidator ID="dateValidateAttendanceDateTo" runat="server" ControlToValidate="txtAttendanceDateTo"
                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date" ValidationGroup="InputAtt"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                                &nbsp;
                            </td>
                            <td class="label">
                                Ideal Date Log In Time
                            </td>
                            <td class="label">
                                <asp:DropDownList ID="drpIHour" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                    <asp:ListItem>6</asp:ListItem>
                                    <asp:ListItem>7</asp:ListItem>
                                    <asp:ListItem>8</asp:ListItem>
                                    <asp:ListItem>9</asp:ListItem>
                                    <asp:ListItem>10</asp:ListItem>
                                    <asp:ListItem>11</asp:ListItem>
                                    <asp:ListItem>12</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpIMin" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem>00</asp:ListItem>
                                    <asp:ListItem>10</asp:ListItem>
                                    <asp:ListItem>20</asp:ListItem>
                                    <asp:ListItem>30</asp:ListItem>
                                    <asp:ListItem>40</asp:ListItem>
                                    <asp:ListItem>50</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpIAMPM" runat="server" CssClass="InputTxtBox" Width="50px">
                                    <asp:ListItem>AM</asp:ListItem>
                                    <asp:ListItem>PM</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                            </td>
                            <td class="label">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Remarks
                            </td>
                            <td class="label">
                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="250px"></asp:TextBox>
                            </td>
                            <td class="label">
                                <asp:RequiredFieldValidator ID="reqFldRemarks" runat="server" ControlToValidate="txtRemarks"
                                    Display="None" ErrorMessage="Required: Remarks" ValidationGroup="InputAtt"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldRemarks_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldRemarks" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td class="label">
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Upload Reference
                            </td>
                            <td class="label">
                                <asp:FileUpload ID="flupFile" runat="server" />
                            </td>
                            <td>
                            </td>
                            <td class="label">
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnInputAtt" runat="server" CssClass="styled-button-1" Text="Submit"
                                    ValidationGroup="InputAtt" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
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
                <div style="max-height: 400px; max-width: 100%; overflow: auto">
                    <asp:GridView ID="grdUserAttendance" runat="server" CssClass="mGrid" AutoGenerateColumns="False">
                        <Columns>
                            <asp:TemplateField HeaderText="UserAttendanceID" Visible="False">
                                <ItemTemplate>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("UserAttendanceID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UserID">
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("UserID") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="LogTime">
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("LogTime") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IdealLogTime">
                                <ItemTemplate>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("IdealLogTime") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EmpCode">
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("EmpCode") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Remarks">
                                <ItemTemplate>
                                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("Remarks") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Department">
                                <ItemTemplate>
                                    <asp:Label ID="Label7" runat="server" Text='<%# Bind("Department") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Designation">
                                <ItemTemplate>
                                    <asp:Label ID="Label8" runat="server" Text='<%# Bind("Designation") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Branch">
                                <ItemTemplate>
                                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("Branch") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Reference">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hpDocument" runat="server" CssClass="linkbtn" NavigateUrl='<%# ConfigurationManager.AppSettings("OutputEHRMFiles")+ Eval("DocumentReference") %>'
                                        Target="_blank">View</asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </td>
        </tr>
        <tr align="center">
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
