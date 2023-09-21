
Alter proc rptJobContinuingCertificate
@EmployeeID nvarchar(50)
as
begin
	Declare @EmployeeName as nvarchar(50) Set @EmployeeName = ''
	Declare @Gender as nvarchar(50) Set @Gender = ''
	Declare @GenderSign as nvarchar(50) Set @GenderSign = ''
	Declare @DistrictName as nvarchar(50) Set @DistrictName = ''
	Declare @UpazilaName as nvarchar(50) Set @UpazilaName = ''
	Declare @FathersName as nvarchar(50) Set @FathersName = ''
	Declare @MothersName as nvarchar(50) Set @MothersName = ''
	Declare @CareOF as nvarchar(10) Set @CareOF = ''
	Declare @Salutation as nvarchar(10) Set @Salutation = ''
	Declare @OfficialDesignationID as nvarchar(50) Set @OfficialDesignationID = ''
	Declare @Designation as nvarchar(50) Set @Designation = ''
	Declare @DepartmentID as nvarchar(50) Set @DepartmentID = ''
	Declare @Department as nvarchar(50) Set @Department = ''
	Declare @JoiningDate as datetime
	Declare @ResignationDate as datetime

	Declare @PresentAddress as nvarchar(200) Set @PresentAddress = ''
	Declare @PreDistrict as int Set @PreDistrict = 0
	Declare @PreThana as int Set @PreThana = 0

	
	Select @EmployeeName=EmployeeName,@Gender=Gender,@PresentAddress=PresentAddress,@PreDistrict=PreDistrict,@PreThana=PreThana,
	@FathersName=FathersName, @MothersName=MothersName, @OfficialDesignationID=OfficialDesignationID,
	@DepartmentID=DepartmentID,@JoiningDate=JoiningDate, @ResignationDate=@ResignationDate
	from tblEmployeeInfo Where EmployeeID = @EmployeeID

	Select @Department=DeptName from tblDepartment Where DepartmentID = @DepartmentID
	Select @Designation = DesignationName from tblDesignation Where DesignationID = @OfficialDesignationID
	Select @DistrictName=DistrictName from tblDistrict Where DistrictID = @PreDistrict
	Select @UpazilaName=UpazilaName from tblUpazila Where UpazilaID = @PreThana
		
	Set @PresentAddress = @PresentAddress + ', '+ @DistrictName + ', ' + @UpazilaName

	if @Gender = 'Male'
	begin
		Set @CareOF = 'S/O'
		Set @Salutation = 'Mr.'
		Set @GenderSign = 'He'
	end
	else
	begin
		Set @CareOF = 'D/O'
		Set @Salutation = 'Ms.'
		Set @GenderSign = 'She'
	End
		

	Select @Salutation as 'Salutation',@EmployeeName as 'EmployeeName',@PresentAddress as 'PresentAddress',
	@CareOF as 'CareOF',@FathersName as 'FathersName', @MothersName as 'MothersName',
	@Designation as 'Designation',@Department as 'Department', @JoiningDate as 'JoiningDate',
	@ResignationDate as 'Resignationdate', @GenderSign as 'GenderSign'

end

GO


Create proc rptNOCforPassport
@EmployeeID nvarchar(50)
as
begin
	Declare @EmployeeName as nvarchar(50) Set @EmployeeName = ''
	Declare @Gender as nvarchar(50) Set @Gender = ''
	Declare @GenderSign as nvarchar(50) Set @GenderSign = ''
	Declare @DistrictName as nvarchar(50) Set @DistrictName = ''
	Declare @UpazilaName as nvarchar(50) Set @UpazilaName = ''
	Declare @PerDistrictName as nvarchar(50) Set @PerDistrictName = ''
	Declare @PerUpazilaName as nvarchar(50) Set @PerUpazilaName = ''
	Declare @FathersName as nvarchar(50) Set @FathersName = ''
	Declare @CareOF as nvarchar(10) Set @CareOF = ''
	Declare @Salutation as nvarchar(10) Set @Salutation = ''
	Declare @OfficialDesignationID as nvarchar(50) Set @OfficialDesignationID = ''
	Declare @Designation as nvarchar(50) Set @Designation = ''
	Declare @DepartmentID as nvarchar(50) Set @DepartmentID = ''
	Declare @Department as nvarchar(50) Set @Department = ''
	Declare @JoiningDate as datetime

	Declare @PresentAddress as nvarchar(200) Set @PresentAddress = ''
	Declare @PreDistrict as int Set @PreDistrict = 0
	Declare @PreThana as int Set @PreThana = 0

	Declare @PermanentAddress as nvarchar(200) Set @PermanentAddress = ''
	Declare @PerDistrict as int Set @PerDistrict = 0
	Declare @PerThana as int Set @PerThana = 0

	Select @EmployeeName=EmployeeName,@Gender=Gender,@PresentAddress=PresentAddress,@PreDistrict=PreDistrict,@PreThana=PreThana,
	@PermanentAddress=PermanentAddress,@PerDistrict=PerDistrict,@PerThana=PerThana,@FathersName=FathersName,
	@OfficialDesignationID=OfficialDesignationID,@DepartmentID=DepartmentID,@JoiningDate=JoiningDate
	from tblEmployeeInfo Where EmployeeID = @EmployeeID

	Select @Department=DeptName from tblDepartment Where DepartmentID = @DepartmentID
	Select @Designation = DesignationName from tblDesignation Where DesignationID = @OfficialDesignationID
	Select @DistrictName=DistrictName from tblDistrict Where DistrictID = @PreDistrict
	Select @UpazilaName=UpazilaName from tblUpazila Where UpazilaID = @PreThana
	Select @PerDistrictName=DistrictName from tblDistrict Where DistrictID = @PerDistrict
	Select @PerUpazilaName=UpazilaName from tblUpazila Where UpazilaID = @PerThana
	
	Set @PresentAddress = @PresentAddress + ', '+ @DistrictName + ', ' + @UpazilaName

	Set @PermanentAddress = @PermanentAddress + ', '+ @PerDistrictName + ', ' + @PerUpazilaName

	if @Gender = 'Male'
	begin
		Set @CareOF = 'S/O'
		Set @Salutation = 'Mr.'
		Set @GenderSign = 'He'
	end
	else
	begin
		Set @CareOF = 'D/O'
		Set @Salutation = 'Ms.'
		Set @GenderSign = 'She'
	End
		

	Select @Salutation as 'Salutation',@EmployeeName as 'EmployeeName',@PresentAddress as 'PresentAddress',
	@PermanentAddress as 'PermanentAddress', @CareOF as 'CareOF',@FathersName as 'FathersName',
	@Designation as 'Designation',@Department as 'Department', @JoiningDate as 'JoiningDate',@GenderSign as 'GenderSign'

end

GO


Create proc rptNOCforVisa
@EmployeeID nvarchar(50)
as
begin
	Declare @EmployeeName as nvarchar(50) Set @EmployeeName = ''
	Declare @Gender as nvarchar(50) Set @Gender = ''
	Declare @GenderSign as nvarchar(50) Set @GenderSign = ''
	Declare @DistrictName as nvarchar(50) Set @DistrictName = ''
	Declare @UpazilaName as nvarchar(50) Set @UpazilaName = ''
	Declare @FathersName as nvarchar(50) Set @FathersName = ''
	Declare @CareOF as nvarchar(10) Set @CareOF = ''
	Declare @Salutation as nvarchar(10) Set @Salutation = ''
	Declare @OfficialDesignationID as nvarchar(50) Set @OfficialDesignationID = ''
	Declare @Designation as nvarchar(50) Set @Designation = ''
	Declare @DepartmentID as nvarchar(50) Set @DepartmentID = ''
	Declare @Department as nvarchar(50) Set @Department = ''
	Declare @JoiningDate as datetime

	Declare @PresentAddress as nvarchar(200) Set @PresentAddress = ''
	Declare @PreDistrict as int Set @PreDistrict = 0
	Declare @PreThana as int Set @PreThana = 0

	
	Select @EmployeeName=EmployeeName,@Gender=Gender,@PresentAddress=PresentAddress,@PreDistrict=PreDistrict,@PreThana=PreThana,
	@FathersName=FathersName, @OfficialDesignationID=OfficialDesignationID,@DepartmentID=DepartmentID,@JoiningDate=JoiningDate
	from tblEmployeeInfo Where EmployeeID = @EmployeeID

	Select @Department=DeptName from tblDepartment Where DepartmentID = @DepartmentID
	Select @Designation = DesignationName from tblDesignation Where DesignationID = @OfficialDesignationID
	Select @DistrictName=DistrictName from tblDistrict Where DistrictID = @PreDistrict
	Select @UpazilaName=UpazilaName from tblUpazila Where UpazilaID = @PreThana
		
	Set @PresentAddress = @PresentAddress + ', '+ @DistrictName + ', ' + @UpazilaName

	if @Gender = 'Male'
	begin
		Set @CareOF = 'S/O'
		Set @Salutation = 'Mr.'
		Set @GenderSign = 'He'
	end
	else
	begin
		Set @CareOF = 'D/O'
		Set @Salutation = 'Ms.'
		Set @GenderSign = 'She'
	End
		

	Select @Salutation as 'Salutation',@EmployeeName as 'EmployeeName',@PresentAddress as 'PresentAddress',
	@CareOF as 'CareOF',@FathersName as 'FathersName', @Designation as 'Designation',@Department as 'Department', @JoiningDate as 'JoiningDate',@GenderSign as 'GenderSign'

end

GO


Create proc rptExperienceCertificate
@EmployeeID nvarchar(50)
as
begin
	Declare @EmployeeName as nvarchar(50) Set @EmployeeName = ''
	Declare @Gender as nvarchar(50) Set @Gender = ''
	Declare @GenderSign as nvarchar(50) Set @GenderSign = ''
	Declare @DistrictName as nvarchar(50) Set @DistrictName = ''
	Declare @UpazilaName as nvarchar(50) Set @UpazilaName = ''
	Declare @FathersName as nvarchar(50) Set @FathersName = ''
	Declare @CareOF as nvarchar(10) Set @CareOF = ''
	Declare @Salutation as nvarchar(10) Set @Salutation = ''
	Declare @OfficialDesignationID as nvarchar(50) Set @OfficialDesignationID = ''
	Declare @Designation as nvarchar(50) Set @Designation = ''
	Declare @DepartmentID as nvarchar(50) Set @DepartmentID = ''
	Declare @Department as nvarchar(50) Set @Department = ''
	Declare @JoiningDate as datetime

	Declare @PresentAddress as nvarchar(200) Set @PresentAddress = ''
	Declare @PreDistrict as int Set @PreDistrict = 0
	Declare @PreThana as int Set @PreThana = 0

	Select @EmployeeName=EmployeeName,@Gender=Gender,@PresentAddress=PresentAddress,@PreDistrict=PreDistrict,@PreThana=PreThana,
	@FathersName=FathersName,@OfficialDesignationID=OfficialDesignationID,@DepartmentID=DepartmentID,@JoiningDate=JoiningDate
	from tblEmployeeInfo Where EmployeeID = @EmployeeID

	Select @Department=DeptName from tblDepartment Where DepartmentID = @DepartmentID
	Select @Designation = DesignationName from tblDesignation Where DesignationID = @OfficialDesignationID
	Select @DistrictName=DistrictName from tblDistrict Where DistrictID = @PreDistrict
	Select @UpazilaName=UpazilaName from tblUpazila Where UpazilaID = @PreThana
	
	Set @PresentAddress = @PresentAddress + ', '+ @DistrictName + ', ' + @UpazilaName

	if @Gender = 'Male'
	begin
		Set @CareOF = 'S/O'
		Set @Salutation = 'Mr.'
		Set @GenderSign = 'He'
	end
	else
	begin
		Set @CareOF = 'D/O'
		Set @Salutation = 'Ms.'
		Set @GenderSign = 'She'
	End
		

	Select @Salutation as 'Salutation',@EmployeeName as 'EmployeeName',@PresentAddress as 'PresentAddress',
	@CareOF as 'CareOF',@FathersName as 'FathersName',@Designation as 'Designation',@Department as 'Department',
	@JoiningDate as 'JoiningDate',@GenderSign as 'GenderSign'

end

GO

Create proc rptReleaseOrder
@EmployeeID nvarchar(50)
as
begin
	Declare @EmployeeName as nvarchar(50) Set @EmployeeName = ''
	Declare @Gender as nvarchar(50) Set @Gender = ''
	Declare @GenderSign as nvarchar(50) Set @GenderSign = ''
	Declare @DistrictName as nvarchar(50) Set @DistrictName = ''
	Declare @UpazilaName as nvarchar(50) Set @UpazilaName = ''
	Declare @FathersName as nvarchar(50) Set @FathersName = ''
	Declare @CareOF as nvarchar(10) Set @CareOF = ''
	Declare @Salutation as nvarchar(10) Set @Salutation = ''
	Declare @OfficialDesignationID as nvarchar(50) Set @OfficialDesignationID = ''
	Declare @Designation as nvarchar(50) Set @Designation = ''
	Declare @DepartmentID as nvarchar(50) Set @DepartmentID = ''
	Declare @Department as nvarchar(50) Set @Department = ''
	Declare @JoiningDate as datetime
	Declare @ResignationDate as datetime Set @ResignationDate=GETDATE()
	Declare @ResignationEffectiveDate as datetime Set @ResignationEffectiveDate=GETDATE()

	Declare @PresentAddress as nvarchar(200) Set @PresentAddress = ''
	Declare @PreDistrict as int Set @PreDistrict = 0
	Declare @PreThana as int Set @PreThana = 0

	Select @EmployeeName=EmployeeName,@Gender=Gender,@PresentAddress=PresentAddress,@PreDistrict=PreDistrict,@PreThana=PreThana,
	@FathersName=FathersName,@OfficialDesignationID=OfficialDesignationID,@DepartmentID=DepartmentID,@JoiningDate=JoiningDate
	from tblEmployeeInfo Where EmployeeID = @EmployeeID

	Select @Department=DeptName from tblDepartment Where DepartmentID = @DepartmentID
	Select @Designation = DesignationName from tblDesignation Where DesignationID = @OfficialDesignationID
	Select @DistrictName=DistrictName from tblDistrict Where DistrictID = @PreDistrict
	Select @UpazilaName=UpazilaName from tblUpazila Where UpazilaID = @PreThana
	
	Set @PresentAddress = @PresentAddress + ', '+ @DistrictName + ', ' + @UpazilaName

	if @Gender = 'Male'
	begin
		Set @CareOF = 'S/O'
		Set @Salutation = 'Mr.'
		Set @GenderSign = 'He'
	end
	else
	begin
		Set @CareOF = 'D/O'
		Set @Salutation = 'Ms.'
		Set @GenderSign = 'She'
	End
		

	Select @Salutation as 'Salutation',@EmployeeName as 'EmployeeName',@PresentAddress as 'PresentAddress',
	@CareOF as 'CareOF',@FathersName as 'FathersName',@Designation as 'Designation',@Department as 'Department',
	@JoiningDate as 'JoiningDate',@ResignationDate as 'ResignationDate',@ResignationEffectiveDate as 'ResignationEffectiveDate',
	@GenderSign as 'GenderSign'

end

GO

alter proc rptSalaryCertificate
@EmployeeID nvarchar(50)
as
begin
	Declare @EmployeeName as nvarchar(50) Set @EmployeeName = ''
	Declare @Gender as nvarchar(50) Set @Gender = ''
	Declare @GenderSign as nvarchar(50) Set @GenderSign = ''
	Declare @DistrictName as nvarchar(50) Set @DistrictName = ''
	Declare @UpazilaName as nvarchar(50) Set @UpazilaName = ''
	Declare @FathersName as nvarchar(50) Set @FathersName = ''
	Declare @CareOF as nvarchar(10) Set @CareOF = ''
	Declare @Salutation as nvarchar(10) Set @Salutation = ''
	Declare @PossessiveForm as nvarchar(3) Set @PossessiveForm = ''
	Declare @OfficialDesignationID as nvarchar(50) Set @OfficialDesignationID = ''
	Declare @Designation as nvarchar(50) Set @Designation = ''
	Declare @DepartmentID as nvarchar(50) Set @DepartmentID = ''
	Declare @Department as nvarchar(50) Set @Department = ''
	Declare @JoiningDate as datetime

	Declare @PresentAddress as nvarchar(200) Set @PresentAddress = ''
	Declare @PreDistrict as int Set @PreDistrict = 0
	Declare @PreThana as int Set @PreThana = 0

	Declare @BasicSalary as numeric(18,2) Set @BasicSalary = 0
	Declare @HouseRent as numeric(18,2) Set @HouseRent = 0
	Declare @MedicalAllowance as numeric(18,2) Set @MedicalAllowance = 0
	Declare @Conveyance as numeric(18,2) Set @Conveyance = 0
	Declare @PFDeduction as numeric(18,2) Set @PFDeduction = 0
	Declare @LoanDeduction as numeric(18,2) Set @LoanDeduction = 0
	Declare @TaxDeduction as numeric(18,2) Set @TaxDeduction = 0
	Declare @TotalBenefit as numeric(18,2) Set @TotalBenefit = 0
	Declare @TotalDeduction as numeric(18,2) Set @TotalDeduction = 0
	Declare @NetSalary as numeric(18,2) Set @NetSalary = 0
	Declare @MobileAllowance as numeric(18,2) Set @MobileAllowance = 0

	Select @EmployeeName=EmployeeName,@Gender=Gender,@PresentAddress=PresentAddress,@PreDistrict=PreDistrict,@PreThana=PreThana,
	@FathersName=FathersName,@OfficialDesignationID=OfficialDesignationID,@DepartmentID=DepartmentID,@JoiningDate=JoiningDate
	from tblEmployeeInfo Where EmployeeID = @EmployeeID

	Select @Department=DeptName from tblDepartment Where DepartmentID = @DepartmentID
	Select @Designation = DesignationName from tblDesignation Where DesignationID = @OfficialDesignationID
	Select @DistrictName=DistrictName from tblDistrict Where DistrictID = @PreDistrict
	Select @UpazilaName=UpazilaName from tblUpazila Where UpazilaID = @PreThana
	
	Set @PresentAddress = @PresentAddress + ', '+ @UpazilaName +', ' + @DistrictName

	if @Gender = 'Male'
	begin
		Set @CareOF = 'S/O'
		Set @Salutation = 'Mr.'
		Set @GenderSign = 'He'
		Set @PossessiveForm = 'his'
	end
	else
	begin
		Set @CareOF = 'D/O'
		Set @Salutation = 'Ms.'
		Set @GenderSign = 'She'
		Set @PossessiveForm = 'her'
	End
	
	Select @BasicSalary=BasicSalary,@HouseRent=BasicSalary*HouseRentPer*0.01,@MedicalAllowance=BasicSalary*MedicalPer*0.01,
	@Conveyance=BasicSalary*ConveyancePer*0.01,@PFDeduction=BasicSalary*PFDeductionPer*0.01,
	@LoanDeduction=LoanDeduciton,@TaxDeduction=TaxDeduction
	from tblEmpSalaryProfile Where EmployeeID = @EmployeeID

	Set @TotalBenefit = @BasicSalary + @HouseRent + @MedicalAllowance + @Conveyance
	Set @TotalDeduction = @PFDeduction + @LoanDeduction + @TaxDeduction
	Set @NetSalary = @TotalBenefit - @TotalDeduction

	Select @Salutation as 'Salutation',@EmployeeName as 'EmployeeName',@PresentAddress as 'PresentAddress',
	@CareOF as 'CareOF',@FathersName as 'FathersName',@Designation as 'Designation',@Department as 'Department',
	@JoiningDate as 'JoiningDate',@GenderSign as 'GenderSign',@BasicSalary as 'BasicSalary',@HouseRent as 'HouseRent',
	@MedicalAllowance as 'MedicalAllowance',@Conveyance as 'Conveyance',@PFDeduction as 'PFDeduction',
	@LoanDeduction as 'LoanDeduction',@TaxDeduction as 'TaxDeduction',@TotalBenefit as 'TotalBenefit',
	@TotalDeduction as 'TotalDeduction',@NetSalary as 'NetSalary',dbo.udf_Num_ToWords(@TotalBenefit) as 'AmountInWords',
	@PossessiveForm as 'PossessiveForm',@MobileAllowance as 'MobileAllowance'

end

GO

-- exec rptSalaryCertificate 'EMP-00000098'