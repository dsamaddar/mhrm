<%@ Page Language="VB" MasterPageFile="~/EmployeeProfile/MasterEmpProfile.master"
    AutoEventWireup="false" CodeFile="frmSubOrdinateLeaveBalance.aspx.vb" Inherits="EmployeeProfile_frmSubOrdinateLeaveBalance"
    Theme="CommonSkin" Title=".:m-HRM:Subordinate Leave Balance:." %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script language="JavaScript" type="text/javascript">
    function openWindow(windowURL,windowName,windowWidth,windowHeight) {

    var left = (screen.width/2)-(windowWidth/2);
    var top = (screen.height/2)-(windowHeight/2);



    window.name = 'parentWnd';
    newWindow = window.open(windowURL,windowName,'top='+ top +',left='+ left +',width='+windowWidth+',height='+windowHeight+',toolbar=0,location=no,directories=0, status=0,menuBar=0,scrollBars=1,resizable=1');
    newWindow.focus();
    }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <asp:Panel ID="Panel1" runat="server" SkinID="pnlInner">
                    <table style="width: 100%;">
                        <tr>
                            <td>
                                <div class="widget-title">
                                    Subordinate Leave Balance
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="grdSubOrdinateLeaveBalance" runat="server" CssClass="mGrid" Width="100%"
                                    AutoGenerateColumns="False">
                                    <Columns>
                                        <asp:TemplateField HeaderText="EmployeeID" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("EmployeeID") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Employee">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkbtnPending" runat="server" CausesValidation="False" CssClass="linkbtn"
                                                    Font-Size="14px" OnClientClick='<%# Eval("EmployeeID","openWindow(""frmEmpLeaveReqDetails.aspx?EmployeeID={0}"",""Popup"",1000,1100);") %>'
                                                    Text='<%# Bind("EmployeeName") %>'>
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CasualLeave" HeaderText="Casual" />
                                        <asp:BoundField DataField="MedicalLeave" HeaderText="Medical" />
                                        <asp:BoundField DataField="AnnualLeave" HeaderText="Annual" />
                                        <asp:BoundField DataField="MaternityLeave" HeaderText="Maternity" />
                                        <asp:BoundField DataField="LeaveWithOutPay" HeaderText="With Out Pay" />
                                        <asp:BoundField DataField="SpecialLeave" HeaderText="Special" />
                                    </Columns>
                                </asp:GridView>
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
            </td>
        </tr>
    </table>
</asp:Content>
