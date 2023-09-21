Imports System.Net
Imports System.IO
Imports System.Web.UI
Imports System.Data

Partial Class EmployeeProfile_frmIssueLetter
    Inherits System.Web.UI.Page

    Dim DocumentData As clsDocumentType = New clsDocumentType()
    Dim DocumentListData As clsDocumentList = New clsDocumentList()
    Dim EmployeeData As New clsEmployeeInfo()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserName") = "" Or Session("UniqueUserID") = "" Then
            Response.Redirect("~/frmHRMLogin.aspx")
        End If
        If Not IsPostBack Then
            Dim LoginUserId As String = Session("UniqueUserID")

            Dim ToWhomProShow As String = Session("ToWhomProShow")
            lblHolder.Text = ToWhomProShow
            Dim DocumentCategory As String = "Document"

            getBasicProfileInfo(ToWhomProShow)

            If LoginUserId = ToWhomProShow Then
                Dim Check As Boolean = EmployeeData.CheckPermissionForOwnInfo(LoginUserId)
                If Check = True Then
                    pnlUploadLetters.Visible = True
                Else
                    pnlUploadLetters.Visible = False
                End If
            Else
                Dim Check As Boolean = EmployeeData.CheckPermissionForOthers(LoginUserId)
                If Check = True Then
                    pnlUploadLetters.Visible = True
                Else
                    pnlUploadLetters.Visible = False
                End If
            End If
            ShowDocumentType()

            txtFileName.Text = "N\A"
            txtRemarks.Text = "."
            txtEffectiveDate.Text = Now.Date
            txtIssueDate.Text = Now.Date

            getUserDocuments(lblHolder.Text, DocumentCategory)

        End If
    End Sub

    Protected Sub getUserDocuments(ByVal ToWhomProShow As String, ByVal DocumentCategory As String)
        grdIssuedLetters.DataSource = DocumentListData.fnGetEmpDocuments(ToWhomProShow, DocumentCategory)
        grdIssuedLetters.DataBind()

        BlockDeleteOption()
    End Sub

    Protected Sub ShowDocumentType()
        drpDocumentType.DataTextField = "DocumentType"
        drpDocumentType.DataValueField = "DocTypeID"
        drpDocumentType.DataSource = DocumentData.fnShowDocumentType("Employee")
        drpDocumentType.DataBind()

        drpDocumentType.Items.Insert(0, "-Select-")
    End Sub

    Protected Sub btnUploadDocuments_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUploadDocuments.Click
        Dim folder As String = ""
        Dim Title As String = ""
        Dim DocExt As String = ""
        Dim DocFullName As String = ""
        Dim DocPrefix As String = ""
        Dim FileSize As Integer = 0
        Dim DocFileName As String = ""
        Dim DocumentCategory As String = "Document"

        Dim DocumentList As clsDocumentList = New clsDocumentList()

        If flupFile.HasFile Then

            folder = ConfigurationManager.AppSettings("InputEHRMFiles")

            Title = txtFileName.Text

            Title = Replace(Title, ".", "")

            FileSize = flupFile.PostedFile.ContentLength()
            If FileSize > 10485760 Then
                MessageBox("File size should be within 10MB")
                Exit Sub
            End If

            DocPrefix = Title.Replace(" ", "")

            DocExt = System.IO.Path.GetExtension(flupFile.FileName)
            DocFileName = "Emp_Doc_" & DateTime.Now.ToString("ddMMyyHHmmss") & DocExt
            DocFullName = folder & DocFileName

            '' Uploading A file stream
            'Dim fs As System.IO.Stream = flupFile.PostedFile.InputStream
            'Dim br As New System.IO.BinaryReader(fs)
            'Dim bytes As Byte() = br.ReadBytes(CType(fs.Length, Integer))
            'UploadFile(DocFileName, bytes)
            flupFile.SaveAs(DocFullName)

            DocumentList.DocTypeID = drpDocumentType.SelectedValue
            If drpDocumentType.SelectedValue = "-Select-" Then
                MessageBox("Please Select Document Type.")
                Exit Sub
            End If
            DocumentList.UniqueUserID = lblHolder.Text 'Session("UniqueUserID")
            DocumentList.DocumentName = DocFileName
            DocumentList.FileName = txtFileName.Text
            DocumentList.IssueDate = txtIssueDate.Text
            DocumentList.EffectiveDate = txtEffectiveDate.Text
            DocumentList.Remarks = txtRemarks.Text
            DocumentList.UploadedBy = Session("LoginUserID")


            Dim check As Integer = DocumentListData.InsertDocuments(DocumentList)
            If check = 1 Then
                MessageBox("Inserted Successfully")
                ClearDocumentList()
                getUserDocuments(lblHolder.Text, DocumentCategory)
            Else
                MessageBox("Error Found.")
            End If

        Else
            MessageBox("Select A Document To Upload.")
            Exit Sub
        End If
    End Sub

    Protected Sub UploadFile(ByVal FileName As String, ByVal filebyte As Byte())
        Try
            Dim webClient As WebClient = New WebClient()
            Dim FileSavePath As String = Server.MapPath("~\Attachments\") & FileName
            File.WriteAllBytes(FileSavePath, filebyte)
            webClient.UploadFile("http://192.168.1.132/HRMAttachments/Upload.aspx", FileSavePath)
            webClient.Dispose()
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

    Protected Sub ClearDocumentList()
        drpDocumentType.SelectedIndex = 0
        txtFileName.Text = ""
        txtIssueDate.Text = ""
        txtEffectiveDate.Text = ""
        txtRemarks.Text = ""
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

    Protected Sub grdIssuedLetters_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdIssuedLetters.RowDeleting
        Try
            Dim lblDocumentID As New Label
            lblDocumentID = grdIssuedLetters.Rows(e.RowIndex).FindControl("lblDocumentID")

            Dim Check As Integer = DocumentListData.fnDeleteUserDocuments(lblDocumentID.Text)
            If Check = 1 Then
                MessageBox("Document Deleted.")
                getUserDocuments(Session("ToWhomProShow"), "Document")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub BlockDeleteOption()
        Try
            Dim LoginUserId As String = Session("UniqueUserID")
            Dim ToWhomProShow As String = Session("ToWhomProShow")

            If LoginUserId = ToWhomProShow Then
                Dim Check As Boolean = EmployeeData.CheckPermissionForOwnInfo(LoginUserId)
                If Check = False Then
                    For Each row As GridViewRow In grdIssuedLetters.Rows
                        row.Cells(8).Enabled = False
                    Next
                End If
            Else
                Dim Check As Boolean = EmployeeData.CheckPermissionForOthers(LoginUserId)
                If Check = False Then
                    For Each row As GridViewRow In grdIssuedLetters.Rows
                        row.Cells(8).Enabled = False
                    Next
                End If
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

End Class
