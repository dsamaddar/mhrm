
Partial Class Administration_frmDeptSettings
    Inherits System.Web.UI.Page

    Dim DeptData As New clsDepartment()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "DeptSet~") = 0 Then
            Response.Redirect("~\frmHRMLogin.aspx")
        End If

        If Not IsPostBack Then
            GetDeptDetails()
            btnUpdate.Visible = False
            btnInsertDepartment.Visible = True
        End If
    End Sub

    Protected Sub GetDeptDetails()
        grdDeptInfo.DataSource = DeptData.fnGetDepartmentDetails()
        grdDeptInfo.DataBind()
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim UserID As String
        UserID = Session("LoginUserID")

        If hdFldDepartmentID.Value = "" Then
            MessageBox("Select The Department First.")
            Exit Sub
        End If

        Dim DepartmentInfo As New clsDepartment()

        DepartmentInfo.DepartmentID = hdFldDepartmentID.Value
        DepartmentInfo.DeptName = txtDepartmentName.Text
        DepartmentInfo.DeptCode = txtDeptCode.Text

        If chkIsActive.Checked = True Then
            DepartmentInfo.IsActive = True
        Else
            DepartmentInfo.IsActive = False
        End If

        DepartmentInfo.EntryBy = UserID
        Dim check As Integer = DeptData.fnUpdateDeptInfoByID(DepartmentInfo)

        If check = 1 Then
            ClearDeptForm()
            GetDeptDetails()
            MessageBox("Updated Successfully.")
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub btnInsertDepartment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsertDepartment.Click
        Dim UserID As String
        UserID = Session("LoginUserID")

        Dim DepartmentInfo As New clsDepartment()

        DepartmentInfo.DeptName = txtDepartmentName.Text
        DepartmentInfo.DeptCode = txtDeptCode.Text

        If chkIsActive.Checked = True Then
            DepartmentInfo.IsActive = True
        Else
            DepartmentInfo.IsActive = False
        End If

        DepartmentInfo.EntryBy = UserID

        Dim check As Integer = DeptData.fnInsertDepartment(DepartmentInfo)

        If check = 1 Then
            ClearDeptForm()
            GetDeptDetails()
            MessageBox("Inserted.")
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub ClearDeptForm()
        txtDepartmentName.Text = ""
        txtDeptCode.Text = ""
        chkIsActive.Checked = False
        btnUpdate.Visible = False
        btnInsertDepartment.Visible = True
        grdDeptInfo.SelectedIndex = -1
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub btnCancelSelection_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelSelection.Click

    End Sub

    Protected Sub grdDeptInfo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdDeptInfo.SelectedIndexChanged
        Dim lblDepartmentID, lblIsActive, lblDeptName, lblDeptCode As New Label()
        lblDepartmentID = grdDeptInfo.SelectedRow.FindControl("lblDepartmentID")
        lblIsActive = grdDeptInfo.SelectedRow.FindControl("lblIsActive")
        lblDeptName = grdDeptInfo.SelectedRow.FindControl("lblDeptName")
        lblDeptCode = grdDeptInfo.SelectedRow.FindControl("lblDeptCode")

        If lblIsActive.Text = "YES" Then
            chkIsActive.Checked = True
        Else
            chkIsActive.Checked = False
        End If

        txtDepartmentName.Text = lblDeptName.Text
        txtDeptCode.Text = lblDeptCode.Text
        hdFldDepartmentID.Value = lblDepartmentID.Text
        btnUpdate.Visible = True
        btnInsertDepartment.Visible = False

    End Sub


End Class
