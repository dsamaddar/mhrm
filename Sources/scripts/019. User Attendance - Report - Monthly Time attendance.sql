
GO

-- drop function fnCountLateIn
alter function fnCountLateIn(@EmployeeID nvarchar(50),@Year int,@Month int)
returns int
as
begin

	Declare @EICount as int Set @EICount = 0
	Declare @MonthParam as nvarchar(50) Set @MonthParam = ''

	if @Month = 0
		set @MonthParam = '%'
	else
		set @MonthParam = '%'+ Convert(nvarchar,@Month) +'%'
		

	Declare @LateInTbl as table(
	LateInCount int
	);

	Insert into @LateInTbl
	select min(DATEDIFF(MINUTE,U.IdealLogTime,U.LogTime))
	from tblUserAttendance U Where EmployeeID=@EmployeeID
	And DATEPART(YEAR,LogTime)=@Year and Convert(nvarchar,DATEPART(MONTH,LogTime)) like @MonthParam
	group by DATEPART(DAY,U.LogTime)
	having min(DATEDIFF(MINUTE,U.IdealLogTime,U.LogTime)) > 0

	Select @EICount=Count(*) from @LateInTbl
	
	return ISNULL(@EICount,0);
end

--select dbo.fnCountLateIn('EMP-00000098',2017,2)

GO

alter function fnCountEarlyOut(@EmployeeID nvarchar(50),@Year int,@Month int)
returns int
as
begin

	Declare @EOCount as int Set @EOCount = 0
	Declare @MonthParam as nvarchar(50) Set @MonthParam = ''

	if @Month = 0
		set @MonthParam = '%'
	else
		set @MonthParam = '%'+ Convert(nvarchar,@Month) +'%'

	Declare @EarlyOutTbl as table(
	LateInCount int
	);

	Insert into @EarlyOutTbl
	select DATEDIFF(MINUTE,max(U.LogTime),ISNULL(MAX(U.IdealLogOutTime),Convert(datetime, convert(nvarchar,MAX(U.LogTime),101) + ' 04:00:00 PM')))
	from tblUserAttendance U Where EmployeeID=@EmployeeID
	And DATEPART(YEAR,LogTime)=@Year and Convert(nvarchar,DATEPART(MONTH,LogTime)) like @MonthParam
	group by DATEPART(DAY,U.LogTime)
	having DATEDIFF(MINUTE,max(U.LogTime),ISNULL(MAX(U.IdealLogOutTime),Convert(datetime, convert(nvarchar,MAX(U.LogTime),101) + ' 04:00:00 PM'))) > 0

	Select @EOCount=Count(*) from @EarlyOutTbl
	
	return ISNULL(@EOCount,0);
end

-- select dbo.fnCountEarlyOut('EMP-00000098',2017,0)

GO

alter function fnCountWorkingDay(@year int, @month int)
returns int
as
begin
	
	Declare @TotalWorkingDay as int Set @TotalWorkingDay = 0
	Declare @TotalHoliday as int Set @TotalHoliday = 0
	Declare @DaysInYear as int Set @DaysInYear = 0
	Declare @MonthParam as nvarchar(50) Set @MonthParam = ''

	if @Month = 0
	begin
		set @MonthParam = '%'
		Set @DaysInYear = DATEDIFF(DAY,DATEADD(DD,-DATEPART(DY,GETDATE())+1,GETDATE()), DATEADD(DD,-1,DATEADD(YY,DATEDIFF(YY,0,GETDATE())+1,0)))
	end
	else
	begin
		set @MonthParam = '%'+ Convert(nvarchar,@Month) +'%'
		Set @DaysInYear = DAY(EOMONTH(Convert(nvarchar,@month)+'/01/'+Convert(nvarchar,@year)))
	end

	select @TotalHoliday = Count(*)  from tblHolidays Where DATEPART(YEAR,HolidayDate)=@year
	and Convert(nvarchar,DATEPART(MONTH,HolidayDate)) like @MonthParam

	Set @TotalWorkingDay = @DaysInYear - @TotalHoliday
	
	return isnull(@TotalWorkingDay,0);
end

--select dbo.fnCountWorkingDay(2017,0)

GO

alter function fnCountWKH(@EmployeeID nvarchar(50),@Year int,@Month int)
returns numeric(18,2)
as
begin

	Declare @TotalWKH as numeric(18,2) Set @TotalWKH = 0
	Declare @MonthParam as nvarchar(50) Set @MonthParam = ''

	if @Month = 0
		set @MonthParam = '%'
	else
		set @MonthParam = '%'+ Convert(nvarchar,@Month) +'%'

	select @TotalWKH = @TotalWKH + Convert(numeric(18,2),DATEDIFF(MINUTE,min(U.LogTime),Max(U.LogTime)))
	from tblUserAttendance U Where EmployeeID=@EmployeeID
	And DATEPART(YEAR,LogTime)=@Year 
	and Convert(nvarchar,DATEPART(MONTH,LogTime)) like @MonthParam
	group by DATEPART(DAY,U.LogTime)

	return 	ISNULL(@TotalWKH,0)/60
end

-- select dbo.fnCountWKH('EMP-00000098',2017,0)


GO

alter function fnCountOnLeave(@EmployeeID nvarchar(50),@Year int,@Month int)
returns int
as
begin
	Declare @TotalOnLeave as numeric(18,2) Set @TotalOnLeave = 0
	Declare @MonthParam as nvarchar(50) Set @MonthParam = ''

	if @Month = 0
		set @MonthParam = '%'
	else
		set @MonthParam = '%'+ Convert(nvarchar,@Month) +'%'

	select @TotalOnLeave = Count(*) from tblLeaveDetails LD 
	Where EmployeeID=@EmployeeID
	and DATEPART(YEAR,LD.LeaveDate)=@Year 
	and Convert(nvarchar,DATEPART(MONTH,LD.LeaveDate)) like @MonthParam

	return @TotalOnLeave;
end

GO

-- select dbo.fnCountOnLeave('EMP-00000098',2017,0)

GO

alter proc spReportMonthlyAttSummary
@DesignationID nvarchar(50),
@year int,
@month int
as
begin

	Declare @ReportMonth as nvarchar(10) Set @ReportMonth = ''
	Declare @DesignationIDParam as nvarchar(50) set @DesignationIDParam = ''
	Declare @ParameterDate as date

	if @DesignationID = 'ALL'
		Set @DesignationIDParam = '%'
	else
		Set @DesignationIDParam = '%' + @DesignationID + '%'

	if @month = 0
		Set @ParameterDate = convert(nvarchar,DATEPART(MONTH,GETDATE()))+'/01/'+Convert(nvarchar,@year);
	else
		Set @ParameterDate = convert(nvarchar,@month)+'/01/'+Convert(nvarchar,@year);
	 
	Set @ReportMonth =  DATENAME(MONTH,@ParameterDate);

	Declare @WD as int Set @WD = 0
	Set @WD = dbo.fnCountWorkingDay(@year,@month)

	Select distinct E.EmpCode,E.EmployeeName as 'Employee',E.OfficialDesignation as 'Designation',ISNULL(E.DeptName,'N\A') as 'Department',
	dbo.fnCountLateIn(E.EmployeeID,@year,@month) as 'LI',
	dbo.fnCountEarlyOut(E.EmployeeID,@year,@month) as 'EO',
	dbo.fnCountOnLeave(E.EmployeeID,@year,@month) as 'LE',
	@WD as 'WD',
	dbo.fnCountWKH(E.EmployeeID,@year,@month) as 'WKH',
	@ReportMonth as 'ReportMonth'
	from vwEmpInfo E Where E.isActive = 1
	and E.OfficialDesignationID like @DesignationIDParam
	order by E.EmpCode
end

-- exec spReportMonthlyAttSummary 'ALL',2018,2






