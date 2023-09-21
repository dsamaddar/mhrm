Imports System.Net
Imports System.IO
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Class EmployeeProfile_frmSubEmpAttReport
    Inherits System.Web.UI.Page

    Dim UsrAttData As New clsUserAttendance()
    Dim EmployeeData As New clsEmployeeInfo()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtDateFrom.Text = Now.Date
            txtDateTo.Text = Now.Date
            getBasicProfileInfo(Session("ToWhomProShow"))
            'GetEmployeeList(Session("EmployeeID"))
            GetEmployeeList(Session("ToWhomProShow"))
        End If
    End Sub

    Protected Sub GetEmployeeList(ByVal EmployeeID As String)
        drpEmployeeList.DataValueField = "EmployeeID"
        drpEmployeeList.DataTextField = "EmployeeName"
        drpEmployeeList.DataSource = EmployeeData.fnGetTeamMembers(EmployeeID)
        drpEmployeeList.DataBind()
    End Sub

    Protected Sub getBasicProfileInfo(ByVal EmployeeID As String)
        Try
            Dim EmpInfo As New clsEmployeeInfo()
            EmpInfo = EmployeeData.fnGetBasicProfile(EmployeeID)

            Dim pnlEmpSummary As Panel
            Master.FindControl("pnlEmpSummary")
            pnlEmpSummary = Master.FindControl("pnlEmpSummary")

            Dim lblEmployeeName, lblEmployeeID, lblOfficialDesignation, lblFunctionalDesignation, lblDepartment, lblSupervisorName, lblEmployeeType, lblServiceLength, lblLocation As Label
            Dim imgEmployee As Image
            Dim hpLnkCanProfile As New HyperLink

            lblEmployeeName = pnlEmpSummary.FindControl("lblEmployeeName")
            lblEmployeeID = pnlEmpSummary.FindControl("lblEmployeeID")
            lblOfficialDesignation = pnlEmpSummary.FindControl("lblOfficialDesignation")
            lblFunctionalDesignation = pnlEmpSummary.FindControl("lblFunctionalDesignation")
            lblDepartment = pnlEmpSummary.FindControl("lblDepartment")
            lblSupervisorName = pnlEmpSummary.FindControl("lblSupervisorName")
            lblEmployeeType = pnlEmpSummary.FindControl("lblEmployeeType")
            lblServiceLength = pnlEmpSummary.FindControl("lblServiceLength")
            lblLocation = pnlEmpSummary.FindControl("lblLocation")
            imgEmployee = pnlEmpSummary.FindControl("imgEmployee")
            hpLnkCanProfile = pnlEmpSummary.FindControl("hpLnkCanProfile")

            lblEmployeeName.Text = EmpInfo.EmployeeName
            lblEmployeeID.Text = EmpInfo.EmpCode
            lblOfficialDesignation.Text = EmpInfo.OfficialDesignation
            lblFunctionalDesignation.Text = EmpInfo.FunctionalDesignation
            lblDepartment.Text = EmpInfo.Department
            lblSupervisorName.Text = EmpInfo.CurrentSupervisor
            lblEmployeeType.Text = EmpInfo.EmpType
            lblServiceLength.Text = EmpInfo.ServiceLength
            lblLocation.Text = EmpInfo.Branch

            If EmpInfo.Photos = "" Then
                imgEmployee.ImageUrl = "~\Sources\images\human.png"
            Else
                ShowImage(ConfigurationManager.AppSettings("OutputEHRMFiles") & EmpInfo.Photos, "imgEmployee")
            End If

            'lblImg.Text = imgEmployee.ImageUrl
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

    Protected Sub ShowImage(ByVal UrlStr As String, ByVal ControlName As String)
        Dim tClient As WebClient = New WebClient
        Dim memStrmPic As MemoryStream = New MemoryStream(tClient.DownloadData(UrlStr))
        Dim bytesPic As Byte() = memStrmPic.ToArray()
        Dim base64StringPic As String = Convert.ToBase64String(bytesPic, 0, bytesPic.Length)

        Dim imgCtrl As System.Web.UI.WebControls.Image = Master.FindControl(ControlName)
        imgCtrl.ImageUrl = "data:image/png;base64," & base64StringPic
        memStrmPic.Dispose()
    End Sub

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
            myReport.SetParameterValue("@DepartmentID", "ALL")
            myReport.SetParameterValue("@BranchID", "ALL")
            myReport.SetParameterValue("@DesignationID", "ALL")
            myReport.SetParameterValue("@DateFrom", Convert.ToDateTime(txtDateFrom.Text))
            myReport.SetParameterValue("@DateTo", Convert.ToDateTime(txtDateTo.Text))
            myReport.SetParameterValue("@EmpTypeID", "ALL")
            myReport.SetParameterValue("@AttStatus", drpAttStatus.SelectedValue)
            myReport.ExportToHttpResponse(drpExportFormat.SelectedValue, Response, True, "team_branch_att_report_" & Now.Ticks)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub
End Class
