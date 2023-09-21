alter proc spInsertAdminAttendance
@EmployeeID nvarchar(50),
@LogTime datetime,
@IdealLogTime datetime,
@DateTo datetime,
@Remarks nvarchar(500),
@DocumentReference nvarchar(200),
@EntryBy nvarchar(50)
as
begin

	Declare @UserID as nvarchar(50)
	Declare @IdeaTime as nvarchar(50)
	Declare @DepartmentID as nvarchar(50)
	Declare @DesignationID as nvarchar(50)
	Declare @ULCBranchID as nvarchar(50)
	Declare @AttendanceID as nvarchar(50)
	
	Declare @IdealLogOutTime datetime
	Declare @IdealLogOut nvarchar(50)
	Declare @UserAttendanceID nvarchar(50)
	Declare @CurrentUserAttendanceID numeric(18,0)
	Declare @UserAttendanceIDPrefix as nvarchar(8)
	Declare @CountDate as int Set @CountDate = 0
	Declare @Count as int Set @Count = 1
	set @UserAttendanceIDPrefix='USR-ATT-'

begin tran

	Set @CountDate = DATEDIFF(dd,convert(nvarchar,@LogTime,101),convert(nvarchar,@DateTo,101)) + 1
	
	select @CurrentUserAttendanceID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentUserAttendanceID'
	select @IdealLogOut = PropertyValue from tblAppSettings Where PropertyName='IdealLogoutTime'
	
	Set @IdealLogOutTime = convert(datetime, Convert(nvarchar,@LogTime,101) + ' ' + @IdealLogOut )

	while @Count <= @CountDate
	begin
		
		if not exists(Select HolidayID from tblHolidays Where Convert(nvarchar,HolidayDate,101)= convert(nvarchar,@logTime,101)  )
		And dateName(dw,@logTime) <>'Friday' And dateName(dw,@logTime) <> 'Saturday' 
		begin
			set @CurrentUserAttendanceID=isnull(@CurrentUserAttendanceID,0)+1
			Select @UserAttendanceID=dbo.generateID(@UserAttendanceIDPrefix,@CurrentUserAttendanceID,8)		
			IF (@@ERROR <> 0) GOTO ERR_HANDLER

			Select @UserID = UserID,@AttendanceID=AttendanceID,@DepartmentID=DepartmentID,@DesignationID=OfficialDesignationID,@ULCBranchID=ULCBranchID 
			from tblEmployeeInfo Where EmployeeID=@EmployeeID

			Insert into tblUserAttendance (UserAttendanceID,EmployeeID,UserID,DepartmentID,DesignationID,ULCBranchID,AttendanceID,LogIndex,LogTime,IdealLogTime,IdealLogOutTime,NodeID,WorkStation,AttSystem,Remarks,DocumentReference,EntryBy)
			Values(@UserAttendanceID,@EmployeeID,@UserID,@DepartmentID,@DesignationID,@ULCBranchID,@AttendanceID,0,@LogTime,@IdealLogTime,@IdealLogOutTime,0,'','Admin',@Remarks,@DocumentReference,@EntryBy)
			IF (@@ERROR <> 0) GOTO ERR_HANDLER
		end
		
		Set @Count = @Count + 1
		Set @LogTime =  DATEADD(dd,1,@LogTime)
		Set @IdealLogTime = convert(datetime, Convert(nvarchar,@LogTime,101) + ' 10:00:00 AM' )
		Set @IdealLogOutTime = convert(datetime, Convert(nvarchar,@LogTime,101) + ' ' + @IdealLogOut )
	end
	
	update tblAppSettings set PropertyValue=@CurrentUserAttendanceID where PropertyName='CurrentUserAttendanceID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spGetUserAttInputByAdmin
@EmployeeID nvarchar(50)
as
begin
	
	Select UA.UserAttendanceID,UA.UserID,UA.AttendanceID,Convert(nvarchar,UA.LogTime,100) as 'LogTime',
	convert(nvarchar,UA.IdealLogTime,100) as 'IdealLogTime',EI.EmployeeName,EI.EmpCode,
	UA.Remarks,
	isnull((SElect DeptName from tblDepartment D Where D.DepartmentID=UA.DepartmentID ),'N\A') as 'Department',
	isnull((Select DesignationName from tblDesignation D Where D.DesignationID=UA.DesignationID),'N\A') as 'Designation',
	isnull((Select ULCBranchName from tblULCBranch UB Where UB.ULCBranchID=UA.ULCBranchID),'N\A') as 'Branch',
	WorkStation,UA.AttSystem,
	Case UA.NodeID When  1 Then 'Motijheel'
				Else 'N\A' End as 'Location',
	Case When UA.IdealLogTime< UA.LogTime Then 'Late (' + Convert(nvarchar, datediff(MINUTE,IdealLogTime,logTime)) + 'mins )'
		 Else '' end as 'Status', UA.DocumentReference
	from tblUserAttendance UA left join tblEmployeeInfo EI On EI.EmployeeID=UA.EmployeeID
	Where  UA.EmployeeID= @EmployeeID And AttSystem='Admin'
	order by LogTime desc

end