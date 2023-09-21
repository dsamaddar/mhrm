Imports System
Imports System.Data
Imports System.Net.Mail

Partial Class frmHRServiceRequest
    Inherits System.Web.UI.Page

    Dim HRServiceReqData As New clsHRServiceRequest()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetHRServiceRequest()
            btnRejectRequest.Enabled = False
            btnServiceProvided.Enabled = False
        End If
    End Sub

    Protected Sub GetHRServiceRequest()
        grdHRServiceRequest.DataSource = HRServiceReqData.fnGetHRServiceRequest()
        grdHRServiceRequest.DataBind()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        txtServiceRemarks.Text = ""
        hdFldServiceIssueID.Value = ""
        grdHRServiceRequest.SelectedIndex = -1
        btnRejectRequest.Enabled = False
        btnServiceProvided.Enabled = False
    End Sub

    Protected Sub btnServiceProvided_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnServiceProvided.Click
        Try
            Dim HRServiceReq As New clsHRServiceRequest()

            HRServiceReq.HRServiceIssueID = hdFldServiceIssueID.Value
            HRServiceReq.ServiceProviderRemarks = txtServiceRemarks.Text
            HRServiceReq.ServiceProvider = Session("LoginUserID")
            HRServiceReq.ServiceEvent = "Provided"

            Dim Check As Integer = HRServiceReqData.fnProvideHRService(HRServiceReq)

            If Check = 1 Then
                MessageBox("Notification Sent")
                GetHRServiceRequest()
                ClearForm()
                SendHRServiceRequestMail(HRServiceReqData.fnGetHRServiceProvidedMail(HRServiceReq))
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnRejectRequest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRejectRequest.Click
        Try
            Dim HRServiceReq As New clsHRServiceRequest()

            HRServiceReq.HRServiceIssueID = hdFldServiceIssueID.Value
            HRServiceReq.ServiceProviderRemarks = txtServiceRemarks.Text
            HRServiceReq.ServiceProvider = Session("LoginUserID")
            HRServiceReq.ServiceEvent = "Rejected"

            Dim Check As Integer = HRServiceReqData.fnProvideHRService(HRServiceReq)

            If Check = 1 Then
                MessageBox("Notification Sent")
                GetHRServiceRequest()
                ClearForm()

                SendHRServiceRequestMail(HRServiceReqData.fnGetHRServiceProvidedMail(HRServiceReq))
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub SendHRServiceRequestMail(ByVal MailProp As clsMailProperty)
        Dim TestArray() As String
        Dim mail As New Net.Mail.MailMessage()
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

    Protected Sub grdHRServiceRequest_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdHRServiceRequest.SelectedIndexChanged
        Dim lblHRServiceIssueID As New Label()

        lblHRServiceIssueID = grdHRServiceRequest.SelectedRow.FindControl("lblHRServiceIssueID")
        hdFldServiceIssueID.Value = lblHRServiceIssueID.Text

        btnRejectRequest.Enabled = True
        btnServiceProvided.Enabled = True

    End Sub

End Class
