
Partial Class SalarySettings_frmProcessSalary
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()
    Dim SalProcess As New clsEmpSalaryProcess()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Dim MenuIDs As String
            MenuIDs = Session("PermittedMenus")

            If InStr(MenuIDs, "ProcessSalary~") = 0 Then
                Response.Redirect("~\frmHRMLogin.aspx")
            End If

            ShowEmployeeType()
            GetEmpList(drpEmployeeType.SelectedValue)
            Intialization()
        End If
    End Sub

    Protected Sub Intialization()
        lblProcessingEntryPoint.Text = Now.Year.ToString() & Now.Day.ToString() & Now.Month.ToString() & Now.Hour.ToString() & Now.Minute.ToString() ' & Now.Ticks.ToString()
        drpSalaryMonth.SelectedValue = Now.Month.ToString()
        drpSalaryYear.SelectedValue = Now.Year.ToString()
        lblSelectEmpType.Text = "Select Employee Type"
        btnProcessSalary.Enabled = False
    End Sub

    Protected Sub GetEmpList(ByVal EmployeeTypeID As String)
        chkBxLstEmployees.DataTextField = "EmployeeName"
        chkBxLstEmployees.DataValueField = "EmployeeID"
        chkBxLstEmployees.DataSource = EmpData.fnGetEmpListByTypePayrollActive(EmployeeTypeID)
        chkBxLstEmployees.DataBind()
    End Sub

    Protected Sub chkSelectAllEmployee_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkSelectAllEmployee.CheckedChanged
        Try
            If chkSelectAllEmployee.Checked = True Then
                For Each item As ListItem In chkBxLstEmployees.Items
                    item.Selected = True
                Next
            Else
                For Each item As ListItem In chkBxLstEmployees.Items
                    item.Selected = False
                Next
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
        
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub ShowEmployeeType()
        Try
            drpEmployeeType.DataTextField = "EmployeeTypeName"
            drpEmployeeType.DataValueField = "EmployeeTypeID"
            drpEmployeeType.DataSource = EmpData.fnGetEmployeeType()
            drpEmployeeType.DataBind()

            Dim A As New ListItem()
            A.Text = "N\A"
            A.Value = "N\A"
            drpEmployeeType.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnCheckSystem_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCheckSystem.Click
        Try
            Dim EmpSalPro As New clsEmpSalaryProcess()
            Dim canProceed As String = ""
            Dim canNotProceed As String = "********** Blocked Process ************" & vbCrLf
            EmpSalPro.SalaryMonth = Convert.ToInt32(drpSalaryMonth.SelectedValue)
            EmpSalPro.SalaryYear = Convert.ToInt32(drpSalaryYear.SelectedValue)

            If chkProcessSalary.Checked = True Then
                EmpSalPro.IsSalaryProcessSelected = True
            Else
                EmpSalPro.IsSalaryProcessSelected = False
            End If

            If chkProcessPB.Checked = True Then
                EmpSalPro.IsPBSelected = True
            Else
                EmpSalPro.IsPBSelected = False
            End If

            If chkProcessFestivalBonus.Checked = True Then
                EmpSalPro.IsFBSelected = True
            Else
                EmpSalPro.IsFBSelected = False
            End If

            If chkProcessTaxDeduction.Checked = True Then
                EmpSalPro.IsTDSelected = True
            Else
                EmpSalPro.IsTDSelected = False
            End If

            For Each item As ListItem In chkBxLstEmployees.Items
                If item.Selected = True Then
                    EmpSalPro.EmployeeID = item.Value
                    canProceed = SalProcess.fnCheckSalarySystem(EmpSalPro)
                    If canProceed = "NO" Then
                        canNotProceed &= " " & item.Text & vbCrLf
                        item.Selected = False
                    End If
                End If
            Next
            DisableAllControls()
            MessageBox(canNotProceed)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub DisableAllControls()
        chkSelectAllEmployee.Enabled = False
        drpSalaryMonth.Enabled = False
        drpSalaryYear.Enabled = False
        chkBxLstEmployees.Enabled = False
        drpEmployeeType.Enabled = False
        btnProcessSalary.Enabled = True

        chkProcessBaishakhiAllowance.Enabled = False
        chkProcessFestivalBonus.Enabled = False
        chkProcessPB.Enabled = False
        chkProcessSalary.Enabled = False
        chkProcessTaxDeduction.Enabled = False
    End Sub

    Protected Sub EnableAllControl()
        chkSelectAllEmployee.Enabled = True
        drpSalaryMonth.Enabled = True
        drpSalaryYear.Enabled = True
        chkBxLstEmployees.Enabled = True
        drpEmployeeType.Enabled = True
        btnProcessSalary.Enabled = False

        chkProcessBaishakhiAllowance.Enabled = True
        chkProcessFestivalBonus.Enabled = True
        chkProcessPB.Enabled = True
        chkProcessSalary.Enabled = True
        chkProcessTaxDeduction.Enabled = True
    End Sub

    Protected Sub btnProcessSalary_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcessSalary.Click
        Try
            Dim EmpSalPro As New clsEmpSalaryProcess()
            Dim result As New clsResult()
            Dim canNotProceed As String = "********** Can Not Process ************" & vbCrLf

            EmpSalPro.SalaryMonth = Convert.ToInt32(drpSalaryMonth.SelectedValue)
            EmpSalPro.SalaryYear = Convert.ToInt32(drpSalaryYear.SelectedValue)
            EmpSalPro.ProcessedBy = Session("UserID")
            EmpSalPro.EntryPoint = lblProcessingEntryPoint.Text

            If chkProcessSalary.Checked = True Then
                EmpSalPro.IsSalaryProcessSelected = True
            Else
                EmpSalPro.IsSalaryProcessSelected = False
            End If

            If chkProcessPB.Checked = True Then
                EmpSalPro.IsPBSelected = True
            Else
                EmpSalPro.IsPBSelected = False
            End If

            If chkProcessFestivalBonus.Checked = True Then
                EmpSalPro.IsFBSelected = True
            Else
                EmpSalPro.IsFBSelected = False
            End If

            If chkProcessTaxDeduction.Checked = True Then
                EmpSalPro.IsTDSelected = True
            Else
                EmpSalPro.IsTDSelected = False
            End If

            For Each item As ListItem In chkBxLstEmployees.Items
                If item.Selected = True Then
                    EmpSalPro.EmployeeID = item.Value
                    result = SalProcess.fnProcessSalary(EmpSalPro)
                    If result.Success = False Then
                        canNotProceed &= " " & item.Text & vbCrLf
                    End If
                End If
            Next
            EnableAllControl()
            MessageBox(canNotProceed)
            MessageBox("Processed Successfully.")
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        EnableAllControl()
    End Sub

    Protected Sub drpEmployeeType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpEmployeeType.SelectedIndexChanged
        Try
            GetEmpList(drpEmployeeType.SelectedValue)
            lblSelectEmpType.Text = "Total " & drpEmployeeType.SelectedItem.Text & " Employees = " & chkBxLstEmployees.Items.Count.ToString
            chkSelectAllEmployee.Checked = False
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub
End Class
