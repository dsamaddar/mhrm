
select * from tblEmployeeInfo
-- exec rptNOCforPassportApply 'EMP-00000001'

alter proc rptNOCforPassportApply
@EmployeeID nvarchar(50)
as
begin
	Declare @EmployeeName as nvarchar(50) Set @EmployeeName = ''
	Declare @Gender as nvarchar(50) Set @Gender = ''
	Declare @GenderSign as nvarchar(50) Set @GenderSign = ''
	Declare @PossPronounU as nvarchar(50) set @PossPronounU = '';
	Declare @PossPronounL as nvarchar(50) set @PossPronounL = '';
	Declare @DistrictName as nvarchar(50) Set @DistrictName = ''
	Declare @UpazilaName as nvarchar(50) Set @UpazilaName = ''
	Declare @PerDistrictName as nvarchar(50) Set @PerDistrictName = ''
	Declare @PerUpazilaName as nvarchar(50) Set @PerUpazilaName = ''
	Declare @FathersName as nvarchar(50) Set @FathersName = ''
	Declare @MothersName as nvarchar(50) Set @MothersName = ''
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
	@PermanentAddress=PermanentAddress,@PerDistrict=PerDistrict,@PerThana=PerThana,@FathersName=FathersName,@MothersName=MothersName,
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
		Set @PossPronounU = 'His';
		set @PossPronounL = 'his';
	end
	else
	begin
		Set @CareOF = 'D/O'
		Set @Salutation = 'Ms.'
		Set @GenderSign = 'She'
		Set @PossPronounU = 'Her';
		set @PossPronounL = 'her';
	End
		

	Select @Salutation as 'Salutation',@EmployeeName as 'EmployeeName',@PresentAddress as 'PresentAddress',
	@PermanentAddress as 'PermanentAddress', @CareOF as 'CareOF',@FathersName as 'FathersName',@MothersName as MothersName,
	@Designation as 'Designation',@Department as 'Department', @JoiningDate as 'JoiningDate',
	@GenderSign as 'GenderSign', @PossPronounU as PossPronounU, @PossPronounL as PossPronounL

end

