Create proc spGetActiveLateAttCause
as
begin
	Select LateAttCauseID,Cause from tblLateAttCause Where IsActive=1
	Order by Cause
end

GO

alter proc spInsertUsrAttBySupervisor
@OutOfOfficeReqID nvarchar(50),
@EmployeeID nvarchar(50),
@LogTime datetime,
@EntryBy nvarchar(50)
as
begin
	Declare @UserID as nvarchar(50)
	Declare @IdeaTime as nvarchar(50)
	Declare @IdealLoginTime as nvarchar(50)
	Declare @FinalIdealLoginTime as datetime
	Declare @IdealLogTimeText as nvarchar(50)=''

	Declare @DepartmentID as nvarchar(50)
	Declare @DesignationID as nvarchar(50)
	Declare @ULCBranchID as nvarchar(50)
	Declare @AttendanceID as nvarchar(50) Set @AttendanceID = ''
	Declare @Attachment as nvarchar(200) Set @Attachment = ''
	Declare @Remarks as nvarchar(500) Set @Remarks = ''
	Declare @UserAttendanceID nvarchar(50)
	Declare @CurrentUserAttendanceID numeric(18,0)
	Declare @UserAttendanceIDPrefix as nvarchar(8)
	Declare @IdealLogOutTime datetime
	Declare @IdealLogOut nvarchar(50) Set @IdealLogOut = ''

	set @UserAttendanceIDPrefix='USR-ATT-'

begin tran
	
	Select @Attachment=Attachment,@Remarks=Remarks from tblOutOfOfficeReq Where OutOfOfficeReqID=@OutOfOfficeReqID

	select @CurrentUserAttendanceID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentUserAttendanceID'
	
	set @CurrentUserAttendanceID=isnull(@CurrentUserAttendanceID,0)+1
	Select @UserAttendanceID=dbo.generateID(@UserAttendanceIDPrefix,@CurrentUserAttendanceID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Select @IdeaTime = PropertyValue from tblAppSettings where  PropertyName='IdealLoginTime'
	select @IdealLogOut = PropertyValue from tblAppSettings Where PropertyName='IdealLogoutTime'

	Set @IdealLoginTime =CONVERT(VARCHAR(10), @LogTime, 101)+ ' ' + @IdeaTime
	Set @IdealLogOutTime = convert(datetime, Convert(nvarchar,@LogTime,101) + ' ' + @IdealLogOut )

	Select @EmployeeID=EmployeeID,@UserID = UserID,@DepartmentID=DepartmentID,@DesignationID=OfficialDesignationID,@ULCBranchID=ULCBranchID,
	@AttendanceID=AttendanceID,@IdealLogTimeText= ISNULL(IdealLoginTime,'')
	from tblEmployeeInfo Where EmployeeID=@EmployeeID

	If @IdealLogTimeText = ''
			Set @FinalIdealLoginTime = @IdealLoginTime
		else
			Set @FinalIdealLoginTime = convert(datetime,Convert(nvarchar,@LogTime,101) +' ' + @IdealLogTimeText)

	Insert into tblUserAttendance (UserAttendanceID,EmployeeID,UserID,DepartmentID,DesignationID,ULCBranchID,AttendanceID,LogIndex,LogTime,IdealLogTime,IdealLogOutTime,NodeID,WorkStation,AttSystem,Remarks,DocumentReference,OutOfOfficeReqID,EntryBy)
	Values(@UserAttendanceID,@EmployeeID,@UserID,@DepartmentID,@DesignationID,@ULCBranchID,@AttendanceID,0,@LogTime,@FinalIdealLoginTime,@IdealLogOutTime,0,'Supervisor-PC','Supervisor',@Remarks,@Attachment,@OutOfOfficeReqID,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentUserAttendanceID where PropertyName='CurrentUserAttendanceID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Select @IdealLoginTime

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spInsertOutOfOfficeReq
@EmployeeID nvarchar(50),
@LateAttCauseID nvarchar(50),
@DateFrom datetime,
@DateTo datetime,
@Remarks nvarchar(500),
@Attachment nvarchar(200),
@EntryBy nvarchar(50)
as
begin
	
	Declare @OutOfOfficeReqID nvarchar(50)
	Declare @CurrentOutOfOfficeReqID numeric(18,0)
	Declare @OutOfOfficeReqIDPrefix as nvarchar(8)
	Declare @ApproverID as nvarchar(50) Set @ApproverID = ''
	set @OutOfOfficeReqIDPrefix='OUT-OFC-'
		
begin tran

	SElect @ApproverID=CurrentSupervisor from tblEmployeeInfo Where EmployeeID=@EmployeeID
	
	select @CurrentOutOfOfficeReqID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentOutOfOfficeReqID'
	
	set @CurrentOutOfOfficeReqID=isnull(@CurrentOutOfOfficeReqID,0)+1
	Select @OutOfOfficeReqID=dbo.generateID(@OutOfOfficeReqIDPrefix,@CurrentOutOfOfficeReqID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblOutOfOfficeReq(OutOfOfficeReqID,EmployeeID,LateAttCauseID,DateFrom,DateTo,Remarks,Attachment,ApproverID,EntryBy)
	Values(@OutOfOfficeReqID,@EmployeeID,@LateAttCauseID,@DateFrom,@DateTo,@Remarks,@Attachment,@ApproverID,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentOutOfOfficeReqID where PropertyName='CurrentOutOfOfficeReqID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

alter proc spApproveOutOfOfficeReq
@OutOfOfficeReqID nvarchar(50),
@ApproverRemarks nvarchar(500),
@EventName nvarchar(50),
@EntryBy nvarchar(50)
as
begin
	Declare @DateFrom as datetime
	Declare @DateTo as datetime
	Declare @MaidenDate as datetime
	Declare @EmployeeID as nvarchar(50)
	Declare @Count as int Set @Count=1
	Declare @NCount as int Set @NCount=0
begin tran

	if @EventName = 'Approved'
	begin
		Update tblOutOfOfficeReq Set IsApproved=1,ApproverRemarks=@ApproverRemarks,ApprovalDate=getdate()
		Where OutOfOfficeReqID=@OutOfOfficeReqID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

		Select @DateFrom=DateFrom,@DateTo=DateTo,@EmployeeID=EmployeeID from tblOutOfOfficeReq Where OutOfOfficeReqID=@OutOfOfficeReqID

		Set @MaidenDate =  CONVERT(VARCHAR(10), @DateFrom, 101) + ' ' + '09:30:00 AM'
		Set @NCount = datediff(dd,@DateFrom,@DateTo) + 1

		While @Count <= @NCount
		begin
			if not exists (
				Select *  from tblHolidays  where convert(date, CONVERT(nvarchar,@MaidenDate,101))=convert(date, CONVERT(nvarchar,HolidayDate,101)) 
				)
			begin
				if (datepart(weekday,@MaidenDate)!=6 and datepart(weekday,@MaidenDate)!=7)
				begin
					--exec spInsertUsrAttBySupervisor @OutOfOfficeReqID,@EmployeeID,@MaidenDate,@EntryBy
					exec spInsertUsrAttBySupervisor @OutOfOfficeReqID,@EmployeeID,@DateFrom,@EntryBy
					IF (@@ERROR <> 0) GOTO ERR_HANDLER

					exec spInsertUsrAttBySupervisor @OutOfOfficeReqID,@EmployeeID,@DateTo,@EntryBy
					IF (@@ERROR <> 0) GOTO ERR_HANDLER
				end
			end
			Set @MaidenDate = DATEADD(dd,1,@MaidenDate)
			Set @Count = @Count + 1
		end
	end
	else
	begin
		Update tblOutOfOfficeReq Set IsRejected=1,RejectionDate=getdate(),RejectionRemarks=@ApproverRemarks,RejectedBy=@EntryBy
		Where OutOfOfficeReqID=@OutOfOfficeReqID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
	end
	
COMMIT TRAN
RETURN 0
ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

alter proc spGetOutOfOfficeReqSubmitted
@EmployeeID nvarchar(50),
@DateFrom datetime,
@DateTo datetime,
@LateAttCauseID nvarchar(200),
@Remarks nvarchar(500)
as
begin
	Declare @MailBody as nvarchar(4000) Set @MailBody = ''
	Declare @MailSubject as nvarchar(200) Set @MailSubject = ''
	Declare @MailTo as nvarchar(50) Set @MailTo = ''
	Declare @MailFrom as nvarchar(50) Set @MailFrom =''
	Declare @MailCC as nvarchar(50) Set @MailCC = ''
	Declare @EHRMLink  as nvarchar(500) Set @EHRMLink = 'http://192.168.11.241/mhrm/frmhrmlogin.aspx'

	Declare @LateAttCause as nvarchar(200) Set @LateAttCause = ''
	Declare @EmployeeName as nvarchar(200) Set @EmployeeName = ''
	Declare @CurrentSupervisor as nvarchar(50) Set @CurrentSupervisor = ''
	
	Select @LateAttCause=Cause from tblLateAttCause Where LateAttCauseID = @LateAttCauseID
	Select @EmployeeName=EmployeeName,@CurrentSupervisor=CurrentSupervisor   from tblEmployeeInfo Where EmployeeID=@EmployeeID

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr>
		<th>Date From</th>
		<th>Date To</th>
		<th>Cause</th>
		<th>Remarks</th>
	</tr>
	<tr>
		<td>' + Convert(nvarchar,@DateFrom,106) + '</td>
		<td>' + Convert(nvarchar,@DateTo,106) + '</td>
		<td>' + @LateAttCause + '</td>
		<td>' + @Remarks + '</td>
	</tr>
	<tr>
		<td colspan=''2''>MHRM</td>
		<td colspan=''2''><a href='+@EHRMLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	Set @MailSubject = 'MHRM : Out Of Office Request From ('+@EmployeeName+') : Need Approval '
	Select @MailFrom = Email from tblEmployeeInfo Where EmployeeID=@EmployeeID
	Select @MailTo = Email from tblEmployeeInfo Where EmployeeID=@CurrentSupervisor
	Set @MailCC = 'divit@meridianfinance.com'

	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'divit@meridianfinance.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'divit@meridianfinance.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'divit@meridianfinance.com' else @MailCC end as 'MailCC',
	'dsamaddar@meridianfinance.com' as 'MailBCC'

end

GO

alter proc spGetOutOfOfficeReqApprovedMail
@OutOfOfficeReqID nvarchar(50),
@ApproverRemarks nvarchar(500),
@EventName nvarchar(50)
as
begin

	Declare @MailBody as nvarchar(4000) Set @MailBody = ''
	Declare @MailSubject as nvarchar(200) Set @MailSubject = ''
	Declare @MailTo as nvarchar(50) Set @MailTo = ''
	Declare @MailFrom as nvarchar(50) Set @MailFrom =''
	Declare @MailCC as nvarchar(50) Set @MailCC = ''
	Declare @EHRMLink  as nvarchar(500) Set @EHRMLink = 'http://192.168.11.241/mhrm/frmhrmlogin.aspx'

	Declare @LateAttCauseID as nvarchar(50)
	Declare @EmployeeID as nvarchar(50)
	Declare @DateFrom as datetime
	Declare @DateTo as datetime
	Declare @Remarks as nvarchar(500)
	Declare @LateAttCause as nvarchar(200) Set @LateAttCause = ''
	Declare @EmployeeName as nvarchar(200) Set @EmployeeName = ''
	Declare @SupervisorName as nvarchar(200) Set @SupervisorName = ''
	Declare @CurrentSupervisor as nvarchar(50) Set @CurrentSupervisor = ''
	Declare @FunctionalDesignation as nvarchar(200) Set @FunctionalDesignation = ''
	
	Select @LateAttCauseID=LateAttCauseID,@EmployeeID=EmployeeID,@DateFrom=DateFrom,@DateTo=DateTo,@Remarks=Remarks from tblOutOfOfficeReq Where OutOfOfficeReqID=@OutOfOfficeReqID
	Select @LateAttCause=Cause from tblLateAttCause Where LateAttCauseID = @LateAttCauseID
	Select @EmployeeName=EmployeeName,@CurrentSupervisor=CurrentSupervisor   from tblEmployeeInfo Where EmployeeID=@EmployeeID
	Select @SupervisorName = EmployeeName,@FunctionalDesignation=dbo.fnGetDesignationName(FunctionalDesignationID) from tblEmployeeInfo Where EmployeeID=@CurrentSupervisor

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr>
		<th>Date From</th>
		<th>Date To</th>
		<th>Cause</th>
		<th>Remarks</th>
		<th>Approver Remarks</>
	</tr>
	<tr>
		<td>' + Convert(nvarchar,@DateFrom,106) + '</td>
		<td>' + Convert(nvarchar,@DateTo,106) + '</td>
		<td>' + @LateAttCause + '</td>
		<td>' + @Remarks + '</td>
		<td>' + @ApproverRemarks + '</td>
	</tr>
	<tr>
		<td colspan=''2''>MHRM</td>
		<td colspan=''3''><a href='+@EHRMLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	if @EventName = 'Approved'
	begin
		Set @MailSubject = 'EHRM : Out Of Office Request From ('+@EmployeeName+') : Approved By: ( '+ @FunctionalDesignation +' )' 
		Select @MailFrom =Email from tblEmployeeInfo Where EmployeeID=@CurrentSupervisor
		Select @MailTo =Email from tblEmployeeInfo Where EmployeeID=@EmployeeID
		Set @MailCC = 'divit@meridianfinance.com'
	end
	else
	begin
		Set @MailSubject = 'EHRM : Out Of Office Request From ('+@EmployeeName+') : Rejected By: ( ' + @FunctionalDesignation + ' )'
		Select @MailFrom =Email from tblEmployeeInfo Where EmployeeID=@CurrentSupervisor
		Select @MailTo =Email from tblEmployeeInfo Where EmployeeID=@EmployeeID
		Set @MailCC = 'divit@meridianfinance.com'
	end

	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'divit@meridianfinance.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'divit@meridianfinance.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'divit@meridianfinance.com' else @MailCC end as 'MailCC',
	'dsamaddar@meridianfinance.com' as 'MailBCC'

end

GO

alter proc spGetPendingOutOfOfficeReq
@ApproverID nvarchar(50)
as
begin
	Select OOR.OutOfOfficeReqID,
	(Select EmployeeName from tblEmployeeInfo Where EmployeeID = OOR.EmployeeID) as 'EmployeeName',
	LAC.Cause,Convert(nvarchar,OOR.DateFrom,106) as 'DateFrom',
	Convert(nvarchar,OOR.DateTo,106) as 'DateTo',OOR.Remarks,
	Case OOR.Attachment When '' Then 'na.jpg' Else OOR.Attachment end as 'Attachment'
	from tblOutOfOfficeReq OOR inner Join tblLateAttCause LAC On OOR.LateAttCauseID=LAC.LateAttCauseID
	Where ApproverID=@ApproverID And IsApproved=0 And IsRejected=0
end

-- exec spGetPendingOutOfOfficeReq 'EMP-00000020'

GO

Create proc spGetOutOfOfficeReqByUser
@EmployeeID nvarchar(50)
as
begin
	Select OOR.OutOfOfficeReqID,LAC.Cause,Convert(nvarchar,OOR.DateFrom,106) as 'DateFrom',
	Convert(nvarchar,OOR.DateTo,106) as 'DateTo',OOR.Remarks,
	Case OOR.Attachment When '' Then 'na.jpg' Else OOR.Attachment end as 'Attachment',
	Case OOR.IsApproved When 1 Then 'YES' Else 'NO' end as 'IsApproved'
	from tblOutOfOfficeReq OOR left Join tblLateAttCause LAC On OOR.LateAttCauseID=LAC.LateAttCauseID
	Where OOR.EmployeeID = @EmployeeID
	order by OOR.DateFrom desc
end