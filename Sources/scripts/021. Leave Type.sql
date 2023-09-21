
CREATE TABLE tblLeaveType(
LeaveTypeID nvarchar(50) primary key,
LeaveType nvarchar(50) UNIQUE(LeaveType),
OnlyForMale bit default 0,
OnlyForFemale bit default 0,
IsDedFrmLeaveBalance bit default 1,
IsCarryForwardEnabled bit default 0,
YearlyBalanceForward int default 0,
MaxBalance int default 0,
IsActive bit default 1,
EntryBy nvarchar(50) default 'System',
EntryDate datetime default getdate()
);

GO

alter proc spShowLeaveType
as
begin
	Select LeaveTypeID,LeaveType,OnlyForMale,OnlyForFemale,IsDedFrmLeaveBalance,IsCarryForwardEnabled,
	YearlyBalanceForward,MaxBalance,IsActive,EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate'
	from tblLeaveType Order By LeaveType
end

GO

alter proc spInsertLeaveType
@LeaveType nvarchar(50),
@OnlyForMale bit,
@OnlyForFemale bit,
@IsDedFrmLeaveBalance bit,
@IsCarryForwardEnabled bit,
@YearlyBalanceForward int,
@MaxBalance int,
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @LeaveTypeID as nvarchar(50)
	Declare @CurrentLeaveTypeID numeric(18,0)
	Declare @LeaveTypeIDPrefix as nvarchar(11)

	set @LeaveTypeIDPrefix='LEAVE-TYPE-'

begin tran
	
	select @CurrentLeaveTypeID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentLeaveTypeID'
	
	set @CurrentLeaveTypeID=isnull(@CurrentLeaveTypeID,0)+1
	Select @LeaveTypeID=dbo.generateID(@LeaveTypeIDPrefix,@CurrentLeaveTypeID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	Insert into tblLeaveType(LeaveTypeID,LeaveType,OnlyForMale,OnlyForFemale,IsActive,IsDedFrmLeaveBalance,
	IsCarryForwardEnabled,YearlyBalanceForward,MaxBalance,EntryBy)
	Values(@LeaveTypeID,@LeaveType,@OnlyForMale,@OnlyForFemale,@IsActive,@IsDedFrmLeaveBalance,
	@IsCarryForwardEnabled,@YearlyBalanceForward,@MaxBalance,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	update tblAppSettings set PropertyValue=@CurrentLeaveTypeID where PropertyName='CurrentLeaveTypeID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

alter proc spShowLeaveTypeGenderWise
@EmployeeID nvarchar(50)
as
begin

	Declare @Gender as nvarchar(50)
	
	if exists(Select * from tblEmployeeInfo  Where EmployeeID=@EmployeeID)
	begin
		Select @Gender = Gender from  tblEmployeeInfo Where EmployeeID=@EmployeeID
				
		if @Gender='Male'
		begin
			Select LeaveTypeID,LeaveType + ' ( ' + Convert(nvarchar,dbo.fnGetLeaveBalByLeaveType(@EmployeeID,LeaveTypeID)) + ' ) ' as 'LeaveType'
			from tblLeaveType Where OnlyForMale = 1 And IsActive=1 and dbo.fnGetLeaveBalByLeaveType(@EmployeeID,LeaveTypeID) <> 0
		end
		else
			Select LeaveTypeID,LeaveType + ' (' + Convert(nvarchar,dbo.fnGetLeaveBalByLeaveType(@EmployeeID,LeaveTypeID)) + ' ) ' as 'LeaveType'
			from tblLeaveType Where OnlyForFemale = 1 And IsActive=1 and dbo.fnGetLeaveBalByLeaveType(@EmployeeID,LeaveTypeID) <> 0
	end
	else
		Select '' as LeaveTypeID, '' as LeaveType

end

GO

alter function fnGetLeaveBalByLeaveType(@EmployeeID as nvarchar(50),@LeaveTypeID as nvarchar(50))
returns int
as
begin
	Declare @LeaveBalance as int Set @LeaveBalance = 0
	Declare @LeaveType as nvarchar(50) Set @LeaveType = ''
	Select @LeaveType = LeaveType from tblLeaveType Where LeaveTypeID = @LeaveTypeID

	if @LeaveType = 'Casual Leave'
	begin
		select @LeaveBalance = ISNULL(CasualLeave,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else if @LeaveType = 'Medical Leave'
	begin
		select @LeaveBalance = ISNULL(MedicalLeave,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else if @LeaveType = 'Annual Leave'
	begin
		select @LeaveBalance = ISNULL(AnnualLeave,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else if @LeaveType = 'Maternity Leave'
	begin
		select @LeaveBalance = ISNULL(MaternityLeave,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else if @LeaveType = 'Leave Without Pay'
	begin
		select @LeaveBalance = ISNULL(LeaveWithOutPay,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else if @LeaveType = 'Special Leave'
	begin
		select @LeaveBalance = ISNULL(SpecialLeave,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else
	begin
		Set @LeaveBalance = 0
	end

	return @LeaveBalance
end

GO

Create function fnGetLeaveBalByLeaveTypes(@EmployeeID as nvarchar(50),@LeaveType as nvarchar(50))
returns int
as
begin
	Declare @LeaveBalance as int Set @LeaveBalance = 0

	if @LeaveType = 'Casual Leave'
	begin
		select @LeaveBalance = ISNULL(CasualLeave,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else if @LeaveType = 'Medical Leave'
	begin
		select @LeaveBalance = ISNULL(MedicalLeave,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else if @LeaveType = 'Annual Leave'
	begin
		select @LeaveBalance = ISNULL(AnnualLeave,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else if @LeaveType = 'Maternity Leave'
	begin
		select @LeaveBalance = ISNULL(MaternityLeave,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else if @LeaveType = 'Leave Without Pay'
	begin
		select @LeaveBalance = ISNULL(LeaveWithOutPay,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else if @LeaveType = 'Special Leave'
	begin
		select @LeaveBalance = ISNULL(SpecialLeave,0) from tblEmpLeaveBalance Where EmployeeID = @EmployeeID and IsActive=1
	end
	else
	begin
		Set @LeaveBalance = 0
	end

	return @LeaveBalance
end

GO

alter proc spUpdateLeaveType
@LeaveTypeID nvarchar(50),
@LeaveType nvarchar(50),
@OnlyForMale bit,
@OnlyForFemale bit,
@IsDedFrmLeaveBalance bit,
@IsCarryForwardEnabled bit,
@YearlyBalanceForward int,
@MaxBalance int,
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
begin tran
		UPDATE tblLeaveType
		   SET LeaveType = @LeaveType,OnlyForMale = @OnlyForMale,OnlyForFemale = @OnlyForFemale,
			  IsDedFrmLeaveBalance = @IsDedFrmLeaveBalance,IsCarryForwardEnabled = @IsCarryForwardEnabled,
			  YearlyBalanceForward = @YearlyBalanceForward,MaxBalance = @MaxBalance,
			  IsActive = @IsActive,EntryBy = @EntryBy
		 WHERE LeaveTypeID = @LeaveTypeID
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO
-- spInsertLeaveType @LeaveType,@OnlyForMale,@OnlyForFemale,@IsDedFrmLeaveBalance,@IsCarryForwardEnabled,@YearlyBalanceForward,@MaxBalance,@IsActive,@EntryBy
/*
exec spInsertLeaveType 'Casual Leave',1,1,1,0,0,0,1,'dsamaddar'
exec spInsertLeaveType 'Medical Leave',1,1,1,0,0,0,1,'dsamaddar'
exec spInsertLeaveType 'Annual Leave',1,1,1,0,0,0,1,'dsamaddar'
exec spInsertLeaveType 'Maternity Leave',1,1,1,0,0,0,1,'dsamaddar'
exec spInsertLeaveType 'Leave Without Pay',1,1,1,0,0,0,1,'dsamaddar'
exec spInsertLeaveType 'Special Leave',1,1,1,0,0,0,1,'dsamaddar'
*/