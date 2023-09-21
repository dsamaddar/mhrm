
select dbo.fnCountLateInYearly('EMP-00000098',2018)

GO

alter function fnCountLateInYearly(@EmployeeID nvarchar(50),@Year int)
returns int
as
begin

	Declare @EICount as int Set @EICount = 0
	Declare @MonthParam as nvarchar(50) Set @MonthParam = ''

	Declare @LateInTbl as table(
	LateInCount int
	);

	Insert into @LateInTbl
	select min(DATEDIFF(MINUTE,U.IdealLogTime,U.LogTime))
	from tblUserAttendance U Where EmployeeID=@EmployeeID
	And DATEPART(YEAR,LogTime)=@Year
	group by convert(nvarchar,U.LogTime,106)
	having min(DATEDIFF(MINUTE,U.IdealLogTime,U.LogTime)) > 0

	Select @EICount=Count(*) from @LateInTbl
	
	return ISNULL(@EICount,0);
end

GO


--select dbo.fnCountEarlyOutYearly('EMP-00000098',2018)

GO

alter function fnCountEarlyOutYearly(@EmployeeID nvarchar(50),@Year int)
returns int
as
begin

	Declare @EOCount as int Set @EOCount = 0

	Declare @EarlyOutTbl as table(
	LateInCount int
	);

	Insert into @EarlyOutTbl
	select DATEDIFF(MINUTE,max(U.LogTime),ISNULL(MAX(U.IdealLogOutTime),Convert(datetime, convert(nvarchar,MAX(U.LogTime),101) + ' 04:00:00 PM')))
	from tblUserAttendance U Where EmployeeID=@EmployeeID
	And DATEPART(YEAR,LogTime)=@Year
	group by convert(nvarchar,U.LogTime,106)
	having DATEDIFF(MINUTE,max(U.LogTime),ISNULL(MAX(U.IdealLogOutTime),Convert(datetime, convert(nvarchar,MAX(U.LogTime),101) + ' 04:00:00 PM'))) > 0

	Select @EOCount=Count(*) from @EarlyOutTbl
	
	return ISNULL(@EOCount,0);
end


GO

alter function fnCountOnLeaveYearly(@EmployeeID nvarchar(50),@Year int)
returns int
as
begin
	Declare @TotalOnLeave as numeric(18,2) Set @TotalOnLeave = 0

	select @TotalOnLeave = Count(distinct LeaveDate) from tblLeaveDetails LD 
	Where EmployeeID=@EmployeeID
	and DATEPART(YEAR,LD.LeaveDate)=@Year

	return @TotalOnLeave;
end

select dbo.fnCountOnLeaveYearly('EMP-00000107',2018);
select * from tblLeaveDetails where EmployeeID = 'EMP-00000107';

GO

--select * from fnGetLeaveNatureYearly(2018)

GO

alter function fnGetLeaveNatureYearly(@Year int)
returns @LeaveNature table(
	EmployeeID nvarchar(50),
	CL int,
	AL int,
	ML int,
	MAL int,
	LWP int,
	SL int
)
as
begin
	
	Declare @Count as int Set @Count = 1;
	Declare @NCount as int Set @NCount = 0;
	Declare @CountCL as int Set @CountCL = 0;
	Declare @CountAL as int Set @CountAL = 0;
	Declare @CountML as int Set @CountML = 0;
	Declare @CountMAL as int Set @CountMAL = 0;
	Declare @CountLWP as int Set @CountLWP = 0;
	Declare @CountSL as int Set @CountSL = 0;
	Declare @EmployeeID as nvarchar(50) Set @EmployeeID = '';

	Declare @EmpData as table(
	EmployeeID nvarchar(50),
	Taken bit default 0
	);

	Insert into @EmpData(EmployeeID)
	Select EmployeeID from tblEmployeeInfo Where isActive=1;

	select @NCount=Count(*) from @EmpData;

	Declare @leaveStatus as table(
	LeaveCount int,
	LeaveType nvarchar(50)
	);

	While @Count <= @NCount
	begin
		Select top 1 @EmployeeID=EmployeeID from @EmpData Where Taken = 0;

		delete from @leaveStatus;

		Insert Into @leaveStatus
		Select SUM(LR.TotalWorkingDays),LT.ShortCode from tblLeaveRequest LR INNER JOIN tblLeaveType LT ON LR.LeaveTypeID = LT.LeaveTypeID
		Where LR.EmployeeID = @EmployeeID
		And DATEPART(YEAR,LeaveFrom) = @Year
		And LR.IsApproved = 1
		group by LT.ShortCode;

		Select  @CountCL = LeaveCount from @leaveStatus Where LeaveType = 'CL';
		Select  @CountAL = LeaveCount from @leaveStatus Where LeaveType = 'AL';
		Select  @CountML = LeaveCount from @leaveStatus Where LeaveType = 'ML';
		Select  @CountMAL = LeaveCount from @leaveStatus Where LeaveType = 'MAL';
		Select  @CountLWP = LeaveCount from @leaveStatus Where LeaveType = 'LWP';
		Select  @CountSL = LeaveCount from @leaveStatus Where LeaveType = 'SL';

		Insert Into @LeaveNature(EmployeeID,CL,AL,ML,MAL,LWP,SL)
		Values(@EmployeeID,@CountCL,@CountAL,@CountML,@CountMAL,@CountLWP,@CountSL)

		Set @Count = @Count + 1;
		update @EmpData Set Taken = 1 Where EmployeeID = @EmployeeID;
		Set @EmployeeID = '';
		Set @CountCL = 0;
		Set @CountAL = 0;
		Set @CountML = 0;
		Set @CountMAL = 0;
		Set @CountLWP = 0;
		Set @CountSL = 0;
	end

	return;
end

GO


/*
-- Configure ORAOLEDB.Oracle provider so that runs in process within SQL Server
exec master.dbo.sp_MSset_oledb_prop 'ORAOLEDB.Oracle', N'AllowInProcess', 1

-- Add a Linked Server
sp_addlinkedserver 
 @server = 'ULTIMUS'
,@srvproduct = 'refldb'
,@provider = 'OraOLEDB.Oracle'
,@datasrc = '192.168.0.3'
*/


Create proc spGetEmpPerformance
@Year int
as
begin
	select EI.EmployeeName,EI.EmpCode,EI.OfficialDesignation,EI.DeptName,dbo.fnGetAgeC(EI.JoiningDate,GETDATE()) 'ServiceLife',
	dbo.fnCountLateInYearly(EI.EmployeeID,@Year) as 'LateIn',dbo.fnCountEarlyOutYearly(EI.EmployeeID,2018) as 'EarlyOut',
	dbo.fnCountOnLeaveYearly(EI.EmployeeID,@Year) as 'CountOnLeave',L.AL,L.CL,L.ML,L.SL,L.MAL,L.LWP
	from vwEmpInfo EI INNER JOIN dbo.fnGetLeaveNatureYearly(@Year) L ON EI.EmployeeID = L.EmployeeID
	Where EI.isActive = 1 
	order by EI.EmpCode
End

-- exec spGetEmpPerformance 2018

