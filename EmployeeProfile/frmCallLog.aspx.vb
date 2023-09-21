Imports System
Imports System.Data
Imports System.Net.Mail
Imports System.Net
Imports System.IO

Partial Class EmployeeProfile_frmCallLog
    Inherits System.Web.UI.Page

    Dim EmployeeData As New clsEmployeeInfo()

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim ToWhomProShow As String = Session("ToWhomProShow")

            getBasicProfileInfo(ToWhomProShow)
            GetCallLog(ToWhomProShow)
        End If
    End Sub

    Protected Sub GetCallLog(ByVal EmployeeID As String)
        grdCallLog.DataSource = EmployeeData.fnGetEmpCallLog(EmployeeID)
        grdCallLog.DataBind()
    End Sub

    Protected Sub getBasicProfileInfo(ByVal EmployeeId As String)
        Try
            Dim EmpInfo As New clsEmployeeInfo()
            EmpInfo = EmployeeData.fnGetBasicProfile(EmployeeId)

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
