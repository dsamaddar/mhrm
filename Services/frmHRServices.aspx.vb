
Partial Class frmHRServices
    Inherits System.Web.UI.Page

    Dim HRServiceData As New clsHRServices()

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim HRService As New clsHRServices()

        Try
            HRService.HRService = txtServiceTitle.Text
            HRService.HRServiceReqInstruction = txtServiceReqInstruction.Text
            HRService.SeqPriority = Convert.ToInt32(txtSeqPriority.Text)

            If chkIsActive.Checked = True Then
                HRService.IsActive = True
            Else
                HRService.IsActive = False
            End If

            HRService.EntryBy = Session("LoginUserID")

            Dim Check As Integer = HRServiceData.fnInsertHRServices(HRService)

            If Check = 1 Then
                MessageBox("Inserted Successfully.")
                ClearForm()
                GetHRServiceList()
            Else
                MessageBox("Error Found.")
            End If
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
        Dim HRService As New clsHRServices()

        Try
            HRService.HRServiceID = hdFldHRServiceID.Value
            HRService.HRService = txtServiceTitle.Text
            HRService.HRServiceReqInstruction = txtServiceReqInstruction.Text
            HRService.SeqPriority = Convert.ToInt32(txtSeqPriority.Text)

            If chkIsActive.Checked = True Then
                HRService.IsActive = True
            Else
                HRService.IsActive = False
            End If

            HRService.EntryBy = Session("LoginUserID")

            Dim Check As Integer = HRServiceData.fnUpdateHRServices(HRService)

            If Check = 1 Then
                MessageBox("Updated Successfully.")
                ClearForm()
                GetHRServiceList()
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearForm()
    End Sub

    Protected Sub ClearForm()
        hdFldHRServiceID.Value = ""
        txtSeqPriority.Text = "0"
        txtServiceTitle.Text = ""
        txtServiceReqInstruction.Text = ""
        chkIsActive.Checked = False
        btnSubmit.Enabled = True
        btnUpdate.Enabled = False
        If grdHRServiceList.Rows.Count > 0 Then
            grdHRServiceList.SelectedIndex = -1
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            btnSubmit.Enabled = True
            btnUpdate.Enabled = False
            txtSeqPriority.Text = "0"
            GetHRServiceList()
        End If
    End Sub

    Protected Sub GetHRServiceList()
        grdHRServiceList.DataSource = HRServiceData.fnGetHRServiceList()
        grdHRServiceList.DataBind()
    End Sub

    Protected Sub grdHRServiceList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdHRServiceList.SelectedIndexChanged
        Dim lblHRServiceID, lblHRService, lblHRServiceReqInstruction, lblIsActive, lblSeqPriority As New Label
        Try
            lblHRServiceID = grdHRServiceList.SelectedRow.FindControl("lblHRServiceID")
            lblHRService = grdHRServiceList.SelectedRow.FindControl("lblHRService")
            lblHRServiceReqInstruction = grdHRServiceList.SelectedRow.FindControl("lblHRServiceReqInstruction")
            lblIsActive = grdHRServiceList.SelectedRow.FindControl("lblIsActive")
            lblSeqPriority = grdHRServiceList.SelectedRow.FindControl("lblSeqPriority")

            hdFldHRServiceID.Value = lblHRServiceID.Text
            txtServiceTitle.Text = lblHRService.Text

            If lblIsActive.Text = "YES" Then
                chkIsActive.Checked = True
            Else
                chkIsActive.Checked = False
            End If

            txtServiceReqInstruction.Text = lblHRServiceReqInstruction.Text
            txtSeqPriority.Text = lblSeqPriority.Text
            btnUpdate.Enabled = True
            btnSubmit.Enabled = False
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

End Class
