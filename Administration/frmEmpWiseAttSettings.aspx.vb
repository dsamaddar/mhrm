
Partial Class Administration_frmEmpWiseAttSettings
    Inherits System.Web.UI.Page

    Dim EmpInfoData As New clsEmployeeInfo()
    Dim UsrAttData As New clsUserAttendance()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim MenuIDs As String

        MenuIDs = Session("PermittedMenus")

        If InStr(MenuIDs, "EmpAttSett~") = 0 Then
            Response.Redirect("~\frmHRMLogin.aspx")
        End If

        If Not IsPostBack Then
            ListAllActionEmpForAttSettings()
        End If
    End Sub

    Protected Sub chkSelectAllEmployees_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkSelectAllEmployees.CheckedChanged
        If chkSelectAllEmployees.Checked = True Then
            For Each item As ListItem In chkEmpList.Items
                item.Selected = True
            Next
        Else
            For Each item As ListItem In chkEmpList.Items
                item.Selected = False
            Next
        End If
    End Sub

    Protected Sub ListAllActionEmpForAttSettings()
        chkEmpList.DataTextField = "EmployeeName"
        chkEmpList.DataValueField = "EmpCode"
        chkEmpList.DataSource = EmpInfoData.fnListAllActiveEmpAttSettings()
        chkEmpList.DataBind()
    End Sub

    Protected Sub btnProcess_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnProcess.Click

        Dim EmployeeIDList As String = ""
        Dim UserAtt As New clsUserAttendance()

        Try
            For Each itm As ListItem In chkEmpList.Items
                If itm.Selected = True Then
                    EmployeeIDList &= itm.Value + ","
                End If
            Next

            If EmployeeIDList = "" Then
                MessageBox("Select Employees To Process.")
                Exit Sub
            Else
                EmployeeIDList = EmployeeIDList.Remove(Len(EmployeeIDList) - 1, 1)
                UserAtt.EmpList = EmployeeIDList
            End If

            If chkInheritDefaultSettings.Checked = True Then
                UserAtt.IdealLogTimeText = ""
                UserAtt.IdealLogOutTimeText = ""
            Else
                UserAtt.IdealLogTimeText = drpHour.SelectedValue + ":" + drpMin.SelectedValue + ":00 " + drpAMPM.SelectedValue
                UserAtt.IdealLogOutTimeText = drpHourO.SelectedValue + ":" + drpMinO.SelectedValue + ":00 " + drpAMPMO.SelectedValue
            End If


            Dim check As Integer = UsrAttData.fnUpdateEmpWiseAttSettings(UserAtt)

            If check = 1 Then
                MessageBox("Updated Successfully.")
                ClearForm()
            Else
                MessageBox("")
            End If
        Catch ex As Exception
            MessageBox("Error Occured.")
        End Try

    End Sub

    Protected Sub ClearForm()
        For Each itm As ListItem In chkEmpList.Items
            If itm.Selected = True Then
                itm.Selected = False
            End If
        Next

        chkSelectAllEmployees.Checked = False

        ListAllActionEmpForAttSettings()

        drpAMPM.SelectedIndex = -1
        drpHour.SelectedIndex = -1
        drpMin.SelectedIndex = -1
        chkInheritDefaultSettings.Checked = False
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

End Class
