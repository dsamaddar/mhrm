
Partial Class Administration_frmAddNewEmployeeaspx
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()
    Dim DashBoardData As New clsDashBoard()

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        Try
            '********************** Check License ********************************
            Dim DashBoard As clsDashBoard = DashBoardData.fnGetDashBoardInfo()

            If DashBoard.AvailableUser <= 0 Then
                MessageBox("License Expiry Date : " & DashBoard.LicenseExpiryDate.ToString() & "\n" & _
                           "Maximum User Limit  : " & DashBoard.MaximumUser.ToString() & "\n" & _
                           "Total Allocated User: " & DashBoard.TotalUser.ToString() & "\n" & _
                           "Available User      : " & DashBoard.AvailableUser.ToString() & "")
                Exit Sub
            End If
            '********************** Check License ********************************

            Dim EmpInfo As New clsEmployeeInfo()

            EmpInfo.EmployeeName = txtEmployeeName.Text
            EmpInfo.EmpCode = txtEmployeeID.Text
            EmpInfo.UserID = txtLoginID.Text
            EmpInfo.Password = txtLoginPassword.Text
            EmpInfo.EntryBy = Session("LoginUserID")

            Dim Check As Integer = EmpData.fnAddNewEmployee(EmpInfo)

            If Check = 1 Then
                MessageBox("Inserted Successfully.")
                ClearForm()
            Else
                MessageBox("Error found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
        
    End Sub

    Protected Sub ClearForm()
        txtEmployeeID.Text = ""
        txtEmployeeName.Text = ""
        txtLoginID.Text = ""
        txtLoginPassword.Text = "Standard@1"
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "AddNewEmployee~") = 0 Then
            Response.Redirect("~\frmHRMLogin.aspx")
        End If
    End Sub
End Class
