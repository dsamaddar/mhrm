Imports Microsoft.VisualBasic
Imports System.Data.SqlClient
Imports System.Data
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Net
Imports System.IO

Partial Class EmployeeProfile_frmEmployeeDetails
    Inherits System.Web.UI.Page

    Dim Cypher As New clsCaesarCypher()
    Dim DeptData As New clsDepartment()
    Dim EmpInfoData As New clsEmployeeInfo()
    Dim HealthPlanData As New clsHealthPlan()

    Protected Sub btnUpdateEmployee_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateEmployee.Click
        Dim EmpInfo As New clsEmployeeInfo()

        If EmpInfo.EmpTypeID = "-Select-" Then
            MessageBox("Please select employee type")
            Exit Sub
        End If

        Try
            EmpInfo.EmployeeID = lblHolder.Text
            EmpInfo.EmployeeName = txtEmployeeName.Text
            EmpInfo.JoiningDate = Convert.ToDateTime(txtJoiningDate.Text)
            If txtConfirmationDate.Text = "" Then
                EmpInfo.ConfirmationDate = "1/1/1900"
            Else
                EmpInfo.ConfirmationDate = Convert.ToDateTime(txtConfirmationDate.Text)
            End If

            EmpInfo.OfficialDesignationID = ddlOfficialDesignation.SelectedValue
            EmpInfo.FunctionalDesignationID = ddlFunctionalDesignation.SelectedValue
            EmpInfo.CurrentSupervisor = ddlCurrentSupervisor.SelectedValue
            EmpInfo.DateOfBirth = txtDateOfBirthAsPerSSC.Text
            EmpInfo.Nationality = txtNationality.Text
            EmpInfo.NIDNo = txtNationalID.Text
            EmpInfo.BloodGroupID = ddlBloodGrp.SelectedValue
            EmpInfo.Religion = ddlReligion.SelectedValue
            EmpInfo.FathersName = txtFatherName.Text
            EmpInfo.FathersOccupation = ddlFathersOccupation.SelectedValue
            EmpInfo.MothersName = txtMotherName.Text
            EmpInfo.MothersOccupation = ddlMotherOccupation.SelectedValue
            EmpInfo.SpouseName = txtSpouseName.Text
            EmpInfo.SpouseOccupation = ddlSpouseOccupation.SelectedValue
            EmpInfo.RelationshipStatus = ddlRelStatus.Text
            EmpInfo.MobileNo = txtMobileNo.Text
            EmpInfo.OfficePhone = txtOfficePhone.Text
            EmpInfo.OfficeExtension = txtOfficeExtension.Text
            EmpInfo.EmmergencyConPerName = txtEmrgContactPersonName.Text
            EmpInfo.EmmerConPerPhone = txtEmrgContactPersonPhnNo.Text
            EmpInfo.RelWithEmmerConPer = txtRelWithEmrgContactPerson.Text
            EmpInfo.ActualBirthDay = drpActualBirthDay.SelectedValue
            EmpInfo.ActualBirthMonth = drpActualBirthMonth.SelectedValue
            EmpInfo.Gender = rdbtnGender.SelectedValue
            EmpInfo.PresentAddress = txtPreAdd.Text
            EmpInfo.PreDistrict = ddlPreDistrict.SelectedValue
            EmpInfo.PreThana = ddlPreThana.Text
            EmpInfo.PermanentAddress = txtPerAddress.Text
            EmpInfo.PerDistrict = ddlperDistrict.SelectedValue
            EmpInfo.PerThana = ddlPerThana.SelectedValue
            EmpInfo.EmpTypeID = ddlEmpType.SelectedValue
            EmpInfo.ULCBranchID = ddlULCBranch.SelectedValue
            EmpInfo.DepartmentID = ddlDepartment.SelectedValue
            EmpInfo.Email = txtEmail.Text
            EmpInfo.AlternateEmail = txtAlterEmail.Text
            EmpInfo.BankID = ddlBankName.SelectedValue
            EmpInfo.BranchID = ddlBranchName.SelectedValue
            EmpInfo.BankAccountNo = txtAccountNo.Text
            EmpInfo.SecondaryBankID = ddlSecBankName.SelectedValue
            EmpInfo.SecondaryBranchID = ddlSecBranchName.SelectedValue
            EmpInfo.SecondaryBankAccountNo = txtSecAccountNo.Text
            EmpInfo.InsuranceNo = txtInsuranceNo.Text
            EmpInfo.TinNo = txtTINNo.Text
            EmpInfo.PassportNo = txtPassportNo.Text
            EmpInfo.DrivingLicenseNo = txtDrivingLicenseNo.Text
            EmpInfo.ApproverID = ddlLeaveApprover.SelectedValue
            EmpInfo.RecommenderID = ddlleaveRecommender.SelectedValue
            EmpInfo.PrimaryEvaluator = drpPrimaryEvaluator.SelectedValue
            EmpInfo.SecondaryEvaluator = drpSecondaryEvaluator.SelectedValue

            If ddlReligion.SelectedValue = "-Select-" Then
                MessageBox("Please Select Religion")
                Exit Sub
            Else
                EmpInfo.Religion = ddlReligion.SelectedValue
            End If

            If ddlBankName.SelectedItem.Text = "" Then
                MessageBox("Please select Bank Name")
                Exit Sub
            End If

            If ddlBranchName.SelectedValue = "" Then
                MessageBox("Please select Branch Name")
                Exit Sub
            End If

            If ddlRelStatus.SelectedItem.Text = "Married" Then
                If txtSpouseName.Text = "" Then
                    MessageBox("Please Give Your Spouse Name")
                    Exit Sub
                End If
                If ddlSpouseOccupation.SelectedItem.Text = "" Then
                    MessageBox("Please Select Spouse Occupation")
                    Exit Sub
                End If
            End If

            If ddlPreDistrict.SelectedItem.Text = "" Then
                MessageBox("Please Select Present District")
                Exit Sub
            End If

            If ddlPreThana.SelectedItem.Text = "" Then
                MessageBox("Please Select Present Thana\Upazilla")
                Exit Sub
            End If

            If ddlperDistrict.SelectedItem.Text = "" Then
                MessageBox("Please Select Present District")
                Exit Sub
            End If

            If ddlPerThana.SelectedItem.Text = "" Then
                MessageBox("Please Select Present Thana\Upazilla")
                Exit Sub
            End If

            Dim folder As String
            Dim DocFileName As String = ""
            Dim DocFileNameSign As String = ""
            Dim DocExt As String
            Dim AttachmentFileName As String
            Dim Signature As String
            Dim DocPrefix As String
            Dim FileSize As Integer


            folder = ConfigurationManager.AppSettings("InputEHRMFiles")

            If FileUpImage.HasFile Then

                FileSize = FileUpImage.PostedFile.ContentLength()

                If FileSize > 10485760 Then
                    MessageBox("File size should be within 10MB")
                    Exit Sub
                End If

                DocPrefix = Title.Replace(" ", "")

                DocExt = System.IO.Path.GetExtension(FileUpImage.FileName)

                If DocExt <> ".jpg" And DocExt <> ".JPG" And DocExt <> ".gif" And DocExt <> ".GIF" And DocExt <> ".PNG" And DocExt <> ".png" Then
                    MessageBox("Select Image File Only")
                    Exit Sub
                End If

                DocFileName = "Photo_Emp" & "_" & Replace(Replace(txtEmployeeName.Text, ".", "_"), " ", "_") & "_" & DateTime.Now.ToString("ddMMyyHHmmss") & DocExt
                AttachmentFileName = folder & DocFileName

                'Dim fs As System.IO.Stream = FileUpImage.PostedFile.InputStream
                'Dim br As New System.IO.BinaryReader(fs)
                'Dim bytes As Byte() = br.ReadBytes(CType(fs.Length, Integer))
                'UploadFile(folder, DocFileName, bytes)
                FileUpImage.SaveAs(AttachmentFileName)
                EmpInfo.Photos = DocFileName

            Else

                Dim pnlEmpSummary As Panel
                Master.FindControl("pnlEmpSummary")
                pnlEmpSummary = Master.FindControl("pnlEmpSummary")

                Dim imgEmployee As Image
                imgEmployee = pnlEmpSummary.FindControl("imgEmployee")

                If imgEmployee.ImageUrl = "" And EmpInfo.Photos = "" Then
                    MessageBox("Select A Profile Picture First.")
                    Exit Sub
                End If

                EmpInfo.Photos = ""
            End If


            If FileUpSign.HasFile Then
                FileSize = FileUpSign.PostedFile.ContentLength()

                If FileSize > 5242880 Then
                    MessageBox("File size should be within 5MB")
                    Exit Sub
                End If

                DocPrefix = Title.Replace(" ", "")

                DocExt = System.IO.Path.GetExtension(FileUpSign.FileName)

                If DocExt <> ".jpg" And DocExt <> ".JPG" And DocExt = ".gif" And DocExt = ".GIF" And DocExt = ".png" And DocExt = ".PNG" Then
                    MessageBox("Select Image File Only")
                    Exit Sub
                End If

                DocFileNameSign = "Sig_Emp" & "_" & Replace(Replace(txtEmployeeName.Text, ".", "_"), " ", "_") & "_" & DateTime.Now.ToString("ddMMyyHHmmss") & DocExt
                Signature = folder & DocFileNameSign

                'Dim fs As System.IO.Stream = FileUpSign.PostedFile.InputStream
                'Dim br As New System.IO.BinaryReader(fs)
                'Dim bytes As Byte() = br.ReadBytes(CType(fs.Length, Integer))
                'UploadFile(folder, DocFileName, bytes)
                FileUpSign.SaveAs(Signature)
                EmpInfo.Signature = DocFileNameSign
            Else
                EmpInfo.Signature = ""
            End If

            EmpInfo.HealthPlanID = ddlHealthPlan.SelectedValue
            EmpInfo.EntryBy = Session("LoginUserID")
            Dim Check As String = EmpInfoData.fnUpdateBasicInfo(EmpInfo)

            If Check = 1 Then
                MessageBox("Updated Successfully")
                ClearBasicData()
                GetEmployeeInfo(lblHolder.Text)
                getBasicProfileInfo(lblHolder.Text)
            Else
                MessageBox("Error Found.")
            End If
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try

    End Sub

    Protected Sub UploadFile(ByVal DestinationPathWithName As String, ByVal FileName As String, ByVal filebyte As Byte())
        Try
            Dim webClient As WebClient = New WebClient()
            Dim FileSavePath As String = ConfigurationManager.AppSettings("InputEHRMFiles") & FileName
            File.WriteAllBytes(FileSavePath, filebyte)
            webClient.UploadFile("http://ext.mfilbd.com/MHRM/Upload.aspx", FileSavePath)
            webClient.Dispose()
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub getBasicProfileInfo(ByVal EmployeeID As String)
        Try
            Dim EmpInfo As New clsEmployeeInfo()
            EmpInfo = EmpInfoData.fnGetBasicProfile(EmployeeID)

            Dim pnlEmpSummary As Panel
            Master.FindControl("pnlEmpSummary")
            pnlEmpSummary = Master.FindControl("pnlEmpSummary")

            Dim lblEmployeeName, lblEmployeeID, lblOfficialDesignation, lblFunctionalDesignation, lblDepartment, lblSupervisorName, lblEmployeeType, lblServiceLength, lblLocation As Label
            Dim imgEmployee As Image
            Dim hpLnkCanProfile As New HyperLink

            lblEmployeeName = pnlEmpSummary.FindControl("lblEmployeeName")
            lblEmployeeID = pnlEmpSummary.FindControl("lblEmployeeID")
            lblOfficialDesignation = pnlEmpSummary.FindControl("lblOfficialDesignation")
            lblFunctionalDesignation = pnlEmpSummary.FindControl("lblFunctionalDesignation")
            lblDepartment = pnlEmpSummary.FindControl("lblDepartment")
            lblSupervisorName = pnlEmpSummary.FindControl("lblSupervisorName")
            lblEmployeeType = pnlEmpSummary.FindControl("lblEmployeeType")
            lblServiceLength = pnlEmpSummary.FindControl("lblServiceLength")
            lblLocation = pnlEmpSummary.FindControl("lblLocation")
            imgEmployee = pnlEmpSummary.FindControl("imgEmployee")
            hpLnkCanProfile = pnlEmpSummary.FindControl("hpLnkCanProfile")

            lblEmployeeName.Text = EmpInfo.EmployeeName
            lblEmployeeID.Text = EmpInfo.EmpCode
            lblOfficialDesignation.Text = EmpInfo.OfficialDesignation
            lblFunctionalDesignation.Text = EmpInfo.FunctionalDesignation
            lblDepartment.Text = EmpInfo.Department
            lblSupervisorName.Text = EmpInfo.CurrentSupervisor
            lblEmployeeType.Text = EmpInfo.EmpType
            lblServiceLength.Text = EmpInfo.ServiceLength
            lblLocation.Text = EmpInfo.Branch

            If EmpInfo.Photos = "" Then
                imgEmployee.ImageUrl = "~\Sources\images\human.png"
            Else
                ShowImage(ConfigurationManager.AppSettings("OutputEHRMFiles") & EmpInfo.Photos, "imgEmployee")
            End If

            lblImg.Text = imgEmployee.ImageUrl
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ShowImage(ByVal UrlStr As String, ByVal ControlName As String)
        Try
            Dim tClient As WebClient = New WebClient
            Dim memStrmPic As MemoryStream = New MemoryStream(tClient.DownloadData(UrlStr))
            Dim bytesPic As Byte() = memStrmPic.ToArray()
            Dim base64StringPic As String = Convert.ToBase64String(bytesPic, 0, bytesPic.Length)

            Dim imgCtrl As System.Web.UI.WebControls.Image = Master.FindControl(ControlName)
            imgCtrl.ImageUrl = "data:image/png;base64," & base64StringPic
            memStrmPic.Dispose()
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

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        ClearBasicData()
    End Sub

    Protected Sub LoadData()
        getRelationshipStatus()
        getBloodGroup()
        getOccupationList()
        ShowDesignationOfficial()
        ShowDesignationFunc()
        fnGetDistrictName()
        ShowSupervisorList()
        ShowDepertment()
        ShowULCBranch()
        ShowEmployeeType()
        ShowBankName()
        ShowSecondaryBankName()
        GetHealthPlanType()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Try
                Dim LoginUserId As String = Session("UniqueUserID")

                Dim ToWhomProShow As String = "" 'Request.QueryString("EmployeeID")

                If Request.QueryString("EmployeeID") = Nothing Then
                    ToWhomProShow = ""
                Else
                    ToWhomProShow = Request.QueryString("EmployeeID")
                End If

                Dim Type As String = ""
                If Request.QueryString("Type") Is Nothing Then
                    Type = ""
                Else
                    Type = Request.QueryString("Type")
                End If

                If ToWhomProShow <> "Self" And ToWhomProShow <> "" And Type <> "Admin" Then
                    ToWhomProShow = Cypher.Decrypt(ToWhomProShow)
                End If

                If ToWhomProShow = "" Then
                    ToWhomProShow = Session("ToWhomProShow")
                ElseIf ToWhomProShow = "Self" Then
                    ToWhomProShow = LoginUserId
                End If

                lblHolder.Text = ToWhomProShow
                Session("ToWhomProShow") = ToWhomProShow

                getBasicProfileInfo(ToWhomProShow)

                If lblImg.Text = "" Then
                    pnlImages.Visible = True
                    pnlPermission.Visible = False
                Else
                    pnlImages.Visible = False
                    pnlPermission.Visible = True
                End If

                rdbtnIsChange.SelectedIndex = 1

                Dim CountForImage As Integer = EmpInfoData.EmpCountForImage(ToWhomProShow)

                If CountForImage = 0 Then
                    pnlImages.Visible = True
                    rdbtnIsChange.SelectedIndex = 0
                Else
                    pnlImages.Visible = False
                    rdbtnIsChange.SelectedIndex = 1
                End If


                If LoginUserId = ToWhomProShow Then
                    Dim Check As Boolean = EmpInfoData.CheckPermissionForOwnInfo(LoginUserId)
                    If Check = True Then
                        btnArea.Visible = True
                    Else
                        btnArea.Visible = False
                    End If
                Else
                    Dim Check As Boolean = EmpInfoData.CheckPermissionForOthers(LoginUserId)
                    If Check = True Then
                        btnArea.Visible = True
                    Else
                        btnArea.Visible = False
                    End If
                End If

                Dim Employeename As String = ""
                Dim EmployeeCode As String = ""

                EmpInfoData.fnGetEmpNameCode(ToWhomProShow, Employeename, EmployeeCode)
                txtEmployeeName.Text = Employeename
                lblEmployeeID.Text = EmployeeCode

                LoadData()

                'Dim Count As Integer = EmpInfoData.EmployeeCount(ToWhomProShow)
                'If Count = 0 Then
                '    Exit Sub
                'End If

                GetEmployeeInfo(ToWhomProShow)

                If ddlRelStatus.SelectedItem.Text = "Single" Then
                    txtSpouseName.Text = ""
                    ddlSpouseOccupation.SelectedIndex = -1
                    txtSpouseName.Enabled = False
                    ddlSpouseOccupation.Enabled = False

                Else
                    txtSpouseName.Enabled = True
                    ddlSpouseOccupation.Enabled = True
                End If

            Catch ex As Exception
                MessageBox(ex.Message)
            End Try
        End If
    End Sub

    Protected Sub GetEmployeeInfo(ByVal ToWhomProShow As String)
        Dim EmpInfo As New clsEmployeeInfo()

        EmpInfo = EmpInfoData.fnGetEmployeeBasicProfileInfo(ToWhomProShow)

        If EmpInfo.JoiningDate = "1/1/1900" Then
            txtJoiningDate.Text = ""
        Else
            txtJoiningDate.Text = EmpInfo.JoiningDate
        End If

        If EmpInfo.ConfirmationDate = "1/1/1900" Then
            txtConfirmationDate.Text = ""
        Else
            txtConfirmationDate.Text = EmpInfo.ConfirmationDate
        End If

        txtEmployeeName.Text = EmpInfo.EmployeeName
        ddlOfficialDesignation.SelectedValue = EmpInfo.OfficialDesignation
        ddlFunctionalDesignation.SelectedValue = EmpInfo.FunctionalDesignation
        ddlCurrentSupervisor.SelectedValue = EmpInfo.CurrentSupervisor
        txtNationality.Text = EmpInfo.Nationality
        txtNationalID.Text = EmpInfo.NIDNo
        ddlBloodGrp.SelectedValue = EmpInfo.BloodGroupID
        ddlReligion.SelectedValue = EmpInfo.Religion
        txtFatherName.Text = EmpInfo.FathersName
        ddlFathersOccupation.SelectedValue = EmpInfo.FathersOccupation
        txtMotherName.Text = EmpInfo.MothersName
        ddlMotherOccupation.SelectedValue = EmpInfo.MothersOccupation
        txtSpouseName.Text = EmpInfo.SpouseName
        ddlSpouseOccupation.SelectedValue = EmpInfo.SpouseOccupation
        ddlRelStatus.Text = EmpInfo.RelationshipStatus
        txtMobileNo.Text = EmpInfo.MobileNo
        txtOfficePhone.Text = EmpInfo.OfficePhone
        txtOfficeExtension.Text = EmpInfo.OfficeExtension
        txtEmrgContactPersonName.Text = EmpInfo.EmmergencyConPerName
        txtEmrgContactPersonPhnNo.Text = EmpInfo.EmmerConPerPhone
        txtRelWithEmrgContactPerson.Text = EmpInfo.RelWithEmmerConPer
        drpActualBirthDay.SelectedValue = EmpInfo.ActualBirthDay
        drpActualBirthMonth.SelectedValue = EmpInfo.ActualBirthMonth
        txtPreAdd.Text = EmpInfo.PresentAddress
        txtPerAddress.Text = EmpInfo.PermanentAddress
        ddlULCBranch.SelectedValue = EmpInfo.Branch
        ddlDepartment.SelectedValue = EmpInfo.Department
        ddlEmpType.SelectedValue = EmpInfo.EmpTypeID
        rdbtnGender.SelectedValue = EmpInfo.Gender
        txtEmail.Text = EmpInfo.Email
        txtAlterEmail.Text = EmpInfo.AlternateEmail
        ddlBankName.SelectedValue = EmpInfo.BankID
        ShowBranchName(ddlBankName.SelectedValue)
        'ddlBranchName.DataTextField = "BranchName"
        'ddlBranchName.DataValueField = "BranchID"
        'ddlBranchName.DataSource = EmpInfoData.fnGetBranchName(ddlBankName.SelectedValue)
        'ddlBranchName.DataBind()
        ddlBranchName.SelectedValue = EmpInfo.BranchID
        txtAccountNo.Text = EmpInfo.BankAccountNo

        ddlSecBankName.SelectedValue = EmpInfo.SecondaryBankID
        ShowSecondaryBranchName(ddlSecBankName.SelectedValue)
        ddlSecBranchName.SelectedValue = EmpInfo.SecondaryBranchID
        txtSecAccountNo.Text = EmpInfo.SecondaryBankAccountNo


        If EmpInfo.HealthPlanID = "" Or EmpInfo.HealthPlanID = "N\A" Then
            ddlHealthPlan.SelectedIndex = -1
        Else
            ddlHealthPlan.SelectedValue = EmpInfo.HealthPlanID
        End If

        txtInsuranceNo.Text = EmpInfo.InsuranceNo
        ddlLeaveApprover.SelectedValue = EmpInfo.ApproverID
        drpPrimaryEvaluator.SelectedValue = EmpInfo.PrimaryEvaluator
        drpSecondaryEvaluator.SelectedValue = EmpInfo.SecondaryEvaluator

        If EmpInfo.RecommenderID = "" Then
            ddlleaveRecommender.SelectedIndex = 0
        Else
            ddlleaveRecommender.SelectedValue = EmpInfo.RecommenderID
        End If

        ddlPreDistrict.SelectedValue = EmpInfo.PreDistrict
        ddlPreThana.DataTextField = "UpazilaName"
        ddlPreThana.DataValueField = "UpazilaID"
        ddlPreThana.DataSource = EmpInfoData.getUpazillaName(ddlPreDistrict.SelectedValue)
        ddlPreThana.DataBind()
        ddlPreThana.SelectedValue = EmpInfo.PreThana

        ddlperDistrict.SelectedValue = EmpInfo.PerDistrict
        ddlPerThana.DataTextField = "UpazilaName"
        ddlPerThana.DataValueField = "UpazilaID"
        ddlPerThana.DataSource = EmpInfo.getUpazillaName(ddlperDistrict.SelectedValue)
        ddlPerThana.DataBind()

        ddlPerThana.SelectedValue = EmpInfo.PerThana
        txtDateOfBirthAsPerSSC.Text = EmpInfo.DateOfBirth
        txtTINNo.Text = EmpInfo.TinNo
        txtPassportNo.Text = EmpInfo.PassportNo
        txtDrivingLicenseNo.Text = EmpInfo.DrivingLicenseNo

        Dim HealthPlanID As String = EmpInfoData.fnGetHealthPlanByDesignation(ddlOfficialDesignation.SelectedValue)
        ddlHealthPlan.SelectedValue = HealthPlanID
    End Sub

    Protected Sub getRelationshipStatus()
        ddlRelStatus.DataTextField = "RelName"
        ddlRelStatus.DataValueField = "RelationshipID"
        ddlRelStatus.DataSource = EmpInfoData.fnGetRelationShipStatus()
        ddlRelStatus.DataBind()

        ddlRelStatus.Items.Insert(0, "-Select-")
    End Sub

    Protected Sub getBloodGroup()
        ddlBloodGrp.DataTextField = "BloodGroupName"
        ddlBloodGrp.DataValueField = "BloodGroupID"
        ddlBloodGrp.DataSource = EmpInfoData.fnGetBloodGroup()
        ddlBloodGrp.DataBind()
    End Sub

    Protected Sub getOccupationList()
        ddlFathersOccupation.DataTextField = "OccupationName"
        ddlFathersOccupation.DataValueField = "OccupationID"
        ddlFathersOccupation.DataSource = EmpInfoData.fnGetOccupationList()
        ddlFathersOccupation.DataBind()

        ddlMotherOccupation.DataTextField = "OccupationName"
        ddlMotherOccupation.DataValueField = "OccupationID"
        ddlMotherOccupation.DataSource = EmpInfoData.fnGetOccupationList()
        ddlMotherOccupation.DataBind()

        ddlSpouseOccupation.DataTextField = "OccupationName"
        ddlSpouseOccupation.DataValueField = "OccupationID"
        ddlSpouseOccupation.DataSource = EmpInfoData.fnGetOccupationList()
        ddlSpouseOccupation.DataBind()
    End Sub

    Protected Sub fnGetDistrictName()
        ddlPreDistrict.DataTextField = "DistrictName"
        ddlPreDistrict.DataValueField = "DistrictID"
        ddlPreDistrict.DataSource = EmpInfoData.getDistrictName()
        ddlPreDistrict.DataBind()

        If ddlPreDistrict.Items.Count > 0 Then
            ddlPreDistrict.SelectedIndex = 0
            ddlPreThana.DataTextField = "UpazilaName"
            ddlPreThana.DataValueField = "UpazilaID"
            ddlPreThana.DataSource = EmpInfoData.getUpazillaName(ddlPreDistrict.SelectedValue)
            ddlPreThana.DataBind()
        End If

        ddlperDistrict.DataTextField = "DistrictName"
        ddlperDistrict.DataValueField = "DistrictID"
        ddlperDistrict.DataSource = EmpInfoData.getDistrictName()
        ddlperDistrict.DataBind()

        If ddlperDistrict.Items.Count > 0 Then
            ddlperDistrict.SelectedIndex = 0
            ddlPerThana.DataTextField = "UpazilaName"
            ddlPerThana.DataValueField = "UpazilaID"
            ddlPerThana.DataSource = EmpInfoData.getUpazillaName(ddlperDistrict.SelectedValue)
            ddlPerThana.DataBind()
        End If
    End Sub

    Protected Sub ShowDesignationOfficial()
        ddlOfficialDesignation.DataTextField = "DesignationName"
        ddlOfficialDesignation.DataValueField = "DesignationID"
        ddlOfficialDesignation.DataSource = EmpInfoData.fnGetOfficialDesignation()
        ddlOfficialDesignation.DataBind()
    End Sub

    Protected Sub ShowDesignationFunc()
        ddlFunctionalDesignation.DataTextField = "DesignationName"
        ddlFunctionalDesignation.DataValueField = "DesignationID"
        ddlFunctionalDesignation.DataSource = EmpInfoData.fnGetFunctionalDesignation()
        ddlFunctionalDesignation.DataBind()
        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        ddlFunctionalDesignation.Items.Insert(0, A)
    End Sub

    Protected Sub ShowSupervisorList()

        Dim ds As DataSet = EmpInfoData.fnGetEmployeeList()
        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"

        ddlCurrentSupervisor.DataTextField = "EmployeeName"
        ddlCurrentSupervisor.DataValueField = "EmployeeID"
        ddlCurrentSupervisor.DataSource = ds
        ddlCurrentSupervisor.DataBind()
        ddlCurrentSupervisor.Items.Insert(0, A)

        ddlLeaveApprover.DataTextField = "EmployeeName"
        ddlLeaveApprover.DataValueField = "EmployeeID"
        ddlLeaveApprover.DataSource = ds
        ddlLeaveApprover.DataBind()
        ddlLeaveApprover.Items.Insert(0, "N\A")

        ddlleaveRecommender.DataTextField = "EmployeeName"
        ddlleaveRecommender.DataValueField = "EmployeeID"
        ddlleaveRecommender.DataSource = ds
        ddlleaveRecommender.DataBind()
        ddlleaveRecommender.Items.Insert(0, "N\A")

        drpPrimaryEvaluator.DataTextField = "EmployeeName"
        drpPrimaryEvaluator.DataValueField = "EmployeeID"
        drpPrimaryEvaluator.DataSource = ds
        drpPrimaryEvaluator.DataBind()
        drpPrimaryEvaluator.Items.Insert(0, "N\A")

        drpSecondaryEvaluator.DataTextField = "EmployeeName"
        drpSecondaryEvaluator.DataValueField = "EmployeeID"
        drpSecondaryEvaluator.DataSource = ds
        drpSecondaryEvaluator.DataBind()
        drpSecondaryEvaluator.Items.Insert(0, "N\A")

    End Sub

    Protected Sub ddlPreDistrict_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlPreDistrict.SelectedIndexChanged
        ddlPreThana.DataTextField = "UpazilaName"
        ddlPreThana.DataValueField = "UpazilaID"
        ddlPreThana.DataSource = EmpInfoData.getUpazillaName(ddlPreDistrict.SelectedValue)
        ddlPreThana.DataBind()

        chkSamePreAdd.Checked = False
    End Sub

    Protected Sub ddlperDistrict_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlperDistrict.SelectedIndexChanged
        ddlPerThana.DataTextField = "UpazilaName"
        ddlPerThana.DataValueField = "UpazilaID"
        ddlPerThana.DataSource = EmpInfoData.getUpazillaName(ddlperDistrict.SelectedValue)
        ddlPerThana.DataBind()

        chkSamePreAdd.Checked = False
    End Sub

    Protected Sub ClearBasicData()
        txtEmployeeName.Text = ""
        txtFatherName.Text = ""
        txtMotherName.Text = ""
        txtSpouseName.Text = ""
        rdbtnGender.SelectedIndex = -1
        txtNationalID.Text = ""
        txtNationality.Text = ""
        ddlReligion.SelectedIndex = -1
        txtPreAdd.Text = ""
        txtPerAddress.Text = ""
        txtMobileNo.Text = ""
        ddlBloodGrp.SelectedIndex = -1
        ddlRelStatus.SelectedIndex = -1
        ddlFathersOccupation.SelectedIndex = 0
        ddlSpouseOccupation.SelectedIndex = 0
        ddlMotherOccupation.SelectedIndex = 0
        txtEmrgContactPersonName.Text = ""
        txtEmrgContactPersonPhnNo.Text = ""
        txtRelWithEmrgContactPerson.Text = ""
        ddlperDistrict.SelectedIndex = 0
        ddlPreDistrict.SelectedIndex = 0
        drpActualBirthDay.SelectedIndex = 0
        drpActualBirthMonth.SelectedIndex = 0
        txtJoiningDate.Text = ""
        txtConfirmationDate.Text = ""
        txtDateOfBirthAsPerSSC.Text = ""
        ddlOfficialDesignation.SelectedIndex = 0
        ddlFunctionalDesignation.SelectedIndex = 0
        ddlCurrentSupervisor.SelectedIndex = 0
        txtEmail.Text = ""
        txtAlterEmail.Text = ""
        ddlHealthPlan.SelectedIndex = 0
        txtInsuranceNo.Text = ""

        ddlPreThana.DataSource = EmpInfoData.getUpazillaName(ddlPreDistrict.SelectedValue)
        ddlPreThana.DataBind()

        ddlPerThana.DataSource = EmpInfoData.getUpazillaName(ddlperDistrict.SelectedValue)
        ddlPerThana.DataBind()
    End Sub

    Protected Sub ShowDepertment()
        ddlDepartment.DataTextField = "DeptName"
        ddlDepartment.DataValueField = "DepartmentID"
        ddlDepartment.DataSource = DeptData.fnGetDeptList()
        ddlDepartment.DataBind()

        Dim A As New ListItem
        A.Text = "N\A"
        A.Value = "N\A"
        ddlDepartment.Items.Insert(0, A)
    End Sub

    Protected Sub ShowULCBranch()
        ddlULCBranch.DataTextField = "ULCBranchName"
        ddlULCBranch.DataValueField = "ULCBranchID"
        ddlULCBranch.DataSource = EmpInfoData.fnGetULCBranch()
        ddlULCBranch.DataBind()
    End Sub

    Protected Sub ShowEmployeeType()
        ddlEmpType.DataTextField = "EmployeeTypeName"
        ddlEmpType.DataValueField = "EmployeeTypeID"
        ddlEmpType.DataSource = EmpInfoData.fnGetEmployeeType()
        ddlEmpType.DataBind()
        ddlEmpType.Items.Insert(0, "-Select-")
    End Sub

    Protected Sub ShowBankName()
        ddlBankName.DataTextField = "BankName"
        ddlBankName.DataValueField = "BankID"
        ddlBankName.DataSource = EmpInfoData.fnGetBankName()
        ddlBankName.DataBind()

        Dim BankID As String

        BankID = ddlBankName.SelectedValue
        ShowBranchName(BankID)
    End Sub

    Protected Sub ShowBranchName(ByVal BankID As String)
        ddlBranchName.DataTextField = "BranchName"
        ddlBranchName.DataValueField = "BranchID"
        ddlBranchName.DataSource = EmpInfoData.fnGetBranchName(BankID)
        ddlBranchName.DataBind()
    End Sub

    Protected Sub ShowSecondaryBankName()
        ddlSecBankName.DataTextField = "BankName"
        ddlSecBankName.DataValueField = "BankID"
        ddlSecBankName.DataSource = EmpInfoData.fnGetBankName()
        ddlSecBankName.DataBind()

        Dim BankID As String

        BankID = ddlSecBankName.SelectedValue
        ShowSecondaryBranchName(BankID)
    End Sub

    Protected Sub ShowSecondaryBranchName(ByVal BankID As String)
        ddlSecBranchName.DataTextField = "BranchName"
        ddlSecBranchName.DataValueField = "BranchID"
        ddlSecBranchName.DataSource = EmpInfoData.fnGetBranchName(BankID)
        ddlSecBranchName.DataBind()
    End Sub

    Protected Sub GetHealthPlanType()
        ddlHealthPlan.DataTextField = "HealthPlanName"
        ddlHealthPlan.DataValueField = "HealthPlanID"
        ddlHealthPlan.DataSource = HealthPlanData.fnGetHealthPlanList()
        ddlHealthPlan.DataBind()
    End Sub

    Protected Sub ddlBankName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlBankName.SelectedIndexChanged
        Dim BankID As String
        BankID = ddlBankName.SelectedValue
        ShowBranchName(BankID)
    End Sub

    Protected Sub rdbtnIsChange_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rdbtnIsChange.SelectedIndexChanged
        If rdbtnIsChange.SelectedValue = "YES" Then
            pnlImages.Visible = True
        Else
            pnlImages.Visible = False
        End If
    End Sub

    Protected Sub chkSamePreAdd_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkSamePreAdd.CheckedChanged
        If chkSamePreAdd.Checked = True Then
            txtPerAddress.Text = txtPreAdd.Text
            ddlperDistrict.SelectedValue = ddlPreDistrict.SelectedValue
            ddlPerThana.DataTextField = "UpazilaName"
            ddlPerThana.DataValueField = "UpazilaID"
            ddlPerThana.DataSource = EmpInfoData.getUpazillaName(ddlPreDistrict.SelectedValue)
            ddlPerThana.DataBind()

            ddlPerThana.SelectedValue = ddlPreThana.SelectedValue
        Else
            txtPerAddress.Text = ""
            ddlperDistrict.SelectedIndex = 0
            ddlPerThana.SelectedIndex = 0
        End If
    End Sub

    Protected Sub ddlPreThana_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlPreThana.SelectedIndexChanged
        chkSamePreAdd.Checked = False
    End Sub

    Protected Sub ddlPerThana_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlPerThana.SelectedIndexChanged
        chkSamePreAdd.Checked = False
    End Sub

    Protected Sub ddlRelStatus_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlRelStatus.SelectedIndexChanged
        If ddlRelStatus.SelectedItem.Text = "Single" Then
            txtSpouseName.Text = ""
            ddlSpouseOccupation.SelectedIndex = -1
            txtSpouseName.Enabled = False
            ddlSpouseOccupation.Enabled = False
        Else
            txtSpouseName.Enabled = True
            ddlSpouseOccupation.Enabled = True
        End If
    End Sub

    Protected Sub ddlOfficialDesignation_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlOfficialDesignation.SelectedIndexChanged
        Try
            Dim HealthPlanID As String = EmpInfoData.fnGetHealthPlanByDesignation(ddlOfficialDesignation.SelectedValue)
            ddlHealthPlan.SelectedValue = HealthPlanID
        Catch ex As Exception
            MessageBox(ex.Message)
        End Try
    End Sub

    Protected Sub ddlSecBankName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSecBankName.SelectedIndexChanged
        Dim BankID As String
        BankID = ddlSecBankName.SelectedValue
        ShowSecondaryBranchName(BankID)
    End Sub

End Class