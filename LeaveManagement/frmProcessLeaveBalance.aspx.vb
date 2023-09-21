
Partial Class LeaveManagement_frmProcessLeaveBalance
    Inherits System.Web.UI.Page

    Dim EmpLeaveBalData As New clsEmpLeaveBalance()

    Protected Sub btnProcessLeaveYear_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcessLeaveYear.Click
        Try
            Dim EmpLeaveBal As New clsEmpLeaveBalance()
            Dim result As New clsResult()

            EmpLeaveBal.EntryBy = Session("LoginUserID")
            EmpLeaveBal.LeaveYear = drpLeaveYear.SelectedValue

            result = EmpLeaveBalData.fnProcessYearlyLeaveBalance(EmpLeaveBal)

            If result.Success = True Then
                ShowLeaveBalance()
            End If
            MessageBox(result.Message)
        Catch ex As Exception

        End Try
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub ShowLeaveBalance()
        Try
            grdLeaveBalance.DataSource = EmpLeaveBalData.fnGetAllEmpLeaveBalance("N\A")
            grdLeaveBalance.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            FormInitialization()
        End If
    End Sub

    Protected Sub FormInitialization()
        drpLeaveYear.SelectedValue = Now.Year.ToString()
        drpLeaveYear.Enabled = False
        ShowLeaveBalance()
    End Sub

End Class
