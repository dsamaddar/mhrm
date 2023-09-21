<%@ Page Language="VB" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmHoliday.aspx.vb" Inherits="Administration_frmHoliday" Title=".:EHRM:Manage Holidays:."
    Theme="CommonSkin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Sources/css/UltraCssClass.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        window.onload = function() {
            var strCook = document.cookie;
            if (strCook.indexOf("!~") != 0) {
                var intS = strCook.indexOf("!~");
                var intE = strCook.indexOf("~!");
                var strPos = strCook.substring(intS + 2, intE);
                document.getElementById("divgrd").scrollTop = strPos;
            }
        }
        function SetDivPosition() {
            var intY = document.getElementById("divgrd").scrollTop;
            document.title = intY;
            document.cookie = "yPos=!~" + intY + "~!";
        }

        window.scrollBy(100, 100); 
    </script>

    <table style="width: 100%;">
        <tr align="center">
            <td>
                <asp:Panel ID="pnlInputFormHoliday" runat="server" SkinID="pnlInner" Width="800px">
                    <table style="width: 100%;">
                        <tr>
                            <td align="left" colspan="6">
                                <div class="widgettitle">
                                    Manage Holidays<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:20px">
                            </td>
                            <td style="width:150px">
                            </td>
                            <td style="width:300px">
                            </td>
                            <td style="width:20px">
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                        </tr>
                        <tr align="left">
                            <td class="label">
                            </td>
                            <td class="label">
                                <asp:Label ID="lblDateFrom" runat="server" Text="Date From"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="dtDateFrom" runat="server" CssClass="InputTxtBox" 
                                    Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="dtDateFm_CalendarExtender" Format="dd-MMM-yy" runat="server"
                                    Enabled="True" TargetControlID="dtDateFrom">
                                </cc1:CalendarExtender>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="reqFldStartDate" runat="server" 
                                    ControlToValidate="dtDateFrom" Display="None" 
                                    ErrorMessage="Required: Holiday Start Date" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldStartDate_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" TargetControlID="reqFldStartDate" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td class="label" runat="server" id="IDDateto">
                                Date To
                            </td>
                            <td runat="server" id="tdDateto">
                                <asp:TextBox ID="dtDateTo" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtDateTo_CalendarExtender" Format="dd-MMM-yy" runat="server"
                                    Enabled="True" TargetControlID="dtDateTo">
                                </cc1:CalendarExtender>
                                &nbsp;
                                </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Purpose
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtPurpose" runat="server" CssClass="InputTxtBox" Height="60px"
                                    TextMode="MultiLine" Width="200px"></asp:TextBox>
                                &nbsp;<asp:RequiredFieldValidator ID="reqFldHolidayPurpose" runat="server" 
                                    ControlToValidate="txtPurpose" Display="None" 
                                    ErrorMessage="Required: Holiday Purpose" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldHolidayPurpose_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldHolidayPurpose" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:RequiredFieldValidator ID="reqFldHolidayEndDate" runat="server" 
                                    ControlToValidate="dtDateTo" Display="None" 
                                    ErrorMessage="Required: Holiday End Date" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldHolidayEndDate_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldHolidayEndDate" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
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
                            <td>
                            </td>
                            <td>
                            </td>
                            <td align="left">
                                <asp:Button ID="btnSave" runat="server" Text="Insert" CssClass="styled-button-1"
                                    ValidationGroup="Submit" />
                                &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="styled-button-1" />
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                &nbsp;</td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlUpdateHoliday" runat="server" Width="800px" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr align="left">
                            <td colspan="3">
                                <div class="widget-title">
                                    Update Holiday Info.</div>
                            </td>
                        </tr>
                        <tr align="left" >
                            <td style="width: 20px">
                            </td>
                            <td style="width: 150px">
                            </td>
                            <td>
                                <asp:HiddenField ID="hdFldHolidayID" runat="server" />
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Holiday</td>
                            <td class="label">
                                <asp:TextBox ID="txtHolidayDate" runat="server" CssClass="InputTxtBox" Width="120px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtHolidayDate_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtHolidayDate">
                                </cc1:CalendarExtender>
                                &nbsp;(MM/DD/YYYY)
                                <asp:CompareValidator ID="dateValidatorHolidayDate" runat="server" ControlToValidate="txtHolidayDate"
                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date" ValidationGroup="UpdateHoliday">
                                </asp:CompareValidator>
                                <asp:RequiredFieldValidator ID="reqFldHolidayDate" runat="server" ControlToValidate="txtHolidayDate"
                                    ErrorMessage="Joining Date Required" ValidationGroup="UpdateHoliday" Display="None">
                                </asp:RequiredFieldValidator><cc1:ValidatorCalloutExtender ID="reqFldHolidayDate_ValidatorCalloutExtender"
                                    runat="server" Enabled="True" TargetControlID="reqFldHolidayDate" CloseImageUrl="~/Sources/images/valClose.png"
                                    CssClass="customCalloutStyle" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                                
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td class="label">
                                Purpose</td>
                            <td>
                                <asp:TextBox ID="txtPurposeUpdate" runat="server" CssClass="InputTxtBox" Height="50px"
                                    TextMode="MultiLine" Width="250px"></asp:TextBox>
                                &nbsp;
                                <asp:RequiredFieldValidator ID="reqFldPurposeUpdate" runat="server" 
                                    ControlToValidate="txtPurposeUpdate" Display="None" 
                                    ErrorMessage="Required: Holiday Purpose" ValidationGroup="UpdateHoliday"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldPurposeUpdate_ValidatorCalloutExtender" 
                                    runat="server" CloseImageUrl="~/Sources/images/valClose.png" 
                                    CssClass="customCalloutStyle" Enabled="True" 
                                    TargetControlID="reqFldPurposeUpdate" 
                                    WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr align="left">
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <asp:Button ID="btnUpdateHolidayInfo" runat="server" Text="Update" 
                                    CssClass="styled-button-1" ValidationGroup="UpdateHoliday" />
                                &nbsp;<asp:Button ID="btnCancelUpdateHoliday" runat="server" Text="Cancel" CssClass="styled-button-1" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr align="center">
            <td>
                <asp:Panel ID="pnlHolidayList" runat="server" SkinID="pnlInner" Width="800px">
                    <table style="width: 100%;">
                        <tr>
                            <td align="left">
                                <div class="widgettitle">
                                    Search Year Wise Balance</div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div id="divgrd" onscroll="SetDivPosition()" style="max-height: 350px; width: 100%;
                                    overflow: auto">
                                    <asp:GridView ID="grdHolidayList" runat="server" AutoGenerateColumns="False" DataKeyNames="HolidayID"
                                        Width="100%" AllowSorting="True" CssClass="mGrid">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Select" ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                        Text="Select"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="HolidayID" Visible="False">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblHolidayID" runat="server" Text='<%# Bind("HolidayID") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Holiday">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDateFrom" runat="server" Text='<%# Bind("HolidayDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Purpose">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPurpose" runat="server" Text='<%# Bind("Purpose") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Delete">
                                                <ItemTemplate>
                                                    <asp:ImageButton Width="30" ID="imgDelete" CommandName="Delete" runat="server" OnClientClick="return confirm('Are You Sure You Want to Delete?')"
                                                        ImageUrl="~/Sources/images/erase.png" CausesValidation="False" />
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
    </table>
</asp:Content>
