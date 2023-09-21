
--select dbo.fnGetAttStatus('EMP-00000009','10/27/2019')

alter function fnGetAttStatus(@EmployeeID nvarchar(50), @AttDate DATE)
returns nvarchar(20)
as
begin

	Declare @AttStatus as nvarchar(20) Set @AttStatus= ''
	Declare @LateIn as int Set @LateIn = 0
	Declare @EarlyOut as int Set @EarlyOut = 0

	if exists(select * from tblUserAttendance Where EmployeeID = @EmployeeID and Convert(nvarchar,LogTime,106)=Convert(nvarchar,@AttDate,106))
	begin
		if exists (select min(DATEDIFF(MINUTE,U.IdealLogTime,U.LogTime)) from tblUserAttendance U Where EmployeeID=@EmployeeID
					And Convert(nvarchar,LogTime,106)=Convert(nvarchar,@AttDate,106)
					group by DATEPART(DAY,U.LogTime)
					having min(DATEDIFF(MINUTE,U.IdealLogTime,U.LogTime)) > 0
				  )
				  begin
						Set @AttStatus = @AttStatus + 'Late'
				  end

		if exists(
					select DATEDIFF(MINUTE,max(U.LogTime),ISNULL(MAX(U.IdealLogOutTime),Convert(datetime, convert(nvarchar,MAX(U.LogTime),101) + ' 04:00:00 PM')))
					from tblUserAttendance U Where EmployeeID=@EmployeeID
					And Convert(nvarchar,LogTime,106)=Convert(nvarchar,@AttDate,106)
					group by DATEPART(DAY,U.LogTime)
					having DATEDIFF(MINUTE,max(U.LogTime),ISNULL(MAX(U.IdealLogOutTime),Convert(datetime, convert(nvarchar,MAX(U.LogTime),101) + ' 04:00:00 PM'))) > 0
		)
				begin
					if @AttStatus = ''
					begin
						Set @AttStatus = @AttStatus + 'Early'
					end
					else
					begin
						Set @AttStatus = @AttStatus + ',Early'
					end
						
				end
		if @AttStatus = ''
		begin
			Set @AttStatus = 'Regular'
		end

		else if exists(
			Select * from tblHolidays Where convert(nvarchar,HolidayDate,103)=convert(nvarchar,@AttDate,103)
		)
		begin
			Set @AttStatus += ',Holiday'
		end
	end
	else
	begin
		
		if exists(
			select * from tblLeaveDetails Where EmployeeID = @EmployeeID and convert(nvarchar,LeaveDate,103) =convert(nvarchar,@AttDate,103) 
		)
		begin
			Declare @LShortCode as nvarchar(50) Set @LShortCode = ''
			select @LShortCode=ISNULL(LT.ShortCode,'')
			from tblLeaveDetails LD INNER JOIN tblLeaveRequest LR ON LD.LeaveRequestID=LR.LeaveRequestID
			INNER JOIN tblLeaveType LT ON LR.LeaveTypeID = LT.LeaveTypeID
			Where LD.EmployeeID = @EmployeeID and convert(nvarchar,LeaveDate,103) =convert(nvarchar,@AttDate,103)
			Set @AttStatus = 'on Leave - ' + ISNULL(@LShortCode,'')
		end
		else if exists(
			Select * from tblHolidays Where convert(nvarchar,HolidayDate,103)=convert(nvarchar,@AttDate,103)
		)
		begin
			Set @AttStatus = 'Holiday';
		end
		else if exists(Select * from tblEmployeeInfo Where EmployeeID=@EmployeeID And JoiningDate > @AttDate)
		begin
			Set @AttStatus = 'Unemployed';
		end
		else
			Set @AttStatus = 'Absent';
	end


	return ISNULL(@AttStatus,'-')
end

GO
-- select dbo.fnGetLeaveReqStatus('EMP-00000009','11/3/2019')

alter function fnGetLeaveReqStatus(@EmployeeID nvarchar(50), @AttDate DATE)
returns nvarchar(20)
as
begin
	if exists (select * from tblLeaveRequest where EmployeeID=@EmployeeID 
	and @AttDate between LeaveFrom and LeaveTo)
	begin
		return ',Requested';
	end

	return ',Pending';
end

GO

select * from dbo.fnGetAbsentInfo('ALL','ALL','ALL','ALL','10/19/2021','10/19/2021','ALL','ALL');

alter function fnGetAbsentInfo(
@EmployeeID nvarchar(50),@DepartmentID nvarchar(50),@BranchID nvarchar(50),@DesignationID nvarchar(50),
@DateFrom date,@DateTo date,@EmpTypeID nvarchar(50),@AttStatus nvarchar(50)
)
returns @AttTbl table(
	IndividualEmp nvarchar(200),
	ID nvarchar(50),
	Employee nvarchar(200),
	Designation nvarchar(50),
	Department nvarchar(50),
	Branch nvarchar(50),
	TimeIn datetime,
	TimeOuts datetime,
	Remarks nvarchar(50)
)
as
begin

	Declare @EmpID as nvarchar(50) Set @EmpID = ''
	Declare @EmployeeIDParam as nvarchar(50) Set @EmployeeIDParam = ''
	Declare @DepartmentIDParam as nvarchar(50) Set @DepartmentIDParam = ''
	Declare @AttStatusParam as nvarchar(50) Set @AttStatusParam = ''
	Declare @DateFromParam as datetime
	Declare @DateToParam as datetime
	Declare @BranchIDParam as nvarchar(50) set @BranchIDParam = ''
	Declare @DesignationIDParam as nvarchar(50) set @DesignationIDParam = ''
	Declare @EmpTypeIDParam as nvarchar(50) Set @EmpTypeIDParam = ''
	Declare @IndividualEmp as nvarchar(50) Set @IndividualEmp = ''

	if @DepartmentID = 'ALL'
		Set @DepartmentIDParam = '%'
	else
		Set @DepartmentIDParam = '%' + @DepartmentID + '%'

	if @DesignationID = 'ALL'
		Set @DesignationIDParam = '%'
	else
		Set @DesignationIDParam = '%' + @DesignationID + '%'

	if @EmployeeID = 'ALL'
	begin
		Set @EmployeeIDParam = '%'
		Set @IndividualEmp = 'ALL'
	end
	else
	begin
		Set @EmployeeIDParam = '%' + @EmployeeID + '%'
		Select @IndividualEmp =EmployeeName from tblEmployeeInfo Where EmployeeID = @EmployeeID
	end

	if @BranchID= 'ALL'
		Set @BranchIDParam = '%'
	else
		Set @BranchIDParam = '%' + @BranchID + '%';

	if @EmpTypeID = 'ALL'
		Set @EmpTypeIDParam = '%'
	else
		Set @EmpTypeIDParam = '%'+ @EmpTypeID +'%'

	Set @DateFromParam = Convert(datetime,Convert(nvarchar,@DateFrom,101) + ' 12:01:01 AM')
	Set @DateToParam = Convert(datetime, Convert(nvarchar,@DateTo,101) + ' 11:59:59 PM')

	declare @emptbl table(
	EmployeeID nvarchar(50),
	IsTaken bit default 0
	)

	--print 'A'
	
	Insert into @emptbl(EmployeeID)
	Select EmployeeID
	from vwEmpInfo V
	where V.isActive = 1 and V.IncludedInPayroll = 1 
	And V.DepartmentID like @DepartmentIDParam
	And V.EmployeeID like @EmployeeIDParam
	And V.ULCBranchID like @BranchIDParam
	And V.OfficialDesignationID like @DesignationIDParam
	And V.EmpTypeID like @EmpTypeIDParam

	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0
	Declare @TempDate as datetime

	select @NCount = Count(*) from @emptbl

	--print convert(nvarchar,@NCount)
	Declare @AttendanceStatus as nvarchar(50) Set @AttendanceStatus = ''

	While @Count <= @NCount
	begin
		
		Select top 1 @EmpID=EmployeeID from @emptbl Where IsTaken=0
		Set @TempDate = @DateFromParam
		--print 'B'
		While @TempDate <= @DateToParam
		begin
			Set @AttendanceStatus = dbo.fnGetAttStatus(@EmpID,@TempDate)
			if @AttendanceStatus = 'Absent' or  @AttendanceStatus = 'Unemployed'
			begin
				Set @AttendanceStatus = @AttendanceStatus + dbo.fnGetLeaveReqStatus(@EmpID,@TempDate)
				Insert into @AttTbl(IndividualEmp,ID,Employee,Designation,Department,Branch,TimeIn,TimeOuts,Remarks)
				select @IndividualEmp,V.EmpCode,V.EmployeeName,V.OfficialDesignation,V.DeptName,V.ULCBranchName,@TempDate,@TempDate,@AttendanceStatus
				from vwEmpInfo V Where EmployeeID = @EmpID
			end

			Set @TempDate = DATEADD(DAY,1,@TempDate);
		end

		Update @emptbl Set IsTaken = 1 Where EmployeeID = @EmpID
		Set @EmpID = ''
		Set @Count += 1
	end

	return;
end

GO


alter function fnGetAttendanceInfoDateRange(
@EmployeeID nvarchar(50),@DepartmentID nvarchar(50),@BranchID nvarchar(50),@DesignationID nvarchar(50),
@DateFrom date,@DateTo date,@EmpTypeID nvarchar(50),@AttStatus nvarchar(50)
)
returns @AttTbl table(
	IndividualEmp nvarchar(200),
	ID nvarchar(50),
	Employee nvarchar(200),
	Designation nvarchar(50),
	Department nvarchar(50),
	Branch nvarchar(50),
	TimeIn datetime,
	TimeOuts datetime,
	Remarks nvarchar(50)
)
as
begin

	Declare @EmpID as nvarchar(50) Set @EmpID = ''
	Declare @EmployeeIDParam as nvarchar(50) Set @EmployeeIDParam = ''
	Declare @DepartmentIDParam as nvarchar(50) Set @DepartmentIDParam = ''
	Declare @AttStatusParam as nvarchar(50) Set @AttStatusParam = ''
	Declare @DateFromParam as datetime
	Declare @DateToParam as datetime
	Declare @BranchIDParam as nvarchar(50) set @BranchIDParam = ''
	Declare @DesignationIDParam as nvarchar(50) set @DesignationIDParam = ''
	Declare @EmpTypeIDParam as nvarchar(50) Set @EmpTypeIDParam = ''
	Declare @IndividualEmp as nvarchar(50) Set @IndividualEmp = ''

	if @DepartmentID = 'ALL'
		Set @DepartmentIDParam = '%'
	else
		Set @DepartmentIDParam = '%' + @DepartmentID + '%'

	if @DesignationID = 'ALL'
		Set @DesignationIDParam = '%'
	else
		Set @DesignationIDParam = '%' + @DesignationID + '%'

	if @EmployeeID = 'ALL'
	begin
		Set @EmployeeIDParam = '%'
		Set @IndividualEmp = 'ALL'
	end
	else
	begin
		Set @EmployeeIDParam = '%' + @EmployeeID + '%'
		Select @IndividualEmp =EmployeeName from tblEmployeeInfo Where EmployeeID = @EmployeeID
	end

	if @BranchID= 'ALL'
		Set @BranchIDParam = '%'
	else
		Set @BranchIDParam = '%' + @BranchID + '%';

	if @EmpTypeID = 'ALL'
		Set @EmpTypeIDParam = '%'
	else
		Set @EmpTypeIDParam = '%'+ @EmpTypeID +'%'

	Set @DateFromParam = Convert(datetime,Convert(nvarchar,@DateFrom,101) + ' 12:01:01 AM')
	Set @DateToParam = Convert(datetime, Convert(nvarchar,@DateTo,101) + ' 11:59:59 PM')

	declare @emptbl table(
	EmployeeID nvarchar(50),
	IsTaken bit default 0
	)

	--print 'A'
	
	Insert into @emptbl(EmployeeID)
	Select EmployeeID
	from vwEmpInfo V
	where V.isActive = 1 and V.IncludedInPayroll = 1 
	And V.DepartmentID like @DepartmentIDParam
	And V.EmployeeID like @EmployeeIDParam
	And V.ULCBranchID like @BranchIDParam
	And V.OfficialDesignationID like @DesignationIDParam
	And V.EmpTypeID like @EmpTypeIDParam

	Declare @Count as int Set @Count = 1
	Declare @NCount as int Set @NCount = 0
	Declare @TempDate as datetime

	select @NCount = Count(*) from @emptbl

	--print convert(nvarchar,@NCount)
	Declare @AttendanceStatus as nvarchar(50) Set @AttendanceStatus = ''

	While @Count <= @NCount
	begin
		Select top 1 @EmpID=EmployeeID from @emptbl Where IsTaken=0
		Set @TempDate = @DateFromParam
		--print 'B'
		While @TempDate <= @DateToParam
		begin
			Set @AttendanceStatus = dbo.fnGetAttStatus(@EmpID,@TempDate)
			--Set @AttendanceStatus = @AttendanceStatus + dbo.fnGetLeaveReqStatus(@EmpID,@TempDate)
			Insert into @AttTbl(IndividualEmp,ID,Employee,Designation,Department,Branch,TimeIn,TimeOuts,Remarks)
			select @IndividualEmp,V.EmpCode,V.EmployeeName,V.OfficialDesignation,V.DeptName,V.ULCBranchName,@TempDate,@TempDate,@AttendanceStatus
			from vwEmpInfo V Where EmployeeID = @EmpID
			
			Set @TempDate = DATEADD(DAY,1,@TempDate);
		end

		Update @emptbl Set IsTaken = 1 Where EmployeeID = @EmpID
		Set @EmpID = ''
		Set @Count += 1
	end

	return;
end

GO

Create table tblReportQuery(
ReportID int identity(1,1) primary key,
ReportName nvarchar(100),
ReportParameters nvarchar(2000),
QueryDate datetime default getdate()
);

GO
-- exec spReportDailyAtt 'ALL','ALL','ALL','ALL','10/19/2021','10/19/2021','ALL','ALL'
alter proc spReportDailyAtt
@EmployeeID nvarchar(50),
@DepartmentID nvarchar(50),
@BranchID nvarchar(50),
@DesignationID nvarchar(50),
@DateFrom date,
@DateTo date,
@EmpTypeID nvarchar(50),
@AttStatus nvarchar(50)
as
begin
	
	Insert Into tblReportQuery(ReportName,ReportParameters) 
	VALUES ('Daily Attendance','EmployeeID : ' + @EmployeeID + ' DepartmentID : ' + @DepartmentID + ' BranchID : ' + @BranchID
	+ ' DesignationID : ' + @DesignationID + ' DateFrom : ' + Convert(nvarchar,@DateFrom,106) + ' DateTo : ' 
	+ Convert(nvarchar,@DateTo,106) + ' AttStatus : ' + @AttStatus);


	Declare @EmployeeIDParam as nvarchar(50) Set @EmployeeIDParam = ''
	Declare @DepartmentIDParam as nvarchar(50) Set @DepartmentIDParam = ''
	Declare @AttStatusParam as nvarchar(50) Set @AttStatusParam = ''
	Declare @DateFromParam as datetime
	Declare @DateToParam as datetime
	Declare @JoiningDate as date
	Declare @BranchIDParam as nvarchar(50) set @BranchIDParam = ''
	Declare @DesignationIDParam as nvarchar(50) set @DesignationIDParam = ''
	Declare @EmpTypeIDParam as nvarchar(50) Set @EmpTypeIDParam = ''
	Declare @IndividualEmp as nvarchar(50) Set @IndividualEmp = ''

	Set @DateFromParam = Convert(datetime,Convert(nvarchar,@DateFrom,101) + ' 12:01:01 AM')
	Set @DateToParam = Convert(datetime, Convert(nvarchar,@DateTo,101) + ' 11:59:59 PM')

	if @DepartmentID = 'ALL'
		Set @DepartmentIDParam = '%'
	else
		Set @DepartmentIDParam = '%' + @DepartmentID + '%'

	if @DesignationID = 'ALL'
		Set @DesignationIDParam = '%'
	else
		Set @DesignationIDParam = '%' + @DesignationID + '%'

	if @EmployeeID = 'ALL'
	begin
		Set @EmployeeIDParam = '%'
		Set @IndividualEmp = 'ALL'
	end
	else
	begin
		Set @EmployeeIDParam = '%' + @EmployeeID + '%'
		Select @IndividualEmp =EmployeeName from tblEmployeeInfo Where EmployeeID = @EmployeeID
	end

	if @AttStatus = 'ALL'
		Set @AttStatusParam = '%'
	else
		Set @AttStatusParam = '%' + @AttStatus + '%'

	if @BranchID= 'ALL'
		Set @BranchIDParam = '%'
	else
		Set @BranchIDParam = '%' + @BranchID + '%';

	if @EmpTypeID = 'ALL'
		Set @EmpTypeIDParam = '%'
	else
		Set @EmpTypeIDParam = '%'+ @EmpTypeID +'%'

	select @IndividualEmp as 'IndividualEmp',V.EmpCode as 'ID', V.EmployeeName as 'Employee',V.OfficialDesignation as 'Designation',V.DeptName as 'Department',V.ULCBranchName as 'Branch',
	MIN(U.LogTime) as 'TimeIn', MAX(U.LogTime) as 'TimeOut',dbo.fnGetAttStatus(V.EmployeeID,Convert(nvarchar,U.LogTime,101)) as 'Remarks'
	from vwEmpInfo V inner JOIN tblUserAttendance U 
	ON V.EmployeeID = U.EmployeeID
	And U.LogTime between @DateFromParam and @DateToParam
	where V.isActive = 1 and V.IncludedInPayroll = 1 
	And V.DepartmentID like @DepartmentIDParam
	And V.EmployeeID like @EmployeeIDParam
	And V.ULCBranchID like @BranchIDParam
	And V.OfficialDesignationID like @DesignationIDParam
	And V.EmpTypeID like @EmpTypeIDParam
	And dbo.fnGetAttStatus(V.EmployeeID,Convert(nvarchar,U.LogTime,101)) like @AttStatusParam
	--And Convert(date,V.JoiningDate) >= Convert(date,@DateFrom)
	group by V.EmpCode, V.EmployeeName,V.EmployeeID,V.OfficialDesignation,V.DeptName,Convert(nvarchar,U.LogTime,101),V.ULCBranchName
	--order by V.EmpCode,Designation,Department
	UNION ALL
	select @IndividualEmp as 'IndividualEmp',V.EmpCode as 'ID', V.EmployeeName as 'Employee',V.OfficialDesignation as 'Designation',V.DeptName as 'Department',V.ULCBranchName as 'Branch',
	LD.LeaveDate as 'TimeIn',LD.LeaveDate as 'TimeOut',dbo.fnGetAttStatus(LD.EmployeeID,LD.LeaveDate) as 'Remarks'--'on Leave' as 'Remarks'
	from vwEmpInfo V inner JOIN tblLeaveDetails LD ON V.EmployeeID=LD.EmployeeID And LD.LeaveDate between @DateFromParam and @DateToParam
	where V.isActive = 1 and V.IncludedInPayroll = 1 
	And V.DepartmentID like @DepartmentIDParam
	And V.EmployeeID like @EmployeeIDParam
	And V.ULCBranchID like @BranchIDParam
	And V.OfficialDesignationID like @DesignationIDParam
	And V.EmpTypeID like @EmpTypeIDParam
	--And Convert(date,V.JoiningDate) >= Convert(date,@DateFrom)
	And dbo.fnGetAttStatus(V.EmployeeID,Convert(nvarchar,LD.LeaveDate,101)) like @AttStatusParam
	UNION ALL
	Select * from dbo.fnGetAbsentInfo(@EmployeeID,@DepartmentID,@BranchID,@DesignationID,@DateFrom,@DateTo,@EmpTypeID,@AttStatus)
	Where Remarks like @AttStatusParam
	order by V.EmpCode,Designation,Department,TimeIn

end

-- exec spReportDailyAtt 'ALL','ALL','ALL','ALL','02/01/2018','02/05/2018','ALL','ALL'
--select * from tblEmployeeInfo where EmployeeName like '%nazmul%'

go

-- exec spReporYearlyAttStatus 'EMP-00000354','2019','Absent'
alter proc spReporYearlyAttStatus
@EmployeeID nvarchar(50),
@Year nvarchar(4),
@AttStatus nvarchar(50)
as
begin
	
	Declare @AttStatusParam as nvarchar(50) Set @AttStatusParam = ''
	Declare @DateFrom as datetime
	Declare @DateTo as datetime

	Set @DateFrom = convert(datetime,'01/01/'+ @Year + ' 12:01:01 AM')
	Set @DateTo = convert(datetime,'12/31/'+ @Year + ' 11:59:59 PM')

	if @DateTo > CURRENT_TIMESTAMP
		set @DateTo = CURRENT_TIMESTAMP

	if @AttStatus = 'ALL'
		Set @AttStatusParam = '%'
	else
		Set @AttStatusParam = '%' + @AttStatus + '%'

	Select A.IndividualEmp,A.ID,A.Designation,A.Department,A.Branch,Convert(nvarchar,A.TimeIn,106) as 'Dated',A.Remarks
	from dbo.fnGetAttendanceInfoDateRange(@EmployeeID,'%','%','%',@DateFrom,@DateTo,'%',@AttStatus) A
	Where Remarks like @AttStatusParam

end


--Select * from dbo.fnGetAttendanceInfoDateRange('EMP-00000074','%','%','%','01/01/2020','7/9/2020','%','ALL')
--Select * from dbo.fnGetAttendanceInfoDateRange('EMP-00000098','%','%','%','01/01/2020','7/9/2020','%','ALL')