Imports System.Net
Imports System.IO
Imports System.Web.UI
Imports System.Data

Partial Class Attendance_frmInputAttendance
    Inherits System.Web.UI.Page

    Dim UsrAttData As New clsUserAttendance()
    Dim EmpInfoData As New clsEmployeeInfo()

    Protected Sub btnInputAtt_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInputAtt.Click

        Dim folder As String = ""
        Dim Title As String = ""
        Dim DocExt As String = ""
        Dim DocFullName As String = ""
        Dim DocPrefix As String = ""
        Dim FileSize As Integer = 0
        Dim DocFileName As String = ""

        Try
            Dim UsrAtt As New clsUserAttendance()
            UsrAtt.EmployeeID = drpUserList.SelectedValue
            UsrAtt.LogTime = txtAttendanceDate.Text + " " + drpAHour.SelectedValue + ":" + drpAMin.SelectedValue + ":00 " + drpAAMPM.SelectedValue
            UsrAtt.IdealLogTime = txtAttendanceDate.Text + " " + drpIHour.SelectedValue + ":" + drpIMin.SelectedValue + ":00 " + drpIAMPM.SelectedValue
            UsrAtt.DateTo = Convert.ToDateTime(txtAttendanceDateTo.Text)
            UsrAtt.Remarks = txtRemarks.Text
            UsrAtt.EntryBy = Session("LoginUserID")

            If flupFile.HasFile Then

                folder = ConfigurationManager.AppSettings("InputEHRMFiles")

                Title = flupFile.FileName

                Title = Replace(Title, ".", "")

                FileSize = flupFile.PostedFile.ContentLength()
                If FileSize > 4194304 Then
                    MessageBox("File size should be within 4MB")
                    Exit Sub
                End If

                DocPrefix = Title.Replace(" ", "")

                DocExt = System.IO.Path.GetExtension(flupFile.FileName)
                DocFileName = "Emp_Att_" & DateTime.Now.ToString("ddMMyyHHmmss") & DocExt
                UsrAtt.DocumentReference = DocFileName
                DocFullName = folder & DocFileName
                flupFile.SaveAs(DocFullName)

                '' Uploading A file stream
                'Dim fs As System.IO.Stream = flupFile.PostedFile.InputStream
                'Dim br As New System.IO.BinaryReader(fs)
                'Dim bytes As Byte() = br.ReadBytes(CType(fs.Length, Integer))
                'UploadFile(DocFileName, bytes)

            Else
                MessageBox("Select A Reference To Upload.")
                Exit Sub
            End If


            Dim check As Integer = UsrAttData.fnInsertAdminAttendance(UsrAtt)

            If check = 1 Then
                MessageBox("Successfully Inserted.")
                ClearForm()
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
            webClient.UploadFile("http://192.168.1.241/HRMAttachments/Upload.aspx", FileSavePath)
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

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        txtAttendanceDate.Text = ""
        txtAttendanceDateTo.Text = ""
        txtRemarks.Text = ""
        drpAHour.SelectedValue = "9"
        drpAMin.SelectedValue = "40"
        drpAAMPM.SelectedValue = "AM"

        drpIHour.SelectedValue = "10"
        drpIMin.SelectedValue = "00"
        drpIAMPM.SelectedValue = "AM"

        If drpUserList.Items.Count > 0 Then
            GetUsrAttData()
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim MenuIDs As String

        'MenuIDs = Session("PermittedMenus")

        'If InStr(MenuIDs, "AttStatInd~") = 0 Then
        '    Response.Redirect("~\frmHRMLogin.aspx")
        'End If

        If Not IsPostBack Then
            ShowUserList()
            txtAttendanceDate.Text = Now.Date
            txtAttendanceDateTo.Text = Now.Date
            drpAHour.SelectedValue = "9"
            drpAMin.SelectedValue = "40"
            drpAAMPM.SelectedValue = "AM"

            drpIHour.SelectedValue = "10"
            drpIMin.SelectedValue = "00"
            drpIAMPM.SelectedValue = "AM"

            If drpUserList.Items.Count > 0 Then
                drpUserList.SelectedIndex = 0
                GetUsrAttData()
            End If

        End If
    End Sub

    Protected Sub ShowUserList()
        drpUserList.DataTextField = "EmployeeName"
        drpUserList.DataValueField = "EmployeeID"
        drpUserList.DataSource = EmpInfoData.fnGetEmployeeList()
        drpUserList.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpUserList.Items.Insert(0, A)
    End Sub

    Protected Sub drpUserList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpUserList.SelectedIndexChanged
        GetUsrAttData()
    End Sub

    Protected Sub GetUsrAttData()
        Dim UsrAtt As New clsUserAttendance()
        UsrAtt.EmployeeID = drpUserList.SelectedValue

        grdUserAttendance.DataSource = UsrAttData.fnGetUserAttInputByAdmin(UsrAtt)
        grdUserAttendance.DataBind()
    End Sub

End Class
