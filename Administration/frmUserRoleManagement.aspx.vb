
Partial Class Administration_frmUserRoleManagement
    Inherits System.Web.UI.Page

    'Dim UserData As New clsUserDataAccess()
    Dim EmpData As New clsEmployeeInfo()
    Dim RoleData As New clsRole()
    Dim UserWiseRoleData As New clsUserWiseRole()

    Protected Sub drpUserList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpUserList.SelectedIndexChanged

        If drpUserList.SelectedValue <> "N\A" Then
            ShowUserWiseRole()
        End If

    End Sub

    Protected Sub ShowUserWiseRole()

        grdUserRole.DataSource = ""
        grdUserRole.DataBind()

        Dim UserWiseRole As New clsUserWiseRole()
        UserWiseRole.EmployeeID = drpUserList.SelectedValue
        grdUserRole.DataSource = UserWiseRoleData.fnShowUserWiseRole(UserWiseRole)
        grdUserRole.DataBind()
    End Sub

    Protected Sub ShowRoleList()
        drpRoleList.DataTextField = "RoleName"
        drpRoleList.DataValueField = "RoleID"
        drpRoleList.DataSource = RoleData.fnGetRoleList()
        drpRoleList.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpRoleList.Items.Insert(0, A)
    End Sub

    Protected Sub ShowActiveEmpList()
        drpUserList.DataTextField = "EmployeeName"
        drpUserList.DataValueField = "EmployeeID"
        drpUserList.DataSource = EmpData.fnGetEmpListPayrollActive()
        drpUserList.DataBind()

        Dim A As New ListItem()

        A.Text = "N\A"
        A.Value = "N\A"

        drpUserList.Items.Insert(0, A)
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnApplyRole_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApplyRole.Click

        If drpUserList.SelectedValue = "N\A" Or drpRoleList.SelectedValue = "N\A" Then
            MessageBox("Select User/Role Properly.")
            Exit Sub
        End If

        Dim lblRoleID As New System.Web.UI.WebControls.Label()

        For Each rw As GridViewRow In grdUserRole.Rows
            lblRoleID = rw.FindControl("lblRoleID")
            If drpRoleList.SelectedValue = lblRoleID.Text Then
                MessageBox("Role Already Applied.")
                Exit Sub
            End If

        Next

        Dim UserWiseRole As New clsUserWiseRole()

        UserWiseRole.EmployeeID = drpUserList.SelectedValue
        UserWiseRole.RoleID = drpRoleList.SelectedValue
        UserWiseRole.EntryBy = Session("LoginUserID")

        Dim Check As Integer = UserWiseRoleData.fnInsertUserWiseRole(UserWiseRole)

        If Check = 1 Then
            MessageBox("Applied Successfully.")
            ShowUserWiseRole()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'Dim MenuIDs As String

        'MenuIDs = Session("PermittedMenus")

        'If InStr(MenuIDs, "UsrWiseRole~") = 0 Then
        '    Response.Redirect("~\frmHRMLogin.aspx")
        'End If

        If Not IsPostBack Then
            ShowRoleList()
            ShowActiveEmpList()
        End If
    End Sub

    Protected Sub grdUserRole_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdUserRole.RowDeleting

        Dim lblUserWiseRoleID As New System.Web.UI.WebControls.Label()
        Dim UserWiseRole As New clsUserWiseRole()
        Dim i As Integer = e.RowIndex
        lblUserWiseRoleID = grdUserRole.Rows(i).FindControl("lblUserWiseRoleID")

        UserWiseRole.UserWiseRoleID = lblUserWiseRoleID.Text
        Dim Check As Integer = UserWiseRoleData.fnInActiveUsrPermission(UserWiseRole)

        If Check = 1 Then
            MessageBox("Permission Denied Successfully.")
            ShowUserWiseRole()
        Else
            MessageBox("Error Found.")
        End If

    End Sub
End Class
