Imports System
Imports System.Data
Imports System.Net.Mail
Imports System.Net
Imports System.IO

Partial Class EmployeeProfile_frmHRServiceRequest
    Inherits System.Web.UI.Page

    Dim HRServiceData As New clsHRServices()
    Dim HRServiceRequestData As New clsHRServiceRequest()
    Dim EmployeeData As New clsEmployeeInfo()

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim HRServiceRequest As New clsHRServiceRequest()

        If drpHRServices.SelectedIndex = 0 Then
            MessageBox("Select Proper Service Request.")
            Exit Sub
        End If

        HRServiceRequest.EmployeeID = Session("UniqueUserID")
        HRServiceRequest.HRServiceID = drpHRServices.SelectedValue
        HRServiceRequest.EffectiveDate = Convert.ToDateTime(txtEffectiveDate.Text)
        HRServiceRequest.Remarks = txtRemarks.Text
        HRServiceRequest.EntryBy = Session("LoginUserID")

        Dim check As Integer = HRServiceRequestData.fnInsertHRServiceIssue(HRServiceRequest)

        If check = 1 Then
            MessageBox("Submitted.")
            ClearForm()
            GetServiceReqByEmp(Session("UniqueUserID"))
            SendHRServiceRequestMail(HRServiceRequestData.fnGetHRServiceMailInfoSubmitted(HRServiceRequest))
        End If

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

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            txtEffectiveDate.Text = Now.Date
            GetActiveHRServices()
            getBasicProfileInfo(Session("ToWhomProShow"))
            GetServiceReqByEmp(Session("UniqueUserID"))
        End If
    End Sub

    Protected Sub GetServiceReqByEmp(ByVal EmployeeID As String)
        grdEmpWiseHRServices.DataSource = HRServiceRequestData.fnGetHRServiceIssueByEmp(EmployeeID)
        grdEmpWiseHRServices.DataBind()
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

    Protected Sub ClearForm()
        txtEffectiveDate.Text = Now.Date
        txtRemarks.Text = ""
        drpHRServices.SelectedIndex = -1
    End Sub

    Protected Sub GetActiveHRServices()
        drpHRServices.DataTextField = "HRService"
        drpHRServices.DataValueField = "HRServiceID"
        drpHRServices.DataSource = HRServiceData.fnGetActiveHRServices()
        drpHRServices.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        drpHRServices.Items.Insert(0, A)
    End Sub

    Protected Sub drpHRServices_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpHRServices.SelectedIndexChanged
        Dim HRServices As New clsHRServices()
        Try
            HRServices.HRServiceID = drpHRServices.SelectedValue
            HRServices = HRServiceData.fnGetHRServiceInstruction(HRServices)

            lblHRServiceReqInstruction.Text = HRServices.HRServiceReqInstruction
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
     
    End Sub

End Class
