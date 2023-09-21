
Partial Class SalarySettings_frmSalaryConfirmation
    Inherits System.Web.UI.Page

    Dim EmpSalarySummaryData As New clsEmpSalarySummary()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetSalaryEntryPoint()
        End If
    End Sub

    Protected Sub GetSalaryEntryPoint()
        Try
            drpEntryPoint.DataSource = EmpSalarySummaryData.fnGetSalaryEntryPointForConfirmation()
            drpEntryPoint.DataTextField = "EntryPointText"
            drpEntryPoint.DataValueField = "EntryPoint"
            drpEntryPoint.DataBind()
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

    Protected Sub btnFinalizeSalary_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFinalizeSalary.Click
        Try
            If drpEntryPoint.SelectedValue = "" Then
                MessageBox("Select an entry point first.")
                Exit Sub
            End If

            Dim result As clsResult = EmpSalarySummaryData.fnFinalizeSalary(drpEntryPoint.SelectedValue, Session("UserID"))
            MessageBox(result.Message)
            GetSalaryEntryPoint()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnReverseSalary_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReverseSalary.Click
        Try
            If drpEntryPoint.SelectedValue = "" Then
                MessageBox("Select an entry point first.")
                Exit Sub
            End If

            Dim result As clsResult = EmpSalarySummaryData.fnReverseSalary(drpEntryPoint.SelectedValue)
            MessageBox(result.Message)
            GetSalaryEntryPoint()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub
End Class
