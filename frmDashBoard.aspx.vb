
Partial Class frmDashBoard
    Inherits System.Web.UI.Page

    Dim DashBoardData As New clsDashBoard()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetDashBoardInfo()
        End If
    End Sub

    Protected Sub GetDashBoardInfo()
        Try
            Dim DashBoard As clsDashBoard = DashBoardData.fnGetDashBoardInfo()

            lblLicenseExpiryDate.Text = DashBoard.LicenseExpiryDate
            lblMaximumUserLimit.Text = DashBoard.MaximumUser
            lblActiveUsers.Text = DashBoard.ActiveUser
            lblInActiveUsers.Text = DashBoard.InActiveUser
            lblAvailableUsers.Text = DashBoard.AvailableUser
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

End Class
