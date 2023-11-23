Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine

Partial Class Services_frmIssueCertificate
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()

    Protected Sub btnProcessReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcessReport.Click
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
            repName = folder & drpCertificateOptions.SelectedValue
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
            myReport.SetParameterValue("@EmployeeID", drpEmpList.SelectedValue)
            If drpCertificateOptions.SelectedValue = "rptSalaryPayslip.rpt" Then
                myReport.SetParameterValue("@SalaryMonth", Convert.ToInt32(drpSalaryMonth.SelectedValue))
                myReport.SetParameterValue("@SalaryYear", Convert.ToInt32(drpSalaryYear.SelectedValue))
            End If
            myReport.ExportToHttpResponse(ExportFormatType.RichText, Response, True, "ExportedReport")
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

    Protected Sub GetEmpList()
        drpEmpList.DataTextField = "EmployeeName"
        drpEmpList.DataValueField = "EmployeeID"
        drpEmpList.DataSource = EmpData.fnGetEmployeeList()
        drpEmpList.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetEmpList()
            drpSalaryMonth.SelectedValue = Now.Date.Month.ToString()
            drpSalaryYear.SelectedValue = Now.Date.Year.ToString()
        End If
    End Sub

End Class
