
Partial Class SalarySettings_frmEmpSalaryProfile
    Inherits System.Web.UI.Page

    Dim EmpData As New clsEmployeeInfo()
    Dim EmpSalaryProfileData As New clsEmpSalaryProfile()

    Protected Sub btnUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate.Click

        Dim EmpSalaryProfile As New clsEmpSalaryProfile()
        Dim Result As New clsResult()

        Try
            EmpSalaryProfile.EmployeeID = drpSelectEmployee.SelectedValue
            EmpSalaryProfile.GrossSalary = txtGrossSalary.Text
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
        txtGrossSalary.Text = "0"
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

        lblBasicSalaryM.Text = "0"
        lblBasicSalaryY.Text = "0"
        lblCTCM.Text = "0"
        lblCTCY.Text = "0"
        lblFestivalBonusM.Text = "0"
        lblFestivalBonusMPM.Text = "0"
        lblFestivalBonusMPY.Text = "0"
        lblFestivalBonusY.Text = "0"
        lblHouseRentM.Text = "0"
        lblHouseRentY.Text = "0"
        lblGratuityM.Text = "0"
        lblGratuityY.Text = "0"
        lblLFAM.Text = "0"
        lblLFAY.Text = "0"
        lblMedicalAllowanceM.Text = "0"
        lblMedicalAllowanceY.Text = "0"
        lblMobileBIllM.Text = "0"
        lblMobileBIllY.Text = "0"
        lblProvidentFundM.Text = "0"
        lblProvidentFundY.Text = "0"
        lblTotalBenefitBM.Text = "0"
        lblTotalBenefitBY.Text = "0"
        lblTotalGrossSalaryAM.Text = "0"
        lblTotalGrossSalaryAY.Text = "0"
        lblTCBM.Text = "0"
        lblTCBY.Text = "0"

        lblEmpType.Text = ""
        lblBSPer.Text = ""
        lblHRPer.Text = ""
        lblMedPer.Text = ""
        lblConvPer.Text = ""
        lblLFAPer.Text = ""
        lblPFPer.Text = ""

        drpSelectEmployee.SelectedIndex = -1

    End Sub

    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        ClearForm()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            Dim MenuIDs As String
            MenuIDs = Session("PermittedMenus")

            If InStr(MenuIDs, "EmpSalarySetup~") = 0 Then
                Response.Redirect("~\frmHRMLogin.aspx")
            End If

            GetEmployeeList()
        End If
    End Sub

    Protected Sub GetEmployeeList()
        Try
            drpSelectEmployee.DataValueField = "EmployeeID"
            drpSelectEmployee.DataTextField = "EmployeeName"
            drpSelectEmployee.DataSource = EmpData.fnGetEmpListPayrollActive()
            drpSelectEmployee.DataBind()

            Dim A As New ListItem()
            A.Text = "N\A"
            A.Value = "N\A"
            drpSelectEmployee.Items.Insert(0, A)
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub drpSelectEmployee_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles drpSelectEmployee.SelectedIndexChanged
        Try
            If drpSelectEmployee.SelectedItem.Text = "N\A" Then
                ClearForm()
                Exit Sub
            End If

            Dim EmpSalaryProfile As New clsEmpSalaryProfile()
            EmpSalaryProfile = EmpSalaryProfileData.fnGetEmpSalaryProfile(drpSelectEmployee.SelectedValue)

            If EmpSalaryProfile Is Nothing Then
                MessageBox(drpSelectEmployee.SelectedItem.Text & " has no salary profile.")
                Exit Sub
            End If

            hdFldEmpSalaryProfileID.Value = EmpSalaryProfile.EmpSalaryProfileID
            txtGrossSalary.Text = EmpSalaryProfile.GrossSalary
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
            LoadEmpStatus()
            fnCalculateSummary()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub LoadEmpStatus()
        Try
            lblEmpType.Text = EmpData.fnGetEmployeeTypeByEmpID(drpSelectEmployee.SelectedValue)

            If lblEmpType.Text = "Permanent" Then
                lblBSPer.Text = "(50%)"
                lblHRPer.Text = "(25%)"
                lblMedPer.Text = "(5%)"
                lblConvPer.Text = "(7.5%)"
                lblLFAPer.Text = "(12.5%)"
                lblPFPer.Text = "(10%)"
            Else
                lblBSPer.Text = "(50%)"
                lblHRPer.Text = "(25%)"
                lblMedPer.Text = "(5%)"
                lblConvPer.Text = "(20%)"
                lblLFAPer.Text = ""
                lblPFPer.Text = ""
            End If

        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub fnCalculateSummary()
        lblBasicSalaryM.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtBasicSalary.Text))
        lblBasicSalaryY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(lblBasicSalaryM.Text) * 12)

        lblHouseRentM.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtHouseRent.Text))
        lblHouseRentY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtHouseRent.Text) * 12)

        lblMedicalAllowanceM.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtMedical.Text))
        lblMedicalAllowanceY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtMedical.Text) * 12)

        lblFestivalBonusMPM.Text = String.Format("{0:#,##0.00}", (Convert.ToDouble(lblBasicSalaryM.Text) * 2) / 12)
        lblFestivalBonusMPY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(lblBasicSalaryM.Text) * 2)

        lblLFAM.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtLFA.Text))
        lblLFAY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtLFA.Text) * 12)

        lblTotalGrossSalaryAM.Text = Convert.ToDouble(lblBasicSalaryM.Text) + Convert.ToDouble(lblHouseRentM.Text) + Convert.ToDouble(lblMedicalAllowanceM.Text) + Convert.ToDouble(lblFestivalBonusMPM.Text) + Convert.ToDouble(lblLFAM.Text)
        lblTotalGrossSalaryAY.Text = Convert.ToDouble(lblBasicSalaryY.Text) + Convert.ToDouble(lblHouseRentY.Text) + Convert.ToDouble(lblMedicalAllowanceY.Text) + Convert.ToDouble(lblFestivalBonusMPY.Text) + Convert.ToDouble(lblLFAY.Text)
        lblTotalGrossSalaryAM.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(lblTotalGrossSalaryAM.Text))
        lblTotalGrossSalaryAY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(lblTotalGrossSalaryAY.Text))

        lblMobileBIllM.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtMobileAllowance.Text))
        lblMobileBIllY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtMobileAllowance.Text) * 12)

        lblFestivalBonusM.Text = String.Format("{0:#,##0.00}", (Convert.ToDouble(lblBasicSalaryM.Text) * 2) / 12)
        lblFestivalBonusY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(lblBasicSalaryM.Text) * 2)

        lblTotalBenefitBM.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(lblMobileBIllM.Text) + Convert.ToDouble(lblFestivalBonusM.Text))
        lblTotalBenefitBY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(lblMobileBIllY.Text) + Convert.ToDouble(lblFestivalBonusY.Text))

        lblProvidentFundM.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtPFDeduction.Text))
        lblProvidentFundY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtPFDeduction.Text) * 12)

        lblProvidentFundM.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtBasicSalary.Text) / 12)
        lblProvidentFundY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(txtBasicSalary.Text))

        lblTCBM.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(lblProvidentFundM.Text) + Convert.ToDouble(lblProvidentFundM.Text))
        lblTCBY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(lblProvidentFundY.Text) + Convert.ToDouble(lblProvidentFundY.Text))

        lblCTCM.Text = Convert.ToDouble(lblTotalGrossSalaryAM.Text) + Convert.ToDouble(lblTotalBenefitBM.Text) + Convert.ToDouble(lblTCBM.Text)
        lblCTCY.Text = Convert.ToDouble(lblTotalGrossSalaryAY.Text) + Convert.ToDouble(lblTotalBenefitBY.Text) + Convert.ToDouble(lblTCBY.Text)

        lblCTCM.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(lblCTCM.Text))
        lblCTCY.Text = String.Format("{0:#,##0.00}", Convert.ToDouble(lblCTCY.Text))

    End Sub

    Private Sub MessageBox(ByVal strMsg As String)
        Dim lbl As New System.Web.UI.WebControls.Label
        lbl.Text = "<script language='javascript'>" & Environment.NewLine _
                   & "window.alert(" & "'" & strMsg & "'" & ")</script>"
        Page.Controls.Add(lbl)
    End Sub

    Protected Sub txtGrossSalary_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtGrossSalary.TextChanged
        Try
            Dim GrossSalary As Double = Convert.ToDouble(txtGrossSalary.Text)
            Dim BasicSalary As Double = GrossSalary * 0.5

            If lblEmpType.Text = "Permanent" Then

                txtBasicSalary.Text = BasicSalary
                txtFestivalBonus.Text = BasicSalary
                txtHouseRent.Text = BasicSalary * 0.25
                txtMedical.Text = BasicSalary * 0.05
                txtConveyance.Text = BasicSalary * 0.075
                txtLFA.Text = BasicSalary * 0.125
                txtPFDeduction.Text = BasicSalary * 0.1
            Else
                txtBasicSalary.Text = BasicSalary
                txtFestivalBonus.Text = BasicSalary
                txtHouseRent.Text = BasicSalary * 0.25
                txtMedical.Text = BasicSalary * 0.05
                txtConveyance.Text = BasicSalary * 0.2
                txtLFA.Text = 0
                txtPFDeduction.Text = 0
            End If
            fnCalculateSummary()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

End Class
