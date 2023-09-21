

Partial Class Administration_frmEmpEditBasicInfoAdmin
    Inherits System.Web.UI.Page

    Dim DeptData As New clsDepartment()
    Dim EmployeeData As New clsEmployeeInfo()
    Dim TotalEmpCount As Integer = 0

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Dim OrgSrchStr As New clsEmployeeInfo()

        Try
            OrgSrchStr.EmpIDOrName = txtEmpIDOrName.Text
            OrgSrchStr.EmpTypeID = drpEmployeeType.SelectedValue

            If drpSelectDesignation.SelectedIndex = 0 Then
                OrgSrchStr.OfficialDesignationID = "N\A"
            Else
                OrgSrchStr.OfficialDesignationID = drpSelectDesignation.SelectedValue
            End If

            If drpSelectDepartment.SelectedIndex = 0 Then
                OrgSrchStr.DepartmentID = "N\A"
            Else
                OrgSrchStr.DepartmentID = drpSelectDepartment.SelectedValue
            End If

            If drpULCBranch.SelectedIndex = 0 Then
                OrgSrchStr.ULCBranchID = "N\A"
            Else
                OrgSrchStr.ULCBranchID = drpULCBranch.SelectedValue
            End If

            OrgSrchStr.IsActive = drpEmployeeStatus.SelectedValue
            If rdbtnGender.SelectedIndex = -1 Then
                OrgSrchStr.Gender = "N\A"
            Else
                OrgSrchStr.Gender = rdbtnGender.SelectedValue
            End If

            OrgSrchStr.BloodGroupID = ddlBloodGrp.SelectedValue
            OrgSrchStr.PerDistrict = Convert.ToInt32(ddlPerDistrict.SelectedValue)

            grdEmployeeList.DataSource = EmployeeData.fnSearchEmployeeForEdit(OrgSrchStr)
            grdEmployeeList.DataBind()

            grdEmployeeList.SelectedIndex = -1

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

    Protected Sub ShowULCBranch()
        drpULCBranch.DataTextField = "ULCBranchName"
        drpULCBranch.DataValueField = "ULCBranchID"
        drpULCBranch.DataSource = EmployeeData.fnGetULCBranch()
        drpULCBranch.DataBind()
    End Sub

    Protected Sub ShowDesignationOfficial()
        drpSelectDesignation.DataTextField = "DesignationName"
        drpSelectDesignation.DataValueField = "DesignationID"
        drpSelectDesignation.DataSource = EmployeeData.fnGetOfficialDesignation()
        drpSelectDesignation.DataBind()
    End Sub

    Protected Sub getBloodGroup()
        ddlBloodGrp.DataTextField = "BloodGroupName"
        ddlBloodGrp.DataValueField = "BloodGroupID"
        ddlBloodGrp.DataSource = EmployeeData.fnGetBloodGroup()
        ddlBloodGrp.DataBind()

        Dim A As New ListItem()
        A.Text = "N\A"
        A.Value = "N\A"
        ddlBloodGrp.Items.Insert(0, A)

    End Sub

    Protected Sub geDistrictName()
        ddlPerDistrict.DataTextField = "DistrictName"
        ddlPerDistrict.DataValueField = "DistrictID"
        ddlPerDistrict.DataSource = EmployeeData.getDistrictName()
        ddlPerDistrict.DataBind()

        Dim A As New ListItem()
        A.Text = "N\A"
        A.Value = "0"
        ddlPerDistrict.Items.Insert(0, A)

    End Sub

    Protected Sub ShowDepertment()
        drpSelectDepartment.DataTextField = "DeptName"
        drpSelectDepartment.DataValueField = "DepartmentID"
        drpSelectDepartment.DataSource = DeptData.fnGetDeptList()
        drpSelectDepartment.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            ShowULCBranch()
            ShowDesignationOfficial()
            getBloodGroup()
            geDistrictName()
            ShowDepertment()
            txtAttendanceID.Attributes.Add("Value", String.Empty)
        End If
    End Sub

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click

        If hdFldEmployeeID.Value = "" Then
            MessageBox("Select An Employee First.")
            Exit Sub
        End If

        Dim EmpInfo As New clsEmployeeInfo()

        EmpInfo.EmployeeID = hdFldEmployeeID.Value
        EmpInfo.EmpCode = txtEmpCode.Text
        EmpInfo.UserType = drpUserType.SelectedValue
        EmpInfo.UserID = txtUserID.Text
        EmpInfo.Password = txtUserPassword.Text
        If drpEmpStatus.SelectedValue = "1" Then
            EmpInfo.isActive = True
        Else
            EmpInfo.isActive = False
        End If
        EmpInfo.IsPermittedToShowOwn = IIf(drpPermittedOnEdtOwn.SelectedValue = "1", True, False)
        EmpInfo.IsPermittedToShowOthers = IIf(drpPermittedToEditOthers.SelectedValue = "1", True, False)
        EmpInfo.AttendanceID = txtAttendanceID.Text
        EmpInfo.ProbationEffectiveDate = Convert.ToDateTime(txtProbationEffectiveDate.Text)
        EmpInfo.ProbationPeriod = Convert.ToInt32(txtProbationPeriod.Text)

        If chkAutoAdvTaxDeduction.Checked = True Then
            EmpInfo.AutoAdvTaxDeduction = True
        Else
            EmpInfo.AutoAdvTaxDeduction = False
        End If

        If chkIncludedInPayroll.Checked = True Then
            EmpInfo.IncludedInPayroll = True
        Else
            EmpInfo.IncludedInPayroll = False
        End If

        Dim Check As Integer = EmployeeData.fnEditBasicEmpInfoAdmin(EmpInfo)

        If Check = 1 Then
            MessageBox("Updated Successfully.")
            ClearBasicInfo()
        Else
            MessageBox("Error Found.")
        End If

    End Sub

    Protected Sub ClearBasicInfo()
        txtUserPassword.Attributes.Add("Value", String.Empty)
        txtEmpCode.Text = ""
        hdFldEmployeeID.Value = ""
        txtUserID.Attributes.Add("Value", String.Empty)
        txtUserPassword.Text = ""
        drpPermittedOnEdtOwn.SelectedIndex = -1
        drpPermittedToEditOthers.SelectedIndex = -1
        drpEmployeeStatus.SelectedIndex = -1
        txtAttendanceID.Attributes.Add("Value", String.Empty)
        chkAutoAdvTaxDeduction.Checked = False
        txtProbationEffectiveDate.Text = ""
        txtProbationPeriod.Text = ""
    End Sub

    Protected Sub btnCancelSelection_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelSelection.Click
        ClearBasicInfo()
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click

    End Sub

    Protected Sub grdEmployeeList_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdEmployeeList.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            TotalEmpCount += 1
        End If

        If e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(0).Text = "Total:"
            e.Row.Cells(2).Text = TotalEmpCount.ToString()
        End If
    End Sub

    Protected Sub grdEmployeeList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdEmployeeList.SelectedIndexChanged
        Try
            Dim lblEmployeeID As New Label
            Dim EmpInfoData As New clsEmployeeInfo()
            Dim EmpInfo As New clsEmployeeInfo()

            lblEmployeeID = grdEmployeeList.SelectedRow.FindControl("lblEmployeeID")
            hdFldEmployeeID.Value = lblEmployeeID.Text
            EmpInfo = EmpInfoData.fnGetEmpInformationByID(lblEmployeeID.Text)

            txtEmpCode.Text = EmpInfo.EmpCode
            drpUserType.SelectedValue = EmpInfo.UserType
            txtUserID.Text = EmpInfo.UserID
            txtUserPassword.Attributes.Add("Value", EmpInfo.Password)

            If EmpInfo.isActive = True Then
                drpEmpStatus.SelectedValue = "1"
            Else
                drpEmpStatus.SelectedValue = "0"
            End If
            drpPermittedOnEdtOwn.SelectedValue = IIf(EmpInfo.IsPermittedToShowOwn = True, "1", "0")
            drpPermittedToEditOthers.SelectedValue = IIf(EmpInfo.IsPermittedToShowOthers = True, "1", "0")
            txtAttendanceID.Text = EmpInfo.AttendanceID
            txtProbationEffectiveDate.Text = EmpInfo.ProbationEffectiveDate
            txtProbationPeriod.Text = EmpInfo.ProbationPeriod

            If EmpInfo.AutoAdvTaxDeduction = True Then
                chkAutoAdvTaxDeduction.Checked = True
            Else
                chkAutoAdvTaxDeduction.Checked = False
            End If

            If EmpInfo.IncludedInPayroll = True Then
                chkIncludedInPayroll.Checked = True
            Else
                chkIncludedInPayroll.Checked = False
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

End Class
