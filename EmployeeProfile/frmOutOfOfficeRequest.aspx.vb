Imports System
Imports System.Data
Imports System.Net.Mail
Imports System.Net
Imports System.IO

Partial Class EmployeeProfile_frmOutOfOfficeRequest
    Inherits System.Web.UI.Page

    Dim EmployeeData As New clsEmployeeInfo()
    Dim LateAttCauseData As New clsLateAttendanceCause()
    Dim OutOfOfficeReqData As New clsOutOfficeReq()

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Try
            If Convert.ToDateTime(txtDateFrom.Text) < DateAdd(DateInterval.Month, -30, Now.Date) Then
                MessageBox("You Can't Apply For a Out Of Office Request Older Than One Month.")
                Exit Sub
            End If

            Dim MailProp As New clsMailProperty()
            Dim OutOfOffReq As New clsOutOfficeReq()
            Dim folder As String = ""
            Dim Title As String = ""
            Dim DocExt As String = ""
            Dim DocFullName As String = ""
            Dim DocPrefix As String = ""
            Dim FileSize As Integer = 0
            Dim DocFileName As String = ""

            If flupReference.HasFile Then
                folder = Server.MapPath("~/Attachments/")

                Title = flupReference.FileName

                Title = Replace(Title, ".", "")

                FileSize = flupReference.PostedFile.ContentLength()
                If FileSize > 4194304 Then
                    MessageBox("File size should be within 4MB")
                    Exit Sub
                End If

                DocPrefix = Title.Replace(" ", "")

                DocExt = System.IO.Path.GetExtension(flupReference.FileName)
                DocFileName = "Emp_OUT_OFC_" & DateTime.Now.ToString("ddMMyyHHmmss") & DocExt
                DocFullName = folder & DocFileName
                'flupReference.SaveAs(DocFullName)

                '' Uploading A file stream
                Dim fs As System.IO.Stream = flupReference.PostedFile.InputStream
                Dim br As New System.IO.BinaryReader(fs)
                Dim bytes As Byte() = br.ReadBytes(CType(fs.Length, Integer))
                UploadFile(DocFileName, bytes)
            Else
                DocFileName = ""
            End If

            OutOfOffReq.EmployeeID = Session("UniqueUserID")
            OutOfOffReq.LateAttCauseID = drpReasonForOutOfOfficeReq.SelectedValue
            OutOfOffReq.DateFrom = Convert.ToDateTime(txtDateFrom.Text + " " + drpAHour.SelectedValue + ":" + drpAMin.SelectedValue + ":00 " + drpAAMPM.SelectedValue)
            OutOfOffReq.DateTo = Convert.ToDateTime(txtDateFrom.Text + " " + drpIHour.SelectedValue + ":" + drpIMin.SelectedValue + ":00 " + drpIAMPM.SelectedValue)
            OutOfOffReq.Remarks = txtRemarks.Text
            OutOfOffReq.Attachment = DocFileName
            OutOfOffReq.EntryBy = Session("LoginUserID")

            Dim Check As Integer = OutOfOfficeReqData.fnInsertOutOfOfficeReq(OutOfOffReq)

            If Check = 1 Then
                MessageBox("Submitted Successfully.")
                MailProp = OutOfOfficeReqData.fnGetOutOfOfficeReqSubmitted(OutOfOffReq)
                SendOutOfOfficeReqMail(MailProp)
                ShowOutOfOfficeReq(Session("ToWhomProShow"))
                ClearReq()
            Else
                MessageBox("Error Found.")
            End If

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
       
    End Sub

    Protected Sub UploadFile(ByVal FileName As String, ByVal filebyte As Byte())
        Try
            Dim webClient As WebClient = New WebClient()
            Dim FileSavePath As String = Server.MapPath("~\Attachments\") & FileName
            File.WriteAllBytes(FileSavePath, filebyte)
            webClient.UploadFile("http://ext.mfilbd.com/HRMAttachments/Upload.aspx", FileSavePath)
            webClient.Dispose()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    'Protected Sub SendOutOfOfficeReqMail(ByVal MailProp As clsMailProperty)
    '    Dim mail As New Net.Mail.MailMessage()
    '    Try
    '        mail.From = New MailAddress(MailProp.MailFrom)
    '        mail.To.Add(MailProp.MailTo)
    '        mail.CC.Add(MailProp.MailCC)
    '        mail.Bcc.Add(MailProp.MailBCC)
    '        mail.Subject = MailProp.MailSubject
    '        mail.Body = MailProp.MailBody
    '        mail.IsBodyHtml = True
    '        Dim smtp As New SmtpClient("192.168.1.15", 25)
    '        smtp.Send(mail)
    '    Catch ex As Exception
    '        MessageBox(ex.Message)
    '    End Try
    'End Sub

    Protected Sub SendOutOfOfficeReqMail(ByVal MailProp As clsMailProperty)
        Dim mail As New Net.Mail.MailMessage()
        Dim TestArray() As String

        Try
            mail.From = New MailAddress(MailProp.MailFrom)

            TestArray = Split(MailProp.MailTo, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.To.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            TestArray = Split(MailProp.MailCC, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.CC.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            TestArray = Split(MailProp.MailBCC, ";")
            For i As Integer = 0 To TestArray.Length - 1
                If TestArray(i) <> "" Then
                    mail.Bcc.Add(TestArray(i))
                End If
            Next
            TestArray = Nothing

            mail.Subject = MailProp.MailSubject
            mail.Body = MailProp.MailBody
            mail.IsBodyHtml = True
            mail.Priority = MailPriority.High
            Dim smtp As New SmtpClient("192.168.1.15", 25)
            smtp.Send(mail)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowOutOfOfficeReq(ByVal EmployeeID As String)
        grdOutOfOfficeRequest.DataSource = OutOfOfficeReqData.fnGetOutOfOfficeReqByUser(EmployeeID)
        grdOutOfOfficeRequest.DataBind()
    End Sub

    Protected Sub GetActiveLateAttCauseList()
        drpReasonForOutOfOfficeReq.DataTextField = "Cause"
        drpReasonForOutOfOfficeReq.DataValueField = "LateAttCauseID"
        drpReasonForOutOfOfficeReq.DataSource = LateAttCauseData.fnGetActiveLateAttCause()
        drpReasonForOutOfOfficeReq.DataBind()
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearReq()
    End Sub

    Protected Sub ClearReq()
        txtDateFrom.Text = ""
        txtRemarks.Text = ""
        drpReasonForOutOfOfficeReq.SelectedIndex = -1
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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Try
                Dim LoginUserId As String = Session("UniqueUserID")
                Dim ToWhomProShow As String = Session("ToWhomProShow")
                getBasicProfileInfo(ToWhomProShow)
                GetActiveLateAttCauseList()
                ShowOutOfOfficeReq(Session("ToWhomProShow"))
            Catch ex As Exception
                MessageBox(ex.Message)
            End Try
        End If
    End Sub


End Class
