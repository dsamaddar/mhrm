Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Net
Imports System.IO

Partial Class EmployeeProfile_frmEmpProfCertification
    Inherits System.Web.UI.Page

    Dim Common As New clsCommon()
    Dim EmpInfoData As New clsEmployeeInfo()
    Dim profData As New clsProfessionalCertification()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("UserName") = "" Or Session("UniqueUserID") = "" Then
            Response.Redirect("~/frmHRMLogin.aspx")
        End If

        If Not IsPostBack Then
            Try
                Dim LoginUserId As String = Session("UniqueUserID")
                Dim ToWhomProShow As String = Session("ToWhomProShow")

                getBasicProfileInfo(ToWhomProShow)

                Dim dtProfessionalCertificationInfo As DataTable = New DataTable()
                dtProfessionalCertificationInfo = FormatProfessionalCertificationInfo()
                Session("EmployeeProfessionalCertificationInfo") = dtProfessionalCertificationInfo

                dtProfessionalCertificationInfo = profData.fnGetProCertificationInformation(ToWhomProShow).Tables(0)
                If dtProfessionalCertificationInfo.Rows.Count > 0 Then
                    grdCertification.DataSource = dtProfessionalCertificationInfo
                    grdCertification.DataBind()
                    Session("EmployeeProfessionalCertificationInfo") = dtProfessionalCertificationInfo
                End If

                If LoginUserId = ToWhomProShow Then
                    Dim Check As Boolean = Common.CheckPermissionForOwnInfo(LoginUserId)
                    If Check = True Then
                        pnlEmpProfCertificationInfo.Visible = True
                        pnlCertification.Visible = True
                        pnlProfCertSave.Visible = True
                    Else
                        pnlEmpProfCertificationInfo.Visible = False
                        pnlCertification.Visible = True
                        pnlProfCertSave.Visible = False
                    End If
                Else
                    Dim Check As Boolean = Common.CheckPermissionForOthers(LoginUserId)
                    If Check = True Then
                        pnlEmpProfCertificationInfo.Visible = True
                        pnlCertification.Visible = True
                        pnlProfCertSave.Visible = True
                    Else
                        pnlEmpProfCertificationInfo.Visible = False
                        pnlCertification.Visible = True
                        pnlProfCertSave.Visible = False
                    End If
                End If

                btnSubmit.Enabled = False
                
            Catch ex As Exception
                MessageBox(ex.Message)
            End Try
        End If
    End Sub

    Protected Sub getBasicProfileInfo(ByVal EmployeeID As String)
        Try
            Dim EmpInfo As New clsEmployeeInfo()
            EmpInfo = EmpInfoData.fnGetBasicProfile(EmployeeID)

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

#Region "Professional Certification"

    Protected Function FormatProfessionalCertificationInfo() As DataTable
        Dim dt As DataTable = New DataTable()
        dt.Columns.Add("CertificationName", System.Type.GetType("System.String"))
        dt.Columns.Add("InstituteName", System.Type.GetType("System.String"))
        dt.Columns.Add("Location", System.Type.GetType("System.String"))
        dt.Columns.Add("IssuingDate", System.Type.GetType("System.DateTime"))
        dt.Columns.Add("ExpireDate", System.Type.GetType("System.DateTime"))
        dt.Columns.Add("NeverExpire", System.Type.GetType("System.String"))
        Return dt
    End Function

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnAddCerti_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddCerti.Click
        Try
            Dim Checkdate As Boolean
            If drpDay.SelectedValue = "DD" Or drpMonth.SelectedValue = "MM" Or drpYear.SelectedValue = "YYYY" Then
                MessageBox("Select Issuing Date Parameter Correctly.")
                Exit Sub
            End If

            If chkNeverExpire.Checked = False Then
                If drpDayTo.SelectedValue = "DD" Or drpMonthTo.SelectedValue = "MM" Or drpYearTo.SelectedValue = "YYYY" Then
                    MessageBox("Select Expire Date Parameter Correctly.")
                    Exit Sub
                End If
            End If

            Dim EmployeeProfessionCerti As New clsProfessionalCertification()

            EmployeeProfessionCerti.CertificationName = txtCertificationName.Text
            EmployeeProfessionCerti.InstituteName = txtInstitutionName.Text
            EmployeeProfessionCerti.Location = txtLocation.Text
            Checkdate = IsDate(drpMonth.SelectedValue + "/" + drpDay.SelectedValue + "/" + drpYear.SelectedValue)

            If Checkdate = False Then
                MessageBox("Please Enter a Valid ISSUING DATE")
                Exit Sub
            End If
            EmployeeProfessionCerti.DateFrom = drpMonth.SelectedValue + "/" + drpDay.SelectedValue + "/" + drpYear.SelectedValue

            EmployeeProfessionCerti.NeverExpire = chkNeverExpire.Checked

            If chkNeverExpire.Checked = True Then
                EmployeeProfessionCerti.DateTo = "1911-01-01"
            Else
                Checkdate = IsDate(drpMonthTo.SelectedValue + "/" + drpDayTo.SelectedValue + "/" + drpYearTo.SelectedValue)
                If Checkdate = False Then
                    MessageBox("Please Enter a Valid EXPIRE DATE")
                    Exit Sub
                End If
                EmployeeProfessionCerti.DateTo = drpMonthTo.SelectedValue + "/" + drpDayTo.SelectedValue + "/" + drpYearTo.SelectedValue
            End If

            Dim dt As DataTable = GetProfessionalCertificationData(EmployeeProfessionCerti)
            Session("EmployeeProfessionalCertificationInfo") = dt

            grdCertification.DataSource = dt
            grdCertification.DataBind()
            ClearProfessionalCertificationData()
            btnSubmit.Enabled = True
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Function GetProfessionalCertificationData(ByVal EmployeeProfessionCerti As clsProfessionalCertification) As DataTable

        Dim dtProfessionalCertificationInfo As DataTable = Session("EmployeeProfessionalCertificationInfo")

        Dim dr As DataRow
        dr = dtProfessionalCertificationInfo.NewRow()
        dr("CertificationName") = EmployeeProfessionCerti.CertificationName
        dr("InstituteName") = EmployeeProfessionCerti.InstituteName
        dr("Location") = EmployeeProfessionCerti.Location
        dr("IssuingDate") = String.Format("{0:dd MMM yyyy}", EmployeeProfessionCerti.DateFrom)

        If EmployeeProfessionCerti.NeverExpire = True Then
            dr("ExpireDate") = "1900-01-01"
        Else
            dr("ExpireDate") = String.Format("{0:dd MMM yyyy}", EmployeeProfessionCerti.DateTo)
        End If

        If EmployeeProfessionCerti.NeverExpire = True Then
            dr("NeverExpire") = "Never Expire"
        Else
            dr("NeverExpire") = ""
        End If

        dtProfessionalCertificationInfo.Rows.Add(dr)
        dtProfessionalCertificationInfo.AcceptChanges()
        btnSubmit.Enabled = True
        Return dtProfessionalCertificationInfo

    End Function

    Protected Sub ClearProfessionalCertificationData()
        txtCertificationName.Text = ""
        txtInstitutionName.Text = ""
        txtLocation.Text = ""
        drpDay.SelectedIndex = -1
        drpMonth.SelectedIndex = -1
        drpYear.SelectedIndex = -1
        drpDayTo.SelectedIndex = -1
        drpMonthTo.SelectedIndex = -1
        drpYearTo.SelectedIndex = -1
        chkNeverExpire.Checked = False
        drpMonthTo.Visible = True
        drpDayTo.Visible = True
        drpYearTo.Visible = True
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Try
            Dim UserID As String
            UserID = Session("LoginUserID")

            Dim LoginUserId As String = Session("UniqueUserID")
            Dim ToWhomProShow As String = Session("ToWhomProShow")

            Dim EmployeeProfessionalCertificationInfo As String = ""
            Dim isoProfessionalCertificationParts As String = ""

            Dim dtProfessionalCertificationInfo As DataTable = New DataTable()
            dtProfessionalCertificationInfo = Session("EmployeeProfessionalCertificationInfo")

            Dim ProInfo As New clsProfessionalCertification()
            For Each rw As DataRow In dtProfessionalCertificationInfo.Rows
                ProInfo.CertificationName = rw.Item("CertificationName")
                ProInfo.InstituteName = rw.Item("InstituteName")
                ProInfo.Location = rw.Item("Location")
                ProInfo.DateFrom = rw.Item("IssuingDate")
                ProInfo.DateTo = rw.Item("ExpireDate")

                If rw.Item("NeverExpire") = "Never Expire" Then
                    ProInfo.NeverExpire = True
                Else
                    ProInfo.NeverExpire = False
                End If

                isoProfessionalCertificationParts = isoProfessionalCertificationParts & ProInfo.CertificationName & "~" & ProInfo.InstituteName & "~" & ProInfo.Location & "~" & ProInfo.DateFrom & "~" & ProInfo.DateTo & "~" & ProInfo.NeverExpire & "~|"
            Next

            Dim Check As Integer = profData.fnAddProfessionalCertification(ToWhomProShow, isoProfessionalCertificationParts)
            If Check = 1 Then
                MessageBox("Inserted Successfully")
                btnSubmit.Enabled = False
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub grdCertification_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdCertification.RowDeleting
        Try
            btnSubmit.Enabled = True
            Dim i As Integer
            Dim dtProfessionalCertificationInfo As DataTable = New DataTable()
            dtProfessionalCertificationInfo = Session("EmployeeProfessionalCertificationInfo")

            i = e.RowIndex

            dtProfessionalCertificationInfo.Rows(i).Delete()
            dtProfessionalCertificationInfo.AcceptChanges()
            grdCertification.DataSource = dtProfessionalCertificationInfo
            grdCertification.DataBind()

            If dtProfessionalCertificationInfo.Rows.Count = 0 Then
                btnSubmit.Enabled = False
            Else
                btnSubmit.Enabled = True
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub chkNeverExpire_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkNeverExpire.CheckedChanged
        If chkNeverExpire.Checked = True Then
            drpMonthTo.Visible = False
            drpDayTo.Visible = False
            drpYearTo.Visible = False
        Else
            drpMonthTo.Visible = True
            drpDayTo.Visible = True
            drpYearTo.Visible = True
        End If
    End Sub

#End Region

End Class
