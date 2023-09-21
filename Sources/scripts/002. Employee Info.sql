
alter proc spGetEmployeeBasicProfileInfo
@EmployeeID nvarchar(50)
as
SELECT 
      EmployeeName
      ,isnull(FathersName,'') FathersName
      ,isnull(FathersOccupation,'') FathersOccupation
      ,isnull(MothersName,'') MothersName
      ,isnull(MothersOccupation,'')  MothersOccupation
      ,isnull(SpouseName,'') SpouseName
      ,isnull(SpouseOccupation,'') SpouseOccupation
      ,isnull(RelationshipStatus,'') [RelationshipStatus]
      ,isnull(MobileNo,'')  MobileNo
	  ,isnull(OfficePhone,'')  OfficePhone
	  ,isnull(OfficeExtension,'')  OfficeExtension
      ,isnull(EmmergencyConPerName,'') EmmergencyConPerName
      ,isnull(EmmerConPerPhone,'') EmmerConPerPhone
      ,isnull(RelWithEmmerConPer,'') RelWithEmmerConPer
      ,isnull([PresentAddress],'') [PresentAddress]
      ,isnull([PreDistrict],'') [PreDistrict]
      ,isnull([PreThana],'') [PreThana]
      ,isnull([PermanentAddress],'') [PermanentAddress]
      ,isnull([PerDistrict],'') [PerDistrict]
      ,isnull([PerThana],'') [PerThana]
      ,isnull([Gender],'') [Gender]
      ,isnull([Nationality],'') [Nationality]
      ,isnull([Religion],'') [Religion]
      ,isnull(BloodGroupID ,'') BloodGroupID
      ,isnull([NIDNo],'') [NIDNo]
      ,isnull(DateOfBirth,'') DateOfBirth
      ,isnull(JoiningDate,'') JoiningDate
      ,isnull(ConfirmationDate,'') ConfirmationDate
      ,isnull(OfficialDesignationID,'') OfficialDesignationID
      ,isnull(FunctionalDesignationID,'N\A') FunctionalDesignationID
      ,isnull(CurrentSupervisor,'N\A') CurrentSupervisor
      ,isnull(Photos,'human.png') Photos
      ,isnull(Signature,'') [Signature]
      ,isnull(ActualBirthDay,'') ActualBirthDay
      ,isnull(ActualBirthMonth,'') ActualBirthMonth
      ,isnull(ULCBranchID,'') ULCBranchID
      ,isnull(DepartmentID,'') DepartmentID
      ,isnull(EmpTypeID,'')  EmpTypeID
      ,isnull(Email ,'') Email
      ,isnull(AlternateEmail ,'') AlternateEmail
      ,isnull(BankID,'') BankID
      ,isnull(BranchID,'') BranchID
      ,isnull(BankAccountNo,'') BankAccountNo
	  ,isnull(SecondaryBankID,'') SecondaryBankID
      ,isnull(SecondaryBranchID,'') SecondaryBranchID
      ,isnull(SecondaryBankAccountNo,'') SecondaryBankAccountNo
      ,isnull(InsuranceNo,'') InsuranceNo
	  ,isnull(TinNo,'') TinNo
	  ,isnull(PassportNo,'') PassportNo
	  ,isnull(DrivingLicenseNo,'') DrivingLicenseNo
      ,isnull(LeaveApprover,'') LeaveApprover 
      ,isnull(LeaveRecommender,'') LeaveRecommender
	  ,ISNULL(PrimaryEvaluator,'N\A') PrimaryEvaluator
	  ,ISNULL(SecondaryEvaluator,'N\A') SecondaryEvaluator
      ,isnull((select HealthPlanID from tblDesignation  where DesignationID =tblEmployeeInfo.OfficialDesignationID),'') HealthPlanID
  FROM tblEmployeeInfo where EmployeeID=@EmployeeID 


GO


alter proc spGetBasicInfoProfile
@EmployeeID nvarchar(50)
as
begin
	SELECT 
	  isnull(tblEmployeeInfo.EmployeeName,'') Name
	  ,isnull(JoiningDate,'') JoiningDate
	  ,isnull(EmpCode,'') EmpCode
      ,isnull((select DesignationName from dbo.tblDesignation where DesignationID=tblEmployeeInfo.FunctionalDesignationID),'') FunctionalDesignation
      ,isnull((select DesignationName from dbo.tblDesignation where DesignationID=tblEmployeeInfo.OfficialDesignationID),'') OfficialDesignation
      ,isnull((select DeptName from dbo.tblDepartment where DepartmentID=tblEmployeeInfo.DepartmentID) ,'') DepartmentName
      ,isnull((select EmployeeName from dbo.tblEmployeeInfo Emp where Emp.EmployeeID=tblEmployeeInfo.CurrentSupervisor),'') CurrentSupervisor
      ,isnull((select EmployeeTypeName from dbo.tblEmployeeType where EmployeeTypeID=tblEmployeeInfo.EmpTypeID ),'') EmployeeTypeName
      ,ServiceLength = case when JoiningDate is null  then '0'
      else dbo.fnGetAgeE(EmployeeID) /*dbo.fnGetAgeC(JoiningDate,GETDATE())*/
      end 
      ,isnull((select ULCBranchName from dbo.tblULCBranch where ULCBranchID=tblEmployeeInfo.ULCBranchID),'') ULCBranchName
      ,isnull([Photos],'') [Photos]
      ,isnull([Signature],'') [Signature]
	  ,isnull(CandidateID,'N\A') as 'CandidateID'
      FROM tblEmployeeInfo
	  where EmployeeID=@EmployeeID 
 end

 GO
  
alter proc spUpdateEmpBasProfileInfo
@EmployeeID nvarchar(50),
@EmployeeName nvarchar(100),
@JoiningDate datetime,
@ConfirmationDate datetime,
@OfficialDesignationID nvarchar(50),
@FunctionalDesignationID nvarchar(50),
@CurrentSupervisor nvarchar(50),
@DateOfBirth datetime,
@Gender nvarchar(50),
@Nationality nvarchar(50),
@BloodGroupID nvarchar(50),
@NIDNo nvarchar(100),
@Religion nvarchar(50),
@FathersName nvarchar(100),
@FathersOccupation nvarchar(200),
@MothersName nvarchar(100),
@MothersOccupation nvarchar(200),
@SpouseName nvarchar(100),
@SpouseOccupation nvarchar(200),
@RelationshipStatus nvarchar(50),
@MobileNo nvarchar(50),
@OfficePhone nvarchar(50),
@OfficeExtension nvarchar(50),
@EmmergencyConPerName nvarchar(200),
@EmmerConPerPhone nvarchar(50),
@RelWithEmmerConPer nvarchar(100),
@PresentAddress nvarchar(500),
@PreDistrict nvarchar(50),
@PreThana nvarchar(50),
@PermanentAddress nvarchar(500),
@PerDistrict nvarchar(50),
@PerThana nvarchar(50),
@Photos nvarchar(500),
@Signature nvarchar(500),
@ActualBirthDay nvarchar(50),
@ActualBirthMonth nvarchar(50),
@EmpTypeID nvarchar(50),
@ULCBranchID nvarchar(50),
@DepartmentID nvarchar(50),
@EMail nvarchar(50),
@AlternateEmail nvarchar(50),
@BankID nvarchar(50),
@BranchID nvarchar(50),
@BankAccountNo nvarchar(50),
@SecondaryBankID nvarchar(50),
@SecondaryBranchID nvarchar(50),
@SecondaryBankAccountNo nvarchar(50),
@InsuranceNo nvarchar(50),
@ApproverID nvarchar(50),
@RecommenderID nvarchar(50),
@PrimaryEvaluator nvarchar(50),
@SecondaryEvaluator nvarchar(50),
@HealthPlanID nvarchar(50),
@TinNo nvarchar(100),
@PassportNo nvarchar(100),
@DrivingLicenseNo nvarchar(100),
@EntryBy nvarchar(50)
as
begin
	Declare @total int
	Declare @EmpBasicID nvarchar(50)
	Declare @CurrentEmpBasicID numeric(18,0)
	Declare @EmpBasicIDPrefix as nvarchar(8)
	Declare @Cnfdt as datetime
	Declare @PermanentCode as nvarchar
	Declare @LeaveRecommender as nvarchar(50)

	--set @EmpBasicIDPrefix='EMP-BAS-'
	
	begin tran

	if @ConfirmationDate ='1/1/1900'
		set @Cnfdt=null
	else
		set @Cnfdt=@ConfirmationDate
		
	if @RecommenderID='N\A'
	begin
		set @LeaveRecommender=NULL
	end
	else
		set @LeaveRecommender=@RecommenderID

	If @FunctionalDesignationID = 'N\A'
		Set @FunctionalDesignationID = NULL

	IF @CurrentSupervisor = 'N\A'
		Set @CurrentSupervisor = NULL

	If @PrimaryEvaluator = 'N\A'
		Set @PrimaryEvaluator = NULL

	If @SecondaryEvaluator = 'N\A'
		Set @SecondaryEvaluator = NULL;

	If @Photos = ''
	begin
		Select @Photos = ISNULL(Photos,'') from tblEmployeeInfo where EmployeeID = @EmployeeID;
	end

	If @Signature = ''
	begin
		Select @Signature = ISNULL(Signature,'') from tblEmployeeInfo where EmployeeID = @EmployeeID;
	end
	 
	
	Declare @HasSalary as bit = 1
		
	Update tblEmployeeInfo Set EmployeeName =@EmployeeName,JoiningDate=@JoiningDate,
	ConfirmationDate=@ConfirmationDate,OfficialDesignationID=@OfficialDesignationID,
	FunctionalDesignationID=@FunctionalDesignationID,CurrentSupervisor=@CurrentSupervisor,
	DateOfBirth=@DateOfBirth,Gender=@Gender,Nationality=@Nationality,BloodGroupID=@BloodGroupID,
	NIDNo=@NIDNo,Religion=@Religion,FathersName=@FathersName,FathersOccupation=@FathersOccupation,
	MothersName=@MothersName,MothersOccupation=@MothersOccupation,SpouseName=@SpouseName,
	SpouseOccupation=@SpouseOccupation,RelationshipStatus=@RelationshipStatus,MobileNo=@MobileNo,
	OfficePhone=@OfficePhone,OfficeExtension=@OfficeExtension,EmmergencyConPerName=@EmmergencyConPerName,
	EmmerConPerPhone=@EmmerConPerPhone,RelWithEmmerConPer =@RelWithEmmerConPer,PresentAddress=@PresentAddress,
	PreDistrict=@PreDistrict,PreThana=@PreThana,PermanentAddress=@PermanentAddress,
	PerDistrict=@PerDistrict,PerThana=@PerThana,Photos=@Photos,Signature=@Signature,
	ActualBirthDay=@ActualBirthDay,ActualBirthMonth=@ActualBirthMonth,EmpTypeID=@EmpTypeID,
	ULCBranchID=@ULCBranchID,DepartmentID=@DepartmentID,EMail=@EMail,AlternateEmail=@AlternateEmail,
	BankID=@BankID,BranchID=@BranchID,BankAccountNo=@BankAccountNo,SecondaryBankID=@SecondaryBankID,SecondaryBranchID=@SecondaryBranchID,SecondaryBankAccountNo=@SecondaryBankAccountNo,
	InsuranceNo=@InsuranceNo,
	LeaveApprover =@ApproverID,LeaveRecommender=@RecommenderID,PrimaryEvaluator=@PrimaryEvaluator,
	SecondaryEvaluator=@SecondaryEvaluator,HealthPlanID=@HealthPlanID,TinNo=@TinNo,
	PassportNo=@PassportNo,DrivingLicenseNo=@DrivingLicenseNo,EntryBy=@EntryBy
	where EmployeeID =@EmployeeID  
	IF (@@ERROR <> 0) GOTO ERR_HANDLER	
	
	/*		
	IF 	@ConfirmationDate<>'1/1/1900'
	begin
		select @PermanentCode=EmployeeTypeID from tblEmployeeType where EmployeeTypeName='Permanent'
			
		UPDATE tblEmployeeInfo set EmpTypeID =@PermanentCode where EmployeeID =@EmployeeID  
	end
	*/
			    
COMMIT TRAN
	Return 0
ERR_HANDLER:
ROLLBACK TRAN
	Return 1
end

Go

Create function fnGetEmpName(@EmployeeID nvarchar(50))
returns nvarchar(100)
as
begin
	Declare @EmpName as nvarchar(100) Set @EmpName = ''
	Select @EmpName = EmployeeName from tblEmployeeInfo Where EmployeeID = @EmployeeID

	return ISNULL(@EmpName,'')
end

GO


Create function fnGetDesignationOrder(@DesignationID nvarchar(50))
returns int
as
begin
	Declare @intOrder as int Set @intOrder = 0

	Select @intOrder=intOrder from tblDesignation Where DesignationID=@DesignationID

	return @intOrder
end

GO

Create function fnGetDesignationName(@DesignationID nvarchar(50))
returns nvarchar(200)
as
begin
	Declare @DesignationName nvarchar(200)
	Select @DesignationName=DesignationName from dbo.tblDesignation Where DesignationID=@DesignationID

	return @DesignationName
end

GO

Create function fnGetOccupationByID(@OccupationID nvarchar(50))
returns nvarchar(200)
as
begin
	Declare @OccupationName as nvarchar(200) Set @OccupationName = '';
	select @OccupationName = OccupationName from tblOccupation where OccupationID = @OccupationID;

	return @OccupationName;
end

GO

Create function fnGetBankNameByID(@BankID nvarchar(50))
returns nvarchar(200)
as
begin
	Declare @BankName as nvarchar(200) Set @BankName = '';
	select @BankName = BankName from tblBank where BankID = @BankID;
	return @BankName;
end

GO

Create function fnGetBankBranchNameByID(@BranchID nvarchar(50))
returns nvarchar(200)
as
begin
	Declare @BranchName as nvarchar(200) Set @BranchName = '';
	select @BranchName = BranchName from tblBranch where BranchID = @BranchID;
	return @BranchName;
end

GO

create function fnGetDistrictByID(@DistrictID nvarchar(50))
returns nvarchar(200)
as
begin
	Declare @DistrictName as nvarchar(200) Set @DistrictName = '';
	select @DistrictName = DistrictName from tblDistrict where DistrictID = @DistrictID;

	return @DistrictName;
end

GO

create function fnGetUpazilaByID(@UpazilaID nvarchar(50))
returns nvarchar(200)
as
begin
	Declare @UpazilaName as nvarchar(200) Set @UpazilaName = '';
	select @UpazilaName = UpazilaName from tblUpazila where UpazilaID = @UpazilaID

	return @UpazilaName;
end

GO

select * from vwEmpInfo;

alter view vwEmpInfo
as
SELECT EI.EmployeeID, EI.CandidateID,EI.UserID,EI.EmployeeName, EI.EmpCode, ISNULL(EI.BasicSalary, 0) AS BasicSalary, EI.EmpTypeID, ET.EmployeeTypeName, EI.DateOfBirth, EI.JoiningDate,
EI.FathersName,EI.FathersOccupation,dbo.fnGetOccupationByID(EI.FathersOccupation) as 'FathersOccupationNm',EI.MothersName,EI.MothersOccupation,dbo.fnGetOccupationByID(EI.MothersOccupation) as 'MothersOccupationNm',
EI.SpouseName,EI.SpouseOccupation,dbo.fnGetOccupationByID(EI.SpouseOccupation) as 'SpouseOccupationNm',EI.NoOfChildrenAge,EI.SibblingsNameOccupation,EI.RelationshipStatus,EI.NIDNo,EI.Nationality,
EI.ConfirmationDate, EI.PromotionDate, EI.ContractExpiryDate, EI.ContractRenewalDate, EI.DepartmentID, EI.ULCBranchID,EI.TerminationDate, 
EI.RemarksOnTermination, EI.OfficialDesignationID, EI.JoiningDesignationID, EI.FunctionalDesignationID, dbo.fnGetDesignationName(EI.JoiningDesignationID) AS JoiningDesignation, 
dbo.fnGetDesignationOrder(EI.OfficialDesignationID) AS IntOrder, dbo.fnGetDesignationName(EI.OfficialDesignationID) AS OfficialDesignation, dbo.fnGetDesignationName(EI.FunctionalDesignationID) 
AS FunctionalDesignation, D.DeptName, dbo.tblULCBranch.ULCBranchName, dbo.fnGetEmpName(EI.CurrentSupervisor) AS CurrentSupervisorName, EI.JDno, EI.EmpStatus, dbo.tblBank.BankID,
dbo.tblBank.BankName, dbo.tblBranch.BranchName, EI.BankAccountNo,dbo.fnGetBankNameByID(EI.SecondaryBankID) as 'SecBank',dbo.fnGetBankBranchNameByID(EI.SecondaryBranchID) as 'SecBankBranch',EI.SecondaryBankAccountNo, 
EI.EntryExamScore, EI.PromotionalExamScore, EI.isActive, EI.EntryBy, EI.EntryDate, EI.CurrentSupervisor,dbo.fnGetEmpName(EI.CurrentSupervisor) as 'CurrentSupervisorNm', EI.Photos,EI.Signature, EI.BloodGroupID, 
EI.Religion, EI.Gender,EI.PresentAddress,dbo.fnGetDistrictByID(EI.PreDistrict) as 'PreDistrict',dbo.fnGetUpazilaByID(EI.PreThana) as 'PreThana',
EI.PermanentAddress,dbo.fnGetDistrictByID(EI.PerDistrict) as 'PerDistrict',dbo.fnGetUpazilaByID(EI.PerThana) as 'PerThana',EI.OfficePhone,EI.OfficeExtension,
EI.ActualBirthDay, EI.ActualBirthMonth, ISNULL(EI.Email, N'') AS Email,EI.AlternateEmail, EI.MobileNo, EI.IncludedInPayroll,ISNULL(EI.IPAddress,'') as 'IPAddress',
EI.EmmerConPerPhone,EI.EmmergencyConPerName,EI.RelWithEmmerConPer,dbo.fnGetEmpName( EI.LeaveApprover) as 'LeaveApprover',
dbo.fnGetEmpName(EI.LeaveRecommender) as 'LeaveRecommender',EI.TinNo,EI.DrivingLicenseNo,EI.PassportNo
FROM dbo.tblEmployeeInfo AS EI LEFT OUTER JOIN
dbo.tblEmployeeType ET ON EI.EmpTypeID = ET.EmployeeTypeID  LEFT OUTER JOIN
dbo.tblDepartment D ON D.DepartmentID = EI.DepartmentID  LEFT OUTER JOIN
dbo.tblULCBranch ON dbo.tblULCBranch.ULCBranchID = EI.ULCBranchID  LEFT OUTER JOIN
dbo.tblBank ON dbo.tblBank.BankID = EI.BankID  LEFT OUTER JOIN
dbo.tblBranch ON EI.BranchID = dbo.tblBranch.BranchID
WHERE (EI.EmployeeName <> '')

/*
SELECT        EI.EmployeeID, EI.CandidateID, EI.EmployeeName, EI.EmpCode, ISNULL(EI.BasicSalary, 0) AS BasicSalary, EI.EmpTypeID, ET.EmployeeTypeName, EI.DateOfBirth, EI.JoiningDate, EI.ConfirmationDate, 
                         EI.PromotionDate, EI.ContractExpiryDate, EI.ContractRenewalDate, EI.DepartmentID, EI.ULCBranchID, EI.TerminationDate, EI.RemarksOnTermination, EI.OfficialDesignationID, EI.JoiningDesignationID, 
                         EI.FunctionalDesignationID, dbo.fnGetDesignationName(EI.JoiningDesignationID) AS JoiningDesignation, dbo.fnGetDesignationOrder(EI.OfficialDesignationID) AS IntOrder, 
                         dbo.fnGetDesignationName(EI.OfficialDesignationID) AS OfficialDesignation, dbo.fnGetDesignationName(EI.FunctionalDesignationID) AS FunctionalDesignation, D.DeptName, dbo.tblULCBranch.ULCBranchName, 
                         dbo.fnGetEmpName(EI.CurrentSupervisor) AS CurrentSupervisorName, EI.JDno, EI.EmpStatus, dbo.tblBank.BankID, dbo.tblBank.BankName, dbo.tblBranch.BranchName, EI.BankAccountNo, EI.EntryExamScore, 
                         EI.PromotionalExamScore, EI.isActive, EI.EntryBy, EI.EntryDate, EI.CurrentSupervisor, EI.Photos, EI.BloodGroupID, EI.Religion, EI.Gender, EI.PerDistrict, EI.ActualBirthDay, EI.ActualBirthMonth, ISNULL(EI.Email, 
                         N'') AS Email, EI.MobileNo, EI.IncludedInPayroll, ISNULL(EI.IPAddress, N'') AS IPAddress
FROM            dbo.tblEmployeeInfo AS EI LEFT OUTER JOIN
                         dbo.tblEmployeeType AS ET ON EI.EmpTypeID = ET.EmployeeTypeID LEFT OUTER JOIN
                         dbo.tblDepartment AS D ON D.DepartmentID = EI.DepartmentID LEFT OUTER JOIN
                         dbo.tblULCBranch ON dbo.tblULCBranch.ULCBranchID = EI.ULCBranchID LEFT OUTER JOIN
                         dbo.tblBank ON dbo.tblBank.BankID = EI.BankID LEFT OUTER JOIN
                         dbo.tblBranch ON EI.BranchID = dbo.tblBranch.BranchID
WHERE        (EI.EmployeeName <> '')
*/

GO

Create view vwOrgStructure
as
SELECT        EmployeeID, EmployeeName, EmpTypeID, EmployeeTypeName, JoiningDate, OfficialDesignation, OfficialDesignationID,
(SELECT        intOrder
FROM            dbo.tblDesignation AS D
WHERE        (DesignationID = VwE.OfficialDesignationID)) AS OfficialDesigOrder, FunctionalDesignation, FunctionalDesignationID,
(SELECT        intOrder
FROM            dbo.tblDesignation AS D
WHERE        (DesignationID = VwE.FunctionalDesignationID)) AS FunctionalDesigOrder, DeptName, DepartmentID, ULCBranchID, isActive, Photos, CurrentSupervisor, BloodGroupID, Religion, Gender, PerDistrict,
ActualBirthDay, ActualBirthMonth, EmpCode, IncludedInPayroll
FROM            dbo.vwEmpInfo AS VwE

GO

Create proc spShowOrgStructure
@EmpIDOrName nvarchar(200),
@EmployeeTypeID nvarchar(50),
@DesignationID nvarchar(50),
@FunctionalDesignationID nvarchar(50),
@DepartmentID nvarchar(50),
@ULCBranchID nvarchar(50),
@IsActive bit,
@Gender nvarchar(50),
@CurrentSupervisor nvarchar(50),
@BloodGroupID nvarchar(50),
@Religion nvarchar(50),
@PerDistrict int,
@ActualBirthDay nvarchar(50),
@ActualBirthMonth nvarchar(50),
@JoiningDate datetime,
@JoiningDateTo datetime
as
begin
	Declare @EmpIDOrNameParam as nvarchar(200)
	Declare @EmployeeTypeIDParam as nvarchar(50)
	Declare @DesignationIDParam as nvarchar(50)
	Declare @FunctionalDesignationIDParam as nvarchar(50) Set @FunctionalDesignationIDParam = ''
	Declare @DepartmentIDParam as nvarchar(50)
	Declare @ULCBranchIDParam as nvarchar(50)

	Declare @GenderParam as nvarchar(50)
	Declare @CurrentSupervisorParam as nvarchar(50)
	Declare @BloodGroupIDParam as nvarchar(50)
	Declare @ReligionParam as nvarchar(50)
	Declare @PerDistrictParam as nvarchar(10)
	
	if @EmpIDOrName = ''
		Set @EmpIDOrNameParam = '%'
	Else
		Set @EmpIDOrNameParam = '%' + @EmpIDOrName + '%'
		

	if @EmployeeTypeID = 'N\A'
		Set @EmployeeTypeIDParam = '%'
	else
		Set @EmployeeTypeIDParam = '%'+ @EmployeeTypeID +'%'
		
	if @DesignationID = 'N\A'
		Set @DesignationIDParam = '%'
	else
		Set @DesignationIDParam = '%'+ @DesignationID +'%'

	if @FunctionalDesignationID = 'N\A'
		Set @FunctionalDesignationIDParam = '%'
	else
		Set @FunctionalDesignationIDParam = '%'+ @FunctionalDesignationID +'%'
		
	if @DepartmentID = 'N\A'
		Set @DepartmentIDParam = '%'
	else
		Set @DepartmentIDParam = '%'+ @DepartmentID +'%'
		
	if @ULCBranchID = 'N\A'
		Set @ULCBranchIDParam = '%'
	else
		Set @ULCBranchIDParam = '%'+ @ULCBranchID +'%'

	if @Gender = 'N\A'
		Set @GenderParam = '%'
	else
		Set @GenderParam = @Gender + '%'

	If @CurrentSupervisor = 'N\A'
		Set @CurrentSupervisorParam='%'
	else
		Set @CurrentSupervisorParam='%' + @CurrentSupervisor +'%'

	if @BloodGroupID='N\A'
		Set @BloodGroupIDParam = '%'
	else
		Set @BloodGroupIDParam = '%'+ @BloodGroupID +'%'

	if @Religion = 'N\A'
		Set @ReligionParam = '%'
	else
		Set @ReligionParam ='%'+ @Religion +'%'

	if @PerDistrict=0
		set @PerDistrictParam ='%'
	else
		set @PerDistrictParam = convert(nvarchar,@PerDistrict)

	if @ActualBirthDay='0'
		Set @ActualBirthDay= '%'

	if @ActualBirthMonth = '0'
		Set @ActualBirthMonth = '%'

	-- Select @PerDistrictParam
		
	Select EmployeeID,EmployeeName,EmpCode,OfficialDesignation,FunctionalDesignation,DeptName,
	isnull(Photos,Case 
	When Gender='Male' Then 'male_na.png'
	When Gender='Female' Then 'female_na.png'
	Else 'na.png'
	end) as 'Photos',
	isnull(JoiningDate,'1/1/2099') as 'EffectiveDate',
	ActualBirthDay,ActualBirthMonth 
	
	from vwOrgStructure 
	Where (OfficialDesignationID like @DesignationIDParam or OfficialDesignation is null )
	And (FunctionalDesignationID like @FunctionalDesignationIDParam or FunctionalDesignation is null)
	And ( DepartmentID like @DepartmentIDParam or DepartmentID is null)
	--And ( OfficialDesignation  like @DesignationIDParam or OfficialDesignation is null) 
	And ( ULCBranchID like @ULCBranchIDParam or ULCBranchID is null)
	And isActive=@IsActive
	And ( EmpTypeID like @EmployeeTypeIDParam or EmpTypeID is null)
	And ( CurrentSupervisor like @CurrentSupervisorParam or CurrentSupervisor is null)
	And ( BloodGroupID like @BloodGroupIDParam or BloodGroupID is null)
	And ( Religion like @ReligionParam or Religion is null)
	And ( EmployeeName like @EmpIDOrNameParam or EmpCode like @EmpIDOrNameParam )
	--And ( ActualBirthDay like @ActualBirthDay or ActualBirthDay is null)
	And ( ActualBirthMonth like @ActualBirthMonth or ActualBirthMonth is null)
	And ( PerDistrict like ''+@PerDistrictParam+''  or PerDistrict is null)
	And ( Gender like @GenderParam)
	And ( JoiningDate >= @JoiningDate And JoiningDate <= @JoiningDateTo)
	order by OfficialDesigOrder desc,EffectiveDate asc,JoiningDate asc, FunctionalDesigOrder desc
end

GO

Create proc spSearchEmployeeForEdit
@EmpIDOrName nvarchar(200),
@EmployeeTypeID nvarchar(50),
@DepartmentID nvarchar(50),
@DesignationID nvarchar(50),
@ULCBranchID nvarchar(50),
@IsActive bit,
@Gender nvarchar(50),
@BloodGroupID nvarchar(50),
@PerDistrict int
as
begin

	Declare @EmpIDOrNameParam as nvarchar(200)
	Declare @EmployeeTypeIDParam as nvarchar(50)
	Declare @DepartmentIDParam as nvarchar(50)
	Declare @DesignationIDParam as nvarchar(50)
	Declare @ULCBranchIDParam as nvarchar(50)

	Declare @GenderParam as nvarchar(50)
	Declare @BloodGroupIDParam as nvarchar(50)
	Declare @PerDistrictParam as nvarchar(10)

	if @EmpIDOrName = ''
		Set @EmpIDOrNameParam = '%'
	Else
		Set @EmpIDOrNameParam = '%' + @EmpIDOrName + '%'
		

	if @EmployeeTypeID = 'N\A'
		Set @EmployeeTypeIDParam = '%'
	else
		Set @EmployeeTypeIDParam = '%'+ @EmployeeTypeID +'%'
		
	if @DesignationID = 'N\A'
		Set @DesignationIDParam = '%'
	else
		Set @DesignationIDParam = '%'+ @DesignationID +'%'
		
	if @DepartmentID = 'N\A'
		Set @DepartmentIDParam = '%'
	else
		Set @DepartmentIDParam = '%'+ @DepartmentID +'%'
		
	if @ULCBranchID = 'N\A'
		Set @ULCBranchIDParam = '%'
	else
		Set @ULCBranchIDParam = '%'+ @ULCBranchID +'%'
		
	if @Gender = 'N\A'
		Set @GenderParam = '%'
	else
		Set @GenderParam = @Gender + '%'

	if @BloodGroupID='N\A'
		Set @BloodGroupIDParam = '%'
	else
		Set @BloodGroupIDParam = '%'+ @BloodGroupID +'%'

	if @PerDistrict=0
		set @PerDistrictParam ='%'
	else
		set @PerDistrictParam = convert(nvarchar,@PerDistrict)


	Select EmployeeID,EmployeeName+'( '+EmpCode+' )' as 'EmployeeName' from vwEmpInfo 
	Where OfficialDesignationID like @DesignationIDParam
	And DepartmentID like @DepartmentIDParam And ULCBranchID like @ULCBranchIDParam
	And ( BloodGroupID like @BloodGroupIDParam or BloodGroupID is null)
	And ( EmployeeName like @EmpIDOrNameParam or EmpCode like @EmpIDOrNameParam )
	And ( PerDistrict like ''+@PerDistrictParam+''  or PerDistrict is null)
	And ( Gender like @GenderParam)
	And IsActive=@IsActive
	order by EmployeeName 
end

GO

Create proc spEditBasicEmpInfoAdmin
@EmployeeID nvarchar(50),
@UserType nvarchar(50),
@UserID nvarchar(50),
@Password nvarchar(50),
@EmpCode nvarchar(50),
@isActive bit,
@IncludedInPayroll bit,
@IsPermittedToShowOwn bit,
@IsPermittedToShowOthers bit,
@AttendanceID nvarchar(50),
@ProbationEffectiveDate datetime,
@ProbationPeriod int,
@AutoAdvTaxDeduction bit
as
begin
	Update tblEmployeeInfo Set UserType=@UserType,UserID=@UserID,Password=@Password,EmpCode=@EmpCode,
	isActive=@isActive,IsPermittedToShowOwn=@IsPermittedToShowOwn,IsPermittedToShowOthers=@IsPermittedToShowOthers,
	AttendanceID=@AttendanceID,ProbationEffectiveDate=@ProbationEffectiveDate,ProbationPeriod=@ProbationPeriod,
	AutoAdvTaxDeduction=@AutoAdvTaxDeduction,IncludedInPayroll=@IncludedInPayroll
	Where EmployeeID=@EmployeeID
end

GO

if object_id('spGetEmployeeInfoByID') is not null
	drop proc spGetEmployeeInfoByID

GO

Create proc spGetEmployeeInfoByID
@EmployeeID as nvarchar(50)
as
SELECT [EmployeeID],UserID,Password,UserType,[EmployeeName],[EmpCode]
      ,(case when EmpTypeID is null then (select EmployeeTypeID from dbo.tblEmployeeType where EmployeeTypeName='') else EmpTypeID end) as EmpTypeID
      ,[DateOfBirth]
	  ,isnull(BasicSalary,0) as 'BasicSalary'
      ,(case when JoiningDate is null then '1911-01-01' else [JoiningDate] end) as [JoiningDate]
	  ,(case when ConfirmationDate is null then '1911-01-01' else [ConfirmationDate] end) as [ConfirmationDate]
      ,(case when PromotionDate is null then '1911-01-01' else [PromotionDate] end) as [PromotionDate]
      ,(case when ContractExpiryDate is null then '1911-01-01' else [ContractExpiryDate] end) as [ContractExpiryDate]
      ,(case when ContractRenewalDate is null then '1911-01-01' else [ContractRenewalDate] end) as [ContractRenewalDate]
      ,(case when TerminationTypeID is null then '' end) as TerminationTypeID
      ,(case when TerminationDate is null then '1911-01-01' else [TerminationDate] end) as [TerminationDate]
      ,(case when RemarksOnTermination is null then '' else [RemarksOnTermination] end) as [RemarksOnTermination]
      ,ISNULL(JoiningDesignationID,'N\A') as [JoiningDesignationID]
      ,isnull(OfficialDesignationID,'N\A') as [OfficialDesignationID]
      ,isnull(FunctionalDesignationID,'N\A') as [FunctionalDesignationID]
      ,(case when DepartmentID is null then (select DepartmentID from dbo.tblDepartment where DeptName='') else [DepartmentID] end) as [DepartmentID]
      ,(case when ULCBranchID is null then (select ULCBranchID from dbo.tblULCBranch where ULCBranchName='') else [ULCBranchID] end) as [ULCBranchID]
      ,isnull((case when [CurrentSupervisor] is null then (select EmployeeID from dbo.tblEmployeeInfo where EmployeeName='') else [CurrentSupervisor] end),'') as [CurrentSupervisor]
      ,isnull(JDno,'') as 'JDno'
      ,(case when EmpStatus is null then '' else [EmpStatus] end) as [Status]
      ,(case when BankID is null then (select BankID from dbo.tblBank where BankName='N\A') else [BankID] end) as [BankID]
      ,(case when BranchID is null then (select [BranchID] from dbo.tblBranch where BranchName='') else [BranchID] end) as [BranchID]
      ,(case when BankAccountNo is null then '' else [BankAccountNo] end) as [BankAccountNo]
      ,(case when EntryExamScore is null then 0 else [EntryExamScore] end) as [EntryExamScore]
      ,(case when PromotionalExamScore is null then 0 else [PromotionalExamScore] end) as [PromotionalExamScore]
      ,isActive
      ,ISNULL(Email,'') as 'Email'
      ,isnull(LeaveApprover,EmployeeID) as LeaveApprover
      ,isnull(LeaveRecommender,EmployeeID) as LeaveRecommender,
	  IsPermittedToShowOwn,IsPermittedToShowOthers,isnull(AttendanceID,'') as 'AttendanceID',
	  isnull(ProbationEffectiveDate,JoiningDate) as 'ProbationEffectiveDate', isnull(ProbationPeriod,0) as 'ProbationPeriod',
	  ISNULL(AutoAdvTaxDeduction,0) as 'AutoAdvTaxDeduction',
	  isnull(IncludedInPayroll,0) as 'IncludedInPayroll'
  FROM tblEmployeeInfo where EmployeeID=@EmployeeID

  GO

  --exec spGetEmployeeInfoByID 'EMP-00000098'

alter proc spGetEmpListPayrollActive
as
begin
	SELECT E.EmployeeID,E.EmployeeName + ' ( ' + E.EmpCode + ' )' as 'EmployeeName'
	FROM [dbo].tblEmployeeInfo E-- INNER JOIN tblEmpSalaryProfile P ON E.EmployeeID = P.EmployeeID
	where E.isActive =1 And E.IncludedInPayroll=1 order by E.EmployeeName
end

GO
-- exec spGetTeamMembers 'EMP-00000070'
alter proc spGetTeamMembers
@EmployeeID nvarchar(50)
as
begin

	Declare @IsBIC as bit set @IsBIC = 0;
	Declare @BranchID as nvarchar(50) set @BranchID = '';

	select @IsBIC = IsBIC,@BranchID=ULCBranchID from tblEmployeeInfo where EmployeeID = @EmployeeID;

	declare @team as table(
	EmployeeID nvarchar(50),
	EmployeeName nvarchar(200)
	);

	If @IsBIC = 1
	begin
		
		insert into @team
		select 'ALL','ALL';

		insert into @team
		SELECT EmployeeID,EmployeeName + ' ( ' + EmpCode + ' )' as 'EmployeeName'
		FROM [dbo].tblEmployeeInfo where ULCBranchID = @BranchID
		and isActive =1 And IncludedInPayroll=1 And EmpStatus = 'Active'
		order by EmployeeName
	end
	else
	begin
		insert into @team
		SELECT EmployeeID,EmployeeName + ' ( ' + EmpCode + ' )' as 'EmployeeName'
		FROM [dbo].tblEmployeeInfo where CurrentSupervisor = @EmployeeID
		and isActive =1 And IncludedInPayroll=1 And EmpStatus = 'Active'
		UNION
		SELECT EmployeeID,EmployeeName + ' ( ' + EmpCode + ' )' as 'EmployeeName'
		FROM [dbo].tblEmployeeInfo where EmployeeID = @EmployeeID
		and isActive =1 And IncludedInPayroll=1 And EmpStatus = 'Active'
		order by EmployeeName
	end

	select * from @team;
end

select * from tblEmployeeInfo where EmployeeName like '%tansir%'
--exec spGetTeamMembers 'EMP-00000001'
--exec spGetTeamMembers 'EMP-00000007'

GO

Create proc spCheckPrevPassword
@EmployeeID nvarchar(50),
@Password nvarchar(50)
as
begin

	Select COUNT(*) as 'Count' from tblEmployeeInfo Where EmployeeID=@EmployeeID and Password=@Password

end

GO

Create proc spChangeEmpPassword
@EmployeeID nvarchar(50),
@Password nvarchar(50)
as
begin

	Update tblEmployeeInfo Set Password=@Password Where EmployeeID=@EmployeeID

end

GO

Create proc spGetEmpChartData
as
begin
	SELECT E.EmployeeID,EmpCode, EmployeeName,D.DesignationName as 'Designation',E.Photos,E.CurrentSupervisor
	from tblEmployeeInfo E INNER JOIN tblDesignation D ON D.DesignationID = E.OfficialDesignationID
	Where E.isActive = 1 And E.IncludedInPayroll = 1
end

SELECT EmployeeID, EmployeeName, OfficialDesignation as Designation, CurrentSupervisor as ReportingManager
FROM vwEmpInfo Where IsActive=1 And IncludedInPayroll=1


GO

alter proc spGetEmpListByTypePayrollActive
@EmployeeTypeID nvarchar(50)
as
begin
	SELECT E.EmployeeID,E.EmployeeName + ' ( ' + E.EmpCode + ' )' as 'EmployeeName'
	FROM tblEmployeeInfo E INNER JOIN tblEmpSalaryProfile P ON E.EmployeeID = P.EmployeeID
	where E.isActive =1 And E.IncludedInPayroll=1 And E.EmpTypeID = @EmployeeTypeID
	order by E.EmpCode
end

