
-- exec spCheckSalarySystem 'EMP-00000077',11,2022,1,0,0,0,1
alter proc spCheckSalarySystem
@EmployeeID nvarchar(50),
@SalaryMonth int,
@SalaryYear int,
@IsSalaryProcessSelected bit,
@IsFBSelected bit,
@IsPBSelected bit,
@IsBaishakhiAllowanceSelected bit,
@IsTDSelected bit
as
begin

	Declare @CanProceed as nvarchar(50) Set @CanProceed = 'YES'
	Declare @IsSalaryProcessed bit Set @IsSalaryProcessed = 0
	Declare @IsFBProcessed bit Set @IsFBProcessed = 0
	Declare @IsPBProcessed bit Set @IsPBProcessed = 0
	Declare @IsBaishakhiAllowanceProcessed bit Set @IsBaishakhiAllowanceProcessed = 0

	Select @IsSalaryProcessed=ISNULL(IsSalaryProcessed,0),@IsFBProcessed=IsFBProcessed,
	@IsPBProcessed=ISNULL(IsPBProcessed,0),@IsBaishakhiAllowanceProcessed=ISNULL(IsBaishakhiAllowanceProcessed,0)
	from tblEmpSalarySummary Where EmployeeID=@EmployeeID
	And SalaryMonth=@SalaryMonth And SalaryYear=@SalaryYear

	If ISNULL(@IsSalaryProcessed,0) = 1
	begin
		If @IsSalaryProcessSelected = 1
			Set @CanProceed = 'NO'
	end
	
	If ISNULL(@IsFBProcessed,0) = 1
	begin
		if @IsFBSelected = 1
			Set @CanProceed = 'NO';
	end
	
	If ISNULL(@IsPBProcessed,0) = 1
	begin
		if @IsPBSelected = 1
			Set @CanProceed = 'NO'
	end
	
	If ISNULL(@IsBaishakhiAllowanceProcessed,0) = 1
	begin
		if @IsBaishakhiAllowanceSelected = 1
			Set @CanProceed = 'NO'
	end

	Select @CanProceed as 'CanProceed'
end

GO

-- select * from tblEmployeeInfo where EmpCode='C20220919133'
-- select * from tblDepartment where DepartmentID='DEPT-00000007'
-- exec spProcessSalary 'EMP-00000206',11,2022,1,0,0,0,1,'20222811125638052339263092191','dsmaddar'

GO

alter proc spProcessSalary
@EmployeeList text,
@SalaryMonth int,
@SalaryYear int,
@IsSalaryProcessSelected bit,
@IsFBSelected bit,
@IsPBSelected bit,
@IsBaishakhiAllowanceSelected bit,
@IsTDSelected bit,
@EntryPoint nvarchar(50),
@ProcessedBy nvarchar(50)
as
begin
SET NOCOUNT ON

	Declare @EmpList as table(
	EmployeeID nvarchar(50),
	Taken bit default 0
	);

begin tran
	Insert Into @EmpList(EmployeeID)
	Select Value from dbo.Split(',',@EmployeeList)

	Declare @Msg as nvarchar(500) set @Msg = '';
	Declare @chkSalaryProcessed as bit set @chkSalaryProcessed = 0;
	Declare @chkFBProcessed as bit set @chkFBProcessed = 0;
	Declare @chkPBProcessed as bit set @chkPBProcessed = 0;
	Declare @chkBaishakhiAllowanceProcessed as bit set @chkBaishakhiAllowanceProcessed = 0;
	Declare @chkTDSProcessed as bit set @chkTDSProcessed = 0;

	Declare @EmployeeID as nvarchar(50) Set @EmployeeID = ''
	Declare @DepartmentID as nvarchar(50) Set @DepartmentID = ''
	Declare @DesignationID as nvarchar(50) Set @DesignationID = ''
	Declare @ULCBranchID as nvarchar(50) Set @ULCBranchID = ''
	Declare @BankID as nvarchar(50) Set @BankID = ''
	Declare @BranchID as nvarchar(50) Set @BranchID = ''
	Declare @BankAccountNo as nvarchar(50) Set @BankAccountNo = ''

	Declare @BasicSalary as numeric(18,2) Set @BasicSalary = 0
	Declare @HouseRent as numeric(18,2) Set @HouseRent = 0
	Declare @EnterTainment as numeric(18,2) Set @EnterTainment = 0
	Declare @Medical as numeric(18,2) Set @Medical = 0
	Declare @Conveyance as numeric(18,2) Set @Conveyance = 0
	Declare @HouseMaintenance as numeric(18,2) Set @HouseMaintenance = 0
	Declare @Consolidated as numeric(18,2) Set @Consolidated = 0
	Declare @LFA as numeric(18,2) Set @LFA = 0
	Declare @PerformanceBonus as numeric(18,2) Set @PerformanceBonus = 0
	Declare @FestivalBonus as numeric(18,2) Set @FestivalBonus = 0
	Declare @BaishakhiAllowance as numeric(18,2) Set @BaishakhiAllowance = 0
	Declare @ProfessionalAllowance as numeric(18,2) Set @ProfessionalAllowance = 0
	Declare @SpecialAllowance as numeric(18,2) Set @SpecialAllowance = 0
	Declare @MobileAllowance as numeric(18,2) Set @MobileAllowance = 0
	Declare @Arrear as numeric(18,2) Set @Arrear = 0
	Declare @Cash as numeric(18,2) Set @Cash = 0

	Declare @AccountsRecoverable as numeric(18,2) Set @AccountsRecoverable = 0
	Declare @PFDeduction as numeric(18,2) Set @PFDeduction = 0
	Declare @PBTaxDeducted as numeric(18,2) Set @PBTaxDeducted = 0
	Declare @TaxDeduction as numeric(18,2) Set @TaxDeduction = 0
	Declare @ConveyanceDeduction as numeric(18,2) Set @ConveyanceDeduction = 0
	Declare @LoanDeduction as numeric(18,2) Set @LoanDeduction = 0
	Declare @DonationDeduction as numeric(18,2) Set @DonationDeduction = 0

	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0

	Declare @EmpSalarySummaryID as nvarchar(50)
	Declare @CurrentEmpSalarySummaryID numeric(18,0)
	Declare @EmpSalarySummaryIDPrefix as nvarchar(12)
	set @EmpSalarySummaryIDPrefix='EMP-SAL-'
		
	select @CurrentEmpSalarySummaryID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentEmpSalarySummaryID'
	
	select @NCount = count(*) from @EmpList;

	While @Count <= @NCount
	begin
		Select top 1 @EmployeeID = EmployeeID from @EmpList Where Taken = 0
		
		Select @DepartmentID = E.DepartmentID,@DesignationID = E.OfficialDesignationID, @ULCBranchID = E.ULCBranchID,
		@BankID = E.BankID, @BranchID = E.BranchID, @BankAccountNo = E.BankAccountNo,@BasicSalary = P.BasicSalary,
		@HouseRent =P.HouseRent,@EnterTainment = P.Entertainment,@Medical = P.Medical,@Conveyance = P.Conveyance,
		@HouseMaintenance = P.HouseMaintenance,@Consolidated = P.Consolidated,@LFA = P.LFA,@PerformanceBonus =  P.PerformanceBonus,
		@FestivalBonus = P.FestivalBonus,@BaishakhiAllowance = P.BaishakhiAllowance,@ProfessionalAllowance = P.ProfessionalAllowance,
		@SpecialAllowance = P.SpecialAllowance,@MobileAllowance = P.MobileAllowance,@Arrear = P.Arrear,@Cash = P.Cash,
		@AccountsRecoverable = P.AccountsRecoverable,@PFDeduction = P.PFDeduction,@PBTaxDeducted = P.PBTaxDeduction,
		@TaxDeduction = P.TaxDeduction,@ConveyanceDeduction = P.ConveyanceDeduction,@LoanDeduction = P.LoanDeduction,
		@DonationDeduction = P.DonationDeduction
		from tblEmployeeInfo E INNER JOIN tblEmpSalaryProfile P on E.EmployeeID = P.EmployeeID
		where E.EmployeeID = @EmployeeID;

		set @CurrentEmpSalarySummaryID=isnull(@CurrentEmpSalarySummaryID,0)+1
		Select @EmpSalarySummaryID=dbo.generateID(@EmpSalarySummaryIDPrefix,@CurrentEmpSalarySummaryID,8)		
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		If @IsPBSelected = 0
		begin
			Set @PerformanceBonus = 0;
			Set @PBTaxDeducted = 0;
		end

		If @IsFBSelected = 0
		begin
			Set @FestivalBonus = 0;
		end

		If @IsBaishakhiAllowanceSelected = 0
		begin
			Set @BaishakhiAllowance = 0;
		end

		Declare @IsSalaryProcessed as bit Set @IsSalaryProcessed = 0;

		print 'Department ID: ' +  ISNULL(@DepartmentID,'N\A');
		If @IsSalaryProcessSelected = 1
		begin
			print 'Salary Process : Selected';
			If not exists (select * from tblEmpSalarySummary where EmployeeID = @EmployeeID and SalaryMonth= @SalaryMonth and SalaryYear=@SalaryYear and IsSalaryProcessed=@IsSalaryProcessSelected and IsFBProcessed=@IsFBSelected and IsPBProcessed=@IsPBSelected and IsBaishakhiAllowanceProcessed=@IsBaishakhiAllowanceSelected)
			begin
				print 'Salary Process : New';
				Insert into tblEmpSalarySummary(EmpSalarySummaryID,EmployeeID,DepartmentID,DesignationID,ULCBranchID,BankID,BranchID,BankAccountNo,
				SalaryMonth,SalaryYear,BasicSalary,HouseRent,Entertainment,Medical,Conveyance,HouseMaintenance,Consolidated,LFA,ProfessionalAllowance,SpecialAllowance,
				MobileAllowance,Arrear,Cash,AccountsRecoverable,PFDeduction,TaxDeduction,ConveyanceDeduction,LoanDeduction,DonationDeduction,IsSalaryProcessed,
				IsTDProcessed,EntryPoint,ProcessedBy,ProcessedDate
				)
				Values(@EmpSalarySummaryID,@EmployeeID,@DepartmentID,@DesignationID,@ULCBranchID,@BankID,@BranchID,@BankAccountNo,
				@SalaryMonth,@SalaryYear,@BasicSalary,@HouseRent,@Entertainment,@Medical,@Conveyance,@HouseMaintenance,@Consolidated,@LFA,@ProfessionalAllowance,@SpecialAllowance,
				@MobileAllowance,@Arrear,@Cash,@AccountsRecoverable,@PFDeduction,@TaxDeduction,@ConveyanceDeduction,@LoanDeduction,@DonationDeduction,@IsSalaryProcessSelected,
				@IsTDSelected,@EntryPoint,@ProcessedBy,getdate()
				);
			end
			else
			begin
				/*
				select @EmpSalarySummaryID = EmpSalarySummaryID,@IsSalaryProcessed=IsSalaryProcessed from tblEmpSalarySummary where EmployeeID = @EmployeeID and SalaryMonth= @SalaryMonth and SalaryYear=@SalaryYear;

				If @IsSalaryProcessed = 0
				begin
					Update tblEmpSalarySummary Set
					BasicSalary=@BasicSalary,HouseRent=@HouseRent,Entertainment=@Entertainment,Medical=@Medical,Conveyance=@Conveyance,
					HouseMaintenance=@HouseMaintenance,Consolidated=@Consolidated,LFA=@LFA,ProfessionalAllowance=@ProfessionalAllowance,
					SpecialAllowance=@SpecialAllowance,MobileAllowance=@MobileAllowance,Arrear=@Arrear,Cash=@Cash,AccountsRecoverable=@AccountsRecoverable,
					PFDeduction=@PFDeduction,TaxDeduction=@TaxDeduction,ConveyanceDeduction=@ConveyanceDeduction,LoanDeduction=@LoanDeduction,
					DonationDeduction=@DonationDeduction,IsSalaryProcessed=@IsSalaryProcessSelected,IsTDProcessed=@IsTDSelected,
					EntryPoint=@EntryPoint,ProcessedBy=@ProcessedBy,ProcessedDate=getdate()
					Where EmployeeID = @EmployeeID and SalaryMonth= @SalaryMonth and SalaryYear=@SalaryYear;
				end
				*/
				print 'Salary Process : Existing (Checking)';
				select @EmpSalarySummaryID = EmpSalarySummaryID,@chkSalaryProcessed=IsSalaryProcessed,@chkFBProcessed=IsFBProcessed,@chkPBProcessed = IsPBProcessed,
				@chkBaishakhiAllowanceProcessed = IsBaishakhiAllowanceProcessed, @chkTDSProcessed=IsTDProcessed
				from tblEmpSalarySummary where EmployeeID = @EmployeeID and SalaryMonth=@SalaryMonth and SalaryYear=@SalaryYear;

				if @chkSalaryProcessed = 1
					set @Msg = 'Salary,';

				if @chkFBProcessed = 1
					set @Msg = 'Festival Bonus,';

				if @chkPBProcessed = 1
					set @Msg = 'Profit Bonus,';

				if @chkBaishakhiAllowanceProcessed = 1
					set @Msg = 'Baishakhi Allowance,';

				print 'Already Processed Options : ' + @Msg;
			end
		end

		IF @IsPBSelected = 1
		begin
			print 'Performance Bonus Process : Selected';
			If not exists (select * from tblEmpSalarySummary where EmployeeID = @EmployeeID and SalaryMonth=@SalaryMonth and SalaryYear=@SalaryYear and IsPBProcessed = @IsPBSelected )
			begin
				print 'Performance Bonus Process : New';
				Insert into tblEmpSalarySummary(EmpSalarySummaryID,EmployeeID,DepartmentID,DesignationID,ULCBranchID,BankID,BranchID,BankAccountNo,
				SalaryMonth,SalaryYear,PerformanceBonus,IsPBProcessed,EntryPoint,ProcessedBy,ProcessedDate
				)
				Values(@EmpSalarySummaryID,@EmployeeID,@DepartmentID,@DesignationID,@ULCBranchID,@BankID,@BranchID,@BankAccountNo,
				@SalaryMonth,@SalaryYear,@PerformanceBonus,@IsPBSelected,@EntryPoint,@ProcessedBy,GETDATE()
				);
			end
			else
			begin
				print 'Performance Bonus Process : Existing (Update)';
				/*
				Update tblEmpSalarySummary Set
				PerformanceBonus=@PerformanceBonus,IsPBProcessed = @IsPBSelected
				Where EmployeeID = @EmployeeID and SalaryMonth = @SalaryMonth and SalaryYear = @SalaryYear and IsPBProcessed = @IsPBSelected;
				*/
			end
		end

		IF @IsFBSelected = 1
		begin
			print 'Festival Bonus Process : Selected';
			If not exists (select * from tblEmpSalarySummary where EmployeeID = @EmployeeID and SalaryMonth= @SalaryMonth and SalaryYear=@SalaryYear and IsFBProcessed = @IsFBSelected)
			begin
				print 'Festival Bonus Process : New';
				Insert into tblEmpSalarySummary(EmpSalarySummaryID,EmployeeID,DepartmentID,DesignationID,ULCBranchID,BankID,BranchID,BankAccountNo,
				SalaryMonth,SalaryYear,FestivalBonus,IsFBProcessed,EntryPoint,ProcessedBy,ProcessedDate
				)
				Values(@EmpSalarySummaryID,@EmployeeID,@DepartmentID,@DesignationID,@ULCBranchID,@BankID,@BranchID,@BankAccountNo,
				@SalaryMonth,@SalaryYear,@FestivalBonus,@IsFBSelected,@EntryPoint,@ProcessedBy,GETDATE()
				);
			end
			else
			begin
				print 'Festival Bonus Process : Existing(Update)';
				/*
				Update tblEmpSalarySummary Set
				FestivalBonus=@FestivalBonus,IsFBProcessed = @IsFBSelected
				Where EmployeeID = @EmployeeID and SalaryMonth = @SalaryMonth and SalaryYear=@SalaryYear and IsFBProcessed = @IsFBSelected;
				*/
			end
		end

		IF @IsBaishakhiAllowanceSelected = 1
		begin
			print 'Baishakhi Allowance Process : Selected';
			If not exists (select * from tblEmpSalarySummary where EmployeeID = @EmployeeID and SalaryMonth= @SalaryMonth and SalaryYear=@SalaryYear and IsBaishakhiAllowanceProcessed = @IsBaishakhiAllowanceSelected)
			begin
				print 'Baishakhi Allowance Process : New';
				Insert into tblEmpSalarySummary(EmpSalarySummaryID,EmployeeID,DepartmentID,DesignationID,ULCBranchID,BankID,BranchID,BankAccountNo,
				SalaryMonth,SalaryYear,BaishakhiAllowance,IsBaishakhiAllowanceProcessed,EntryPoint,ProcessedBy,ProcessedDate
				)
				Values(@EmpSalarySummaryID,@EmployeeID,@DepartmentID,@DesignationID,@ULCBranchID,@BankID,@BranchID,@BankAccountNo,
				@SalaryMonth,@SalaryYear,@BaishakhiAllowance,@IsBaishakhiAllowanceSelected,@EntryPoint,@ProcessedBy,GETDATE()
				);
			end
			else
			begin
				print 'Baishakhi Allowance Process : Existing (Update)';
				/*
				Update tblEmpSalarySummary Set
				BaishakhiAllowance=@BaishakhiAllowance,IsBaishakhiAllowanceProcessed = @IsBaishakhiAllowanceSelected
				Where EmployeeID = @EmployeeID and SalaryMonth = @SalaryMonth and SalaryYear=@SalaryYear and IsBaishakhiAllowanceProcessed = @IsBaishakhiAllowanceSelected;
				*/
			end
		end

		update tblAppSettings set PropertyValue=@CurrentEmpSalarySummaryID where PropertyName='CurrentEmpSalarySummaryID'
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Set @Count += 1;
		Set @EmployeeID = '';
		Set @DepartmentID = NULL;
		Set @DesignationID = NULL;
		Set @ULCBranchID = NULL;
		Set @BankID = NULL;
		Set @BankAccountNo = NULL;
	end
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

-- exec spReverseSalary '20222811125638052339263092191'

GO

alter proc spReverseSalary
@EntryPoint nvarchar(50)
as
begin
	delete from tblEmpSalarySummary where EntryPoint=@EntryPoint And IsFinalized = 0;
end

GO

Create proc spFinalizeSalary
@EntryPoint nvarchar(50),
@FinalizedBy nvarchar(50)
as
begin
	Update tblEmpSalarySummary Set IsFinalized=1,FinalizedBy=@FinalizedBy,FinalizedDate=getdate()
	where EntryPoint=@EntryPoint And IsFinalized = 0;
end

GO

/*
select distinct EntryPoint from tblEmpSalarySummary;

select * from tblEmployeeInfo where EmployeeID='EMP-00000098';

select * from tblEmpSalaryProfile where  EmployeeID='EMP-00000098';
select * from tblEmpSalarySummary
delete from tblEmpSalarySummary
*/
