Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Class SalarySettings_frmSalaryReports
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()
    Dim EmpSalarySummaryData As New clsEmpSalarySummary()

    Protected Sub btnProcessReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcessReport.Click
        Try
            If drpReportList.SelectedItem.Text = "Salary Certificate" Then
                GetSalaryCertificate(drpReportList.SelectedValue)
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub GetSalaryCertificate(ByVal rptName As String)
        Dim myReport As New ReportDocument()
        Dim folder As String
        Dim f As String
        Dim repName As String
        Dim serverName As [String], uid As [String], pwd As [String], dbName As [String]

        Dim conStr As String = ConfigurationManager.ConnectionStrings("HRMConnectionString").ConnectionString
        Dim retArr As [String](), usrArr As [String](), pwdArr As [String](), serverArr As [String](), dbArr As [String]()

        Try
            f = "~/Reports/"
            folder = Server.MapPath(f)
            repName = folder & rptName
            myReport.Load(repName)

            retArr = conStr.Split(";")
            serverArr = retArr(0).Split("=")
            dbArr = retArr(1).Split("=")
            usrArr = retArr(2).Split("=")
            pwdArr = retArr(3).Split("=")

            serverName = serverArr(1)
            uid = usrArr(1)
            pwd = pwdArr(1)
            dbName = dbArr(1)

            myReport.SetDatabaseLogon(uid, pwd, serverName, dbName)

            Dim parameters As CrystalDecisions.Web.Parameter = New CrystalDecisions.Web.Parameter()
            myReport.SetParameterValue("@EmployeeID", drpSelectEmployee.SelectedValue)
            myReport.ExportToHttpResponse(drpExportFormat.SelectedValue, Response, True, "SalaryCertificate_" & Now.Ticks)

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

    Protected Sub GetEmployeeList()
        drpSelectEmployee.DataValueField = "EmployeeID"
        drpSelectEmployee.DataTextField = "EmployeeName"
        drpSelectEmployee.DataSource = EmpData.fnGetEmpListPayrollActive()
        drpSelectEmployee.DataBind()
    End Sub


    Protected Sub GetReportableSalaryEntryPoint()
        Try
            drpEntryPoint.DataSource = EmpSalarySummaryData.fnGetReportableSalaryEntryPoint()
            drpEntryPoint.DataTextField = "EntryPointText"
            drpEntryPoint.DataValueField = "EntryPoint"
            drpEntryPoint.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            drpSalaryMonth.SelectedValue = Now.Month
            drpSalaryYear.SelectedValue = Now.Year
            drpSalaryReportYear.SelectedValue = Now.Year
            drpSalaryReportMonth.SelectedValue = Now.Month
            GetEmployeeList()
            GetReportableSalaryEntryPoint()
        End If
    End Sub

    Protected Sub btnProcessSalaryReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcessSalaryReport.Click
        Try
            If drpSalaryReportList.SelectedValue = "rptSalaryBankInstruction.rpt" Then
                GetSalaryBankInstruction(drpSalaryReportList.SelectedValue)
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub GetSalaryBankInstruction(ByVal rptName As String)
        Dim myReport As New ReportDocument()
        Dim folder As String
        Dim f As String
        Dim repName As String
        Dim serverName As [String], uid As [String], pwd As [String], dbName As [String]

        Dim conStr As String = ConfigurationManager.ConnectionStrings("ReportCon").ConnectionString
        Dim retArr As [String](), usrArr As [String](), pwdArr As [String](), serverArr As [String](), dbArr As [String]()

        Try
            f = "~/Reports/"
            folder = Server.MapPath(f)
            repName = folder & rptName
            myReport.Load(repName)

            retArr = conStr.Split(";")
            serverArr = retArr(0).Split("=")
            dbArr = retArr(1).Split("=")
            usrArr = retArr(2).Split("=")
            pwdArr = retArr(3).Split("=")

            serverName = serverArr(1)
            uid = usrArr(1)
            pwd = pwdArr(1)
            dbName = dbArr(1)

            myReport.SetDatabaseLogon(uid, pwd, serverName, dbName)

            Dim parameters As CrystalDecisions.Web.Parameter = New CrystalDecisions.Web.Parameter()
            myReport.SetParameterValue("@EntryPoint", drpEntryPoint.SelectedValue)
            myReport.ExportToHttpResponse(drpSalaryReportExportFormat.SelectedValue, Response, True, "SalaryBankInstruction_" & Now.Ticks)

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

End Class
