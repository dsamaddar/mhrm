<%@ Page Language="VB" Theme="CommonSkin" MasterPageFile="~/MasterEHRM.master" AutoEventWireup="false"
    CodeFile="frmOrganizationStructure.aspx.vb" Inherits="frmOrganizationStructure"
    Title=".:m-HRM:Organization Structure:." %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .table_wrapper
        {
            width: 100%;
            margin: 0 auto;
            font-size: 12px;
            color: #3c3f42;
            padding: 2px 0 0;
            background: url(Sources/Images/table_top.gif) no-repeat;
        }
        .table_wrapper_inner
        {
            border: solid #dbdbdb;
            border-width: 0 0 0 1px;
        }
        .table_wrapper td, .table_wrapper th
        {
            border: solid #dbdbdb;
            border-width: 0 1px 1px 0;
        }
        .table_wrapper th
        {
            font-weight: bold;
            font-size: 13px;
        }
        .table_wrapper th a:link, .table_wrapper th a:visited, .table_wrapper th a:active
        {
            color: #1f476f;
            display: block;
            display: inline-block;
            background-repeat: no-repeat;
            background-position: right center;
            padding: 0 16px 0 0;
        }
        .table_wrapper th a:hover
        {
            color: #3d8ebc;
        }
        .productlist li
        {
            display: inline;
            float: left;
            margin-left: 15px;
            margin-bottom: 15px;
            border-width: 2px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        $(document).ready(funciton(){
            $("#AvailableEmployee").tablesorter();
        });
    </script>

    <script language="JavaScript" type="text/javascript">
        function openWindow(windowURL, windowName, windowWidth, windowHeight) {

            var left = (screen.width / 2) - (windowWidth / 2);
            var top = (screen.height / 2) - (windowHeight / 2);



            window.name = 'parentWnd';
            newWindow = window.open(windowURL, windowName, 'top=' + top + ',left=' + left + ',width=' + windowWidth + ',height=' + windowHeight + ',toolbar=0,location=no,directories=0, status=0,menuBar=0,scrollBars=1,resizable=1');
            newWindow.focus();
        }
    </script>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td align="center">
                <asp:Panel ID="pnlSearchCriteria" runat="server" SkinID="pnlInner" Width="100%">
                    <table style="width: 100%;">
                        <tr>
                            <td align="left" class="label" colspan="5">
                                <div class="widgettitle">
                                    Search Employee<asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20px">
                            </td>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left">
                                &nbsp;
                            </td>
                            <td align="left">
                                &nbsp;
                            </td>
                            <td align="left">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label" style="width: 20px">
                            </td>
                            <td align="left" class="label">
                                Name/ID
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtEmpIDOrName" runat="server" CssClass="InputTxtBox" Width="200px"></asp:TextBox>
                            </td>
                            <td align="left" class="label">
                                <b>Employee Status</b>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpEmployeeStatus" runat="server" CssClass="InputTxtBox" Width="80px">
                                    <asp:ListItem Value="1">Active</asp:ListItem>
                                    <asp:ListItem Value="0">In-Active</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                            </td>
                            <td align="left" class="label">
                                <b>Employee Type</b>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpEmployeeType" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td align="left" class="label">
                                <b>Select Designation</b>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpSelectDesignation" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                            </td>
                            <td align="left" class="label">
                                <b>Select Department</b>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpSelectDepartment" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td align="left" class="label">
                                <b>Select Branch</b>
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpULCBranch" runat="server" CssClass="InputTxtBox" Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                            </td>
                            <td align="left" class="label">
                                Gender
                            </td>
                            <td align="left">
                                <asp:RadioButtonList ID="rdbtnGender" runat="server" class="label" CssClass="rbdText"
                                    RepeatDirection="Horizontal" TabIndex="9">
                                    <asp:ListItem>Male</asp:ListItem>
                                    <asp:ListItem>Female</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                            <td align="left" class="label">
                                Functional Designation
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpFunctionalDesignation" runat="server" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Blood Group
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlBloodGrp" runat="server" CssClass="InputTxtBox" TabIndex="11"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td align="left" class="label">
                            </td>
                            <td align="left">
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Supervisor
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlCurrentSupervisor" runat="server" CssClass="InputTxtBox"
                                    TabIndex="7" Width="200px">
                                </asp:DropDownList>
                            </td>
                            <td align="left" class="label">
                                &nbsp;</td>
                            <td align="left">
                                <asp:DropDownList ID="ddlReligion" runat="server" CssClass="InputTxtBox" Width="200px"
                                    TabIndex="13" Visible="False">
                                    <asp:ListItem>N\A</asp:ListItem>
                                    <asp:ListItem Value="Muslim">Muslim</asp:ListItem>
                                    <asp:ListItem Value="Hindu">Hindu</asp:ListItem>
                                    <asp:ListItem Value="Buddhist">Buddhist</asp:ListItem>
                                    <asp:ListItem Value="Christian">Christian</asp:ListItem>
                                    <asp:ListItem Value="Christian">Others</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                            </td>
                            <td align="left" class="label">
                                Actual Date Of Birth
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="drpActualBirthDay" runat="server" CssClass="InputTxtBox" TabIndex="6"
                                    Width="60px">
                                    <asp:ListItem Value="0">N\A</asp:ListItem>
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
                                    <asp:ListItem>13</asp:ListItem>
                                    <asp:ListItem>14</asp:ListItem>
                                    <asp:ListItem>15</asp:ListItem>
                                    <asp:ListItem>16</asp:ListItem>
                                    <asp:ListItem>17</asp:ListItem>
                                    <asp:ListItem>18</asp:ListItem>
                                    <asp:ListItem>19</asp:ListItem>
                                    <asp:ListItem>20</asp:ListItem>
                                    <asp:ListItem>21</asp:ListItem>
                                    <asp:ListItem>22</asp:ListItem>
                                    <asp:ListItem>23</asp:ListItem>
                                    <asp:ListItem>24</asp:ListItem>
                                    <asp:ListItem>25</asp:ListItem>
                                    <asp:ListItem>26</asp:ListItem>
                                    <asp:ListItem>27</asp:ListItem>
                                    <asp:ListItem>28</asp:ListItem>
                                    <asp:ListItem>29</asp:ListItem>
                                    <asp:ListItem>30</asp:ListItem>
                                    <asp:ListItem>31</asp:ListItem>
                                </asp:DropDownList>
                                &nbsp;<asp:DropDownList ID="drpActualBirthMonth" runat="server" CssClass="InputTxtBox"
                                    TabIndex="7">
                                    <asp:ListItem Value="0">N\A</asp:ListItem>
                                    <asp:ListItem Value="1">JAN</asp:ListItem>
                                    <asp:ListItem Value="2">FEB</asp:ListItem>
                                    <asp:ListItem Value="3">MAR</asp:ListItem>
                                    <asp:ListItem Value="4">APR</asp:ListItem>
                                    <asp:ListItem Value="5">MAY</asp:ListItem>
                                    <asp:ListItem Value="6">JUN</asp:ListItem>
                                    <asp:ListItem Value="7">JUL</asp:ListItem>
                                    <asp:ListItem Value="8">AUG</asp:ListItem>
                                    <asp:ListItem Value="9">SEP</asp:ListItem>
                                    <asp:ListItem Value="10">OCT</asp:ListItem>
                                    <asp:ListItem Value="11">NOV</asp:ListItem>
                                    <asp:ListItem Value="12">DEC</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left" class="label">
                                District
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlPerDistrict" runat="server" AutoPostBack="True" CssClass="InputTxtBox"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="label">
                                &nbsp;
                            </td>
                            <td align="left" class="label">
                                Joining Date &gt;=
                            </td>
                            <td align="left" class="label">
                                <asp:TextBox ID="txtJoiningDate" runat="server" CssClass="InputTxtBox" Width="100px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtJoiningDate_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtJoiningDate">
                                </cc1:CalendarExtender>
                                &nbsp;(MM/DD/YYYY)&nbsp;<asp:CompareValidator ID="dateValidatorStartDate" runat="server"
                                    ControlToValidate="txtJoiningDate" ErrorMessage="Invalid Date" Operator="DataTypeCheck"
                                    Type="Date"></asp:CompareValidator>
                            </td>
                            <td align="left" class="label">
                                Joining Date &lt;=
                            </td>
                            <td align="left" class="label">
                                <asp:TextBox ID="txtJoiningDateTo" runat="server" CssClass="InputTxtBox" Width="100px"></asp:TextBox>
                                <cc1:CalendarExtender ID="txtJoiningDateTo_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtJoiningDateTo">
                                </cc1:CalendarExtender>
                                &nbsp;(MM/DD/YYYY)
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                            </td>
                            <td align="left">
                            </td>
                            <td align="left">
                                <asp:Button ID="btnSearchEmployee" runat="server" CssClass="styled-button-1" Text="Search" />
                                &nbsp;<asp:Button ID="btnCancelSelection" runat="server" CssClass="styled-button-1"
                                    Text="Cancel" />
                            </td>
                            <td align="left">
                                <asp:RequiredFieldValidator ID="reqFldStartDate" runat="server" ControlToValidate="txtJoiningDate"
                                    Display="None" ErrorMessage="Required" ValidationGroup="N\A"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldStartDate_ValidatorCalloutExtender0" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldStartDate" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                            <td align="left">
                                <asp:CompareValidator ID="dateValidatorJoiningDateTo" runat="server" ControlToValidate="txtJoiningDateTo"
                                    ErrorMessage="Invalid Date" Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>
                                <asp:RequiredFieldValidator ID="reqFldJoiningDateTo" runat="server" ControlToValidate="txtJoiningDateTo"
                                    Display="None" ErrorMessage="Required" ValidationGroup="N\A"></asp:RequiredFieldValidator>
                                <cc1:ValidatorCalloutExtender ID="reqFldJoiningDateTo_ValidatorCalloutExtender" runat="server"
                                    CloseImageUrl="~/Sources/images/valClose.png" CssClass="customCalloutStyle" Enabled="True"
                                    TargetControlID="reqFldJoiningDateTo" WarningIconImageUrl="~/Sources/images/Valwarning.png">
                                </cc1:ValidatorCalloutExtender>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                            </td>
                            <td align="left" class="label">
                                Total Count
                            </td>
                            <td align="left">
                                <asp:Label ID="lblTotalCount" runat="server" Font-Bold="True" Font-Names="Verdana"
                                    ForeColor="#009900"></asp:Label>
                            </td>
                            <td align="left">
                            </td>
                            <td align="left">
                                <asp:Button ID="btnExport" runat="server" CssClass="styled-button-1" Text="Export"
                                    ValidationGroup="ShowReport" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:Panel ID="pnlResult" runat="server" Width="100%" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <div class="widgettitle">
                                    Employee List</div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <div class="datagrid" style="max-height: 600px; max-width: 100%; overflow: auto">
                                    <asp:GridView ID="grdOrgStructure" runat="server" AutoGenerateColumns="False" CssClass="mGrid">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Photo">
                                                <ItemTemplate>
                                                    <asp:Image AlternateText="No Image Available" BorderWidth="0px" ID="imgEmployee"
                                                        runat="server" Width="80px" Height="90px" CssClass="img"/>
                                                    <asp:Label ID="lblPhotoID" runat="server" Visible="false" Text='<%# Eval("Photos")%>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="OfficialDesignation" HeaderText="Designation" />
                                            <asp:BoundField DataField="EmployeeName" HeaderText="Name" />
                                            <asp:BoundField DataField="EmpCode" HeaderText="Code" />
                                            <asp:BoundField DataField="DeptName" HeaderText="Department" />
                                            <asp:TemplateField HeaderText=" CV Details " ShowHeader="False">
                                                <ItemTemplate>
                                                    <span style="display: block"><a href='<%#"EmployeeProfile/frmEmployeeDetails.aspx?EmployeeID="+ Eval("EmployeeID")+"&Type=Admin"  %>'
                                                        target="_blank">Details</a></span>
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
