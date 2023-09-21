alter proc spGetZKAttLog
as
begin
	Declare @MaxLogID as int 
	select @MaxLogID = max(LogIndex) from tblUserAttendance where AttSystem='ZK';
	set @MaxLogID = isnull(@MaxLogID,0);

	select distinct c.LOGID as logindex,c.CHECKTIME as logtime,u.Badgenumber as userid,9 as nodeid,c.VERIFYCODE as authtype,c.entry_dt as slogtime
	from [zkmfildb].dbo.CHECKINOUT c 
	inner join [zkmfildb].dbo.USERINFO u on c.USERID = u.USERID
	inner join tblEmployeeInfo e on u.Badgenumber COLLATE SQL_Latin1_General_CP1_CI_AS = e.AttendanceID COLLATE SQL_Latin1_General_CP1_CI_AS
	where c.LOGID > @MaxLogID;
end

-- exec spGetZKAttLog
GO

alter proc spInsertZKUserAttendance
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
		Values(@UserAttendanceID,@EmployeeID,@UserID,@DepartmentID,@DesignationID,@ULCBranchID,@AttendanceID,@LogIndex,@LogTime,@FinalIdealLoginTime,@FinalIdealLogOutTime,@NodeID,@AuthType,'','ZK','',@SLogTime)
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

alter proc spMigrateUserAttendance
@AttendanceID nvarchar(50),
@LogIndex numeric(18,0),
@LogTime datetime,
@NodeID int,
@AuthType int,
@Workstation nvarchar(50),
@SLogTime datetime
as
begin
	SET NOCOUNT ON
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
		Values(@UserAttendanceID,@EmployeeID,@UserID,@DepartmentID,@DesignationID,@ULCBranchID,@AttendanceID,@LogIndex,@LogTime,@FinalIdealLoginTime,@FinalIdealLogOutTime,@NodeID,@AuthType,@Workstation,'Migration','',@SLogTime)
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		update tblAppSettings set PropertyValue=@CurrentUserAttendanceID where PropertyName='CurrentUserAttendanceID'
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

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


/* Data Migration Starts*/

SET NOCOUNT ON

declare @count as int Set @count = 0
declare @ncount as int set @ncount = 0

declare @raw_tbl as table(
sl int identity(1,1),
uname nvarchar(50),
login_time datetime,
workstation nvarchar(50),
attendance_id nvarchar(50),
is_taken bit default 0
);

insert into @raw_tbl(uname,login_time,workstation,attendance_id)
select u.UserName,convert(datetime,CONVERT(VARCHAR(10),LoginDate,101) + ' ' + CONVERT(VARCHAR(12),LoginTime,108)),
a.LoginWSIP,e.AttendanceID
from [pc_att].dbo.UserInformation u 
inner join [pc_att].dbo.AttendanceDetails a on u.UserID = a.UserID
inner join [MHRM].dbo.tblEmployeeInfo e on u.UserName = e.UserID
where u.Active = 'Y' and u.UserName='Mahmud'

select @ncount = count(*) from @raw_tbl;
declare @sl as int set @sl = 0;
declare @uname as nvarchar(50) set @uname = ''
declare @log_time as datetime
declare @workstation as nvarchar(50) set @workstation = ''
declare @attendance_id as nvarchar(50) set @attendance_id = ''
declare @current_dt as datetime set @current_dt = getdate();

while @count < @ncount
begin
	
	select top 1 @sl=sl,@uname = uname,@log_time = login_time, @workstation = workstation,@attendance_id=attendance_id
	from @raw_tbl where is_taken = 0

	exec spMigrateUserAttendance @attendance_id,0,@log_time,0,2,@workstation,@current_dt;
	
	print @sl;

	update @raw_tbl set is_taken = 1 where sl = @sl;
	set @count += 1;
end


/* Data Migration Ends*/
