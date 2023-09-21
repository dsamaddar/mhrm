
Partial Class Services_frmEmpPerformance
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()

    Protected Sub btnProcessReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcessReport.Click
        Try
            grdEmpPerformance.DataSource = EmpData.fnGetEmpPerformance(drpYear.SelectedValue)
            grdEmpPerformance.DataBind()
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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            drpYear.SelectedValue = Now.Year.ToString()
        End If
    End Sub
End Class
