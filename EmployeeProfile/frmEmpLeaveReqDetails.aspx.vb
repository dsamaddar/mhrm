
Partial Class EmployeeProfile_frmEmpLeaveReqDetails
    Inherits System.Web.UI.Page

    Dim LeaveReqData As New clsLeaveRequest()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim EmployeeID As String = Request.QueryString("EmployeeID")
            GetLeaveReqDetails(EmployeeID)
        End If
    End Sub

    Protected Sub GetLeaveReqDetails(ByVal EmployeeID As String)
        Try
            grdLeaveReqDetails.DataSource = LeaveReqData.fnGetEmpLeaveReqDetails(EmployeeID)
            grdLeaveReqDetails.DataBind()
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
