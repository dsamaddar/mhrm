
alter View vwEmpSalaryProfile
as
Select EmployeeID,EmployeeName,EmpCode,Designation,BasicSalary,Consolidated,HouseRent,Medical,Entertainment,Conveyance,HouseMaintenance,PF,Tax,
(BasicSalary+HouseRent+Medical+Entertainment+Conveyance+HouseMaintenance+Consolidated) as 'Gross',
(PF+Tax+ConveyanceDeduction) as 'Deduction',
((BasicSalary+HouseRent+Medical+Entertainment+Conveyance+HouseMaintenance+Consolidated)-(PF+Tax+ConveyanceDeduction)) as 'Net',
MobileAllowance
from (
Select EI.EmployeeID,EI.EmployeeName,EI.EmpCode,EI.OfficialDesignation as 'Designation',SP.BasicSalary,
Convert(numeric(18,2),SP.HouseRent) as 'HouseRent',
Convert(numeric(18,2),SP.Medical) as 'Medical',
Convert(numeric(18,2),SP.Entertainment) as 'Entertainment',
Convert(numeric(18,2),SP.Conveyance) as 'Conveyance',
Convert(numeric(18,2),SP.HouseMaintenance) as 'HouseMaintenance',
Convert(numeric(18,2),(SP.Consolidated)) as 'Consolidated',
Convert(numeric(18,2),SP.PFDeduction) as 'PF',
Convert(numeric(18,2),SP.ConveyanceDeduction) as 'ConveyanceDeduction',
SP.TaxDeduction as 'Tax',
SP.MobileAllowance as 'MobileAllowance'
from vwEmpInfo EI INNER JOIN tblEmpSalaryProfile SP ON EI.EmployeeID = SP.EmployeeID
Where EI.isActive = 1) as E;

GO

select * from vwEmpSalaryProfile;

GO

alter proc spGetEmpSalaryByID
@EmployeeID nvarchar(50)
as
begin
	Select EmployeeName,EmpCode,Designation,BasicSalary,Consolidated,HouseRent,Medical,Entertainment,Conveyance,
	HouseMaintenance,PF,Tax,Gross,Deduction,Net,MobileAllowance
	from vwEmpSalaryProfile Where EmployeeID = @EmployeeID
end

-- exec spGetEmpSalaryByID 'EMP-00000098'

Select * from vwEmpSalaryProfile

GO

ALTER proc rptSalaryCertificate
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
	Declare @EmpTypeID as nvarchar(50) set @EmpTypeID = '';
	Declare @EmployeeType as nvarchar(50) set @EmployeeType = '';
	Declare @JoiningDate as datetime

	Declare @PresentAddress as nvarchar(200) Set @PresentAddress = ''
	Declare @PreDistrict as int Set @PreDistrict = 0
	Declare @PreThana as int Set @PreThana = 0

	Declare @BasicSalary as numeric(18,2) Set @BasicSalary = 0
	Declare @HouseRent as numeric(18,2) Set @HouseRent = 0
	Declare @MedicalAllowance as numeric(18,2) Set @MedicalAllowance = 0
	Declare @Conveyance as numeric(18,2) Set @Conveyance = 0
	Declare @LFA as numeric(18,2) set @LFA = 0;
	Declare @PFDeduction as numeric(18,2) Set @PFDeduction = 0
	Declare @LoanDeduction as numeric(18,2) Set @LoanDeduction = 0
	Declare @TaxDeduction as numeric(18,2) Set @TaxDeduction = 0
	Declare @TotalBenefit as numeric(18,2) Set @TotalBenefit = 0
	Declare @TotalDeduction as numeric(18,2) Set @TotalDeduction = 0
	Declare @NetSalary as numeric(18,2) Set @NetSalary = 0
	Declare @MobileAllowance as numeric(18,2) Set @MobileAllowance = 0

	Select @EmployeeName=EmployeeName,@Gender=Gender,@PresentAddress=PresentAddress,@PreDistrict=PreDistrict,@PreThana=PreThana,
	@FathersName=FathersName,@OfficialDesignationID=OfficialDesignationID,@DepartmentID=DepartmentID,@JoiningDate=JoiningDate,
	@EmpTypeID = EmpTypeID
	from tblEmployeeInfo Where EmployeeID = @EmployeeID

	Select @Department=DeptName from tblDepartment Where DepartmentID = @DepartmentID
	Select @Designation = DesignationName from tblDesignation Where DesignationID = @OfficialDesignationID
	Select @DistrictName=DistrictName from tblDistrict Where DistrictID = @PreDistrict
	Select @UpazilaName=UpazilaName from tblUpazila Where UpazilaID = @PreThana
	Select @EmployeeType = EmployeeTypeName from tblEmployeeType where EmployeeTypeID = @EmpTypeID;
	
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
	
	Select @BasicSalary=BasicSalary,@HouseRent=HouseRent,@MedicalAllowance=Medical,@Conveyance=Conveyance,@LFA = LFA,@PFDeduction=PFDeduction,
	@LoanDeduction=LoanDeduction,@TaxDeduction=TaxDeduction
	from tblEmpSalaryProfile Where EmployeeID = @EmployeeID

	Set @TotalBenefit = @BasicSalary + @HouseRent + @MedicalAllowance + @Conveyance + @LFA;
	Set @TotalDeduction = @PFDeduction + @LoanDeduction + @TaxDeduction
	Set @NetSalary = @TotalBenefit - @TotalDeduction

	Select @Salutation as 'Salutation',@EmployeeName as 'EmployeeName',@PresentAddress as 'PresentAddress',
	@CareOF as 'CareOF',@FathersName as 'FathersName',@EmployeeType as EmployeeType,@Designation as 'Designation',@Department as 'Department',
	@JoiningDate as 'JoiningDate',@GenderSign as 'GenderSign',@BasicSalary as 'BasicSalary',@HouseRent as 'HouseRent',
	@MedicalAllowance as 'MedicalAllowance',@Conveyance as 'Conveyance',@LFA as LFA,@PFDeduction as 'PFDeduction',
	@LoanDeduction as 'LoanDeduction',@TaxDeduction as 'TaxDeduction',@TotalBenefit as 'TotalBenefit',
	@TotalDeduction as 'TotalDeduction',@NetSalary as 'NetSalary',dbo.udf_Num_ToWords(@TotalBenefit) as 'AmountInWords',
	@PossessiveForm as 'PossessiveForm',@MobileAllowance as 'MobileAllowance'

end

GO

create view vwSalarySummary
as
select s.EmployeeID,e.EmployeeName,e.EmpCode,d.DeptName,de.DesignationName,br.ULCBranchName,e.Email,b.BankName,
bbr.BranchName,s.BankAccountNo,s.SalaryMonth,s.SalaryYear,s.BasicSalary,s.HouseRent,s.Entertainment,s.Medical,
s.Conveyance,s.HouseMaintenance,s.Consolidated,s.LFA,s.PerformanceBonus,s.FestivalBonus,s.BaishakhiAllowance,
s.ProfessionalAllowance,s.SpecialAllowance,s.MobileAllowance,s.Arrear,s.Cash,s.AccountsRecoverable,s.PFDeduction,
s.PBTaxDeduction,s.TaxDeduction,s.ConveyanceDeduction,s.LoanDeduction,s.DonationDeduction,s.GrossSalary,
s.NetDeduction,s.IsSalaryProcessed,s.IsFBProcessed,s.IsPBProcessed,s.IsBaishakhiAllowanceProcessed,s.IsTDProcessed,
s.EntryPoint,s.IsFinalized,s.FinalizedDate,s.ProcessedBy,s.ProcessedDate
from tblEmpSalarySummary s 
inner join tblEmployeeInfo e on s.EmployeeID = e.EmployeeID
inner join tblDepartment d on s.DepartmentID = d.DepartmentID
inner join tblDesignation de on s.DesignationID = de.DesignationID
inner join tblULCBranch br on s.ULCBranchID = br.ULCBranchID
inner join tblBank b on s.BankID = b.BankID
inner join tblBranch bbr on s.BranchID = bbr.BranchID

GO

select * from vwSalarySummary;

GO

alter proc rptSalaryBankInstruction
@EntryPoint nvarchar(50)
as
begin
	select '' as customer_ref,s.EmployeeName as payee_name,s.BankAccountNo,GrossSalary-NetDeduction as amount,
	'Salary of ' + DATENAME(MONTH,CONVERT(date,convert(nvarchar,s.SalaryMonth)+'/01/'+CONVERT(nvarchar,s.SalaryYear))) + ' ' + convert(nvarchar,s.SalaryYear) as reason,
	FORMAT(s.ProcessedDate,'dd/MM/yyyy') as payment_dt,'M0002130812101' as debit_ac,s.Email
	from vwSalarySummary s
	Where EntryPoint = @EntryPoint;
end

-- exec rptSalaryBankInstruction '2023231312';
GO
-- exec rptConsolidatedSalary 11,2022
alter proc rptConsolidatedSalary
@SalaryMonth int,
@SalaryYear int
as
begin
	select s.EmployeeName,s.EmpCode,s.DeptName,s.DesignationName,s.ULCBranchName,s.Email,s.BankName,s.BranchName,s.BankAccountNo,
	sum(s.BasicSalary) as BasicSalary,sum(s.HouseRent) as HouseRent,sum(s.Entertainment) as Entertainment,sum(s.Medical) as Medical,
	sum(s.Conveyance) as Conveyance,sum(s.HouseMaintenance) as HouseMaintenance,sum(s.Consolidated) as Consolidated,
	sum(s.LFA) as LFA,sum(s.PerformanceBonus) as PerformanceBonus,sum(s.FestivalBonus) as FestivalBonus,sum(s.BaishakhiAllowance) as BaishakhiAllowance,
	sum(s.ProfessionalAllowance) as ProfessionalAllowance,sum(s.SpecialAllowance) as SpecialAllowance,sum(s.MobileAllowance) as MobileAllowance,
	sum(s.Arrear) as Arrear,sum(s.Cash) as Cash,sum(s.AccountsRecoverable) as AccountsRecoverable,sum(s.PFDeduction) as PFDeduction,
	sum(s.PBTaxDeduction) as PBTaxDeduction,sum(s.TaxDeduction) as TaxDeduction,sum(s.ConveyanceDeduction) as ConveyanceDeduction,
	sum(s.LoanDeduction) as LoanDeduction,sum(s.DonationDeduction) as DonationDeduction,sum(s.GrossSalary) as GrossSalary,
	sum(s.NetDeduction) as NetDeduction
	from vwSalarySummary s where 
	SalaryMonth = @SalaryMonth and SalaryYear = @SalaryYear
	group by s.EmployeeName,s.EmpCode,s.DeptName,s.DesignationName,s.ULCBranchName,s.Email,s.BankName,s.BranchName,s.BankAccountNo
end

select * from vwSalarySummary;

GO

-- drop proc spGetSalaryCertificate
alter proc spGetSalaryCertificate
@EmployeeID nvarchar(50),
@SalaryMonth int,
@SalaryYear int
as
begin
	Select S.EmployeeID,EI.EmployeeName,EI.EmpCode,EI.JoiningDate,EI.FathersName,
	CASE WHEN EI.Gender='Male' THEN ' S.O- ' ELSE ' D.O- ' END AS 'GenderName',
	D.DeptName,U.ULCBranchName,B.BankName,BB.BranchName,S.BankAccountNo,
	S.SalaryMonth,S.SalaryYear,S.BasicSalary,S.HouseRent,S.Entertainment,S.Medical,S.Conveyance,S.HouseMaintenance,S.Consolidated,
	S.LFA,S.PerformanceBonus,S.FestivalBonus,S.BaishakhiAllowance,S.MobileAllowance,S.Arrear,S.Cash,S.AccountsRecoverable,S.PFDeduction,
	S.PBTaxDeduction,S.TaxDeduction,S.ConveyanceDeduction,S.LoanDeduction,S.DonationDeduction,S.GrossSalary,S.NetDeduction
	from 
	tblEmpSalarySummary S LEFT OUTER JOIN
	tblEmployeeInfo AS EI ON S.EmployeeID = EI.EmployeeID LEFT OUTER JOIN
	tblDepartment D ON D.DepartmentID = EI.DepartmentID LEFT OUTER JOIN
	tblULCBranch U ON U.ULCBranchID = EI.ULCBranchID  LEFT OUTER JOIN
	tblBank B ON B.BankID = EI.BankID  LEFT OUTER JOIN
	tblBranch BB ON EI.BranchID = BB.BranchID
	where S.EmployeeID = @EmployeeID and SalaryMonth = @SalaryMonth and SalaryYear = @SalaryYear
end

-- exec spGetSalaryCertificate 'EMP-00000098',7,2020