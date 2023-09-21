-- drop table tblEmpSalaryProfile
Create table tblEmpSalaryProfile(
EmpSalaryProfileID nvarchar(50) primary key,
EmployeeID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
BasicSalary numeric(18,2),
HouseRent numeric(18,2) default 0,
Entertainment numeric(18,2) default 0,
Medical numeric(18,2) default 0,
Conveyance numeric(18,2) default 0,
HouseMaintenance numeric(18,2) default 0,
Consolidated numeric(18,2) default 0,
LFA numeric(18,2) default 0,
PerformanceBonus numeric(18,2) default 0,
FestivalBonus numeric(18,2) default 0,
BaishakhiAllowance numeric(18,2) default 0,
ProfessionalAllowance numeric(18,2) default 0,
SpecialAllowance numeric(18,2) default 0,
MobileAllowance numeric(18,2) default 0,
CarAllowance numeric(18,2) default 0,
Arrear numeric(18,2) default 0,
Cash numeric(18,2) default 0,
AccountsRecoverable numeric(18,2) default 0,
PFDeduction numeric(18,2) default 0,
PBTaxDeduction numeric(18,2) default 0,
TaxDeduction numeric(18,2) default 0,
ConveyanceDeduction numeric(18,2) default 0,
LoanDeduction  numeric(18,2) default 0,
DonationDeduction numeric(18,2) default 0,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO
-- drop table tblEmpSalaryProfileLog
Create table tblEmpSalaryProfileLog(
LogSerialNo int identity(1,1) primary key,
EmpSalaryProfileID nvarchar(50) foreign key references tblEmpSalaryProfile(EmpSalaryProfileID),
EmployeeID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
BasicSalary numeric(18,2),
HouseRent numeric(18,2) default 0,
Entertainment numeric(18,2) default 0,
Medical numeric(18,2) default 0,
Conveyance numeric(18,2) default 0,
HouseMaintenance numeric(18,2) default 0,
Consolidated numeric(18,2) default 0,
LFA numeric(18,2) default 0,
PerformanceBonus numeric(18,2) default 0,
FestivalBonus numeric(18,2) default 0,
BaishakhiAllowance numeric(18,2) default 0,
ProfessionalAllowance numeric(18,2) default 0,
SpecialAllowance numeric(18,2) default 0,
MobileAllowance numeric(18,2) default 0,
CarAllowance numeric(18,2) default 0,
Arrear numeric(18,2) default 0,
Cash numeric(18,2) default 0,
AccountsRecoverable numeric(18,2) default 0,
PFDeduction numeric(18,2) default 0,
PBTaxDeduction numeric(18,2) default 0,
TaxDeduction numeric(18,2) default 0,
ConveyanceDeduction numeric(18,2) default 0,
LoanDeduction  numeric(18,2) default 0,
DonationDeduction numeric(18,2) default 0,
EntryBy nvarchar(50),
EntryDate datetime default getdate(),
LogEvent nvarchar(50),
LogTime datetime default getdate()
);

GO

create TRIGGER trgEmpSalaryProfile
ON tblEmpSalaryProfile after INSERT, UPDATE, DELETE
AS 
begin

declare @LogEvent as nvarchar(50) Set @LogEvent=''

	if exists (select * from deleted)
	begin
		--set @LogEvent='Deleted'
		--Insert Into tblEmpSalaryProfileLog (EmpSalaryProfileID,EmployeeID,BasicSalary,HouseRentPer,EntertainmentPer,MedicalPer,ConveyancePer,HouseMaintenancePer,Consolidated,
		--LFAPer,PerformanceBonus,FestivalBonusPer,BaishakhiAllowancePer,ProfessionalAllowance,SpecialAllowance,MobileAllowance,Arrear,
		--AccountsRecoverable,PFDeductionPer,PBTaxDeduction,TaxDeduction,ConveyanceDeductionPer,LoanDeduciton,DonationDeduction,EntryBy,EntryDate,LogEvent)

		--SELECT EmpSalaryProfileID,EmployeeID,BasicSalary,HouseRentPer,EntertainmentPer,MedicalPer,ConveyancePer,HouseMaintenancePer,Consolidated,
		--LFAPer,PerformanceBonus,FestivalBonusPer,BaishakhiAllowancePer,ProfessionalAllowance,SpecialAllowance,MobileAllowance,Arrear,
		--AccountsRecoverable,PFDeductionPer,PBTaxDeduction,TaxDeduction,ConveyanceDeductionPer,LoanDeduciton,DonationDeduction,EntryBy,EntryDate,@LogEvent
		--FROM deleted
		if exists (select * from INSERTED)
		begin
			Set @LogEvent='Updated'
			Insert Into tblEmpSalaryProfileLog (EmpSalaryProfileID,EmployeeID,BasicSalary,HouseRent,Entertainment,Medical,Conveyance,HouseMaintenance,Consolidated,
			LFA,PerformanceBonus,FestivalBonus,BaishakhiAllowance,ProfessionalAllowance,SpecialAllowance,MobileAllowance,CarAllowance,Arrear,Cash,
			AccountsRecoverable,PFDeduction,PBTaxDeduction,TaxDeduction,ConveyanceDeduction,LoanDeduction,DonationDeduction,EntryBy,EntryDate,LogEvent)

			SELECT EmpSalaryProfileID,EmployeeID,BasicSalary,HouseRent,Entertainment,Medical,Conveyance,HouseMaintenance,Consolidated,
			LFA,PerformanceBonus,FestivalBonus,BaishakhiAllowance,ProfessionalAllowance,SpecialAllowance,MobileAllowance,CarAllowance,Arrear,Cash,
			AccountsRecoverable,PFDeduction,PBTaxDeduction,TaxDeduction,ConveyanceDeduction,LoanDeduction,DonationDeduction,EntryBy,EntryDate,@LogEvent
			FROM INSERTED
		end
	end
	else
	begin
		Set @LogEvent='Inserted'
		Insert Into tblEmpSalaryProfileLog (EmpSalaryProfileID,EmployeeID,BasicSalary,HouseRent,Entertainment,Medical,Conveyance,HouseMaintenance,Consolidated,
		LFA,PerformanceBonus,FestivalBonus,BaishakhiAllowance,ProfessionalAllowance,SpecialAllowance,MobileAllowance,CarAllowance,Arrear,Cash,
		AccountsRecoverable,PFDeduction,PBTaxDeduction,TaxDeduction,ConveyanceDeduction,LoanDeduction,DonationDeduction,EntryBy,EntryDate,LogEvent)

		SELECT EmpSalaryProfileID,EmployeeID,BasicSalary,HouseRent,Entertainment,Medical,Conveyance,HouseMaintenance,Consolidated,
		LFA,PerformanceBonus,FestivalBonus,BaishakhiAllowance,ProfessionalAllowance,SpecialAllowance,MobileAllowance,CarAllowance,Arrear,Cash,
		AccountsRecoverable,PFDeduction,PBTaxDeduction,TaxDeduction,ConveyanceDeduction,LoanDeduction,DonationDeduction,EntryBy,EntryDate,@LogEvent
		FROM INSERTED
	end
end

GO

alter proc spInsertEmpSalaryProfile
@EmployeeID nvarchar(50),
@BasicSalary numeric(18,2),
@HouseRent numeric(18,2),
@Entertainment numeric(18,2),
@Medical numeric(18,2),
@Conveyance numeric(18,2),
@HouseMaintenance numeric(18,2),
@Consolidated numeric(18,2),
@LFA numeric(18,2),
@PerformanceBonus numeric(18,2),
@FestivalBonus numeric(18,2),
@BaishakhiAllowance numeric(18,2),
@ProfessionalAllowance numeric(18,2),
@SpecialAllowance numeric(18,2),
@MobileAllowance numeric(18,2),
@CarAllowance numeric(18,2),
@Arrear numeric(18,2),
@Cash numeric(18,2),
@AccountsRecoverable numeric(18,2),
@PFDeduction numeric(18,2),
@PBTaxDeduction numeric(18,2),
@TaxDeduction numeric(18,2),
@ConveyanceDeduction numeric(18,2),
@LoanDeduction  numeric(18,2),
@DonationDeduction numeric(18,2),
@EntryBy nvarchar(50)
as
begin

	Declare @EmpSalaryProfileID as nvarchar(50)
	Declare @CurrentEmpSalaryProfileID numeric(18,0)
	Declare @EmpSalaryProfileIDPrefix as nvarchar(12)

	set @EmpSalaryProfileIDPrefix='EMP-SAL-PRO-'

begin tran
	
	select @CurrentEmpSalaryProfileID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentEmpSalaryProfileID'
	
	set @CurrentEmpSalaryProfileID=isnull(@CurrentEmpSalaryProfileID,0)+1
	Select @EmpSalaryProfileID=dbo.generateID(@EmpSalaryProfileIDPrefix,@CurrentEmpSalaryProfileID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	Insert Into tblEmpSalaryProfile (EmpSalaryProfileID,EmployeeID,BasicSalary,HouseRent,Entertainment,Medical,Conveyance,HouseMaintenance,Consolidated,
	LFA,PerformanceBonus,FestivalBonus,BaishakhiAllowance,ProfessionalAllowance,SpecialAllowance,MobileAllowance,CarAllowance,Arrear,Cash,
	AccountsRecoverable,PFDeduction,PBTaxDeduction,TaxDeduction,ConveyanceDeduction,LoanDeduction,DonationDeduction,EntryBy)
	Values(@EmpSalaryProfileID,@EmployeeID,@BasicSalary,@HouseRent,@Entertainment,@Medical,@Conveyance,@HouseMaintenance,@Consolidated,
	@LFA,@PerformanceBonus,@FestivalBonus,@BaishakhiAllowance,@ProfessionalAllowance,@SpecialAllowance,@MobileAllowance,@CarAllowance,@Arrear,@Cash,
	@AccountsRecoverable,@PFDeduction,@PBTaxDeduction,@TaxDeduction,@ConveyanceDeduction,@LoanDeduction,@DonationDeduction,@EntryBy)

	update tblAppSettings set PropertyValue=@CurrentEmpSalaryProfileID where PropertyName='CurrentEmpSalaryProfileID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO


alter proc spUpdateEmpSalaryProfile
@EmpSalaryProfileID nvarchar(50),
@EmployeeID nvarchar(50),
@BasicSalary numeric(18,2),
@HouseRent numeric(18,2),
@Entertainment numeric(18,2),
@Medical numeric(18,2),
@Conveyance numeric(18,2),
@HouseMaintenance numeric(18,2),
@Consolidated numeric(18,2),
@LFA numeric(18,2),
@PerformanceBonus numeric(18,2),
@FestivalBonus numeric(18,2),
@BaishakhiAllowance numeric(18,2),
@ProfessionalAllowance numeric(18,2),
@SpecialAllowance numeric(18,2),
@MobileAllowance numeric(18,2),
@CarAllowance numeric(18,2),
@Arrear numeric(18,2),
@Cash numeric(18,2),
@AccountsRecoverable numeric(18,2),
@PFDeduction numeric(18,2),
@PBTaxDeduction numeric(18,2),
@TaxDeduction numeric(18,2),
@ConveyanceDeduction numeric(18,2),
@LoanDeduction  numeric(18,2),
@DonationDeduction numeric(18,2),
@EntryBy nvarchar(50)
as
begin
	
	Update tblEmpSalaryProfile Set EmployeeID=@EmployeeID,BasicSalary=@BasicSalary,HouseRent=@HouseRent,Entertainment=@Entertainment,
	Medical=@Medical,Conveyance=@Conveyance,HouseMaintenance=@HouseMaintenance,Consolidated=@Consolidated,LFA=@LFA,PerformanceBonus=@PerformanceBonus,
	FestivalBonus=@FestivalBonus,BaishakhiAllowance=@BaishakhiAllowance,ProfessionalAllowance=@ProfessionalAllowance,SpecialAllowance=@SpecialAllowance,
	MobileAllowance=@MobileAllowance,CarAllowance=@CarAllowance,Arrear=@Arrear,Cash=@Cash,AccountsRecoverable=@AccountsRecoverable,PFDeduction=@PFDeduction,PBTaxDeduction=@PBTaxDeduction,TaxDeduction=@TaxDeduction,
	ConveyanceDeduction=@ConveyanceDeduction,LoanDeduction=@LoanDeduction,DonationDeduction=@DonationDeduction,EntryBy=@EntryBy,EntryDate=GETDATE()
	Where EmpSalaryProfileID=@EmpSalaryProfileID

end

GO

alter proc spGetEmpSalaryProfile
@EmployeeID nvarchar(50)
as
begin
	Select 
	EmpSalaryProfileID,EmployeeID,BasicSalary,HouseRent,Entertainment,Medical,Conveyance,HouseMaintenance,
	Consolidated,LFA,PerformanceBonus,FestivalBonus,BaishakhiAllowance,ProfessionalAllowance,SpecialAllowance,MobileAllowance,CarAllowance,
	Arrear,Cash,AccountsRecoverable,PFDeduction,PBTaxDeduction,TaxDeduction,ConveyanceDeduction,LoanDeduction,DonationDeduction,
	EntryBy,EntryDate
	from tblEmpSalaryProfile Where EmployeeID=@EmployeeID
end

-- exec spGetEmpSalaryProfile 'EMP-00000098'

GO

insert into tblAppSettings(PropertyName,PropertyValue)values('CurrentEmpSalarySummaryID',0);

GO

-- drop table tblEmpSalarySummary
Create table tblEmpSalarySummary(
EmpSalarySummaryID nvarchar(50) primary key,
EmployeeID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
DepartmentID nvarchar(50) foreign key references tblDepartment(DepartmentID),
DesignationID nvarchar(50) foreign key references tblDesignation(DesignationID),
ULCBranchID nvarchar(50) foreign key references tblULCBranch(ULCBranchID),
BankID nvarchar(50) foreign key references tblBank(BankID),
BranchID nvarchar(50) foreign key references tblBranch(BranchID),
BankAccountNo nvarchar(50),
SalaryMonth int,
SalaryYear int,
BasicSalary numeric(18,2) default 0,
HouseRent numeric(18,2) default 0,
Entertainment numeric(18,2) default 0,
Medical numeric(18,2) default 0,
Conveyance numeric(18,2) default 0,
HouseMaintenance numeric(18,2) default 0,
Consolidated numeric(18,2) default 0,
LFA numeric(18,2) default 0,
PerformanceBonus numeric(18,2) default 0,
FestivalBonus numeric(18,2) default 0,
BaishakhiAllowance numeric(18,2) default 0,
ProfessionalAllowance numeric(18,2) default 0,
SpecialAllowance numeric(18,2) default 0,
MobileAllowance numeric(18,2) default 0,
CarAllowance numeric(18,2) default 0,
Arrear numeric(18,2) default 0,
Cash numeric(18,2) default 0,
AccountsRecoverable numeric(18,2) default 0,
PFDeduction numeric(18,2) default 0,
PBTaxDeduction numeric(18,2) default 0,
TaxDeduction numeric(18,2) default 0,
ConveyanceDeduction numeric(18,2) default 0,
LoanDeduction  numeric(18,2) default 0,
DonationDeduction numeric(18,2) default 0,
GrossSalary AS (BasicSalary+HouseRent+Entertainment+Medical+Conveyance+HouseMaintenance+Consolidated+LFA+PerformanceBonus+FestivalBonus+BaishakhiAllowance+ProfessionalAllowance+SpecialAllowance+MobileAllowance),
NetDeduction AS (AccountsRecoverable+PFDeduction+PBTaxDeduction+TaxDeduction+ConveyanceDeduction+LoanDeduction),
IsSalaryProcessed bit default 0,
IsFBProcessed bit default 0,
IsPBProcessed bit default 0,
IsBaishakhiAllowanceProcessed bit default 0,
IsTDProcessed bit default 0,
EntryPoint nvarchar(50),
IsFinalized bit default 0,
FinalizedBy nvarchar(50),
FinalizedDate datetime,
ProcessedBy nvarchar(50),
ProcessedDate datetime default getdate()
);

GO

alter proc spGetSalaryEntryPointForConfirmation
as
begin
	select distinct EntryPoint,EntryPoint + ' [' + ProcessedBy + '][' + convert(nvarchar,ProcessedDate,106)+']' EntryPointText 
	from tblEmpSalarySummary Where IsFinalized = 0
	order by EntryPoint desc;
end

GO
--exec spGetSalaryEntryPointForConfirmation;

GO

create proc spGetReportableSalaryEntryPoint
as
begin
	select distinct EntryPoint,EntryPoint + ' [' + ProcessedBy + '][' + convert(nvarchar,ProcessedDate,106)+']' EntryPointText 
	from tblEmpSalarySummary Where IsFinalized = 1
	order by EntryPoint desc;
end

GO

