<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmOutOfOfficeRequest.aspx.vb" Inherits="EmployeeProfile_frmOutOfOfficeRequest"
    Title=".:MHRM: Out Of Office Request:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%-- <script language="javascript" type="text/javascript">
    //this script will get the date selected from the given calendarextender (ie: "sender") and append the
    //current time to it.
    function AppendTime(sender, args) {
        var selectedDate = new Date();
        selectedDate = sender.get_selectedDate();
        var now = new Date();
        sender.get_element().value = selectedDate.format("dd/MM/yyyy") + " " + now.format("hh:mm tt");
    }
    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlOutOfOfficeReq" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="5">
                                <div class="widget-title">
                                    Out Of Office Request<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 350px">
                            </td>
                            <td style="width: 50px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 300px">
                                <asp:RequiredFieldValidator ID="reqFldDateFrom" runat="server" 
                                    ControlToValidate="txtDateFrom" Display="None" 
                                    ErrorMessage="Required: Date From" ValidationGroup="OutOfOfcReq"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldDateFrom_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldDateFrom" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td style="width: 50px">
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Date From
                            </td>
                            <td>
                                <asp:TextBox ID="txtDateFrom" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateFrom_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtDateFrom">
                                </cc1:CalendarExtender>
                                &nbsp;<asp:DropDownList ID="drpAHour" runat="server" CssClass="InputTxtBox" 
                                    Width="50px">
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
                                &nbsp;<asp:DropDownList ID="drpAMin" runat="server" CssClass="InputTxtBox" 
                                    Width="50px">
                                    <asp:ListItem>00</asp:ListItem>
                                    <asp:ListItem>10</asp:ListItem>
                                    <asp:ListItem>20</asp:ListItem>
                                    <asp:ListItem>30</asp:ListItem>
                                    <asp:ListItem>40</asp:ListItem>
                                    <asp:ListItem>50</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpAAMPM" runat="server" CssClass="InputTxtBox" 
                                    Width="50px">
                                    <asp:ListItem>AM</asp:ListItem>
                                    <asp:ListItem>PM</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="label">
                                To
                            </td>
                            <td>
                                <asp:DropDownList ID="drpIHour" runat="server" CssClass="InputTxtBox" 
                                    Width="50px">
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
                                &nbsp;<asp:DropDownList ID="drpIMin" runat="server" CssClass="InputTxtBox" 
                                    Width="50px">
                                    <asp:ListItem>00</asp:ListItem>
                                    <asp:ListItem>10</asp:ListItem>
                                    <asp:ListItem>20</asp:ListItem>
                                    <asp:ListItem>30</asp:ListItem>
                                    <asp:ListItem>40</asp:ListItem>
                                    <asp:ListItem>50</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpIAMPM" runat="server" CssClass="InputTxtBox" 
                                    Width="50px">
                                    <asp:ListItem>AM</asp:ListItem>
                                    <asp:ListItem>PM</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Reason For Request
                            </td>
                            <td>
                                <asp:DropDownList ID="drpReasonForOutOfOfficeReq" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
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
                                Remarks
                            </td>
                            <td>
                                <asp:TextBox ID="txtRemarks" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="250px"></asp:TextBox>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldReasonForRequest" runat="server" ControlToValidate="drpReasonForOutOfOfficeReq"
                                    Display="None" ErrorMessage="Required: Reason For Request" ValidationGroup="OutOfOfcReq"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldReasonForRequest_ValidatorCalloutExtender"
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle"
                                    Enabled="True" TargetControlID="reqFldReasonForRequest" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Attachment
                            </td>
                            <td>
                                <asp:FileUpload ID="flupReference" runat="server" />
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldRemarks" runat="server" ControlToValidate="txtRemarks"
                                    Display="None" ErrorMessage="Required: Remarks" ValidationGroup="OutOfOfcReq"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldRemarks_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldRemarks" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnSubmit" runat="server" CssClass="styled-button-1" Text="Submit"
                                    ValidationGroup="OutOfOfcReq" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" CssClass="styled-button-1" Text="Cancel" />
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
        <tr>
            <td>
                <asp:Panel ID="pnlRequestList" runat="server" SkinID="pnlInner">
                    <div style="max-height: 300px; max-width: 100%; overflow: auto">
                        <asp:GridView ID="grdOutOfOfficeRequest" runat="server" CssClass="mGrid" AutoGenerateColumns="False"
                            EmptyDataText="NO REQUEST AVAILABLE">
                            <Columns>
                                <asp:TemplateField HeaderText="OutOfOfficeReqID" Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOutOfOfficeReqID" runat="server" Text='<%# Bind("OutOfOfficeReqID") %>'></asp:Label>
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
                                <asp:BoundField DataField="IsApproved" HeaderText="IsApproved" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
            </td>
        </tr>
    </table>
</asp:Content>
