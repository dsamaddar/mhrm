
Create proc spGetActiveHRServices
as
begin
	Select HRServiceID,HRService from tblHRServices Where IsActive=1 Order by HRService
end

GO

Create proc spGetHRServiceInstruction
@HRServiceID nvarchar(50)
as
begin
	Select isnull(HRServiceReqInstruction,'N\A') as 'HRServiceReqInstruction' from tblHRServices Where HRServiceID=@HRServiceID
end

GO

Create proc spInsertHRServices
@HRService nvarchar(200),
@HRServiceReqInstruction nvarchar(500),
@IsActive bit,
@SeqPriority int,
@EntryBy nvarchar(50)
as
begin
	
	Declare @HRServiceID nvarchar(50)
	Declare @CurrentHRServiceID numeric(18,0)
	Declare @HRServiceIDPrefix as nvarchar(4)

	set @HRServiceIDPrefix='HRS-'

begin tran
	
	select @CurrentHRServiceID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentHRServiceID'
	
	set @CurrentHRServiceID=isnull(@CurrentHRServiceID,0)+1
	Select @HRServiceID=dbo.generateID(@HRServiceIDPrefix,@CurrentHRServiceID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblHRServices(HRServiceID,HRService,HRServiceReqInstruction,IsActive,SeqPriority,EntryBy)
	Values(@HRServiceID,@HRService,@HRServiceReqInstruction,@IsActive,@SeqPriority,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentHRServiceID where PropertyName='CurrentHRServiceID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spGetHRServiceList
as
begin
	Select HRServiceID,HRService,isnull(HRServiceReqInstruction,'N\A') as 'HRServiceReqInstruction',
	case IsActive When 1 then 'YES' else 'NO' end as 'IsActive',SeqPriority,EntryBy
	from tblHRServices Order by HRService
end

GO

/********************************************************* HR Service ISSUE **************************************/
GO

Create proc spGetHRServiceRequest
as
begin
	Select SI.HRServiceIssueID,EI.EmployeeName,S.HRService,Convert(nvarchar,SI.EffectiveDate,106) as 'EffectiveDate',
	SI.Remarks,Convert(nvarchar,SI.EntryDate,106) as 'RequestedOn'
	from tblHRServiceIssue SI left Join tblHRServices S On SI.HRServiceID=S.HRServiceID
	left Join tblEmployeeInfo EI On SI.EmployeeID=EI.EmployeeID
	Where IsServiceProvided=0 And IsRejected=0 
	order by SI.EntryDate asc
end

GO

Create proc spInsertHRServiceIssue
@HRServiceID nvarchar(50),
@EmployeeID nvarchar(50),
@EffectiveDate datetime,
@Remarks nvarchar(500),
@EntryBy nvarchar(50)
as
begin

	Declare @HRServiceIssueID nvarchar(50)
	Declare @CurrentHRServiceIssueID numeric(18,0)
	Declare @HRServiceIssueIDPrefix as nvarchar(6)
	Declare @ServiceStatus as nvarchar(50) Set @ServiceStatus = 'Requested'
	set @HRServiceIssueIDPrefix='HRS-I-'

begin tran
	
	select @CurrentHRServiceIssueID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentHRServiceIssueID'
	
	set @CurrentHRServiceIssueID=isnull(@CurrentHRServiceIssueID,0)+1
	Select @HRServiceIssueID=dbo.generateID(@HRServiceIssueIDPrefix,@CurrentHRServiceIssueID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblHRServiceIssue(HRServiceIssueID,HRServiceID,EmployeeID,EffectiveDate,Remarks,ServiceStatus,EntryBy)
	Values(@HRServiceIssueID,@HRServiceID,@EmployeeID,@EffectiveDate,@Remarks,@ServiceStatus,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentHRServiceIssueID where PropertyName='CurrentHRServiceIssueID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spGetHRServiceIssueByEmp
@EmployeeID nvarchar(50)
as
begin
	select SI.HRServiceIssueID,S.HRService,Convert(nvarchar,SI.EffectiveDate,106) as 'EffectiveDate',SI.Remarks,Convert(nvarchar,SI.EntryDate,106) as 'RequestedOn',SI.ServiceStatus,
	Case When SI.IsRejected=1 Then SI.RejectionRemarks +' by ( ' + SI.RejectedBy + ' ) On ( ' + Convert(nvarchar, SI.RejectionDate,106) + ' )' 
	     When IsServiceProvided=1 then SI.ServiceProviderRemarks+' by ( ' + SI.ServiceProvider + ' ) On ( ' + Convert(nvarchar, SI.ServingDate,106) + ' )' 
		 else 'Yet To Be Reviewed'
		 end 'HRRemarks'
	from tblHRServiceIssue SI left Join tblHRServices S On SI.HRServiceID=S.HRServiceID
	Where SI.EmployeeID=@EmployeeID
end


GO

Create proc spReportHRServicesIssue
@HRServiceID nvarchar(50),
@EmployeeID nvarchar(50),
@ServiceStatus nvarchar(50),
@IsServiceProvided nvarchar(10)
as
begin
	Declare @HRServiceIDParam as nvarchar(50) Set @HRServiceIDParam = ''
	Declare @EmployeeIDParam as nvarchar(50) Set @EmployeeIDParam = ''
	Declare @ServiceStatusParam as nvarchar(50) Set @ServiceStatusParam = ''
	Declare @IsServiceProvidedParam as nvarchar(10) Set @IsServiceProvidedParam = ''

	if @HRServiceID = 'N\A'
		Set @HRServiceIDParam = '%'
	else
		Set @HRServiceIDParam = '%' + @HRServiceID + '%'

	if @EmployeeID = 'N\A'
		Set @EmployeeIDParam = '%'
	else
		Set @EmployeeIDParam = '%' + @EmployeeID + '%'
	
	if @ServiceStatus = 'N\A'
		Set @ServiceStatusParam = '%'
	else
		Set @ServiceStatusParam = '%' + @ServiceStatus + '%'

	if @IsServiceProvided = 'N\A'
		Set @IsServiceProvidedParam = '%'
	else
		Set @IsServiceProvidedParam = '%' + @IsServiceProvided + '%'

	Select HS.HRService,EI.EmployeeName,HSI.EffectiveDate,HSI.Remarks,
	Case HSI.IsServiceProvided When 1 Then 'YES' Else 'NO' end as 'IsServiceProvided',
	isnull(HSI.ServiceProvider,'N\A') as 'ServiceProvider',isnull(HSI.ServiceProviderRemarks,'N\A') as 'ServiceProviderRemarks',
	isnull(Convert(nvarchar,HSI.ServingDate,106),'1/1/1900') as 'ServingDate',
	Case HSI.IsRejected When 1 Then 'YES' Else 'NO' end as 'IsRejected',
	isnull(HSI.RejectedBy,'N\A') as 'RejectedBy',isnull(HSI.RejectionRemarks,'N\A') as 'RejectionRemarks',
	isnull(Convert(nvarchar,HSI.RejectionDate,106),'1/1/1900') as 'RejectionDate',
	HSI.ServiceStatus
	from tblHRServiceIssue HSI left Join tblHRServices HS On HSI.HRServiceID = HS.HRServiceID
	left Join tblEmployeeInfo EI On HSI.EmployeeID=EI.EmployeeID 
	Where HSI.HRServiceID like @HRServiceIDParam 
	And HSI.EmployeeID like @EmployeeIDParam
	And HSI.ServiceStatus like @ServiceStatusParam
	And HSI.IsServiceProvided like  @IsServiceProvidedParam
end

GO

Create proc spUpdateHRServices
@HRServiceID nvarchar(50),
@HRService nvarchar(200),
@HRServiceReqInstruction nvarchar(500),
@IsActive bit,
@SeqPriority int,
@EntryBy nvarchar(50)
as
begin
begin tran
	Update tblHRServices Set HRService=@HRService,HRServiceReqInstruction=@HRServiceReqInstruction,IsActive=@IsActive,
	SeqPriority=@SeqPriority,EntryBy=@EntryBy Where HRServiceID=@HRServiceID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spProvideHRService
@HRServiceIssueID nvarchar(50),
@ServiceProviderRemarks nvarchar(500),
@ServiceProvider nvarchar(50),
@ServiceEvent nvarchar(50)
as
begin
	if @ServiceEvent = 'Provided'
	begin
		Update tblHRServiceIssue Set IsServiceProvided=1,ServiceProvider=@ServiceProvider,ServiceProviderRemarks=@ServiceProviderRemarks,
		ServingDate=getdate(),ServiceStatus=@ServiceEvent Where HRServiceIssueID=@HRServiceIssueID
	end
	else
	begin
		Update tblHRServiceIssue Set IsRejected=1,RejectedBy=@ServiceProvider,RejectionRemarks=@ServiceProviderRemarks,
		RejectionDate=getdate(),ServiceStatus=@ServiceEvent Where HRServiceIssueID=@HRServiceIssueID
	end
end

GO

alter proc spGetHRServiceMailInfoSubmitted
@EmployeeID nvarchar(50),
@HRServiceID nvarchar(50),
@EffectiveDate datetime,
@Remarks nvarchar(500)
as
begin
	Declare @MailBody as nvarchar(4000) Set @MailBody = ''
	Declare @MailSubject as nvarchar(200) Set @MailSubject = ''
	Declare @MailTo as nvarchar(200) Set @MailTo = ''
	Declare @MailFrom as nvarchar(200) Set @MailFrom =''
	Declare @MailCC as nvarchar(200) Set @MailCC = ''
	Declare @GreenHRSLink  as nvarchar(500) Set @GreenHRSLink = 'http://192.168.11.241/mhrm/'

	Declare @EmployeeName as nvarchar(200) Set @EmployeeName = ''
	Declare @SupervisorID  as nvarchar(50) Set @SupervisorID=''
	Declare @HRService as nvarchar(200) Set @HRService = ''

	Select @EmployeeName=EmployeeName,@SupervisorID=CurrentSupervisor from tblEmployeeInfo Where EmployeeID=@EmployeeID
	Select @HRService = HRService from tblHRServices Where HRServiceID=@HRServiceID

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr>
		<th>Service</th>
		<th>Effective Date</th>
		<th>Remarks</th>
	</tr>
	<tr>
		<td>' + @HRService + '</td>
		<td>' + Convert(nvarchar,@EffectiveDate,106) + '</td>
		<td>' + @Remarks + '</td>
	</tr>
	<tr>
		<td colspan=''2''>MHRM</td>
		<td><a href='+@GreenHRSLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	Set @MailSubject = 'MHRM : Service Request From ('+@EmployeeName+')'
	Select @MailFrom =Email from tblEmployeeInfo Where EmployeeID=@EmployeeID
	Set @MailTo = 'divhr@meridianfinancebd.com'
	Select @MailCC = Email from tblEmployeeInfo Where EmployeeID=@SupervisorID

	if @MailCC = ''
		Set @MailCC = 'divit@meridianfinancebd.com'
	--else
	--	Set @MailCC = @MailCC + ';tajul@reflbd.com'

	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'info@meridianfinancebd.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'divit@meridianfinancebd.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'divit@meridianfinancebd.com' else @MailCC end as 'MailCC',
	'dsamaddar@meridianfinancebd.com' as 'MailBCC'

end

GO

alter proc spGetHRServiceProvidedMail
@HRServiceIssueID nvarchar(50),
@ServiceEvent nvarchar(50)
as
begin
	Declare @MailBody as nvarchar(4000) Set @MailBody = ''
	Declare @MailSubject as nvarchar(200) Set @MailSubject = ''
	Declare @MailTo as nvarchar(50) Set @MailTo = ''
	Declare @MailFrom as nvarchar(50) Set @MailFrom =''
	Declare @MailCC as nvarchar(50) Set @MailCC = ''
	Declare @GreenHRSLink  as nvarchar(500) Set @GreenHRSLink = 'http://192.168.11.241/mhrm/'

	Declare @EmployeeName as nvarchar(200) Set @EmployeeName = ''
	Declare @SupervisorID  as nvarchar(50) Set @SupervisorID=''
	Declare @HRService as nvarchar(200) Set @HRService = ''

	Declare @Remarks as nvarchar(500) Set @Remarks = ''
	Declare @ServiceProviderRemarks as nvarchar(500) Set @ServiceProviderRemarks = ''
	Declare @EffectiveDate as datetime 
	Declare @EmployeeID as nvarchar(50) Set @EmployeeID = ''
	Declare @HRServiceID as nvarchar(50) Set @HRServiceID = ''

	if @ServiceEvent = 'Provided'
	begin
		Select @EmployeeID=EmployeeID,@HRServiceID=HRServiceID,@EffectiveDate=EffectiveDate,@Remarks=Remarks,@ServiceProviderRemarks=ServiceProviderRemarks
		from tblHRServiceIssue Where HRServiceIssueID=@HRServiceIssueID
	end
	else
	begin
		Select @EmployeeID=EmployeeID,@HRServiceID=HRServiceID,@EffectiveDate=EffectiveDate,@Remarks=Remarks,@ServiceProviderRemarks=RejectionRemarks 
		from tblHRServiceIssue Where HRServiceIssueID=@HRServiceIssueID
	end

	Select @EmployeeName=EmployeeName,@SupervisorID=CurrentSupervisor from tblEmployeeInfo Where EmployeeID=@EmployeeID
	Select @HRService = HRService from tblHRServices Where HRServiceID=@HRServiceID

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr>
		<th>Service</th>
		<th>Effective Date</th>
		<th>Remarks</th>
		<th>HR-Remarks</th>
	</tr>
	<tr>
		<td>' + @HRService + '</td>
		<td>' + Convert(nvarchar,@EffectiveDate,106) + '</td>
		<td>' + @Remarks + '</td>
		<td>' + @ServiceProviderRemarks + '</td>
	</tr>
	<tr>
		<td colspan=''2''>M-HRM</td>
		<td colspan=''2''><a href='+@GreenHRSLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	Set @MailSubject = 'M-HRM : Service Request From ('+@EmployeeName+') : ' + @ServiceEvent

	if @ServiceEvent = 'Provided'
	begin
		Set @MailFrom = 'hr@meridianfinancebd.com'
		Select @MailTo = Email from tblEmployeeInfo Where EmployeeID=@EmployeeID
		Select @MailCC = Email from tblEmployeeInfo Where EmployeeID=@SupervisorID
	end
	else
	begin	
		Set @MailFrom = 'hr@meridianfinancebd.com'
		Select @MailTo = Email from tblEmployeeInfo Where EmployeeID=@EmployeeID
		Select @MailCC = Email from tblEmployeeInfo Where EmployeeID=@SupervisorID
	end
	
	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'info@meridianfinancebd.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'info@meridianfinancebd.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'info@meridianfinancebd.com' else @MailCC end as 'MailCC',
	'dsamaddar@meridianfinancebd.com' as 'MailBCC'
end
