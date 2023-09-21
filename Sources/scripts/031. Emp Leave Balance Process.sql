/*
Select dbo.fnGetNewLeaveBalByType('EMP-00000031','Female','Casual Leave') as 'Casual Leave'
Select dbo.fnGetNewLeaveBalByType('EMP-00000038','Female','Annual Leave') as 'Annual Leave'
Select dbo.fnGetNewLeaveBalByType('EMP-00000038','Female','Medical Leave') as 'Medical Leave'
Select dbo.fnGetNewLeaveBalByType('EMP-00000038','Female','Maternity Leave') as 'Maternity Leave'
Select dbo.fnGetNewLeaveBalByType('EMP-00000038','Female','Special Leave') as 'Special Leave'
Select dbo.fnGetNewLeaveBalByType('EMP-00000038','Female','Leave Without Pay') as 'Leave Without Pay'
*/
--select * from tblLeaveType Where LeaveType='Casual Leave'

GO

select dbo.fnRecalcLeaveBalance('EMP-00000001',2023,5);

alter function fnRecalcLeaveBalance(@EmployeeID as nvarchar(50),@LeaveYear int,@YearlyBalanceForward int)
returns numeric(5,2)
as
begin
	declare @joining_dt as date;
	declare @end_dt as date set @end_dt = convert(date,'12/31/'+convert(nvarchar,@LeaveYear-1));
	declare @total_month as numeric(5,2) set @total_month = 0;
	declare @prev_balance as numeric(5,2) set @prev_balance = 0;

	select @joining_dt = JoiningDate from tblEmployeeInfo where EmployeeID = @EmployeeID;
	set @total_month = DATEDIFF(YEAR,@joining_dt,@end_dt);
	set @prev_balance = (@total_month/1.00)*@YearlyBalanceForward;

	return @prev_balance;
end

GO

alter function fnGetNewLeaveBalByType(@EmployeeID as nvarchar(50),@Gender nvarchar(10),@LeaveType as nvarchar(50))
returns int
as
begin
	Declare @CurrentLeaveBal as int Set @CurrentLeaveBal = 0
	Declare @NewBal as int Set @NewBal = 0
	Declare @OnlyForMale as bit Set @OnlyForMale = 0
	Declare @OnlyForFemale as bit Set @OnlyForFemale = 0
	Declare @IsDedFrmLeaveBalance as bit Set @IsDedFrmLeaveBalance = 0
	Declare @IsCarryForwardEnabled as bit Set @IsCarryForwardEnabled = 0
	Declare @YearlyBalanceForward as int Set @YearlyBalanceForward = 0
	Declare @MaxBalance as int Set @MaxBalance = 0

	
	Set @CurrentLeaveBal = dbo.fnGetLeaveBalByLeaveTypes(@EmployeeID,@LeaveType)
			
	Select @OnlyForMale=OnlyForMale,@OnlyForFemale=OnlyForFemale,@IsCarryForwardEnabled=IsCarryForwardEnabled,
	@YearlyBalanceForward=YearlyBalanceForward,@MaxBalance=MaxBalance
	from tblLeaveType Where LeaveType=@LeaveType

	If @OnlyForMale = 1 And @Gender='Male'
	begin
		If @IsCarryForwardEnabled = 1
		begin
			Set @NewBal = @CurrentLeaveBal + @YearlyBalanceForward

			If @NewBal > @MaxBalance
				Set @NewBal = @MaxBalance
		end
		else
			Set @NewBal = @YearlyBalanceForward
	end
	else if @OnlyForFemale = 1 And @Gender='Female'
	begin
		If @IsCarryForwardEnabled = 1
		begin
			Set @NewBal = @CurrentLeaveBal + @YearlyBalanceForward

			If @NewBal > @MaxBalance
				Set @NewBal = @MaxBalance
		end
		else
			Set @NewBal = @YearlyBalanceForward
	end
	else
		Set @NewBal = 0

	return ISNULL(@NewBal,0)
end

GO

-- exec spProcessYearlyLeaveBalance 2018,'dsamaddar'
alter proc spProcessYearlyLeaveBalance
@LeaveYear int,
@EntryBy nvarchar(50)
as
begin
	
	Declare @EmpTbl as table(
	EmployeeID nvarchar(50),
	Gender nvarchar(10),
	Taken bit default 0
	);

	Declare @EmployeeID as nvarchar(50) Set @EmployeeID = ''
	Declare @Gender as nvarchar(50) Set @Gender = ''
	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0

	Declare @CasualBal as int Set @CasualBal = 0
	Declare @MedicalBal as int Set @MedicalBal = 0
	Declare @AnnualBal as int Set @AnnualBal = 0
	Declare @MaternityBal as int Set @MaternityBal = 0
	Declare @LWPBal as int Set @LWPBal = 0
	Declare @SpecialBal as int Set @SpecialBal = 0

BEGIN TRY

	BEGIN TRAN
		Insert Into @EmpTbl (EmployeeID,Gender)
		Select EmployeeID,Gender from tblEmployeeInfo Where isActive=1

		Select @NCount = Count(*) from @EmpTbl

		While @Count <= @NCount
		begin
			Select top 1 @EmployeeID=EmployeeID,@Gender=Gender from @EmpTbl Where Taken = 0

			Set @CasualBal = dbo.fnGetNewLeaveBalByType(@EmployeeID,@Gender,'Casual Leave');
			Set @MedicalBal = dbo.fnGetNewLeaveBalByType(@EmployeeID,@Gender,'Medical Leave');
			Set @AnnualBal = dbo.fnGetNewLeaveBalByType(@EmployeeID,@Gender,'Annual Leave');
			Set @MaternityBal = dbo.fnGetNewLeaveBalByType(@EmployeeID,@Gender,'Maternity Leave');
			Set @LWPBal = dbo.fnGetNewLeaveBalByType(@EmployeeID,@Gender,'Leave Without Pay');
			Set @SpecialBal = dbo.fnGetNewLeaveBalByType(@EmployeeID,@Gender,'Special Leave');

			Update tblEmpLeaveBalance Set IsActive = 0 Where EmployeeID = @EmployeeID And IsActive = 1

			exec spInsertEmpLeaveBalance @EmployeeID,@CasualBal,@MedicalBal,@AnnualBal,@MaternityBal,@LWPBal,@SpecialBal,@LeaveYear,@EntryBy
		
			Update @EmpTbl Set Taken = 1 Where EmployeeID = @EmployeeID
			Set @EmployeeID = ''
			Set @Gender = ''
			Set @Count = @Count + 1
		end
	COMMIT TRAN

END TRY
BEGIN CATCH
	--PRINT 'C';
	if @@trancount <> 0
		ROLLBACK TRANSACTION
	THROW
END CATCH
end