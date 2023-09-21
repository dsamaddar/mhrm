

alter proc spUsrAttLogIndex
as
begin
	Declare @AttendanceIDList as varchar(MAX) Set @AttendanceIDList = ''
	Declare @MaxLogIndex as numeric(18,0) Set @MaxLogIndex = 0
	
	Select @MaxLogIndex = isnull( max(LogIndex),0) from tblUserAttendance Where AttSystem='Thumb-Detection'
	
	Select  @AttendanceIDList=  @AttendanceIDList + '''' +AttendanceID +''',' from tblEmployeeInfo Where AttendanceID is not null 
	Set @AttendanceIDList = SUBSTRING(@AttendanceIDList,0,len(@AttendanceIDList))

	Select @MaxLogIndex as 'MaxLogIndex',@AttendanceIDList as 'AttendanceIDList'
end

-- exec spUsrAttLogIndex

GO


alter proc spInsertUserAttendance
@AttendanceID nvarchar(50),
@LogIndex numeric(18,0),
@LogTime datetime,
@NodeID int,
@AuthType int,
@SLogTime datetime
as
begin

	Declare @EmployeeID as nvarchar(50)
	Declare @UserID as nvarchar(50)
	Declare @IdeaTime as nvarchar(50)
	Declare @LogOutTime as nvarchar(50)
	Declare @IdealLoginTime as nvarchar(50)
	Declare @FinalIdealLoginTime as datetime
	Declare @IdealLogOutTime as nvarchar(50)
	Declare @FinalIdealLogOutTime as datetime

	Declare @DepartmentID as nvarchar(50)
	Declare @DesignationID as nvarchar(50)
	Declare @ULCBranchID as nvarchar(50)
	Declare @UserAttendanceID nvarchar(50)
	Declare @CurrentUserAttendanceID numeric(18,0)
	Declare @UserAttendanceIDPrefix as nvarchar(8)
	Declare @IdealLogTimeText as nvarchar(50)=''
	Declare @IdealLogOutTimeText as nvarchar(50)=''

	set @UserAttendanceIDPrefix='USR-ATT-'

begin tran
	
	if exists(
	Select * from tblEmployeeInfo Where AttendanceID=@AttendanceID
	)
	begin
		select @CurrentUserAttendanceID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentUserAttendanceID'
	
		set @CurrentUserAttendanceID=isnull(@CurrentUserAttendanceID,0)+1
		Select @UserAttendanceID=dbo.generateID(@UserAttendanceIDPrefix,@CurrentUserAttendanceID,8)		
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Select @IdeaTime = PropertyValue from tblAppSettings where  PropertyName='IdealLoginTime'
		Select @LogOutTime = PropertyValue from tblAppSettings where  PropertyName='IdealLogoutTime'

		Set @IdealLoginTime =CONVERT(VARCHAR(10), @LogTime, 101)+ ' ' + @IdeaTime
		Set @IdealLogOutTime =CONVERT(VARCHAR(10), @LogTime, 101)+ ' ' + @LogOutTime

		Select @EmployeeID=EmployeeID,@UserID = UserID,@DepartmentID=DepartmentID,@DesignationID=OfficialDesignationID,@ULCBranchID=ULCBranchID,
		@IdealLogTimeText= ISNULL(IdealLoginTime,''),@IdealLogOutTimeText=ISNULL(IdealLogOutTime,'')
		from tblEmployeeInfo Where AttendanceID=@AttendanceID

		If @IdealLogTimeText = ''
		begin
			Set @FinalIdealLoginTime = @IdealLoginTime
			Set @FinalIdealLogOutTime = @IdealLogOutTime
		end
		else
		begin
			Set @FinalIdealLoginTime = convert(datetime,Convert(nvarchar,@LogTime,101) +' ' + @IdealLogTimeText)
			Set @FinalIdealLogOutTime =  convert(datetime,Convert(nvarchar,@LogTime,101) +' ' + @IdealLogOutTimeText)
		end

		Insert into tblUserAttendance (UserAttendanceID,EmployeeID,UserID,DepartmentID,DesignationID,ULCBranchID,AttendanceID,LogIndex,LogTime,IdealLogTime,IdealLogOutTime,NodeID,AuthType,WorkStation,AttSystem,Remarks,EntryDate)
		Values(@UserAttendanceID,@EmployeeID,@UserID,@DepartmentID,@DesignationID,@ULCBranchID,@AttendanceID,@LogIndex,@LogTime,@FinalIdealLoginTime,@FinalIdealLogOutTime,@NodeID,@AuthType,'','Thumb-Detection','',@SLogTime)
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		update tblAppSettings set PropertyValue=@CurrentUserAttendanceID where PropertyName='CurrentUserAttendanceID'
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Select @IdealLoginTime
	end
	else
		Print CONCAT('Not Found : ',@AttendanceID);

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create function fnGetAttSystem(@EmployeeID nvarchar(50),@LogInTime datetime)
returns nvarchar(50)
as
begin
	Declare @AttSystem as nvarchar(50) Set @AttSystem = ''
	Select @AttSystem = AttSystem from tblUserAttendance Where EmployeeID=@EmployeeID And LogTime=@LogInTime
	return ISNULL(@AttSystem,'N\A')
end

GO


Create proc spGetUserAttendance
@EmployeeID nvarchar(50),
@DateFrom datetime,
@DateTo datetime
as
begin
	
	Set @DateFrom = Convert(datetime, convert(nvarchar,@DateFrom,101) + ' 01:00:00.000')
	Set @DateTo = Convert(datetime,convert(nvarchar,@DateTo,101) + ' 23:59:00.000')

	Declare @UsrAttTable table(
	UserID nvarchar(50),
	LogInTime datetime,
	LogOutTime datetime,
	DepartmentID nvarchar(50),
	ULCBranchID nvarchar(50),
	DesignationID nvarchar(50),
	Remarks nvarchar(500),
	WorkStation nvarchar(50),
	Status nvarchar(50)
	);

	Insert into @UsrAttTable(UserID,LogInTime,LogOutTime,DepartmentID,ULCBranchID,DesignationID,Remarks,WorkStation,Status)
	Select  U.UserID,min(U.LogTime),max(U.LogTime),U.DepartmentID,U.ULCBranchID,U.DesignationID,U.Remarks,U.WorkStation,
	Case When min(U.LogTime) > U.IdealLogTime Then 'Late (' + Convert(nvarchar, DATEDIFF(MINUTE,U.IdealLogTime,min(U.LogTime))) +' Mins)' Else 'Regular' End
	From tblUserAttendance U Where U.EmployeeID=@EmployeeID
	And U.LogTime between @DateFrom And @DateTo
	group by U.IdealLogTime,U.UserID,U.WorkStation,U.Remarks,U.DepartmentID,U.ULCBranchID,U.DesignationID
	--order by LogInTime

	Declare @MinTime as datetime 
	Declare @MaxTime as datetime
	Declare @TempDate as datetime

	Select @MinTime=min(LogInTime),@MaxTime=max(LogInTime) from @UsrAttTable

	Select UT.UserID,UT.LogInTime,UT.LogOutTime,UT.WorkStation,UT.Remarks,
	isnull((SElect DeptName from tblDepartment D Where D.DepartmentID=UT.DepartmentID ),'N\A') as 'Department',
	isnull((Select DesignationName from tblDesignation D Where D.DesignationID=UT.DesignationID),'N\A') as 'Designation',
	isnull((Select ULCBranchName from tblULCBranch UB Where UB.ULCBranchID=UT.ULCBranchID),'N\A') as 'Branch',
	Status,dbo.fnGetAttSystem(@EmployeeID,UT.LogInTime) as 'AttSystem' 
	from @UsrAttTable UT
	Where LogInTime= (
	Select min(LogInTime) from @UsrAttTable U Where U.UserID=UT.UserID And U.LogInTime 
	between Convert(datetime,convert(nvarchar,UT.LogInTime,101) + ' 01:00:00.000')
	And Convert(datetime,convert(nvarchar,UT.LogInTime,101) + ' 23:59:00.000'))
	order by UT.LogInTime

end

GO

alter proc spQueryOnAttendance
@EmployeeID nvarchar(50),
@DesignationID nvarchar(50),
@DepartmentID nvarchar(50),
@ULCBranchID nvarchar(50),
@NodeID nvarchar(50),
@DateFrom datetime,
@DateTo datetime
as
begin
	
	Set @DateFrom = Convert(datetime, convert(nvarchar,@DateFrom,101) + ' 01:00:00.000')
	Set @DateTo = Convert(datetime,convert(nvarchar,@DateTo,101) + ' 23:59:00.000')

	Declare @NodeIDParam as nvarchar(50) Set @NodeIDParam = ''
	Declare @EmployeeIDParam as nvarchar(50) Set @EmployeeIDParam = ''
	Declare @DesignationIDParam as nvarchar(50) Set @DesignationIDParam = ''
	Declare @DepartmentIDParam as nvarchar(50) Set @DepartmentIDParam = ''

	if @EmployeeID = 'ALL'
		Set @EmployeeIDParam = '%'
	else
		Set @EmployeeIDParam = '%' + @EmployeeID + '%'

	if @DesignationID = 'ALL'
		Set @DesignationIDParam = '%'
	else
		Set @DesignationIDParam = '%' + @DesignationID + '%'

	if @DepartmentID = 'ALL'
		Set @DepartmentIDParam = '%'
	else
		Set @DepartmentIDParam = '%' + @DepartmentID + '%'

	If @NodeID = 'ALL'
		Set @NodeIDParam = '%'
	else
		Set @NodeIDParam = '%'+ Convert(nvarchar,@NodeID) +'%'

	Select E.EmployeeName,E.EmpCode,E.OfficialDesignation as 'Designation',E.DeptName as 'Department',E.ULCBranchName as 'Branch',
	A.LogTime,N.NodeName
	from tblUserAttendance A INNER JOIN vwEmpInfo E ON A.EmployeeID=E.EmployeeID
	INNER JOIN tblNodes N ON A.NodeID = N.NodeCode
	Where A.EmployeeID like @EmployeeIDParam
	And E.OfficialDesignationID like @DesignationIDParam
	And E.DepartmentID like @DepartmentIDParam
	And A.NodeID like @NodeIDParam
	And (LogTime >= @DateFrom And LogTime <= @DateTo)
	order by E.EmpCode,A.LogTime
end

GO

-- exec spQueryOnAttendance 'ALL','ALL','ALL','ALL','ALL','1/15/2018','1/15/2018'