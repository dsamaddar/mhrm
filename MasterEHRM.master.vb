
Partial Class MasterEHRM
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Try
                lblEmpLoggedInUser.Text = "Welcome " + Session("UserName") + " ! "

                Dim mnu As New Menu
                Dim MenuIDs As String

                mnu = Me.FindControl("mnuEmp")
                MenuIDs = Session("PermittedMenus")

                mnu.Items(0).Enabled = IIf(InStr(MenuIDs, "Administration~"), True, False)
                mnu.Items(0).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "AddNewEmployee~"), True, False)
                mnu.Items(0).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "EdtEmpInfo~"), True, False)
                mnu.Items(0).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "EmpAttSett~"), True, False)
                mnu.Items(0).ChildItems(3).Enabled = IIf(InStr(MenuIDs, "EmpSettings~"), True, False)
                mnu.Items(0).ChildItems(4).Enabled = IIf(InStr(MenuIDs, "MngHolidays~"), True, False)
                mnu.Items(0).ChildItems(5).Enabled = IIf(InStr(MenuIDs, "MngNodes~"), True, False)
                mnu.Items(0).ChildItems(6).Enabled = IIf(InStr(MenuIDs, "DeptSet~"), True, False)
                mnu.Items(0).ChildItems(7).Enabled = IIf(InStr(MenuIDs, "BrSett~"), True, False)
                mnu.Items(0).ChildItems(8).Enabled = IIf(InStr(MenuIDs, "MngUsrProfile~"), True, False)
                mnu.Items(0).ChildItems(8).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "MngRole~"), True, False)
                mnu.Items(0).ChildItems(8).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "MngPermission~"), True, False)
                mnu.Items(0).ChildItems(8).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "UsrWiseRole~"), True, False)

                mnu.Items(1).Enabled = IIf(InStr(MenuIDs, "HRServices~"), True, False)
                mnu.Items(1).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "ServiceSettings~"), True, False)
                mnu.Items(1).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "ServiceRequests~"), True, False)
                mnu.Items(1).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "ServiceReports~"), True, False)
                mnu.Items(1).ChildItems(3).Enabled = IIf(InStr(MenuIDs, "IssueCertificate~"), True, False)
                mnu.Items(1).ChildItems(4).Enabled = IIf(InStr(MenuIDs, "RetZKAttLog~"), True, False)
                mnu.Items(1).ChildItems(5).Enabled = IIf(InStr(MenuIDs, "CallLog~"), True, False)
                mnu.Items(1).ChildItems(6).Enabled = IIf(InStr(MenuIDs, "EmpPerformance~"), True, False)

                mnu.Items(2).Enabled = IIf(InStr(MenuIDs, "Salary~"), True, False)
                mnu.Items(2).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "EmpSalarySetup~"), True, False)
                mnu.Items(2).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "ProcessSalary~"), True, False)
                mnu.Items(2).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "SalaryConfirmation~"), True, False)
                mnu.Items(2).ChildItems(3).Enabled = IIf(InStr(MenuIDs, "SalaryReports~"), True, False)

                mnu.Items(3).Enabled = IIf(InStr(MenuIDs, "leaveMgt~"), True, False)
                mnu.Items(3).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "leaveSettings~"), True, False)
                mnu.Items(3).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "MngLeaveBal~"), True, False)
                mnu.Items(3).ChildItems(2).Enabled = IIf(InStr(MenuIDs, "PrcYearlyLeave~"), True, False)
                mnu.Items(3).ChildItems(3).Enabled = IIf(InStr(MenuIDs, "LeaveQuery~"), True, False)

                mnu.Items(4).Enabled = IIf(InStr(MenuIDs, "AttendanceReports~"), True, False)
                mnu.Items(4).ChildItems(0).Enabled = IIf(InStr(MenuIDs, "InputAtt~"), True, False)
                mnu.Items(4).ChildItems(1).Enabled = IIf(InStr(MenuIDs, "QueryOnAtt~"), True, False)

                mnu.Items(5).Enabled = IIf(InStr(MenuIDs, "OrgStructure~"), True, False)
                mnu.Items(6).Enabled = IIf(InStr(MenuIDs, "QueryTool~"), True, False)

                'mnu.Items(7).NavigateUrl = "http://webapp/MHRM/EmployeeProfile/frmEmployeeDetails.aspx?EmployeeID=" & Session("UniqueUserID") & "&Type=Admin"
                mnu.Items(7).NavigateUrl = "~/EmployeeProfile/frmEmployeeDetails.aspx?EmployeeID=" & Session("UniqueUserID") & "&Type=Admin"

            Catch ex As Exception
                MessageBox(ex.Message)
            End Try
        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

End Class

