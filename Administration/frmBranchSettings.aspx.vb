
Partial Class Administration_frmBranchSettings
    Inherits System.Web.UI.Page


    Dim OrgBranchData As New clsOrgBranch()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "BrSett~") = 0 Then
            Response.Redirect("~\frmHRMLogin.aspx")
        End If

        If Not IsPostBack Then
            GetBranchList()
            btnInsert.Enabled = True
            btnUpdate.Enabled = False
        End If
    End Sub

    Protected Sub GetBranchList()
        grdBranchList.DataSource = OrgBranchData.fnGetTotalULCBranch()
        grdBranchList.DataBind()
    End Sub

    Protected Sub ClearForm()
        txtBranchLocation.Text = ""
        txtBranchName.Text = ""
        chkIsActive.Checked = False
        grdBranchList.SelectedIndex = -1
        hdFldULCBranchID.Value = ""
        btnInsert.Enabled = True
        btnUpdate.Enabled = False
    End Sub

    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click
        Try
            Dim Branch As New clsOrgBranch()

            Branch.ULCBranchName = txtBranchName.Text
            Branch.BranchLocation = txtBranchLocation.Text

            If chkIsActive.Checked = True Then
                Branch.isActive = True
            Else
                Branch.isActive = False
            End If

            Branch.EntryBy = Session("LoginUserID")

            Dim res As clsResult = OrgBranchData.fnInsertULCBranch(Branch)

            If res.Success = True Then
                ClearForm()
                GetBranchList()
            End If
            MessageBox(res.Message)

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

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Try
            Dim Branch As New clsOrgBranch()

            If hdFldULCBranchID.Value = "" Then
                MessageBox("Select A Branch First.")
                Exit Sub
            End If

            Branch.ULCBranchID = hdFldULCBranchID.Value
            Branch.ULCBranchName = txtBranchName.Text
            Branch.BranchLocation = txtBranchLocation.Text

            If chkIsActive.Checked = True Then
                Branch.isActive = True
            Else
                Branch.isActive = False
            End If

            Branch.EntryBy = Session("LoginUserID")

            Dim res As clsResult = OrgBranchData.fnUpdateULCBranch(Branch)

            If res.Success = True Then
                ClearForm()
                GetBranchList()
            End If
            MessageBox(res.Message)

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub grdBranchList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdBranchList.SelectedIndexChanged
        Dim lblULCBranchID, lblULCBranchName, lblBranchLocation, lblIsActive As New Label
        Try
            lblULCBranchID = grdBranchList.SelectedRow.FindControl("lblULCBranchID")
            lblULCBranchName = grdBranchList.SelectedRow.FindControl("lblULCBranchName")
            lblBranchLocation = grdBranchList.SelectedRow.FindControl("lblBranchLocation")
            lblIsActive = grdBranchList.SelectedRow.FindControl("lblIsActive")

            hdFldULCBranchID.Value = lblULCBranchID.Text
            txtBranchName.Text = lblULCBranchName.Text
            txtBranchLocation.Text = lblBranchLocation.Text

            If lblIsActive.Text = "YES" Then
                chkIsActive.Checked = True
            End If

            btnInsert.Enabled = False
            btnUpdate.Enabled = True

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

End Class
