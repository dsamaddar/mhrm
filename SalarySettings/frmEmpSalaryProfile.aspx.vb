
Partial Class SalarySettings_frmEmpSalaryProfile
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()
    Dim EmpSalaryProfileData As New clsEmpSalaryProfile()

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click

        Dim EmpSalaryProfile As New clsEmpSalaryProfile()
        Dim Result As New clsResult()

        Try
            EmpSalaryProfile.EmployeeID = drpSelectEmployee.SelectedValue
            EmpSalaryProfile.BasicSalary = txtBasicSalary.Text
            EmpSalaryProfile.HouseRent = txtHouseRent.Text
            EmpSalaryProfile.Entertainment = txtEntertainment.Text
            EmpSalaryProfile.Medical = txtMedical.Text
            EmpSalaryProfile.Conveyance = txtConveyance.Text
            EmpSalaryProfile.HouseMaintenance = txtHouseMaintenance.Text
            EmpSalaryProfile.Consolidated = txtConsolidated.Text
            EmpSalaryProfile.LFA = txtLFA.Text
            EmpSalaryProfile.PerformanceBonus = txtPerformanceBonus.Text
            EmpSalaryProfile.FestivalBonus = txtFestivalBonus.Text
            EmpSalaryProfile.BaishakhiAllowance = txtBaishakhiBonus.Text
            EmpSalaryProfile.ProfessionalAllowance = txtProfessionalAllowance.Text
            EmpSalaryProfile.SpecialAllowance = txtSpecialAllowance.Text
            EmpSalaryProfile.MobileAllowance = txtMobileAllowance.Text
            EmpSalaryProfile.CarAllowance = txtCarAllowance.Text
            EmpSalaryProfile.Arrear = txtArrear.Text
            EmpSalaryProfile.Cash = txtCash.Text
            EmpSalaryProfile.AccountsRecoverable = txtAccountsRecoverable.Text
            EmpSalaryProfile.PFDeduction = txtPFDeduction.Text
            EmpSalaryProfile.PBTaxDeduction = txtPBTaxDeduction.Text
            EmpSalaryProfile.TaxDeduction = txtTaxDeduction.Text
            EmpSalaryProfile.ConveyanceDeduction = txtConveyenceDeduction.Text
            EmpSalaryProfile.LoanDeduction = txtLoanDeduction.Text
            EmpSalaryProfile.DonationDeduction = txtDonationDeduction.Text
            EmpSalaryProfile.EntryBy = Session("LoginUserID")

            If hdFldEmpSalaryProfileID.Value = "" Then
                Result = EmpSalaryProfile.fnInsertEmpSalaryProfile(EmpSalaryProfile)
                If Result.Success = True Then
                    ClearForm()
                End If
                MessageBox("" & Result.Message)
            Else
                EmpSalaryProfile.EmpSalaryProfileID = hdFldEmpSalaryProfileID.Value
                Result = EmpSalaryProfile.fnUpdateEmpSalaryProfile(EmpSalaryProfile)
                If Result.Success = True Then
                    'ClearForm()
                End If
                MessageBox("" & Result.Message)
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ClearForm()

        hdFldEmpSalaryProfileID.Value = ""
        txtBasicSalary.Text = "0"
        txtHouseRent.Text = "0"
        txtEntertainment.Text = "0"
        txtMedical.Text = "0"
        txtConveyance.Text = "0"
        txtHouseMaintenance.Text = "0"
        txtConsolidated.Text = "0"
        txtLFA.Text = "0"
        txtPerformanceBonus.Text = "0"
        txtFestivalBonus.Text = "0"
        txtBaishakhiBonus.Text = "0"
        txtProfessionalAllowance.Text = "0"
        txtSpecialAllowance.Text = "0"
        txtMobileAllowance.Text = "0"
        txtCarAllowance.Text = "0"
        txtArrear.Text = "0"
        txtCash.Text = "0"
        txtAccountsRecoverable.Text = "0"
        txtPFDeduction.Text = "0"
        txtPBTaxDeduction.Text = "0"
        txtTaxDeduction.Text = "0"
        txtConveyenceDeduction.Text = "0"
        txtLoanDeduction.Text = "0"
        txtDonationDeduction.Text = "0"

        drpSelectEmployee.SelectedIndex = -1

    End Sub

    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            GetEmployeeList()
        End If
    End Sub

    Protected Sub GetEmployeeList()
        drpSelectEmployee.DataValueField = "EmployeeID"
        drpSelectEmployee.DataTextField = "EmployeeName"
        drpSelectEmployee.DataSource = EmpData.fnGetEmpListPayrollActive()
        drpSelectEmployee.DataBind()
    End Sub

    Protected Sub drpSelectEmployee_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpSelectEmployee.SelectedIndexChanged
        Try
            Dim EmpSalaryProfile As New clsEmpSalaryProfile()
            EmpSalaryProfile = EmpSalaryProfileData.fnGetEmpSalaryProfile(drpSelectEmployee.SelectedValue)

            If EmpSalaryProfile Is Nothing Then
                MessageBox(drpSelectEmployee.SelectedItem.Text & " has no salary profile.")
                Exit Sub
            End If

            hdFldEmpSalaryProfileID.Value = EmpSalaryProfile.EmpSalaryProfileID
            txtBasicSalary.Text = EmpSalaryProfile.BasicSalary
            txtHouseRent.Text = EmpSalaryProfile.HouseRent
            txtEntertainment.Text = EmpSalaryProfile.Entertainment
            txtMedical.Text = EmpSalaryProfile.Medical
            txtConveyance.Text = EmpSalaryProfile.Conveyance
            txtHouseMaintenance.Text = EmpSalaryProfile.HouseMaintenance
            txtConsolidated.Text = EmpSalaryProfile.Consolidated
            txtLFA.Text = EmpSalaryProfile.LFA
            txtPerformanceBonus.Text = EmpSalaryProfile.PerformanceBonus
            txtFestivalBonus.Text = EmpSalaryProfile.FestivalBonus
            txtBaishakhiBonus.Text = EmpSalaryProfile.BaishakhiAllowance
            txtProfessionalAllowance.Text = EmpSalaryProfile.ProfessionalAllowance
            txtSpecialAllowance.Text = EmpSalaryProfile.SpecialAllowance
            txtMobileAllowance.Text = EmpSalaryProfile.MobileAllowance
            txtCarAllowance.Text = EmpSalaryProfile.CarAllowance
            txtArrear.Text = EmpSalaryProfile.Arrear
            txtCash.Text = EmpSalaryProfile.Cash
            txtAccountsRecoverable.Text = EmpSalaryProfile.AccountsRecoverable
            txtPFDeduction.Text = EmpSalaryProfile.PFDeduction
            txtPBTaxDeduction.Text = EmpSalaryProfile.PBTaxDeduction
            txtTaxDeduction.Text = EmpSalaryProfile.TaxDeduction
            txtConveyenceDeduction.Text = EmpSalaryProfile.ConveyanceDeduction
            txtLoanDeduction.Text = EmpSalaryProfile.LoanDeduction
            txtDonationDeduction.Text = EmpSalaryProfile.DonationDeduction
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

End Class
