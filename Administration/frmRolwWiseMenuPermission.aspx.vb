
Partial Class Administration_frmRolwWiseMenuPermission
    Inherits System.Web.UI.Page

    Dim MenuData As New clsMenu()
    Dim RoleData As New clsRole()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "MngPermission~") = 0 Then
            Response.Redirect("~\frmHRMLogin.aspx")
        End If

        If Not IsPostBack Then

            ShowRoleList()

            ShowMenuList(grdAdministrationMenu, "Administration")
            ShowMenuList(grdHRServices, "HRServices")
            ShowMenuList(grdSalarySetup, "Salary")
            ShowMenuList(grdLeaveManagement, "LeaveMgt")
            ShowMenuList(grdAttendanceReports, "AttendanceReports")
            ShowMenuList(grdMiscellaneous, "Miscellaneous")
        End If
    End Sub

    Protected Sub ShowMenuList(ByVal grd As GridView, ByVal MenuGroupID As String)
        grd.DataSource = MenuData.fnGetMenuListByGroup(MenuGroupID)
        grd.DataBind()
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

    Protected Sub GetMenuPermission(ByVal MenuIDList As String)

        Dim chkSelectAdminMenu, chkSelectHRServices, chkSelectSalarySetupMenu, chkSelectLeaveManagement, chkSelectAttendanceReportsMenu, chkSelectMiscellaneousMenu As New CheckBox()
        Dim lblAdminMenuID, lblHRServicesMenuID, lblSalarySetupMenuID, lblLeaveManagementMenuID, lblAttendanceReportsMenuID, lblMiscellaneousMenuID As New Label()

        For Each rw As GridViewRow In grdAdministrationMenu.Rows
            lblAdminMenuID = rw.FindControl("lblAdminMenuID")
            If MenuIDList.Contains(lblAdminMenuID.Text) Then
                chkSelectAdminMenu = rw.FindControl("chkSelectAdminMenu")
                chkSelectAdminMenu.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

        For Each rw As GridViewRow In grdHRServices.Rows
            lblHRServicesMenuID = rw.FindControl("lblHRServicesMenuID")
            If MenuIDList.Contains(lblHRServicesMenuID.Text) Then
                chkSelectHRServices = rw.FindControl("chkSelectHRServices")
                chkSelectHRServices.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

        For Each rw As GridViewRow In grdSalarySetup.Rows
            lblSalarySetupMenuID = rw.FindControl("lblSalarySetupMenuID")
            If MenuIDList.Contains(lblSalarySetupMenuID.Text) Then
                chkSelectSalarySetupMenu = rw.FindControl("chkSelectSalarySetupMenu")
                chkSelectSalarySetupMenu.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

        For Each rw As GridViewRow In grdLeaveManagement.Rows
            lblLeaveManagementMenuID = rw.FindControl("lblLeaveManagementMenuID")
            If MenuIDList.Contains(lblLeaveManagementMenuID.Text) Then
                chkSelectLeaveManagement = rw.FindControl("chkSelectLeaveManagement")
                chkSelectLeaveManagement.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

        For Each rw As GridViewRow In grdAttendanceReports.Rows
            lblAttendanceReportsMenuID = rw.FindControl("lblAttendanceReportsMenuID")
            If MenuIDList.Contains(lblSalarySetupMenuID.Text) Then
                chkSelectAttendanceReportsMenu = rw.FindControl("chkSelectAttendanceReportsMenu")
                chkSelectAttendanceReportsMenu.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

        For Each rw As GridViewRow In grdMiscellaneous.Rows
            lblMiscellaneousMenuID = rw.FindControl("lblMiscellaneousMenuID")
            If MenuIDList.Contains(lblMiscellaneousMenuID.Text) Then
                chkSelectMiscellaneousMenu = rw.FindControl("chkSelectMiscellaneousMenu")
                chkSelectMiscellaneousMenu.Checked = True
                rw.ForeColor = Drawing.Color.Green
                rw.Font.Bold = True
            End If
        Next

    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click


        If drpRoleList.SelectedValue = "N\A" Then
            MessageBox("Select Proper Role")
            Exit Sub
        End If

        Dim MenuIDList As String = ""

        Dim chkSelectAdminMenu, chkSelectHRServices, chkSelectSalarySetupMenu, chkSelectLeaveManagement, chkSelectAttendanceReportsMenu, chkSelectMiscellaneousMenu As New CheckBox()
        Dim lblAdminMenuID, lblHRServicesMenuID, lblSalarySetupMenuID, lblLeaveManagementMenuID, lblAttendanceReportsMenuID, lblMiscellaneousMenuID As New Label()

        Try
            For Each rw As GridViewRow In grdAdministrationMenu.Rows
                chkSelectAdminMenu = rw.FindControl("chkSelectAdminMenu")

                If chkSelectAdminMenu.Checked = True Then
                    lblAdminMenuID = rw.FindControl("lblAdminMenuID")
                    MenuIDList += lblAdminMenuID.Text & "~"
                End If
            Next

            For Each rw As GridViewRow In grdHRServices.Rows
                chkSelectHRServices = rw.FindControl("chkSelectHRServices")

                If chkSelectHRServices.Checked = True Then
                    lblHRServicesMenuID = rw.FindControl("lblHRServicesMenuID")
                    MenuIDList += lblHRServicesMenuID.Text & "~"
                End If
            Next

            For Each rw As GridViewRow In grdSalarySetup.Rows
                chkSelectSalarySetupMenu = rw.FindControl("chkSelectSalarySetupMenu")

                If chkSelectSalarySetupMenu.Checked = True Then
                    lblSalarySetupMenuID = rw.FindControl("lblSalarySetupMenuID")
                    MenuIDList += lblSalarySetupMenuID.Text & "~"
                End If
            Next

            For Each rw As GridViewRow In grdLeaveManagement.Rows
                chkSelectLeaveManagement = rw.FindControl("chkSelectLeaveManagement")

                If chkSelectLeaveManagement.Checked = True Then
                    lblLeaveManagementMenuID = rw.FindControl("lblLeaveManagementMenuID")
                    MenuIDList += lblLeaveManagementMenuID.Text & "~"
                End If
            Next

            For Each rw As GridViewRow In grdAttendanceReports.Rows
                chkSelectAttendanceReportsMenu = rw.FindControl("chkSelectAttendanceReportsMenu")

                If chkSelectAttendanceReportsMenu.Checked = True Then
                    lblAttendanceReportsMenuID = rw.FindControl("lblAttendanceReportsMenuID")
                    MenuIDList += lblAttendanceReportsMenuID.Text & "~"
                End If
            Next

            For Each rw As GridViewRow In grdMiscellaneous.Rows
                chkSelectMiscellaneousMenu = rw.FindControl("chkSelectMiscellaneousMenu")

                If chkSelectMiscellaneousMenu.Checked = True Then
                    lblMiscellaneousMenuID = rw.FindControl("lblMiscellaneousMenuID")
                    MenuIDList += lblMiscellaneousMenuID.Text & "~"
                End If
            Next

            Dim Role As New clsRole()

            Role.RoleID = drpRoleList.SelectedValue
            Role.MenuIDList = MenuIDList
            Role.LastUpdatedBy = Session("LoginUserID")

            Dim Check As Integer = RoleData.fnUpdateRolePermission(Role)

            If Check = 1 Then
                MessageBox("Successfully Inserted.")
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub ClearMenuSelection()

        Dim chkSelectAdminMenu, chkSelectHRServices, chkSelectSalarySetupMenu, chkSelectLeaveManagement, chkSelectAttendanceReportsMenu, chkSelectMiscellaneousMenu As New CheckBox()

        For Each rw As GridViewRow In grdAdministrationMenu.Rows
            chkSelectAdminMenu = rw.FindControl("chkSelectAdminMenu")
            If chkSelectAdminMenu.Checked = True Then
                chkSelectAdminMenu.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

        For Each rw As GridViewRow In grdHRServices.Rows
            chkSelectHRServices = rw.FindControl("chkSelectHRServices")
            If chkSelectHRServices.Checked = True Then
                chkSelectHRServices.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

        For Each rw As GridViewRow In grdSalarySetup.Rows
            chkSelectSalarySetupMenu = rw.FindControl("chkSelectSalarySetupMenu")
            If chkSelectSalarySetupMenu.Checked = True Then
                chkSelectSalarySetupMenu.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

        For Each rw As GridViewRow In grdLeaveManagement.Rows
            chkSelectLeaveManagement = rw.FindControl("chkSelectLeaveManagement")
            If chkSelectLeaveManagement.Checked = True Then
                chkSelectLeaveManagement.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

        For Each rw As GridViewRow In grdAttendanceReports.Rows
            chkSelectAttendanceReportsMenu = rw.FindControl("chkSelectAttendanceReportsMenu")
            If chkSelectAttendanceReportsMenu.Checked = True Then
                chkSelectAttendanceReportsMenu.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

        For Each rw As GridViewRow In grdMiscellaneous.Rows
            chkSelectMiscellaneousMenu = rw.FindControl("chkSelectMiscellaneousMenu")
            If chkSelectMiscellaneousMenu.Checked = True Then
                chkSelectMiscellaneousMenu.Checked = False
                rw.ForeColor = Drawing.Color.Black
                rw.Font.Bold = False
            End If
        Next

    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub drpRoleList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpRoleList.SelectedIndexChanged
        ClearMenuSelection()
        If drpRoleList.SelectedValue <> "N\A" Then

            Dim MenuIDList As String = RoleData.fnGetRoleWiseMenuIDs(drpRoleList.SelectedValue)
            GetMenuPermission(MenuIDList)
        Else

            MessageBox("Select Role Properly.")
            Exit Sub
        End If

    End Sub

End Class
