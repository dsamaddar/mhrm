Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.OleDb
Imports System.Data.Common
Imports System.Net
Imports System.IO
Imports System.Math
Imports System.Configuration
Imports System.Web.UI

Partial Class EmployeeProfile_frmEmpEduInfo
    Inherits System.Web.UI.Page

    Dim Common As New clsCommon()
    Dim EmployeeData As New clsEmployeeInfo()

#Region "Education"

    Protected Sub btnNext_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmitEmpEduInfo.Click
        Try
            Dim UserID, EmployeeID As String
            UserID = Session("LoginUserID")
            EmployeeID = Session("EmployeeID")

            Dim RegistrationID As String
            RegistrationID = Session("RegistrationID")

            If grdEducation.Rows.Count <= 0 Then
                MessageBox("An Exam Must Have At Least One Subject.")
                Exit Sub
            End If

            Dim EmployeeEduInfo As String = ""
            Dim isoParts As String = ""

            Dim dtEducationInfo As DataTable = New DataTable()
            dtEducationInfo = Session("EmployeeEduInfo")

            Dim EduInfo As New clsEducation()
            For Each rw As DataRow In dtEducationInfo.Rows
                EduInfo.DegreeType = rw.Item("DegreeType")
                EduInfo.ExamID = rw.Item("ExamID")
                EduInfo.MajorID = rw.Item("MajorID")
                EduInfo.PassingYear = rw.Item("PassingYear")
                EduInfo.InstitutionID = rw.Item("InstitutionID")
                EduInfo.OtherInstitutionName = rw.Item("OtherInstitutionName")
                EduInfo.ResultType = rw.Item("ResultType")
                EduInfo.Result = rw.Item("Result")

                If rw.Item("OutOf") = "N\A" Then
                    EduInfo.OutOf = 0
                Else
                    EduInfo.OutOf = rw.Item("OutOf")
                End If

                isoParts = isoParts & EduInfo.DegreeType & "~" & EduInfo.ExamID & "~" & EduInfo.MajorID & "~" & EduInfo.PassingYear & "~" & EduInfo.InstitutionID & "~" & EduInfo.OtherInstitutionName & "~" & EduInfo.ResultType & "~" & EduInfo.Result & "~" & EduInfo.OutOf & "~|"
            Next

            If btnAddInstitution.Text = "Insert" Then
                MessageBox("Insert Institution Name")
                Exit Sub
            End If

            Dim Check As Integer = EmployeeData.SubmitEducationInformation(lblHolder.Text, isoParts)
            If Check = 1 Then
                MessageBox("Inserted Successfully")
                btnSubmitEmpEduInfo.Enabled = False
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Function FormatEducationInfo() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("DegreeType", System.Type.GetType("System.String"))
        dt.Columns.Add("ExamID", System.Type.GetType("System.String"))
        dt.Columns.Add("ExamName", System.Type.GetType("System.String"))
        dt.Columns.Add("MajorID", System.Type.GetType("System.String"))
        dt.Columns.Add("Major", System.Type.GetType("System.String"))
        dt.Columns.Add("PassingYear", System.Type.GetType("System.Double"))
        dt.Columns.Add("InstitutionID", System.Type.GetType("System.String"))
        dt.Columns.Add("InstitutionName", System.Type.GetType("System.String"))
        dt.Columns.Add("OtherInstitutionName", System.Type.GetType("System.String"))
        dt.Columns.Add("ResultType", System.Type.GetType("System.String"))
        dt.Columns.Add("Result", System.Type.GetType("System.String"))
        dt.Columns.Add("OutOf", System.Type.GetType("System.Decimal"))
        Return dt
    End Function

    Protected Sub btnAddEdu_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddEdu.Click
        Try
            If ddlMajor.SelectedValue = "-Select-" Then
                MessageBox("Select Major Name")
                Exit Sub
            End If

            If ddlPassingYear.SelectedValue = "YYYY" Then
                MessageBox("Select Passing Year")
                Exit Sub
            End If

            If ddlResultType.SelectedValue = "-Select-" Then
                MessageBox("Select Result Type")
                Exit Sub
            End If

            Dim EmpEduInfo As New clsEducation

            EmpEduInfo.DegreeType = rdoDegreeType.SelectedValue
            EmpEduInfo.ExamID = ddlExamName.SelectedValue
            EmpEduInfo.ExamName = ddlExamName.SelectedItem.ToString()
            EmpEduInfo.MajorID = ddlMajor.SelectedValue
            EmpEduInfo.Major = ddlMajor.SelectedItem.ToString()
            EmpEduInfo.PassingYear = Convert.ToInt16(ddlPassingYear.SelectedValue)
            EmpEduInfo.InstitutionID = ddlBoard.SelectedValue
            EmpEduInfo.InstitutionName = ddlBoard.SelectedItem.ToString()
            EmpEduInfo.OtherInstitutionName = Common.CheckAsciiValue(txtOtherInsName.Text)
            EmpEduInfo.ResultType = ddlResultType.SelectedValue

            If EmpEduInfo.ResultType = "GPA" Then
                EmpEduInfo.Result = txtResult.Text
                EmpEduInfo.OutOf = txtOutOf.Text

                If EmpEduInfo.Result > EmpEduInfo.OutOf Then
                    MessageBox("Result should be less than or Equal to Out of")
                    Exit Sub
                End If

            ElseIf EmpEduInfo.ResultType = "Division" Then
                EmpEduInfo.Result = ddlDivision.SelectedValue
                EmpEduInfo.OutOf = "0"

            ElseIf EmpEduInfo.ResultType = "Appeared" Then
                EmpEduInfo.Result = ""
                EmpEduInfo.OutOf = "0"
            End If

            Dim dt As DataTable = GetEducationData(EmpEduInfo)
            Session("EmployeeEduInfo") = dt

            grdEducation.DataSource = dt
            grdEducation.DataBind()
            ClearEducationData()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Function GetEducationData(ByVal EmpEduInfo As clsEducation) As DataTable

        Dim dtEducationInfo As DataTable = Session("EmployeeEduInfo")

        If (CheckDuplicateEducationEntry() = 0) Then
            lblErrorMessageOnEDU.Text = "You Can't Insert Duplicate Exam Name."
            Return dtEducationInfo
        End If
        Dim dr As DataRow
        dr = dtEducationInfo.NewRow()
        dr("DegreeType") = EmpEduInfo.DegreeType
        dr("ExamID") = EmpEduInfo.ExamID
        dr("ExamName") = EmpEduInfo.ExamName
        dr("MajorID") = EmpEduInfo.MajorID
        dr("Major") = EmpEduInfo.Major
        dr("PassingYear") = EmpEduInfo.PassingYear
        dr("InstitutionID") = EmpEduInfo.InstitutionID
        dr("InstitutionName") = EmpEduInfo.InstitutionName
        dr("OtherInstitutionName") = EmpEduInfo.OtherInstitutionName
        dr("ResultType") = EmpEduInfo.ResultType
        dr("Result") = EmpEduInfo.Result

        If EmpEduInfo.InstitutionName = "Others" Then
            dr("InstitutionName") = EmpEduInfo.InstitutionName + "(" + EmpEduInfo.OtherInstitutionName + ")"
        Else
            dr("OtherInstitutionName") = "N\A"
        End If
        If EmpEduInfo.OutOf = 0 Then
            dr("OutOf") = "N\A"
        Else
            dr("OutOf") = EmpEduInfo.OutOf
        End If

        dtEducationInfo.Rows.Add(dr)
        dtEducationInfo.AcceptChanges()

        btnSubmitEmpEduInfo.Enabled = True
        ForGPA.Visible = False
        ForDivision.Visible = False
        idForOthers.Visible = False
        Return dtEducationInfo
    End Function

    Public Function CheckDuplicateEducationEntry() As Integer
        Dim lbl As System.Web.UI.WebControls.Label
        For Each rw As GridViewRow In grdEducation.Rows
            lbl = rw.FindControl("lblExamName")
            If lbl.Text = Nothing Then
                Return 0
            End If
            If ddlExamName.SelectedItem.ToString() = lbl.Text Then
                MessageBox("You Can't Insert Duplicate Exam Name.")
                Return 0
            End If
        Next
        Return 1
    End Function

    Protected Sub ClearEducationData()
        ddlExamName.SelectedIndex = -1
        ddlMajor.SelectedIndex = -1
        ddlPassingYear.SelectedIndex = -1
        ddlBoard.SelectedIndex = -1
        ddlResultType.SelectedIndex = -1
        txtResult.Text = ""
        ddlDivision.SelectedIndex = -1
        txtOutOf.Text = ""
    End Sub

    Protected Sub ddlResultType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlResultType.SelectedIndexChanged
        If ddlResultType.SelectedValue = "GPA" Then
            ForGPA.Visible = True
            ForDivision.Visible = False
        ElseIf ddlResultType.SelectedValue = "Division" Then
            ForGPA.Visible = False
            ForDivision.Visible = True
        Else
            ForGPA.Visible = False
            ForDivision.Visible = False
        End If
        SetFocus(grdEducation)
    End Sub

    Protected Sub grdEducation_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdEducation.RowDeleting

        btnSubmitEmpEduInfo.Enabled = True
        Dim i As Integer
        Dim dtEducationInfo As DataTable = New DataTable()

        dtEducationInfo = Session("EmployeeEduInfo")

        i = e.RowIndex

        dtEducationInfo.Rows(i).Delete()
        dtEducationInfo.AcceptChanges()
        grdEducation.DataSource = dtEducationInfo
        grdEducation.DataBind()

        Dim EmployeeID As String
        EmployeeID = Session("EmployeeID")

        If dtEducationInfo.Rows.Count = 0 Then
            btnSubmitEmpEduInfo.Enabled = False
        End If

    End Sub

    Protected Sub btnAddInstitution_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddInstitution.Click
        Dim UserID As String
        UserID = Session("LoginUserID")

        If btnAddInstitution.Text = "ADD" Then
            lblInstitutionAdd.Visible = True
            btnAddInstitution.Text = "Insert"
        Else
            Dim InstitutionName As String
            Dim EntryBy As String
            Dim IsActive As Integer = 1

            InstitutionName = txtBoard.Text
            EntryBy = UserID

            If InstitutionName = "" Then
                Exit Sub
            End If

            Dim check As Integer = EmployeeData.AddInstitutionName(InstitutionName, 1, EntryBy)

            If check = 1 Then
                MessageBox("Inserted")
                txtBoard.Text = ""
                ShowInstitutionList()
                lblInstitutionAdd.Visible = False
                btnAddInstitution.Text = "ADD"
            Else
                MessageBox("Error Found")
            End If
        End If

    End Sub

    Protected Sub ShowInstitutionList()
        ddlBoard.DataTextField = "InstitutionName"
        ddlBoard.DataValueField = "InstitutionID"
        ddlBoard.DataSource = EmployeeData.fnGetInstitutionList()
        ddlBoard.DataBind()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        lblInstitutionAdd.Visible = False
        btnAddInstitution.Text = "ADD"
    End Sub

    Protected Sub ddlBoard_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlBoard.SelectedIndexChanged
        If ddlBoard.SelectedItem.Text = "Others" Then
            idForOthers.Visible = True
        Else
            idForOthers.Visible = False
        End If

        SetFocus(grdEducation)
    End Sub

    Protected Sub rdoDegreeType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rdoDegreeType.SelectedIndexChanged
        If rdoDegreeType.SelectedValue = "Foreign" Then
            ddlBoard.SelectedIndex = ddlBoard.Items.IndexOf(ddlBoard.Items.FindByText("Others"))
            ddlBoard.Enabled = False
            idForOthers.Visible = True
        Else
            ShowInstitutionList()
            ddlBoard.Enabled = True
            idForOthers.Visible = False
        End If
        SetFocus(grdEducation)
    End Sub

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserName") = "" Or Session("UniqueUserID") = "" Then
            Response.Redirect("~/frmHRMLogin.aspx")
        End If
        If Not IsPostBack Then
            Dim LoginUserId As String = Session("UniqueUserID")

            Dim ToWhomProShow As String = Session("ToWhomProShow")
            lblHolder.Text = ToWhomProShow

            getBasicProfileInfo(ToWhomProShow)

            If LoginUserId = ToWhomProShow Then
                Dim Check As Boolean = Common.CheckPermissionForOwnInfo(LoginUserId)
                If Check = True Then
                    pnlEduInfo.Visible = True
                    pnlEducation.Visible = True
                    pnlEduQuaSave.Visible = True
                Else
                    pnlEduInfo.Visible = False
                    pnlEducation.Visible = True
                    pnlEduQuaSave.Visible = False
                End If
            Else
                Dim Check As Boolean = Common.CheckPermissionForOthers(LoginUserId)
                If Check = True Then
                    pnlEduInfo.Visible = True
                    pnlEducation.Visible = True
                    pnlEduQuaSave.Visible = True
                Else
                    pnlEduInfo.Visible = False
                    pnlEducation.Visible = True
                    pnlEduQuaSave.Visible = False
                End If
            End If

            btnAddInstitution.Enabled = False

            Dim Secmsg As String = Request.QueryString("msg")

            If Secmsg <> 1 Then
                Session("Message") = ""
            End If

            Dim lblMessage As String

            lblMessage = Session("Message")

            Dim UserID As String
            Dim UserName As String
            UserID = Session("LoginUserID")
            UserName = Session("UserName")
            Dim EmployeeID As String
            EmployeeID = Session("EmployeeID")

            btnSubmitEmpEduInfo.Enabled = False
            idForOthers.Visible = False

            lblInstitutionAdd.Visible = False
            ShowInstitutionList()

            getMajorName()
            getExamName()
            getInstitutionName()

            If ddlResultType.SelectedValue = "-Select-" Then
                ForGPA.Visible = False
                ForDivision.Visible = False
            End If


            Dim dtEducationInfo As DataTable = New DataTable()
            dtEducationInfo = FormatEducationInfo()
            Session("EmployeeEduInfo") = dtEducationInfo

            dtEducationInfo = EmployeeData.fnGetEducationInformation(lblHolder.Text).Tables(0)
            grdEducation.DataSource = dtEducationInfo
            grdEducation.DataBind()
            Session("EmployeeEduInfo") = dtEducationInfo

            rdoDegreeType.SelectedIndex = 0
        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub getExamName()
        ddlExamName.DataValueField = "ExamID"
        ddlExamName.DataTextField = "ExamName"
        ddlExamName.DataSource = EmployeeData.fnGetExamName()
        ddlExamName.DataBind()
    End Sub

    Protected Sub getMajorName()
        ddlMajor.DataValueField = "MajorTypeID"
        ddlMajor.DataTextField = "MajorType"
        ddlMajor.DataSource = EmployeeData.fnGetMajorName()
        ddlMajor.DataBind()

        ddlMajor.Items.Insert(0, "-Select-")
    End Sub

    Protected Sub getInstitutionName()
        ddlBoard.DataValueField = "InstitutionID"
        ddlBoard.DataTextField = "InstitutionName"
        ddlBoard.DataSource = EmployeeData.fnGetInstituteName()
        ddlBoard.DataBind()
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
        Try
            Dim tClient As WebClient = New WebClient
            Dim memStrmPic As MemoryStream = New MemoryStream(tClient.DownloadData(UrlStr))
            Dim bytesPic As Byte() = memStrmPic.ToArray()
            Dim base64StringPic As String = Convert.ToBase64String(bytesPic, 0, bytesPic.Length)

            Dim imgCtrl As System.Web.UI.WebControls.Image = Master.FindControl(ControlName)
            imgCtrl.ImageUrl = "data:image/png;base64," & base64StringPic
            memStrmPic.Dispose()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

End Class
