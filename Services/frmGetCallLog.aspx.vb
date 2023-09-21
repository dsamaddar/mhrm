
Partial Class Services_frmGetCallLog
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetAllCallLog()
        End If
    End Sub

    Protected Sub GetAllCallLog()
        Try
            grdCallLog.DataSource = EmpData.fnGetAllCallLog()
            grdCallLog.DataBind()
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

    Protected Sub btnReloadCallLog_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReloadCallLog.Click
        GetAllCallLog()
    End Sub
End Class
