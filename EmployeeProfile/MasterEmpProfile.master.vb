
Partial Class EmployeeProfile_MasterEmpProfile
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UniqueUserID") = "" And Session("UserName") = "" Then
            Response.Redirect("~/frmHRMLogin.aspx")
        End If

        If Not IsPostBack Then
            lblEmpLoggedInUser.Text = "Welcome " + Session("UserName") + " ! "
        End If
    End Sub
End Class



