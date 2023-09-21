
alter proc spGetLeaveSettingsInfoByID
@LeaveTypeID nvarchar(50)
as
begin
		SELECT LeaveTypeID,LeaveType,OnlyForMale,OnlyForFemale,IsDedFrmLeaveBalance,IsCarryForwardEnabled,
		YearlyBalanceForward,MaxBalance,IsActive,EntryBy,EntryDate
		FROM tblLeaveType where LeaveTypeID=@LeaveTypeID
end

GO

Create  procedure prCalculateDays
@FromDateInput datetime,
@ToDateInput datetime
as
begin
	declare @TotalApplied as int
	Declare @ToDateext as datetime
	Declare @TotalHolidays as int
	declare @CurrentDate as datetime
	declare @flag as int
	
	set @CurrentDate = @FromDateInput   
	
		set @ToDateext=dateadd(day,1,@ToDateInput)
		set @TotalApplied=datediff(day,@FromDateInput,@ToDateext)
		set @TotalHolidays=0
	
	while @CurrentDate<=@ToDateInput
	begin
		set @flag=0
		--if exists (Select HolidayID  from tblHolidays  where @CurrentDate>=DateFrom and @CurrentDate<=DateTo)
		if exists (Select HolidayID  from tblHolidays  where @CurrentDate=HolidayDate)
		begin
			set @TotalHolidays = @TotalHolidays + 1
			set @flag=1
		end
	
		if @flag=0 and (datepart(weekday,@CurrentDate)=6 or datepart(weekday,@CurrentDate)=7)
			set @TotalHolidays = @TotalHolidays + 1	
	
		set @CurrentDate=dateadd(day,1,@CurrentDate)
	end

	Select @TotalApplied Applied,@TotalHolidays Holidays,(@TotalApplied-@TotalHolidays) LeaveDays

end

GO

Create Proc spGetApproverRecommender
@EmployeeID as nvarchar(50)
as
Declare @Approver as nvarchar(200)=''
Declare @ApproverID as nvarchar(50)=''
Declare @Recommender as nvarchar(200)=''
Declare @RecommenderID as nvarchar(50)=''
begin	
		select @ApproverID=LeaveApprover from tblEmployeeInfo where EmployeeID=@EmployeeID
		select @RecommenderID=LeaveRecommender from tblEmployeeInfo where EmployeeID=@EmployeeID  

		select @Approver=EmployeeName from tblEmployeeInfo where EmployeeID=@ApproverID
		select @Recommender=EmployeeName from tblEmployeeInfo where EmployeeID=@RecommenderID

		select @ApproverID ApproverID,case when @Approver='' then 'N\A' else @Approver end Approver,isnull(@RecommenderID,'') RecommenderID,
		case when @Recommender='' then 'N\A' else @Recommender end Recommender
end

GO
