
Partial Class Administration_frmRoleManagement
    Inherits System.Web.UI.Page

    Dim RoleData As New clsRole()

    Protected Sub btnInserRole_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInserRole.Click

        Dim Role As New clsRole()

        Role.RoleName = txtRoleName.Text
        Role.CreatedBy = Session("LoginUserID")

        If chkRoleIsActive.Checked = True Then
            Role.isActive = True
        Else
            Role.isActive = False
        End If

        Dim Check As Integer = RoleData.fnInsertRole(Role)

        If Check = 1 Then
            MessageBox("Inserted Successfully.")
            ShowDetailsRoleList()
            ClearForm()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub ClearForm()

        grdRoleList.SelectedIndex = -1

        hdFldRoleID.Value = ""
        txtRoleName.Text = ""
        chkRoleIsActive.Checked = False

        btnInserRole.Visible = True
        btnUpdateRole.Visible = False
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

        If InStr(MenuIDs, "MngRole~") = 0 Then
            Response.Redirect("~\frmHRMLogin.aspx")
        End If

        If Not IsPostBack Then
            ShowDetailsRoleList()
        End If
    End Sub

    Protected Sub ShowDetailsRoleList()
        grdRoleList.DataSource = RoleData.fnGetDetailsRoleList()
        grdRoleList.DataBind()
    End Sub

    Protected Sub grdRoleList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdRoleList.SelectedIndexChanged
        btnInserRole.Visible = False
        btnUpdateRole.Visible = True

        Dim lblRoleID, lblisActive, lblRoleName As New System.Web.UI.WebControls.Label()

        lblRoleID = grdRoleList.SelectedRow.FindControl("lblRoleID")
        lblisActive = grdRoleList.SelectedRow.FindControl("lblisActive")
        lblRoleName = grdRoleList.SelectedRow.FindControl("lblRoleName")

        txtRoleName.Text = lblRoleName.Text

        If lblisActive.Text = "YES" Then
            chkRoleIsActive.Checked = True
        Else
            chkRoleIsActive.Checked = False
        End If

        hdFldRoleID.Value = lblRoleID.Text

    End Sub

    Protected Sub btnUpdateRole_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateRole.Click

        Dim Role As New clsRole()
        Role.RoleID = hdFldRoleID.Value
        Role.RoleName = txtRoleName.Text
        Role.LastUpdatedBy = Session("LoginUserID")

        If chkRoleIsActive.Checked = True Then
            Role.isActive = True
        Else
            Role.isActive = False
        End If

        Dim Check As Integer = RoleData.fnUpdateRole(Role)

        If Check = 1 Then
            MessageBox("Updated Successfully.")
            ShowDetailsRoleList()
            ClearForm()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub btnCancelSelection_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelSelection.Click
        ClearForm()
    End Sub

End Class
