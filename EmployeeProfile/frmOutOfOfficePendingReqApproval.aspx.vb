Imports System
Imports System.Data
Imports System.Net.Mail
Imports System.Net
Imports System.IO

Partial Class EmployeeProfile_frmOutOfOfficePendingReqApproval
    Inherits System.Web.UI.Page

    Dim OutOfOfficeReqData As New clsOutOfficeReq()
    Dim EmployeeData As New clsEmployeeInfo()

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        Dim MailProp As New clsMailProperty()
        Dim OutOfOfficeReq As New clsOutOfficeReq()
        Dim lblOutOfOfficeReqID As New Label()
        lblOutOfOfficeReqID = grdOutOfOfficeRequest.SelectedRow.FindControl("lblOutOfOfficeReqID")
        OutOfOfficeReq.OutOfOfficeReqID = lblOutOfOfficeReqID.Text
        OutOfOfficeReq.ApproverRemarks = txtRemarks.Text
        OutOfOfficeReq.EventName = "Approved"
        OutOfOfficeReq.EntryBy = Session("LoginUserID")
        Dim Check As Integer = OutOfOfficeReqData.fnApproveOutOfOfficeReq(OutOfOfficeReq)

        If Check = 1 Then
            MessageBox("Approved.")
            GetPendingReq(Session("UniqueUserID"))
            MailProp = OutOfOfficeReqData.fnGetOutOfOfficeReqApprovedMail(OutOfOfficeReq)
            SendOutOfOfficeReqMailApproval(MailProp)
            ClearForm()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub SendOutOfOfficeReqMailApproval(ByVal MailProp As clsMailProperty)
        Dim mail As New Net.Mail.MailMessage()
        Try
            mail.From = New MailAddress(MailProp.MailFrom)
            mail.To.Add(MailProp.MailTo)
            mail.CC.Add(MailProp.MailCC)
            mail.Bcc.Add(MailProp.MailBCC)
            mail.Subject = MailProp.MailSubject
            mail.Body = MailProp.MailBody
            mail.IsBodyHtml = True
            Dim smtp As New SmtpClient("192.168.1.14", 25)
            smtp.Send(mail)
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

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        btnApprove.Enabled = False
        btnReject.Enabled = False
        txtRemarks.Text = ""
        grdOutOfOfficeRequest.SelectedIndex = -1
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Dim LoginUserId As String = Session("UniqueUserID")
            Dim ToWhomProShow As String = Session("ToWhomProShow")
            getBasicProfileInfo(ToWhomProShow)

            GetPendingReq(Session("UniqueUserID"))
            btnApprove.Enabled = False
            btnReject.Enabled = False
        End If
    End Sub

    Protected Sub GetPendingReq(ByVal ApproverID As String)
        grdOutOfOfficeRequest.DataSource = OutOfOfficeReqData.fnGetPendingOutOfOfficeReq(ApproverID)
        grdOutOfOfficeRequest.DataBind()
    End Sub

    Protected Sub grdOutOfOfficeRequest_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdOutOfOfficeRequest.SelectedIndexChanged
        btnApprove.Enabled = True
        btnReject.Enabled = True
    End Sub

    Protected Sub getBasicProfileInfo(ByVal EmployeeId As String)
        Dim EmpBasicProfile As New clsEmployeeInfo()
        EmpBasicProfile = EmployeeData.fnGetBasicProfile(EmployeeId)

        Try
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

            lblEmployeeName.Text = EmpBasicProfile.EmployeeName
            lblEmployeeID.Text = EmpBasicProfile.EmpCode
            lblOfficialDesignation.Text = EmpBasicProfile.OfficialDesignation
            lblFunctionalDesignation.Text = EmpBasicProfile.FunctionalDesignation
            lblDepartment.Text = EmpBasicProfile.Department
            lblSupervisorName.Text = EmpBasicProfile.CurrentSupervisor
            lblEmployeeType.Text = EmpBasicProfile.EmpType
            lblServiceLength.Text = EmpBasicProfile.ServiceLength
            lblLocation.Text = EmpBasicProfile.Branch

            If EmpBasicProfile.Photos = "" Then
                imgEmployee.ImageUrl = "~\Sources\images\human.png"
            Else
                ShowImage(ConfigurationManager.AppSettings("OutputEHRMFiles") & EmpBasicProfile.Photos, "imgEmployee")
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

    Protected Sub btnReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReject.Click
        Dim MailProp As New clsMailProperty()
        Dim OutOfOfficeReq As New clsOutOfficeReq()
        Dim lblOutOfOfficeReqID As New Label()
        lblOutOfOfficeReqID = grdOutOfOfficeRequest.SelectedRow.FindControl("lblOutOfOfficeReqID")
        OutOfOfficeReq.OutOfOfficeReqID = lblOutOfOfficeReqID.Text
        OutOfOfficeReq.ApproverRemarks = txtRemarks.Text
        OutOfOfficeReq.EventName = "Rejected"
        OutOfOfficeReq.EntryBy = Session("LoginUserID")
        Dim Check As Integer = OutOfOfficeReqData.fnApproveOutOfOfficeReq(OutOfOfficeReq)

        If Check = 1 Then
            MessageBox("Rejected.")
            GetPendingReq(Session("UniqueUserID"))
            MailProp = OutOfOfficeReqData.fnGetOutOfOfficeReqApprovedMail(OutOfOfficeReq)
            SendOutOfOfficeReqMailApproval(MailProp)
            ClearForm()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

End Class
