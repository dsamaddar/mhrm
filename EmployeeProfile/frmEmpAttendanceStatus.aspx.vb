Imports System.Net
Imports System.IO

Partial Class EmployeeProfile_frmEmpAttendanceStatus
    Inherits System.Web.UI.Page

    Dim UsrAttData As New clsUserAttendance()
    Dim EmployeeData As New clsEmployeeInfo()

    Protected Sub btnProcessReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcessReport.Click
        Try
            Dim UsrAtt As New clsUserAttendance()
            UsrAtt.EmployeeID = Session("ToWhomProShow")


            If Convert.ToDateTime(txtDateFrom.Text) > Convert.ToDateTime(txtDateTo.Text) Then
                Dim TempDate As DateTime = txtDateTo.Text
                txtDateTo.Text = txtDateFrom.Text
                txtDateFrom.Text = TempDate
            End If

            UsrAtt.DateFrom = Convert.ToDateTime(txtDateFrom.Text)
            UsrAtt.DateTo = Convert.ToDateTime(txtDateTo.Text)
            grdEmpAttendanceReport.DataSource = UsrAttData.fnGetUserAttendance(UsrAtt)
            grdEmpAttendanceReport.DataBind()
        Catch ex As Exception

        End Try

       
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtDateFrom.Text = Now.Date.Month.ToString() + "/1/" + Now.Date.Year.ToString()
            txtDateTo.Text = Now.Date
            getBasicProfileInfo(Session("ToWhomProShow"))
        End If
    End Sub

    Protected Sub grdEmpAttendanceReport_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdEmpAttendanceReport.RowDataBound
        Dim lblStatus As New Label
        If e.Row.RowType = DataControlRowType.DataRow Then
            lblStatus = e.Row.FindControl("lblStatus")
            If lblStatus.Text = "Regular" Then
                lblStatus.ForeColor = Drawing.Color.Green
            Else
                lblStatus.ForeColor = Drawing.Color.Red
            End If
        End If
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

    Protected Sub ShowImage(ByVal UrlStr As String, ByVal ControlName As String)
        Dim tClient As WebClient = New WebClient
        Dim memStrmPic As MemoryStream = New MemoryStream(tClient.DownloadData(UrlStr))
        Dim bytesPic As Byte() = memStrmPic.ToArray()
        Dim base64StringPic As String = Convert.ToBase64String(bytesPic, 0, bytesPic.Length)

        Dim imgCtrl As System.Web.UI.WebControls.Image = Master.FindControl(ControlName)
        imgCtrl.ImageUrl = "data:image/png;base64," & base64StringPic
        memStrmPic.Dispose()
    End Sub

End Class
