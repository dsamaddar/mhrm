Imports System
Imports System.Data
Imports System.Net.Mail
Imports System.Net
Imports System.IO

Partial Class EmployeeProfile_frmEmployeeLeaveManagement
    Inherits System.Web.UI.Page

    Dim LeaveData As New clsLeaveRequest()
    Dim EmployeeData As New clsEmployeeInfo()
    Dim TotalWorkingDays As Integer = 0
    Dim TotalDays As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim LoginUserID As String
            Dim EmployeeToView As String

            LoginUserID = Session("UniqueUserID")
            EmployeeToView = Session("ToWhomProShow")

            lblHolder.Text = EmployeeToView

            dtApprovedLeaveDateFrom.Text = "1/1/" + Now.Year.ToString()
            dtApprovedLeaveDateTo.Text = Now.Date
            GetLeaveType()
            getBasicProfileInfo(EmployeeToView)
            getRecemmendedInformation()
            getLeaveRequestData()

            Dim CheckApprover As String = LeaveData.IsApprover(LoginUserID)
            If CheckApprover = "Approver" Then
                pnlApprovalList.Visible = True
                idApprovalList.Visible = True
            Else
                pnlApprovalList.Visible = False
                idApprovalList.Visible = False
            End If

            Dim CheckRecommender As String = LeaveData.IsRecommender(LoginUserID)
            If CheckRecommender = "Recommender" Then
                pnlRecommendation.Visible = True
                idRecommendation.Visible = True
            Else
                pnlRecommendation.Visible = False
                idRecommendation.Visible = False
            End If

            If LoginUserID = EmployeeToView Then
                pnlLeaveRequest.Visible = True
            Else
                pnlLeaveRequest.Visible = False
            End If

            getLeaveApproval()
            getApprovedLeave()
            getPendingListOfAppLvRejReq()

            btnApproveAppLvRejReq.Enabled = False
            btnRejectAppLvRejReq.Enabled = False

        End If
    End Sub

    Protected Sub getApprovedLeave()
        Try
            Dim LoginUserD As String
            LoginUserD = Session("EmployeeID")
            grdApprovedLeave.DataSource = LeaveData.fnGetApprovedLeave(lblHolder.Text, "", "", "All")
            grdApprovedLeave.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub getPendingListOfAppLvRejReq()
        Try
            Dim LoginUserD As String
            LoginUserD = Session("EmployeeID")

            grdPendingAppLvRejReq.DataSource = LeaveData.fnGetPendingListOfAppLvRejectionReq(LoginUserD)
            grdPendingAppLvRejReq.DataBind()

            If grdPendingAppLvRejReq.Rows.Count = 0 Then
                pnlApprovedLeaveRejectionReq.Visible = False
            Else
                pnlApprovedLeaveRejectionReq.Visible = True
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub GetLeaveType()
        Try
            ddlLeaveTypeApproved.DataTextField = "LeaveType"
            ddlLeaveTypeApproved.DataValueField = "LeaveTypeID"
            ddlLeaveTypeApproved.DataSource = LeaveData.fnGetLeaveType()
            ddlLeaveTypeApproved.DataBind()
            ddlLeaveTypeApproved.Items.Insert(0, "All")
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub GetLeaveTypeForRequest(ByVal EmployeeID As String)
        Try
            ddlLeaveTypeForRequest.DataTextField = "LeaveType"
            ddlLeaveTypeForRequest.DataValueField = "LeaveTypeID"
            ddlLeaveTypeForRequest.DataSource = LeaveData.fnGetLeaveTypeGenderWise(EmployeeID)
            ddlLeaveTypeForRequest.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnSearchApprovedLeave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearchApprovedLeave.Click
        Dim DateFrom As String
        Dim DateTo As String
        Dim LeaveTypeID As String

        'Dim EmployeeID As String
        'EmployeeID = Session("EmployeeID")

        'If EmployeeID = "" Then
        '    EmployeeID = Session("UniqueUserID")
        'End If

        Try
            DateFrom = dtApprovedLeaveDateFrom.Text
            DateTo = dtApprovedLeaveDateTo.Text
            LeaveTypeID = ddlLeaveTypeApproved.SelectedValue

            If DateFrom <> "" And DateTo = "" Then
                MessageBox("Please Give Leave To")
                Exit Sub
            End If

            If DateFrom = "" And DateTo <> "" Then
                MessageBox("Please Give Leave From")
                Exit Sub
            End If

            grdApprovedLeave.DataSource = LeaveData.fnGetApprovedLeave(lblHolder.Text, DateFrom, DateTo, LeaveTypeID)
            grdApprovedLeave.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnRecommendedLeave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRecommendedLeave.Click
        Dim chk As System.Web.UI.WebControls.CheckBox
        Dim lblLeaveReqID, lblLeaveTypeID As System.Web.UI.WebControls.Label
        Dim Check As Integer = 0
        Dim LeaveRequestID As String
        Dim EmployeeID As String
        EmployeeID = Session("EmployeeID")
        Dim MailProp As New clsMailProperty()

        For Each rw As GridViewRow In grdRecommendedLeave.Rows
            chk = rw.FindControl("chkSelectRecommend")
            If chk.Checked = True Then
                lblLeaveReqID = rw.FindControl("lblLeaveRequestIDRecom")
                lblLeaveTypeID = rw.FindControl("lblLeaveTypeIDRecom")
                LeaveRequestID = lblLeaveReqID.Text
                Check = LeaveData.ChangeApplicationStatus(lblLeaveTypeID.Text, LeaveRequestID, "Recommended", "", txtRecommendationRemarks.Text)
                If Check = 1 Then
                    MailProp = LeaveData.fnGetLeaveMailInfo(LeaveRequestID, "Recommended", Session("UniqueUserID"), txtRecommendationRemarks.Text)
                    SendLeaveMail(MailProp)
                    MessageBox("Recommended")
                End If
            End If
        Next

        grdRecommendedLeave.DataSource = LeaveData.fnGetLeaveRequestForApproval(Session("UniqueUserID"), "ForRecommendation")
        grdRecommendedLeave.DataBind()

        txtRecommendationRemarks.Text = "N\A"

        If grdRecommendedLeave.Rows.Count = 0 Then
            btnRecommendedLeave.Enabled = False
            btnRecommendedReject.Enabled = False
        End If
    End Sub

    Protected Sub btnRecommendedReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRecommendedReject.Click
        Dim chk As System.Web.UI.WebControls.CheckBox
        Dim lblLeaveReqID, lblLeaveTypeID As System.Web.UI.WebControls.Label

        Dim LeaveRequestID As String
        Dim EmployeeID As String
        EmployeeID = Session("UniqueUserID")
        Dim Check As Integer = 0
        Dim MailProp As New clsMailProperty()

        For Each rw As GridViewRow In grdRecommendedLeave.Rows
            chk = rw.FindControl("chkSelectRecommend")
            If chk.Checked = True Then
                lblLeaveReqID = rw.FindControl("lblLeaveRequestIDRecom")
                lblLeaveTypeID = rw.FindControl("lblLeaveTypeIDRecom")
                LeaveRequestID = lblLeaveReqID.Text

                Check = LeaveData.ChangeApplicationStatus(lblLeaveTypeID.Text, LeaveRequestID, "Rejected", EmployeeID, txtRecommendationRemarks.Text)
                If Check = 1 Then
                    MailProp = LeaveData.fnGetLeaveMailInfo(LeaveRequestID, "Rejected", Session("UniqueUserID"), txtRecommendationRemarks.Text)
                    SendLeaveMail(MailProp)
                    MessageBox("Recommended")
                End If
            End If
        Next

        grdRecommendedLeave.DataSource = LeaveData.fnGetLeaveRequestForApproval(EmployeeID, "ForRecommendation")
        grdRecommendedLeave.DataBind()

        txtRecommendationRemarks.Text = "N\A"

        If grdRecommendedLeave.Rows.Count = 0 Then
            btnRecommendedLeave.Enabled = False
            btnRecommendedReject.Enabled = False
        End If
    End Sub

    Protected Sub getRecemmendedInformation()
        Dim RecommenderID As String
        RecommenderID = Session("RecommenderID")

        grdRecommendedLeave.DataSource = LeaveData.fnGetLeaveRequestForApproval(Session("UniqueUserID"), "ForRecommendation")
        grdRecommendedLeave.DataBind()

        If grdRecommendedLeave.Rows.Count = 0 Then
            btnRecommendedLeave.Enabled = False
            btnRecommendedReject.Enabled = False
        End If
    End Sub

    Protected Sub btnLeaveApprovalReject_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLeaveApprovalReject.Click
        Dim chk As System.Web.UI.WebControls.CheckBox
        Dim lblLeaveRequestID, lblLeaveTypeID As New System.Web.UI.WebControls.Label()

        Dim check As Integer = 0
        Dim LeaveRequestID As String
        Dim EmployeeID As String
        EmployeeID = Session("UniqueUserID")
        Dim MailProp As New clsMailProperty()

        For Each rw As GridViewRow In grdLeaveApproval.Rows
            chk = rw.FindControl("chkSelect")
            If chk.Checked = True Then
                lblLeaveRequestID = rw.FindControl("lblLeaveRequestID")
                lblLeaveTypeID = rw.FindControl("lblLeaveTypeIDApp")
                LeaveRequestID = lblLeaveRequestID.Text

                check = LeaveData.ChangeApplicationStatus(lblLeaveTypeID.Text, LeaveRequestID, "Rejected", EmployeeID, txtApproverRemarks.Text)
                If check = 1 Then
                    MailProp = LeaveData.fnGetLeaveMailInfo(LeaveRequestID, "Rejected", Session("UniqueUserID"), txtApproverRemarks.Text)
                    SendLeaveMail(MailProp)
                    MessageBox("Rejected Successfully.")
                End If
            End If
        Next

        grdLeaveApproval.DataSource = LeaveData.fnGetLeaveRequestForApproval(EmployeeID, "ForApproval")
        grdLeaveApproval.DataBind()

        txtApproverRemarks.Text = "N\A"

        If grdLeaveApproval.Rows.Count = 0 Then
            btnLeaveApproval.Enabled = False
            btnLeaveApprovalReject.Enabled = False
        End If
    End Sub

    Protected Sub btnLeaveApproval_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLeaveApproval.Click
        Dim chk As System.Web.UI.WebControls.CheckBox
        Dim check As Integer = 0
        Dim LeaveRequestID As String
        Dim lblLeaveRequestID, lblLeaveTypeID As New Label
        Dim ApproverID As String = Session("EmployeeID")
        If Session("EmployeeID") = "" Then
            ApproverID = Session("UniqueUserID")
        End If
        Dim MailProp As New clsMailProperty()

        For Each rw As GridViewRow In grdLeaveApproval.Rows
            chk = rw.FindControl("chkSelect")
            If chk.Checked = True Then
                lblLeaveRequestID = rw.FindControl("lblLeaveRequestID")
                lblLeaveTypeID = rw.FindControl("lblLeaveTypeIDApp")
                LeaveRequestID = lblLeaveRequestID.Text

                check = LeaveData.ChangeApplicationStatus(lblLeaveTypeID.Text, LeaveRequestID, "Approved", ApproverID, txtApproverRemarks.Text)
                If check = 1 Then
                    MailProp = LeaveData.fnGetLeaveMailInfo(LeaveRequestID, "Approved", Session("UniqueUserID"), txtApproverRemarks.Text)
                    SendLeaveMail(MailProp)
                    MessageBox("Approved Successfully.")
                End If
            End If
        Next

        grdLeaveApproval.DataSource = LeaveData.fnGetLeaveRequestForApproval(Session("UniqueUserID"), "ForApproval")
        grdLeaveApproval.DataBind()

        txtApproverRemarks.Text = "N\A"

        If grdLeaveApproval.Rows.Count = 0 Then
            btnLeaveApproval.Enabled = False
            btnLeaveApprovalReject.Enabled = False
        End If
    End Sub

    Protected Sub getLeaveApproval()
        Dim ApproverID As String
        ApproverID = Session("ApproverID")

        grdLeaveApproval.DataSource = LeaveData.fnGetLeaveRequestForApproval(Session("UniqueUserID"), "ForApproval")
        grdLeaveApproval.DataBind()

        If grdLeaveApproval.Rows.Count = 0 Then
            btnLeaveApproval.Enabled = False
            btnLeaveApprovalReject.Enabled = False
            pnlApprovalList.Visible = False
        Else
            btnLeaveApproval.Enabled = True
            btnLeaveApprovalReject.Enabled = True
            pnlApprovalList.Visible = True
        End If
    End Sub

    Protected Sub btnSubmitLeaveRequest_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmitLeaveRequest.Click
        Dim LeaveRequest As New clsLeaveRequest()
        Dim MailProp As New clsMailProperty()

        Dim folder As String = ""
        Dim DocExt As String = ""
        Dim FileSize As Integer = 0
        Dim DocFullName As String = ""
        Dim DocFileName As String = ""

        LeaveRequest.EmployeeID = Session("UniqueUserID")
        LeaveRequest.LeaveTypeID = ddlLeaveTypeForRequest.SelectedValue
        LeaveRequest.EmergencyAddress = Replace(txtAddress.Text, "|", ":")
        LeaveRequest.EmergencyContactNo = txtPhoneNo.Text
        LeaveRequest.EmergencyMailAddress = txtEmail.Text
        LeaveRequest.ApproverID = lblApproverID.Text
        LeaveRequest.RecommenderID = lblRecommenderID.Text
        LeaveRequest.PurposeOfLeave = txtPurpose.Text
        LeaveRequest.EntryBy = Session("LoginUserID")

        If flUpAttachment.HasFile Then
            folder = ConfigurationManager.AppSettings("InputEHRMFiles")
            FileSize = flUpAttachment.PostedFile.ContentLength()

            If FileSize > 4194304 Then
                MessageBox("File size should be within 4MB")
                Exit Sub
            End If

            DocExt = System.IO.Path.GetExtension(flUpAttachment.FileName)
            DocFileName = "Emp_Leave_att_" & DateTime.Now.ToString("ddMMyyHHmmss") & DocExt
            DocFullName = folder & DocFileName
            flUpAttachment.SaveAs(DocFullName)

            LeaveRequest.Attachment = DocFileName
        Else
            LeaveRequest.Attachment = "na.jpg"
        End If


        Dim FromDateToDateInfo As String = ""
        Dim isoFromDateToDateParts As String = ""

        Dim dtDateTimeInfo As DataTable = New DataTable()
        dtDateTimeInfo = Session("DateTimeInfo")

        Dim LeveReq As New clsLeaveRequest()
        For Each rw As DataRow In dtDateTimeInfo.Rows
            LeveReq.EmployeeID = Session("UniqueUserID")
            LeveReq.LeaveFrom = rw.Item("LeaveFrom")
            LeveReq.LeaveTo = rw.Item("LeaveTo")
            LeveReq.TotalDays = rw.Item("TotalDays")
            LeveReq.InBetweenHolidays = rw.Item("TotalWorkingDays")
            LeveReq.PurposeOfLeave = rw.Item("PurposeOfLeave")

            LeveReq.TotalWorkingDays = rw.Item("TotalWorkingDays")
            LeveReq.EventName = "Requested"

            MailProp = LeaveData.fnGetLeaveMailInfoSubmitted(LeveReq)
            SendLeaveMail(MailProp)
            isoFromDateToDateParts = isoFromDateToDateParts & LeveReq.LeaveFrom & "~" & LeveReq.LeaveTo & "~" & LeveReq.TotalDays & "~" & LeveReq.InBetweenHolidays & "~" & LeveReq.PurposeOfLeave & "~|"
        Next

        Dim check As Integer = LeaveData.fnInsertLeaveRequest(LeaveRequest, isoFromDateToDateParts)

        If check = 1 Then
            MessageBox("Submitted Successfully.")
            ClearLeaveRequest()
            dtDateTimeInfo.Reset()
            grdCalculationDay.DataSource = dtDateTimeInfo
            grdCalculationDay.DataBind()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub SendLeaveMail(ByVal MailProp As clsMailProperty)
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
            Dim smtp As New SmtpClient("192.168.1.14", 25)
            smtp.Send(mail)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnCalWorkDay_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCalWorkDay.Click
        Try
            Dim DateFrom, DateTo As Date
            Dim TotalHoliday, LeaveDays, TotalApplied As Integer

            If Convert.ToDateTime(dtLeaveRequestDateFrom.Text) < DateAdd(DateInterval.Month, -14, Now.Date) Or Convert.ToDateTime(dtLeaveRequestDateTo.Text) < DateAdd(DateInterval.Month, -14, Now.Date) Then
                Response.Write("You Can't Apply For a Leave Older Than One Year.")
                Exit Sub
            End If

            DateFrom = dtLeaveRequestDateFrom.Text
            DateTo = dtLeaveRequestDateTo.Text

            Dim Check As Integer = LeaveData.fnGetCalcucationWorkingDay(DateFrom, DateTo, TotalHoliday, LeaveDays, TotalApplied)

            If Check = 1 Then
                lblWorkDycnt.Text = LeaveDays
                lblHlidayCnt.Text = TotalHoliday
                lblTAplidcnt.Text = TotalApplied

                btnSubmitLeaveRequest.Enabled = True
                btnLeaveRequestClear.Enabled = True

                If DateFrom > DateTo Then
                    MessageBox("Date from can not greater than date To")
                    Exit Sub
                End If

                Dim LeaveRequest As New clsLeaveRequest()

                LeaveRequest.LeaveFrom = dtLeaveRequestDateFrom.Text
                LeaveRequest.LeaveTo = dtLeaveRequestDateTo.Text
                LeaveRequest.TotalDays = lblTAplidcnt.Text
                LeaveRequest.InBetweenHolidays = lblWorkDycnt.Text
                LeaveRequest.PurposeOfLeave = Replace(txtPurpose.Text, "|", ":")

                Dim dt As DataTable = GetDateTimeData(LeaveRequest)

                If lblMsg.Text = "" Then
                    Session("DateTimeInfo") = dt
                    'grdCertification.DataSource = dt
                End If

                grdCalculationDay.DataSource = Session("DateTimeInfo")
                grdCalculationDay.DataBind()
                ClearDateTimeData()
            Else
                btnSubmitLeaveRequest.Enabled = False
                btnLeaveRequestClear.Enabled = False
                dtLeaveRequestDateFrom.Enabled = True
                dtLeaveRequestDateTo.Enabled = True
                btnCalWorkDay.Enabled = True
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ClearLeaveRequest()
        ddlLeaveTypeForRequest.SelectedIndex = 0
        dtLeaveRequestDateFrom.Text = ""
        dtLeaveRequestDateTo.Text = ""
        txtAddress.Text = ""
        txtEmail.Text = ""
        txtPhoneNo.Text = ""
        txtPurpose.Text = ""
        lblTAplidcnt.Text = ""
        lblWorkDycnt.Text = ""
        lblHlidayCnt.Text = ""
        dtLeaveRequestDateFrom.Enabled = True
        dtLeaveRequestDateTo.Enabled = True
        btnSubmitLeaveRequest.Enabled = False
        btnLeaveRequestClear.Enabled = False
        btnCalWorkDay.Enabled = True
        grdCalculationDay.DataSourceID = ""
        grdCalculationDay.DataBind()

        Dim dtDateTimeInfo As DataTable = New DataTable()
        dtDateTimeInfo = FormatDateTimeInfo()
        Session("DateTimeInfo") = dtDateTimeInfo

    End Sub

    Protected Sub btnLeaveRequestClear_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLeaveRequestClear.Click
        ClearLeaveRequest()
    End Sub

    Protected Function FormatDateTimeInfo() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("LeaveFrom", System.Type.GetType("System.DateTime"))
        dt.Columns.Add("LeaveTo", System.Type.GetType("System.DateTime"))
        dt.Columns.Add("TotalDays", GetType(Integer))
        dt.Columns.Add("TotalWorkingDays", GetType(Integer))
        dt.Columns.Add("PurposeOfLeave", System.Type.GetType("System.String"))
        Return dt
    End Function

    Protected Function GetDateTimeData(ByVal LeaveRequest As clsLeaveRequest) As DataTable
        lblMsg.Text = ""
        Dim dtDateTimeInfo As DataTable = Session("DateTimeInfo")

        Dim EmployeeID As String
        EmployeeID = Session("EmployeeID")
        Dim IsValidEntry As Boolean = True

        Dim dr As DataRow
        dr = dtDateTimeInfo.NewRow()
        dr("LeaveFrom") = String.Format("{0:dd MMM yyyy}", LeaveRequest.LeaveFrom)
        dr("LeaveTo") = String.Format("{0:dd MMM yyyy}", LeaveRequest.LeaveTo)
        dr("TotalDays") = lblTAplidcnt.Text
        dr("TotalWorkingDays") = lblWorkDycnt.Text
        dr("PurposeOfLeave") = LeaveRequest.PurposeOfLeave


        Dim Check As String = LeaveData.CheckAvailableDate(EmployeeID, LeaveRequest.LeaveFrom, LeaveRequest.LeaveTo)
        If Check = "Approved" Or Check = "Pending" Then
            lblMsg.Text = "Date Range is Already Exist in " + Check + " list"
            MessageBox(lblMsg.Text)
            IsValidEntry = False
            Return dtDateTimeInfo
        Else
            lblMsg.Text = ""
        End If

        For Each rw As DataRow In dtDateTimeInfo.Rows
            Dim dtLeaveFrom As DateTime
            Dim dtLeaveTo As DateTime

            dtLeaveFrom = rw.Item("LeaveFrom").ToString()
            dtLeaveTo = rw.Item("LeaveTo").ToString()

            If LeaveRequest.LeaveFrom <= dtLeaveFrom And LeaveRequest.LeaveTo >= dtLeaveFrom Then
                lblMsg.Text = "Date Range is Already Exist In the List"
                MessageBox("Date Range is Already Exist In the List")
                IsValidEntry = False
                Exit For
            End If

            If LeaveRequest.LeaveFrom <= dtLeaveTo And LeaveRequest.LeaveTo >= dtLeaveTo Then
                MessageBox("Date Range is Already Exist In the List")
                lblMsg.Text = "Date Range is Already Exist In the List"
                IsValidEntry = False
                Exit For
            End If

        Next

        If IsValidEntry = True Then
            dtDateTimeInfo.Rows.Add(dr)
            dtDateTimeInfo.AcceptChanges()
            btnSubmitLeaveRequest.Enabled = True
        End If

        Return dtDateTimeInfo

    End Function

    Protected Sub ClearDateTimeData()
        dtLeaveRequestDateFrom.Text = ""
        dtLeaveRequestDateTo.Text = ""
        lblTAplidcnt.Text = ""
        lblWorkDycnt.Text = ""
        lblHlidayCnt.Text = ""
        txtPurpose.Text = ""
    End Sub

    Protected Sub grdCalculationDay_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdCalculationDay.RowDeleting
        btnSubmitLeaveRequest.Enabled = True
        Dim i As Integer
        Dim dtDateTimeInfo As DataTable = New DataTable()

        dtDateTimeInfo = Session("DateTimeInfo")

        i = e.RowIndex

        dtDateTimeInfo.Rows(i).Delete()
        dtDateTimeInfo.AcceptChanges()
        grdCalculationDay.DataSource = dtDateTimeInfo
        grdCalculationDay.DataBind()
    End Sub

    Protected Sub getLeaveRequestData()
        idLabel.Visible = False
        Dim EmployeeID As String = ""
        Dim EntryByID As String = ""
        Dim Approver As String = ""
        Dim ApproverID As String = ""
        Dim Recommender As String = ""
        Dim RecommenderID As String = ""
        Dim TotalLeave As Integer = 0
        Dim LeaveTaken As Integer = 0

        EmployeeID = Session("EmployeeID")

        If EmployeeID = "" Then
            EmployeeID = Session("UniqueUserID")
        End If


        Dim dtDateTimeInfo As DataTable = New DataTable()
        dtDateTimeInfo = FormatDateTimeInfo()
        Session("DateTimeInfo") = dtDateTimeInfo

        'Dim Flag As Integer = LeaveData.fnGetLeaveBalance(EmployeeID, TotalLeave, LeaveTaken)
        'If Flag = 1 Then
        '    lblTLeveCnt.Text = TotalLeave
        '    lblLeveTknCnt.Text = LeaveTaken
        '    lblBlceCnt.Text = TotalLeave - LeaveTaken
        'End If

        Dim Check As Integer = LeaveData.fnGetApproverRecommender(Session("UniqueUserID"), Approver, ApproverID, Recommender, RecommenderID)

        If Check = 1 Then
            lblApprover.Text = Approver
            lblApproverID.Text = ApproverID
            lblRecommender.Text = Recommender
            lblRecommenderID.Text = RecommenderID
        End If

        EntryByID = Session("LoginUserID")
        GetLeaveTypeForRequest(EmployeeID)

        btnSubmitLeaveRequest.Enabled = False
        btnLeaveRequestClear.Enabled = False
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
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

    Protected Sub grdApprovedLeave_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdApprovedLeave.RowDataBound
        Dim lblTotalWorkingDays, lblTotalDays, lblLeaveStatus As New Label()

        If e.Row.RowType = DataControlRowType.DataRow Then
            lblTotalWorkingDays = e.Row.FindControl("lblTotalWorkingDays")
            lblTotalDays = e.Row.FindControl("lblTotalDays")
            lblLeaveStatus = e.Row.FindControl("lblLeaveStatus")
            TotalWorkingDays += Convert.ToInt32(lblTotalWorkingDays.Text)
            TotalDays += Convert.ToInt32(lblTotalDays.Text)
            If lblLeaveStatus.Text <> "Approved" Then
                e.Row.Cells(8).Font.Bold = True
                e.Row.Cells(8).ForeColor = Drawing.Color.Red
            End If
        End If

        If e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(2).Text = "Total:"
            e.Row.Cells(3).Text = TotalDays.ToString()
            e.Row.Cells(4).Text = TotalWorkingDays.ToString()
        End If
    End Sub

    Protected Sub grdPendingAppLvRejReq_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdPendingAppLvRejReq.SelectedIndexChanged
        txtRemarksAppLvRejReq.Enabled = True
        btnApproveAppLvRejReq.Enabled = True
        btnRejectAppLvRejReq.Enabled = True
    End Sub

    Protected Sub btnApproveAppLvRejReq_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApproveAppLvRejReq.Click

        Dim LeaveReq As New clsLeaveRequest()

        Dim lblAppLeaveRejectionID As New Label

        lblAppLeaveRejectionID = grdPendingAppLvRejReq.SelectedRow.FindControl("lblAppLeaveRejectionID")

        LeaveReq.AppLeaveRejectionID = lblAppLeaveRejectionID.Text
        LeaveReq.ActionType = "Approved"
        LeaveReq.ActorRemarks = txtRemarksAppLvRejReq.Text

        Dim check As Integer = LeaveData.fnApproveApprovedleaveRejection(LeaveReq)

        If check = 1 Then
            MessageBox("Request Approved.")
            ClearAppLvRejReq()
        Else
            MessageBox("Error Occured.")
        End If

    End Sub

    Protected Sub ClearAppLvRejReq()
        getPendingListOfAppLvRejReq()

        btnApproveAppLvRejReq.Enabled = False
        btnRejectAppLvRejReq.Enabled = False
    End Sub

    Protected Sub btnRejectAppLvRejReq_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRejectAppLvRejReq.Click
        Dim LeaveReq As New clsLeaveRequest()

        Dim lblAppLeaveRejectionID As New Label

        lblAppLeaveRejectionID = grdPendingAppLvRejReq.SelectedRow.FindControl("lblAppLeaveRejectionID")

        LeaveReq.AppLeaveRejectionID = lblAppLeaveRejectionID.Text
        LeaveReq.ActionType = "Rejected"
        LeaveReq.ActorRemarks = txtRemarksAppLvRejReq.Text

        Dim check As Integer = LeaveData.fnApproveApprovedleaveRejection(LeaveReq)

        If check = 1 Then
            MessageBox("Request Rejected.")
            ClearAppLvRejReq()
        Else
            MessageBox("Error Occured.")
        End If
    End Sub

End Class
