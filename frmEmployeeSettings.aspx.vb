
Partial Class frmEmployeeSettings
    Inherits System.Web.UI.Page

    Dim EmployeeData As New clsEmployeeInfo()
    Dim DepartmentData As New clsDepartment()
    Dim DocumentData As New clsDocumentType()
    Dim DesignationData As New clsDesignation()
    Dim LateAttCauseData As New clsLateAttendanceCause()
    Dim EvalGroupData As New clsEvaluationGroup()
    Dim HealthPlanData As New clsHealthPlan()

    Protected Sub btnInsertDesignation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsertDesignation.Click
        Dim Designation As New clsDesignation()
        Try
            Designation.DesignationName = txtDesignationName.Text
            Designation.DesignationLabel = ddlDesigLabel.SelectedValue
            If ddlDesigLabel.SelectedValue = "0" Then
                MessageBox("Please Select Designation Label")
                Exit Sub
            End If
            Designation.DesignationType = rdoDesignationType.SelectedValue
            Designation.HealthPlanID = ddlHealthPlan.SelectedValue
            Designation.intOrder = txtOrder.Text
            Designation.EvaluationGroupID = drpEvaluationGroup.SelectedValue

            Designation.Fuel = Convert.ToInt32(txtFuel.Text)
            Designation.DriverAllowance = Convert.ToDouble(txtDriverAllowance.Text)
            Designation.VehicleMaintenance = Convert.ToDouble(txtVehicleMaintenance.Text)
            Designation.CarSubsidy = Convert.ToDouble(txtCarSubsidy.Text)
            Designation.NoticePeriod = Convert.ToInt32(txtNoticePeriod.Text)
            Designation.MobileAllowance = Convert.ToDouble(txtMobileAllowance.Text)
            Designation.TransportAllowance = Convert.ToDouble(txtTransportAllowance.Text)

            If chkIsDesigActive.Checked = True Then
                Designation.isActive = True
            Else
                Designation.isActive = False
            End If

            Designation.EntryBy = Session("LoginUserID")

            Dim check As Integer = Designation.fnInsertDesignation(Designation)

            If check = 1 Then
                ClearDesignation()
                ShowDesignation()
                MessageBox("Inserted.")
                ShowDesignationForGrid()
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub GetActiveEvalGroup()
        drpEvaluationGroup.DataTextField = "EvaluationGroup"
        drpEvaluationGroup.DataValueField = "EvaluationGroupID"
        drpEvaluationGroup.DataSource = EvalGroupData.fnGetActiveEvalGroup()
        drpEvaluationGroup.DataBind()

        Dim A As New ListItem
        A.Value = "N\A"
        A.Text = "N\A"
        drpEvaluationGroup.Items.Insert(0, A)
    End Sub

    Protected Sub btnCancelSelection_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelSelection.Click
        ClearDesignation()
    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub ClearDesignation()
        txtDesignationName.Text = ""
        ddlDesigLabel.SelectedValue = 0
        txtOrder.Text = ""
        chkIsDesigActive.Checked = False
        ddlHealthPlan.SelectedIndex = 0
        drpEvaluationGroup.SelectedIndex = -1
        txtFuel.Text = "0"
        txtDriverAllowance.Text = "0"
        txtVehicleMaintenance.Text = "0"
        txtCarSubsidy.Text = "0"
        txtNoticePeriod.Text = "0"
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then
            ShowDesignation()
            ShowDesignationForGrid()
            btnUpdateDesignation.Visible = False
            btnUpdateDocument.Visible = False
            ShowLateAttCauseList()
            GetHealthPlanType()
            ClearLateAttCause()
            ShowDocumentTypeForGrid()
            GetActiveEvalGroup()
            btnUpdateLateAttCause.Enabled = False
        End If

    End Sub

    Protected Sub ShowDesignation()
        drpAvailableDesignation.DataTextField = "DesignationName"
        drpAvailableDesignation.DataValueField = "DesignationID"
        drpAvailableDesignation.DataSource = DesignationData.fnGetDesignationList()
        drpAvailableDesignation.DataBind()
    End Sub

    Protected Sub ShowDesignationForGrid()
        grdDesignation.DataSource = DesignationData.fnGetDesignationList()
        grdDesignation.DataBind()
    End Sub

    Protected Sub GetHealthPlanType()
        Try
            ddlHealthPlan.DataTextField = "HealthPlanName"
            ddlHealthPlan.DataValueField = "HealthPlanID"
            ddlHealthPlan.DataSource = HealthPlanData.fnGetHealthPlanList()
            ddlHealthPlan.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub grdDesignation_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdDesignation.SelectedIndexChanged
        ddlDesigLabel.SelectedValue = 0
        rdoDesignationType.SelectedValue = 0

        Dim lblDesignationName, lblintOrder, lblisActive, lblDesignationType, lblDesignationLabel, _
        lblFuel, lblDriverAllowance, lblVehicleMaintenance, lblCarSubsidy, lblNoticePeriod, lblHealthPlanName, lblHealthPlanID, _
        lblEvaluationGroupID, lblMobileAllowance, lblTransportAllowance As New Label()
        Try
            lblDesignationName = grdDesignation.SelectedRow.FindControl("lblDesignationName")
            lblintOrder = grdDesignation.SelectedRow.FindControl("lblintOrder")
            lblisActive = grdDesignation.SelectedRow.FindControl("lblisActive")
            lblDesignationType = grdDesignation.SelectedRow.FindControl("lblDesignationType")
            lblDesignationLabel = grdDesignation.SelectedRow.FindControl("lblDesignationLabel")
            lblHealthPlanName = grdDesignation.SelectedRow.FindControl("lblHealthPlanName")
            lblHealthPlanID = grdDesignation.SelectedRow.FindControl("lblHealthPlanID")
            lblEvaluationGroupID = grdDesignation.SelectedRow.FindControl("lblEvaluationGroupID")
            lblFuel = grdDesignation.SelectedRow.FindControl("lblFuel")
            lblDriverAllowance = grdDesignation.SelectedRow.FindControl("lblDriverAllowance")
            lblVehicleMaintenance = grdDesignation.SelectedRow.FindControl("lblVehicleMaintenance")
            lblCarSubsidy = grdDesignation.SelectedRow.FindControl("lblCarSubsidy")
            lblNoticePeriod = grdDesignation.SelectedRow.FindControl("lblNoticePeriod")
            lblMobileAllowance = grdDesignation.SelectedRow.FindControl("lblMobileAllowance")
            lblTransportAllowance = grdDesignation.SelectedRow.FindControl("lblTransportAllowance")

            txtDesignationName.Text = lblDesignationName.Text
            ddlDesigLabel.SelectedValue = lblDesignationLabel.Text
            rdoDesignationType.SelectedValue = lblDesignationType.Text
            txtOrder.Text = lblintOrder.Text
            ddlHealthPlan.SelectedValue = lblHealthPlanID.Text
            drpEvaluationGroup.SelectedValue = lblEvaluationGroupID.Text

            txtFuel.Text = lblFuel.Text
            txtDriverAllowance.Text = lblDriverAllowance.Text
            txtVehicleMaintenance.Text = lblVehicleMaintenance.Text
            txtCarSubsidy.Text = lblCarSubsidy.Text
            txtNoticePeriod.Text = lblNoticePeriod.Text
            txtMobileAllowance.Text = Convert.ToDouble(lblMobileAllowance.Text)
            txtTransportAllowance.Text = Convert.ToDouble(lblTransportAllowance.Text)

            If lblisActive.Text = "Active" Then
                chkIsDesigActive.Checked = True
            Else
                chkIsDesigActive.Checked = False
            End If

            btnInsertDesignation.Visible = False
            btnUpdateDesignation.Visible = True
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnUpdateDesignation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateDesignation.Click
        Dim lblDesignationID As New System.Web.UI.WebControls.Label()
        lblDesignationID = grdDesignation.SelectedRow.FindControl("lblDesignationID")

        Dim UserID As String
        UserID = Session("LoginUserID")

        Dim Designation As New clsDesignation()

        Designation.DesignationID = lblDesignationID.Text
        Designation.DesignationName = txtDesignationName.Text
        Designation.DesignationLabel = ddlDesigLabel.SelectedValue
        If ddlDesigLabel.SelectedValue = "0" Then
            MessageBox("Please Select Designation Label")
            Exit Sub
        End If
        Designation.DesignationType = rdoDesignationType.SelectedValue
        Designation.HealthPlanID = ddlHealthPlan.SelectedValue
        Designation.intOrder = txtOrder.Text
        Designation.EvaluationGroupID = drpEvaluationGroup.SelectedValue
        Designation.Fuel = Convert.ToInt32(txtFuel.Text)
        Designation.DriverAllowance = Convert.ToDouble(txtDriverAllowance.Text)
        Designation.VehicleMaintenance = Convert.ToDouble(txtVehicleMaintenance.Text)
        Designation.CarSubsidy = Convert.ToDouble(txtCarSubsidy.Text)
        Designation.NoticePeriod = Convert.ToInt32(txtNoticePeriod.Text)
        Designation.MobileAllowance = Convert.ToDouble(txtMobileAllowance.Text)
        Designation.TransportAllowance = Convert.ToDouble(txtTransportAllowance.Text)

        If chkIsDesigActive.Checked = True Then
            Designation.isActive = 1
        Else
            Designation.isActive = 0
        End If

        Designation.EntryBy = UserID

        Dim check As Integer = DesignationData.fnUpdateDesignation(Designation)

        If check = 1 Then
            ClearDesignation()
            ShowDesignation()
            MessageBox("Updated.")
            ShowDesignationForGrid()
            btnUpdateDesignation.Visible = False
            btnInsertDesignation.Visible = True
        Else
            MessageBox("Error Found.")
            btnUpdateDesignation.Visible = True
            btnInsertDesignation.Visible = False
        End If
    End Sub

    Protected Sub btnInsertLateAttendanceCause_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsertLateAttendanceCause.Click

        Dim LateAttCause As New clsLateAttendanceCause()
        Try
            LateAttCause.Cause = txtLateAttendanceCause.Text
            If chkIsDetailsMandatory.Checked = True Then
                LateAttCause.IsDetailsMandatory = True
            Else
                LateAttCause.IsDetailsMandatory = False
            End If

            If chkIsReportable.Checked = True Then
                LateAttCause.IsReportable = True
            Else
                LateAttCause.IsReportable = False
            End If

            If chkIsLateAttCauseActive.Checked = True Then
                LateAttCause.IsActive = True
            Else
                LateAttCause.IsActive = False
            End If

            LateAttCause.EntryBy = Session("LoginUserID")

            Dim check As Integer = 0
            check = LateAttCauseData.fnInsertLateAttCause(LateAttCause)

            If check = 1 Then
                MessageBox("Inserted Successfully.")
                ShowLateAttCauseList()
                ClearLateAttCause()
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowLateAttCauseList()
        Try
            grdLateAttendanceCause.DataSource = LateAttCauseData.fnShowLateAttCauseList()
            grdLateAttendanceCause.DataBind()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnCancelLateAttSelection_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelLateAttSelection.Click
        ClearLateAttCause()
    End Sub

    Protected Sub ClearLateAttCause()
        chkIsDetailsMandatory.Checked = False
        chkIsReportable.Checked = False
        chkIsLateAttCauseActive.Checked = False
        txtLateAttendanceCause.Text = ""

        btnInsertLateAttendanceCause.Enabled = True
        btnUpdateLateAttCause.Enabled = False

        If grdLateAttendanceCause.Rows.Count > 0 Then
            grdLateAttendanceCause.SelectedIndex = -1
        End If
    End Sub

    Protected Sub btnInsertDocument_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnInsertDocument.Click
        Dim DocumentType As clsDocumentType = New clsDocumentType()
        DocumentType.DocumentType = txtNewDocumentType.Text
        DocumentType.DocTypeFor = ddlDocumentFor.SelectedValue
        DocumentType.DocumentCategory = drpDocumentCategory.SelectedValue
        DocumentType.IsMandatory = chkDocumentTypeIsMandatory.Checked
        DocumentType.IsActive = chkIsActive.Checked

        If chkPerfPositive.Checked = True Then
            DocumentType.PerformanceCriteria = "Positive"
        End If

        If chkPerfNegative.Checked = True Then
            DocumentType.PerformanceCriteria = "Negative"
        End If

        If chkPerfPositive.Checked = False And chkPerfNegative.Checked = False Then
            DocumentType.PerformanceCriteria = "N\A"
        End If

        DocumentType.EntryBy = Session("LoginUserID")

        Dim check As Integer = DocumentData.fnInsertDocumentType(DocumentType)

        If check = 1 Then
            MessageBox("Inserted Successfully.")
            ShowDocumentTypeForGrid()
            ClearDocumentType()
        Else
            MessageBox("Error Found.")
        End If
    End Sub

    Protected Sub ShowDocumentTypeForGrid()
        grdDocument.DataSource = DocumentData.fnShowDocumentTypeForGrid()
        grdDocument.DataBind()
    End Sub

    Protected Sub ClearDocumentType()
        txtNewDocumentType.Text = ""
        ddlDocumentFor.SelectedIndex = 0
        chkIsActive.Checked = False
        chkDocumentTypeIsMandatory.Checked = False

        btnInsertDocument.Visible = True
        btnUpdateDocument.Visible = False

        chkPerfPositive.Checked = False
        chkPerfNegative.Checked = False
    End Sub

    Protected Sub grdDocument_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdDocument.SelectedIndexChanged
        Dim lblDocTypeID, lblPerformanceCriteria As New Label()
        Dim DocTypeID As String
        Try
            lblDocTypeID = grdDocument.SelectedRow.FindControl("lblDocTypeID")
            lblPerformanceCriteria = grdDocument.SelectedRow.FindControl("lblPerformanceCriteria")

            DocTypeID = Convert.ToString(lblDocTypeID.Text)
            Dim DocumentType As New clsDocumentType()

            DocumentType = DocumentData.fnShowDocumentTypeByID(DocTypeID)

            txtNewDocumentType.Text = DocumentType.DocumentType
            ddlDocumentFor.SelectedValue = DocumentType.DocTypeFor
            drpDocumentCategory.SelectedValue = DocumentType.DocumentCategory

            If DocumentType.IsActive = True Then
                chkIsActive.Checked = True
            Else
                chkIsActive.Checked = False
            End If

            If DocumentType.IsMandatory = True Then
                chkDocumentTypeIsMandatory.Checked = True
            Else
                chkDocumentTypeIsMandatory.Checked = False
            End If

            If DocumentType.IsPerformanceFactor = True Then
                chkIsPerformanceFactor.Checked = True
            Else
                chkIsPerformanceFactor.Checked = False
            End If

            If lblPerformanceCriteria.Text = "Positive" Then
                chkPerfPositive.Checked = True
                chkPerfNegative.Checked = False
            End If

            If lblPerformanceCriteria.Text = "Negative" Then
                chkPerfNegative.Checked = True
                chkPerfPositive.Checked = False
            End If

            btnInsertDocument.Visible = False
            btnUpdateDocument.Visible = True
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnUpdateDocument_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateDocument.Click
        Dim DocumentType As New clsDocumentType()

        Dim lblDocTypeID, lblIsPerformanceFactor As New Label()
        Try
            lblDocTypeID = grdDocument.SelectedRow.FindControl("lblDocTypeID")

            DocumentType.DocTypeID = Convert.ToString(lblDocTypeID.Text)
            DocumentType.DocumentType = txtNewDocumentType.Text
            DocumentType.DocTypeFor = ddlDocumentFor.SelectedValue
            DocumentType.DocumentCategory = drpDocumentCategory.SelectedValue

            If chkDocumentTypeIsMandatory.Checked = True Then
                DocumentType.IsMandatory = True
            Else
                DocumentType.IsMandatory = False
            End If

            If chkIsActive.Checked = True Then
                DocumentType.IsActive = True
            Else
                DocumentType.IsActive = False
            End If

            If chkIsPerformanceFactor.Checked = True Then
                DocumentType.IsPerformanceFactor = True
            Else
                DocumentType.IsPerformanceFactor = False
            End If

            If chkPerfPositive.Checked = True Then
                DocumentType.PerformanceCriteria = "Positive"
            End If

            If chkPerfNegative.Checked = True Then
                DocumentType.PerformanceCriteria = "Negative"
            End If

            If chkPerfNegative.Checked = False And chkPerfPositive.Checked = False Then
                DocumentType.PerformanceCriteria = ""
            End If

            Dim check As Integer = DocumentData.fnUpdateDocumentType(DocumentType)

            If check = 1 Then
                MessageBox("Updated Successfully.")
                ShowDocumentTypeForGrid()
                ClearDocumentType()
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnUploadDocumentCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUploadDocumentCancel.Click
        ClearDocumentType()
    End Sub

    Protected Sub grdLateAttendanceCause_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdLateAttendanceCause.SelectedIndexChanged
        Dim lblLateAttCauseID, lblCause, lblIsDetailsMandatory, lblIsReportable, lblReportableToDept, lblIsActive As New Label()

        Try
            lblLateAttCauseID = grdLateAttendanceCause.SelectedRow.FindControl("lblLateAttCauseID")
            lblCause = grdLateAttendanceCause.SelectedRow.FindControl("lblCause")
            lblIsDetailsMandatory = grdLateAttendanceCause.SelectedRow.FindControl("lblIsDetailsMandatory")
            lblIsReportable = grdLateAttendanceCause.SelectedRow.FindControl("lblIsReportable")
            lblIsActive = grdLateAttendanceCause.SelectedRow.FindControl("lblIsActive")

            If lblIsDetailsMandatory.Text = "YES" Then
                chkIsDetailsMandatory.Checked = True
            Else
                chkIsDetailsMandatory.Checked = False
            End If

            If lblIsReportable.Text = "YES" Then
                chkIsReportable.Checked = True
            Else
                chkIsReportable.Checked = False
            End If

            If lblIsActive.Text = "YES" Then
                chkIsLateAttCauseActive.Checked = True
            Else
                chkIsLateAttCauseActive.Checked = False
            End If

            txtLateAttendanceCause.Text = lblCause.Text
            hdFldLateAttCauseID.Value = lblLateAttCauseID.Text
            btnInsertLateAttendanceCause.Enabled = False
            btnUpdateLateAttCause.Enabled = True
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub btnUpdateLateAttCause_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateLateAttCause.Click
        Dim LateAttCause As New clsLateAttendanceCause()

        Try
            LateAttCause.LateAttCauseID = hdFldLateAttCauseID.Value
            LateAttCause.Cause = txtLateAttendanceCause.Text
            If chkIsDetailsMandatory.Checked = True Then
                LateAttCause.IsDetailsMandatory = True
            Else
                LateAttCause.IsDetailsMandatory = False
            End If

            If chkIsReportable.Checked = True Then
                LateAttCause.IsReportable = True
            Else
                LateAttCause.IsReportable = False
            End If

            If chkIsLateAttCauseActive.Checked = True Then
                LateAttCause.IsActive = True
            Else
                LateAttCause.IsActive = False
            End If

            LateAttCause.EntryBy = Session("LoginUserID")

            Dim check As Integer = 0
            check = LateAttCauseData.fnUpdateLateAttCause(LateAttCause)

            If check = 1 Then
                MessageBox("Updated Successfully.")
                ShowLateAttCauseList()
                ClearLateAttCause()
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub chkPerfPositive_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkPerfPositive.CheckedChanged
        If chkIsPerformanceFactor.Checked = True Then
            If chkPerfPositive.Checked = True Then
                chkPerfNegative.Checked = False
            End If
        End If
    End Sub

    Protected Sub chkPerfNegative_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkPerfNegative.CheckedChanged
        If chkIsPerformanceFactor.Checked = True Then
            If chkPerfNegative.Checked = True Then
                chkPerfPositive.Checked = False
            End If
        End If
    End Sub

End Class
