Partial Class Administration_frmNodeSettings
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()
    Dim NodeData As New clsNodes()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "MngNodes~") = 0 Then
            Response.Redirect("~\frmHRMLogin.aspx")
        End If

        If Not IsPostBack Then
            ShowULCBranch()
            ShowNodeList()
            btnInsert.Enabled = True
            btnUpdate.Enabled = False
        End If
    End Sub

    Protected Sub ShowULCBranch()
        Try
            drpBranchList.DataTextField = "ULCBranchName"
            drpBranchList.DataValueField = "ULCBranchID"
            drpBranchList.DataSource = EmpData.fnGetULCBranch()
            drpBranchList.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowNodeList()
        Try
            grdNodeList.DataSource = NodeData.fnShowNodeList()
            grdNodeList.DataBind()
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

    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click
        Try
            Dim Node As New clsNodes()
            Dim result As New clsResult()

            Node.NodeCode = txtNodeCode.Text
            Node.NodeName = txtNodeName.Text
            Node.NodeBranchID = drpBranchList.SelectedValue
            Node.NodeDescription = txtNodeDescription.Text

            If chkNodeIsActive.Checked = True Then
                Node.IsActive = True
            Else
                Node.IsActive = False
            End If
            Node.EntryBy = Session("LoginUserID")

            result = NodeData.fnInsertAttendanceNode(Node)

            If result.Success = True Then
                ClearForm()
                ShowNodeList()
            End If
            MessageBox(result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ClearForm()
        txtNodeCode.Text = ""
        txtNodeDescription.Text = ""
        txtNodeName.Text = ""
        drpBranchList.SelectedIndex = -1
        btnInsert.Enabled = True
        btnUpdate.Enabled = False
        hdFldNodeID.Value = ""
        grdNodeList.SelectedIndex = -1
        chkNodeIsActive.Checked = False
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Try
            If hdFldNodeID.Value = "" Then
                MessageBox("Select A Node Properly.")
                Exit Sub
            End If

            Dim Node As New clsNodes()
            Dim result As New clsResult()

            Node.NodeID = hdFldNodeID.Value
            Node.NodeCode = txtNodeCode.Text
            Node.NodeName = txtNodeName.Text
            Node.NodeBranchID = drpBranchList.SelectedValue
            Node.NodeDescription = txtNodeDescription.Text

            If chkNodeIsActive.Checked = True Then
                Node.IsActive = True
            Else
                Node.IsActive = False
            End If
            Node.EntryBy = Session("LoginUserID")

            result = NodeData.fnUpdateAttendanceNode(Node)

            If result.Success = True Then
                ClearForm()
                ShowNodeList()
            End If
            MessageBox(result.Message)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub grdNodeList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdNodeList.SelectedIndexChanged
        Dim lblNodeID, lblNodeCode, lblNodeName, lblNodeBranchID, lblBranch, lblNodeDescription, lblIsActive, lblEntryBy As New Label

        Try
            lblNodeID = grdNodeList.SelectedRow.FindControl("lblNodeID")
            lblNodeCode = grdNodeList.SelectedRow.FindControl("lblNodeCode")
            lblNodeName = grdNodeList.SelectedRow.FindControl("lblNodeName")
            lblNodeBranchID = grdNodeList.SelectedRow.FindControl("lblNodeBranchID")
            lblNodeDescription = grdNodeList.SelectedRow.FindControl("lblNodeDescription")
            lblIsActive = grdNodeList.SelectedRow.FindControl("lblIsActive")

            hdFldNodeID.Value = lblNodeID.Text
            txtNodeCode.Text = lblNodeCode.Text
            txtNodeName.Text = lblNodeName.Text
            drpBranchList.SelectedValue = lblNodeBranchID.Text
            txtNodeDescription.Text = lblNodeDescription.Text

            If lblIsActive.Text = True Then
                chkNodeIsActive.Checked = True
            End If

            btnInsert.Enabled = False
            btnUpdate.Enabled = True
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
        
    End Sub

End Class
