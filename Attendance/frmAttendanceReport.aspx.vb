Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Class Attendance_frmAttendanceReport
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()
    Dim DeptData As New clsDepartment()
    Dim DesignationData As New clsDesignation()

    Protected Sub btnDailyReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDailyReport.Click
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
            repName = folder & "rptDailyAtt.rpt"
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
            myReport.SetParameterValue("@EmployeeID", drpEmployeeList.SelectedValue)
            myReport.SetParameterValue("@DepartmentID", drpDepartments.SelectedValue)
            myReport.SetParameterValue("@BranchID", drpBranchList.SelectedValue)
            myReport.SetParameterValue("@DesignationID", drpDesignation.SelectedValue)
            myReport.SetParameterValue("@DateFrom", Convert.ToDateTime(txtDateFrom.Text))
            myReport.SetParameterValue("@DateTo", Convert.ToDateTime(txtDateTo.Text))
            myReport.SetParameterValue("@EmpTypeID", drpEmploymentType.SelectedValue)
            myReport.SetParameterValue("@AttStatus", drpAttStatus.SelectedValue)
            myReport.ExportToHttpResponse(drpExportFormat.SelectedValue, Response, True, "Attendance-Report-Daily" & Now.Ticks)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub GetEmployeeList()
        drpEmployeeList.DataValueField = "EmployeeID"
        drpEmployeeList.DataTextField = "EmployeeName"
        drpEmployeeList.DataSource = EmpData.fnGetEmpListPayrollActive()
        drpEmployeeList.DataBind()

        Dim A As New ListItem
        A.Text = "ALL"
        A.Value = "ALL"

        drpEmployeeList.Items.Insert(0, A)
    End Sub

    Protected Sub ShowDepertment()
        Try
            drpDepartments.DataTextField = "DeptName"
            drpDepartments.DataValueField = "DepartmentID"
            drpDepartments.DataSource = DeptData.fnGetDeptList()
            drpDepartments.DataBind()

            Dim A As New ListItem
            A.Text = "ALL"
            A.Value = "ALL"

            drpDepartments.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowDesignation()
        Try
            drpDesignation.DataTextField = "DesignationName"
            drpDesignation.DataValueField = "DesignationID"
            drpDesignation.DataSource = EmpData.fnGetOfficialDesignation()
            drpDesignation.DataBind()

            Dim A As New ListItem
            A.Text = "ALL"
            A.Value = "ALL"

            drpDesignation.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowBranchList()
        drpBranchList.DataTextField = "ULCBranchName"
        drpBranchList.DataValueField = "ULCBranchID"
        drpBranchList.DataSource = EmpData.fnGetULCBranch()
        drpBranchList.DataBind()

        Dim A As New ListItem
        A.Text = "ALL"
        A.Value = "ALL"
        drpBranchList.Items.Insert(0, A)
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnMonthlySummary_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnMonthlySummary.Click
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
            repName = folder & "rptMonthlyAttSummary.rpt"
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
            myReport.SetParameterValue("@DesignationID", drpDesignation.SelectedValue)
            myReport.SetParameterValue("@year", drpReportYear.SelectedValue)
            myReport.SetParameterValue("@month", drpReportMonth.SelectedValue)
            myReport.ExportToHttpResponse(drpExportFormat.SelectedValue, Response, True, "Attendance-Report-Monthly" & Now.Ticks)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetEmployeeList()
            ShowDepertment()
            ShowBranchList()
            ShowDesignation()
            ShowEmployeeType()

            drpReportYear.SelectedValue = Now.Year.ToString()
            drpReportMonth.SelectedValue = Now.Month.ToString()
            txtDateFrom.Text = Now.Date
            txtDateTo.Text = Now.Date
        End If
    End Sub

    Protected Sub ShowEmployeeType()
        Try
            drpEmploymentType.DataTextField = "EmployeeTypeName"
            drpEmploymentType.DataValueField = "EmployeeTypeID"
            drpEmploymentType.DataSource = EmpData.fnGetEmployeeType()
            drpEmploymentType.DataBind()

            Dim A As New ListItem
            A.Text = "ALL"
            A.Value = "ALL"

            drpEmploymentType.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

End Class
