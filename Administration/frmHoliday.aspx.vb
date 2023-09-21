
Partial Class Administration_frmHoliday
    Inherits System.Web.UI.Page

    Dim HolidayData As New clsHolidays()

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Try
            If Convert.ToDateTime(dtDateFrom.Text) < Convert.ToDateTime(dtDateTo.Text) Then
                MessageBox("To Date Should be less than from date")
                Exit Sub
            End If

            Dim Holiday As New clsHolidays()

            Holiday.HolidayDate = dtDateFrom.Text
            Holiday.DateTo = dtDateTo.Text
            Holiday.Purpose = txtPurpose.Text
            Holiday.EntryBy = Session("LoginUserID")

            Dim Check As Integer = HolidayData.fnInsertHolidays(Holiday)
            If Check = 1 Then
                MessageBox("Holiday Inserted.")
                ClearHoliday()
                GetHolidayList()
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub GetHolidayList()
        grdHolidayList.DataSource = HolidayData.fnGetHolidayList()
        grdHolidayList.DataBind()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearHoliday()
    End Sub

    Protected Sub ClearHoliday()
        dtDateFrom.Text = ""
        dtDateTo.Text = ""
        txtPurpose.Text = ""

        IDDateto.Visible = True
        tdDateto.Visible = True
        lblDateFrom.Text = "Date From"
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

        If InStr(MenuIDs, "MngHolidays~") = 0 Then
            Response.Redirect("~\frmHRMLogin.aspx")
        End If

        If Not IsPostBack Then
            GetHolidayList()
            pnlInputFormHoliday.Visible = True
            pnlUpdateHoliday.Visible = False
        End If
    End Sub

    Protected Sub grdHolidayList_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles grdHolidayList.RowDeleting
        Dim lblHolidayID As New Label
        lblHolidayID = grdHolidayList.Rows(e.RowIndex).FindControl("lblHolidayID")

        Dim Check As Integer = HolidayData.fnDeleteHoliday(lblHolidayID.Text)

        If Check = 1 Then
            MessageBox("Holiday Deleted.")
            GetHolidayList()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub grdHolidayList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdHolidayList.SelectedIndexChanged

        Dim lblHolidayID, lblDateFrom, lblPurpose As New Label
        lblHolidayID = grdHolidayList.SelectedRow.FindControl("lblHolidayID")
        lblDateFrom = grdHolidayList.SelectedRow.FindControl("lblDateFrom")
        lblPurpose = grdHolidayList.SelectedRow.FindControl("lblPurpose")

        hdFldHolidayID.Value = lblHolidayID.Text
        txtHolidayDate.Text = Convert.ToDateTime(lblDateFrom.Text)
        txtPurposeUpdate.Text = lblPurpose.Text

        pnlInputFormHoliday.Visible = False
        pnlUpdateHoliday.Visible = True

    End Sub

    Protected Sub btnUpdateHolidayInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateHolidayInfo.Click
        Try
            If Convert.ToDateTime(dtDateFrom.Text) < Convert.ToDateTime(dtDateTo.Text) Then
                MessageBox("To Date Should be less than from date")
                Exit Sub
            End If

            Dim Holiday As New clsHolidays()

            Holiday.HolidayID = hdFldHolidayID.Value
            Holiday.HolidayDate = Convert.ToDateTime(txtHolidayDate.Text)
            Holiday.Purpose = txtPurposeUpdate.Text
            Holiday.EntryBy = Session("LoginUserID")

            Dim Check As Integer = HolidayData.fnUpdateHoliday(Holiday)
            If Check = 1 Then
                MessageBox("Holiday Updated.")
                ClearHoliday()
                ClearUpdate()
                GetHolidayList()
            Else
                MessageBox("Error Found.")
            End If

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
        
    End Sub

    Protected Sub btnCancelUpdateHoliday_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelUpdateHoliday.Click
        ClearUpdate()
    End Sub

    Protected Sub ClearUpdate()
        hdFldHolidayID.Value = ""
        txtHolidayDate.Text = ""
        txtPurposeUpdate.Text = ""

        grdHolidayList.SelectedIndex = -1
        pnlInputFormHoliday.Visible = True
        pnlUpdateHoliday.Visible = False
        GetHolidayList()
    End Sub

End Class
