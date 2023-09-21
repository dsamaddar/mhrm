
Partial Class LeaveManagement_frmEditEmpLeaveBalance
    Inherits System.Web.UI.Page

    Dim EmpLeaveBalData As New clsEmpLeaveBalance()
    Dim EmpData As New clsEmployeeInfo()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            FormInitialization()
        End If
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub FormInitialization()
        GetEmployeeList()
        ShowLeaveBalance()
        drpLeaveYear.Enabled = False
        drpLeaveYear.SelectedValue = Now.Year
        btnInsert.Enabled = True
        btnUpdate.Enabled = False
        grdLeaveBalance.SelectedIndex = -1
        hdFldEmpLeaveBalanceID.Value = ""
        txtAnnualLeve.Text = "0"
        txtCasualLeave.Text = "10"
        txtLeaveWithOutPay.Text = "0"
        txtMaternityLeave.Text = "0"
        txtMedicalLeave.Text = "0"
        txtSpecialLeave.Text = "0"
        txtSickLeave.Text = "0"
    End Sub

    Protected Sub GetEmployeeList()
        drpUserList.DataValueField = "EmployeeID"
        drpUserList.DataTextField = "EmployeeName"
        drpUserList.DataSource = EmpData.fnGetEmpListPayrollActive()
        drpUserList.DataBind()

        Dim A As New ListItem()
        A.Text = "N\A"
        A.Value = "N\A"
        drpUserList.Items.Insert(0, A)
    End Sub

    Protected Sub btnInsert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsert.Click
        Try
            Dim EmpLeaveBal As New clsEmpLeaveBalance()
            Dim result As New clsResult()

            If drpUserList.SelectedValue = "N\A" Then
                MessageBox("Select An Employee First.")
                Exit Sub
            End If

            EmpLeaveBal.EmployeeID = drpUserList.SelectedValue
            EmpLeaveBal.CasualLeave = txtCasualLeave.Text
            EmpLeaveBal.MedicalLeave = txtMedicalLeave.Text
            EmpLeaveBal.AnnualLeave = txtAnnualLeve.Text
            EmpLeaveBal.MaternityLeave = txtMaternityLeave.Text
            EmpLeaveBal.LeaveWithOutPay = txtLeaveWithOutPay.Text
            EmpLeaveBal.SpecialLeave = txtSpecialLeave.Text
            EmpLeaveBal.SickLeave = txtSickLeave.Text
            EmpLeaveBal.LeaveYear = drpLeaveYear.SelectedValue
            EmpLeaveBal.EntryBy = Session("LoginUserID")

            result = EmpLeaveBalData.fnInsertEmpLeaveBalance(EmpLeaveBal)

            If result.Success = True Then
                ShowLeaveBalance()
            End If

            MessageBox(result.Message)

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowLeaveBalance()
        Try
            grdLeaveBalance.DataSource = EmpLeaveBalData.fnGetAllEmpLeaveBalance(drpUserList.SelectedValue)
            grdLeaveBalance.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Try
            Dim EmpLeaveBal As New clsEmpLeaveBalance()
            Dim result As New clsResult()

            If drpUserList.SelectedValue = "N\A" Then
                MessageBox("Select An Employee First.")
                Exit Sub
            End If

            EmpLeaveBal.EmpLeaveBalanceID = hdFldEmpLeaveBalanceID.Value
            EmpLeaveBal.EmployeeID = drpUserList.SelectedValue
            EmpLeaveBal.CasualLeave = txtCasualLeave.Text
            EmpLeaveBal.MedicalLeave = txtMedicalLeave.Text
            EmpLeaveBal.AnnualLeave = txtAnnualLeve.Text
            EmpLeaveBal.MaternityLeave = txtMaternityLeave.Text
            EmpLeaveBal.LeaveWithOutPay = txtLeaveWithOutPay.Text
            EmpLeaveBal.SpecialLeave = txtSpecialLeave.Text
            EmpLeaveBal.SickLeave = txtSickLeave.Text
            EmpLeaveBal.LeaveYear = drpLeaveYear.SelectedValue
            EmpLeaveBal.EntryBy = Session("LoginUserID")

            result = EmpLeaveBalData.fnUpdateEmpLeaveBalance(EmpLeaveBal)

            If result.Success = True Then
                ShowLeaveBalance()
            End If

            MessageBox(result.Message)

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub grdLeaveBalance_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdLeaveBalance.SelectedIndexChanged
        Try
            Dim lblEmpLeaveBalanceID, lblEmployeeID, lblCasualLeave, lblMedicalLeave, lblAnnualLeave, lblMaternityLeave, lblLeaveWithOutPay, _
            lblSpecialLeave, lblSickLeave, lblLeaveYear As New Label

            lblEmpLeaveBalanceID = grdLeaveBalance.SelectedRow.FindControl("lblEmpLeaveBalanceID")
            lblEmployeeID = grdLeaveBalance.SelectedRow.FindControl("lblEmployeeID")
            lblCasualLeave = grdLeaveBalance.SelectedRow.FindControl("lblCasualLeave")
            lblMedicalLeave = grdLeaveBalance.SelectedRow.FindControl("lblMedicalLeave")
            lblAnnualLeave = grdLeaveBalance.SelectedRow.FindControl("lblAnnualLeave")
            lblMaternityLeave = grdLeaveBalance.SelectedRow.FindControl("lblMaternityLeave")
            lblLeaveWithOutPay = grdLeaveBalance.SelectedRow.FindControl("lblLeaveWithOutPay")
            lblSpecialLeave = grdLeaveBalance.SelectedRow.FindControl("lblSpecialLeave")
            lblSickLeave = grdLeaveBalance.SelectedRow.FindControl("lblSickLeave")
            lblLeaveYear = grdLeaveBalance.SelectedRow.FindControl("lblLeaveYear")

            hdFldEmpLeaveBalanceID.Value = lblEmpLeaveBalanceID.Text
            drpUserList.SelectedValue = lblEmployeeID.Text
            txtCasualLeave.Text = lblCasualLeave.Text
            txtMedicalLeave.Text = lblMedicalLeave.Text
            txtAnnualLeve.Text = lblAnnualLeave.Text
            txtMaternityLeave.Text = lblMaternityLeave.Text
            txtLeaveWithOutPay.Text = lblLeaveWithOutPay.Text
            txtSpecialLeave.Text = lblSpecialLeave.Text
            txtSickLeave.Text = lblSickLeave.Text
            drpLeaveYear.SelectedValue = lblLeaveYear.Text

            btnInsert.Enabled = False
            btnUpdate.Enabled = True

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        FormInitialization()
    End Sub

End Class
