
CREATE TABLE tblLeaveRequest(
	[LeaveRequestID] [nvarchar](50) NOT NULL,
	[LeaveReqUniqueID] [nvarchar](50) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[LeaveTypeID] [nvarchar](50) NULL,
	[LeaveFrom] [datetime] NULL,
	[LeaveTo] [datetime] NULL,
	[TotalDays] [int] NULL,
	[TotalWorkingDays] [int] NULL,
	[PurposeOfLeave] [nvarchar](2000) NULL,
	[EmergencyAddress] [nvarchar](500) NULL,
	[EmergencyContactNo] [nvarchar](100) NULL,
	[EmergencyMailAddress] [nvarchar](100) NULL,
	[RecommenderID] [nvarchar](50) NULL,
	[IsRecommended] [bit] NULL,
	[RecommendedDate] [datetime] NULL,
	[RecommendationRemarks] [nvarchar](500) NULL,
	[ApproverID] [nvarchar](50) NULL,
	[IsApproved] [bit] NULL,
	[ApprovalDate] [datetime] NULL,
	[ApproverRemarks] [nvarchar](500) NULL,
	[RejectorID] [nvarchar](50) NULL,
	[IsRejected] [bit] NULL,
	[RejectionDate] [nvarchar](50) NULL,
	[RejectionRemarks] [nvarchar](500) NULL,
	[LeaveStatus] [nvarchar](50) NULL,
	[EntryBy] [nvarchar](50) NULL,
	[EntryDate] [datetime] NULL,
 CONSTRAINT [PK__tblLeave__6094218E12B3B8EF] PRIMARY KEY CLUSTERED 
(
	[LeaveRequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tblLeaveRequest] ADD  CONSTRAINT [DF__tblLeaveR__IsRec__17786E0C]  DEFAULT ((0)) FOR [IsRecommended]
GO

ALTER TABLE [dbo].[tblLeaveRequest] ADD  CONSTRAINT [DF__tblLeaveR__IsApp__1960B67E]  DEFAULT ((0)) FOR [IsApproved]
GO

ALTER TABLE [dbo].[tblLeaveRequest] ADD  CONSTRAINT [DF_tblLeaveRequest_IsRejected]  DEFAULT ((0)) FOR [IsRejected]
GO

ALTER TABLE [dbo].[tblLeaveRequest] ADD  CONSTRAINT [DF__tblLeaveR__Entry__1A54DAB7]  DEFAULT (getdate()) FOR [EntryDate]
GO

ALTER TABLE [dbo].[tblLeaveRequest]  WITH CHECK ADD  CONSTRAINT [FK__tblLeaveR__Appro__186C9245] FOREIGN KEY([ApproverID])
REFERENCES [dbo].[tblEmployeeInfo] ([EmployeeID])
GO

ALTER TABLE [dbo].[tblLeaveRequest] CHECK CONSTRAINT [FK__tblLeaveR__Appro__186C9245]
GO

ALTER TABLE [dbo].[tblLeaveRequest]  WITH CHECK ADD  CONSTRAINT [FK__tblLeaveR__Emplo__149C0161] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[tblEmployeeInfo] ([EmployeeID])
GO

ALTER TABLE [dbo].[tblLeaveRequest] CHECK CONSTRAINT [FK__tblLeaveR__Emplo__149C0161]
GO

ALTER TABLE [dbo].[tblLeaveRequest]  WITH CHECK ADD  CONSTRAINT [FK__tblLeaveR__Leave__1590259A] FOREIGN KEY([LeaveTypeID])
REFERENCES [dbo].[tblLeaveType] ([LeaveTypeID])
GO

ALTER TABLE [dbo].[tblLeaveRequest] CHECK CONSTRAINT [FK__tblLeaveR__Leave__1590259A]
GO

GO

alter proc spGetIsRecommender
@LoginUserID as nvarchar(50)
as
	Declare @Status as nvarchar(100)
begin
	if exists(select * from tblLeaveRequest where RecommenderID=@LoginUserID And IsRecommended= 0 And IsApproved=0 And IsRejected = 0  )
	begin
		set @Status='Recommender'
	end
	else
		set @Status ='N\A'
		
		select @Status as Status
end
-- exec spGetIsRecommender 'EMP-00000020'

GO
-- exec spGetIsApprover 'EMP-00000020'
alter proc spGetIsApprover
@LoginUserID as nvarchar(50)
as
	Declare @Status as nvarchar(100)
begin
	if exists(select * from tblLeaveRequest where ApproverID=@LoginUserID And IsApproved=0 And IsRejected = 0  )
	begin
		set @Status='Approver'
	end
	else
		set @Status ='N\A'
		
	select @Status as 'Status'
end

GO

Create Procedure spGetApprovedLeaveList
@EmployeeID nvarchar(50),
@DateFrom nvarchar(50),
@DateTo nvarchar(50),
@LeaveTypeID nvarchar(50)
as
begin
	
	Declare @LeaveTypeIDParam as nvarchar(50)
	
	if @LeaveTypeID = 'All'
		Set @LeaveTypeIDParam = '%'
	else
		Set @LeaveTypeIDParam = '%' + @LeaveTypeID + '%'
	
	select LeaveRequestID,
	   (Select LeaveType from tblLeaveType LT Where LT.LeaveTypeID=tblLeaveRequest.LeaveTypeID) as 'LeaveType',
	   (select EmployeeName from tblEmployeeInfo where EmployeeID=tblLeaveRequest.EmployeeID) as 'EmployeeName'
	   ,tblLeaveRequest.EmployeeID as 'RequesterID',convert(nvarchar,LeaveFrom,106) as 'LeaveFrom',convert(nvarchar,LeaveTo,106) as 'LeaveTo'
	   ,TotalDays,TotalWorkingDays,convert(nvarchar,EntryDate,100) as 'EntryDate',
	   isnull(convert(nvarchar,ApprovalDate,100),'N\A') as 'ApprovalDate',LeaveStatus,PurposeOfLeave
	   from tblLeaveRequest where EmployeeID=@EmployeeID
	   And ( LeaveFrom >= @DateFrom And LeaveTo<= @DateTo )
	   And LeaveTypeID like @LeaveTypeIDParam
	   order by Convert(datetime,LeaveFrom) desc
end

GO

alter proc spGetReqLeaveReqByUser
@EmployeeID nvarchar(50)
as
begin
	select LR.LeaveTypeID,LT.LeaveType,LR.LeaveRequestID,convert(nvarchar,LeaveFrom,106) LeaveFrom
	,convert(nvarchar,LeaveTo,106) LeaveTo,TotalDays,TotalWorkingDays,EmergencyAddress,EmergencyContactNo
	,PurposeOfLeave,convert(nvarchar,LR.EntryDate,100) EntryDate
	,(select EmployeeName from tblEmployeeInfo where EmployeeID=LR.RecommenderID) as Recommender,
	(select EmployeeName from tblEmployeeInfo where EmployeeID=LR.ApproverID) as Approver,
	dbo.fnGetLeaveBalByLeaveType(LR.EmployeeID,LR.LeaveTypeID) as 'LeaveBalance'
	from tblLeaveRequest LR INNER JOIN tblLeaveType LT on LR.LeaveTypeID = LT.LeaveTypeID
	where EmployeeID= @EmployeeID And LeaveStatus='Requested'
	order by Convert(datetime,LeaveFrom) desc
end

-- exec spGetReqLeaveReqByUser 'EMP-00000020'

GO

alter proc spInsertLeaveRequest
@EmployeeID nvarchar(50),
@LeaveTypeID nvarchar(50),
@EmergencyAddress nvarchar(500),
@EmergencyContactNo nvarchar(100),
@EmergencyMailAddress nvarchar(100),
@Attachment nvarchar(100),
@RecommenderID nvarchar(50),
@ApproverID nvarchar(50),
@EntryBy nvarchar(50),
@isoFromDateToDateParts nvarchar(4000)
as
begin
	
	Declare @isRecommended as bit
	Declare @LeaveRequestID as nvarchar(50)
	Declare @CurrentLeaveRequestID numeric(18,0)
	Declare @LeaveRequestIDPrefix as nvarchar(10)
	Declare @LeaveFrom as datetime
	Declare @LeaveTo as datetime
	Declare @TotalDays as int
	Declare @TotalWorkingDays as int
	Declare @PurposeOfLeave nvarchar(2000)
	
	Declare @RestISOParts as nvarchar(4000)
	Declare @CurrentISOParts as nvarchar(4000)
	Declare @Index as int
	Declare @RestPortion as nvarchar(1000)
	
	Declare @LeaveRequestUniqueID as nvarchar(50)
	Declare @CurrentLeaveUniqueID numeric(18,0)
	Declare @LeaveRequestUniqueIDPrefix as nvarchar(12)
	
	set @LeaveRequestIDPrefix='LEAVE-REQ-'
	set @LeaveRequestUniqueIDPrefix='LEVE-Unique-'

	Declare @ExLeaveBalance as int Set @ExLeaveBalance = dbo.fnGetLeaveBalByLeaveType(@EmployeeID,@LeaveTypeID)

begin tran

	select @CurrentLeaveUniqueID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentLeaveUniqueID'
			
	set @CurrentLeaveUniqueID=isnull(@CurrentLeaveUniqueID,0)+1
	Select @LeaveRequestUniqueID=dbo.generateID(@LeaveRequestUniqueIDPrefix,@CurrentLeaveUniqueID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	IF @RecommenderID='N\A'
	begin
		Set @RecommenderID = NULL
		set @isRecommended=1
	end
	ELSE
		set @isRecommended=0
	
	set @RestISOParts=@isoFromDateToDateParts
	
	while @RestISOParts<>''
		begin
			select @CurrentLeaveRequestID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentLeaveRequestID'
			
			set @CurrentLeaveRequestID=isnull(@CurrentLeaveRequestID,0)+1
			Select @LeaveRequestID=dbo.generateID(@LeaveRequestIDPrefix,@CurrentLeaveRequestID,8)		
			IF (@@ERROR <> 0) GOTO ERR_HANDLER
			
			
				set @Index=CHARINDEX('|',@RestISOParts)
				set @CurrentISOParts=substring(@RestISOParts,1,@Index-1)
				set @RestISOParts=substring(@RestISOParts,@Index+1,len(@RestISOParts))	


				set @RestPortion=@CurrentISOParts

				set @Index=CHARINDEX('~',@RestPortion)		
				set @LeaveFrom =substring(@RestPortion,1,@Index-1)
				set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))		
				
				set @Index=CHARINDEX('~',@RestPortion)		
				set @LeaveTo=substring(@RestPortion,1,@Index-1)
				set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))
				
				set @Index=CHARINDEX('~',@RestPortion)		
				set @TotalDays=substring(@RestPortion,1,@Index-1)
				set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))
				
				set @Index=CHARINDEX('~',@RestPortion)		
				set @TotalWorkingDays=substring(@RestPortion,1,@Index-1)
				set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
				
				set @Index=CHARINDEX('~',@RestPortion)		
				set @PurposeOfLeave=substring(@RestPortion,1,@Index-1)
				set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))		
				
				if @ExLeaveBalance < @TotalWorkingDays
				begin
					GOTO ERR_HANDLER
				end
				else
				begin
					Insert into tblLeaveRequest(LeaveRequestID,LeaveReqUniqueID,EmployeeID,LeaveTypeID,LeaveFrom,LeaveTo,TotalDays,TotalWorkingDays,
					PurposeOfLeave,EmergencyAddress,EmergencyContactNo,EmergencyMailAddress,Attachment,RecommenderID,IsRecommended,ApproverID,LeaveStatus ,EntryBy)
					Values(@LeaveRequestID,@LeaveRequestUniqueID,@EmployeeID,@LeaveTypeID,@LeaveFrom,@LeaveTo,@TotalDays,@TotalWorkingDays,
					@PurposeOfLeave,@EmergencyAddress,@EmergencyContactNo,@EmergencyMailAddress,@Attachment,@RecommenderID,@isRecommended,@ApproverID,'Requested',@EntryBy)
					IF (@@ERROR <> 0) GOTO ERR_HANDLER
			
					update tblAppSettings set PropertyValue=@CurrentLeaveRequestID where PropertyName='CurrentLeaveRequestID'
					IF (@@ERROR <> 0) GOTO ERR_HANDLER
				end
	   end
	   
	   update tblAppSettings set PropertyValue=@CurrentLeaveUniqueID where PropertyName='CurrentLeaveUniqueID'
	   IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

alter proc spGetLeaveMailInfoSubmitted
@EmployeeID nvarchar(50),
@LeaveFrom datetime,
@LeaveTo datetime,
@TotalWorkingDays int,
@PurposeOfLeave nvarchar(500),
@Event nvarchar(50)
as
begin
	Declare @MailBody as nvarchar(4000) Set @MailBody = ''
	Declare @MailSubject as nvarchar(200) Set @MailSubject = ''
	Declare @MailTo as nvarchar(50) Set @MailTo = ''
	Declare @MailFrom as nvarchar(50) Set @MailFrom =''
	Declare @MailCC as nvarchar(50) Set @MailCC = ''
	Declare @EHRMLink  as nvarchar(500) Set @EHRMLink = 'http://ext.mfilbd.com/mhrm/frmhrmlogin.aspx'

	Declare @EmployeeName as nvarchar(200) Set @EmployeeName = ''
	Declare @ApproverID as nvarchar(50) Set @ApproverID = ''
	Declare @RecommenderID  as nvarchar(50) Set @RecommenderID=''

	Select @EmployeeName=EmployeeName,@ApproverID=LeaveApprover,@RecommenderID=LeaveRecommender from tblEmployeeInfo Where EmployeeID=@EmployeeID

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr>
		<th>Leave From</th>
		<th>Leave To</th>
		<th>Days</th>
		<th>Purpose</th>
	</tr>
	<tr>
		<td>' + Convert(nvarchar,@LeaveFrom,106) + '</td>
		<td>' + Convert(nvarchar,@LeaveTo,106) + '</td>
		<td>' + Convert(nvarchar,@TotalWorkingDays) + '</td>
		<td>' + @PurposeOfLeave + '</td>
	</tr>
	<tr>
		<td colspan=''2''>MHRM</td>
		<td colspan=''3''><a href='+@EHRMLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	if @Event = 'Requested'
	begin
		if @RecommenderID <> 'N\A'
		begin
			Set @MailSubject = 'MHRM : Leave Request From ('+@EmployeeName+') : Need Recommendation '
			Select @MailFrom =Email from tblEmployeeInfo Where EmployeeID=@EmployeeID
			Select @MailTo =Email from tblEmployeeInfo Where EmployeeID=@RecommenderID
			Select @MailCC =Email from tblEmployeeInfo Where EmployeeID=@ApproverID
		end
		else
		begin
			Set @MailSubject = 'MHRM : Leave Request From ('+@EmployeeName+') : Need Approval '
			Select @MailFrom =Email from tblEmployeeInfo Where EmployeeID=@EmployeeID
			Select @MailTo =Email from tblEmployeeInfo Where EmployeeID=@ApproverID
			Set @MailCC = ''
		end
	end

	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'divit@meridianfinancebd.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'divit@meridianfinancebd.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'divit@meridianfinancebd.com' else @MailCC end as 'MailCC',
	'dsamaddar@meridianfinancebd.com' as 'MailBCC'

end

GO

alter Procedure spGetLeaveReqForApproval
@EmployeeID nvarchar(50),
@status nvarchar(50)
-- exec spGetLeaveReqForApproval 'EMP-00000020','ForApproval'
as
begin
	if @status='ForApproval'
		 begin
			select 
			LR.LeaveRequestID,LR.LeaveTypeID,LT.LeaveType,EI.EmployeeName as EmployeeName
			,LR.EmployeeID as RequesterID,convert(nvarchar,LeaveFrom,106) LeaveFrom
			,convert(nvarchar,LeaveTo,106) LeaveTo,TotalDays,TotalWorkingDays,EmergencyAddress,EmergencyContactNo
			,isnull(LR.Attachment,'na.jpg') Attachment,PurposeOfLeave,convert(nvarchar,LR.EntryDate,100) EntryDate
			,(select EmployeeName from tblEmployeeInfo where EmployeeID=LR.RecommenderID) as RecommenderName,
			dbo.fnGetLeaveBalByLeaveType(LR.EmployeeID,LR.LeaveTypeID) as 'LeaveBalance'
			from tblLeaveRequest LR INNER JOIN tblEmployeeInfo EI ON LR.EmployeeID = EI.EmployeeID
			INNER JOIN tblEmpLeaveBalance LB ON (LR.EmployeeID = LB.EmployeeID And LB.IsActive=1)
			INNER JOIN tblLeaveType LT ON LR.LeaveTypeID = LT.LeaveTypeID
			where LR.ApproverID= @EmployeeID And IsRecommended=1 And IsApproved=0 And IsRejected=0
			order by Convert(datetime,LeaveFrom) desc
		end
	   
		else if @status='ForRecommendation'
		begin
			select LR.LeaveRequestID,LR.LeaveTypeID,LT.LeaveType,EI.EmployeeName as EmployeeName,LR.EmployeeID as RequesterID,
			convert(nvarchar,LR.LeaveFrom,106) LeaveFrom,convert(nvarchar,LR.LeaveTo,106) LeaveTo
			,TotalDays,TotalWorkingDays,convert(nvarchar,LR.EntryDate,100) EntryDate,
			LR.EmergencyAddress,LR.EmergencyContactNo,isnull(LR.Attachment,'na.jpg') Attachment,LR.PurposeOfLeave 
			,(select EmployeeName from tblEmployeeInfo where EmployeeID=LR.RecommenderID) as RecommenderName,
			dbo.fnGetLeaveBalByLeaveType(LR.EmployeeID,LR.LeaveTypeID) as 'LeaveBalance'
			from tblLeaveRequest LR INNER JOIN tblEmployeeInfo EI ON LR.EmployeeID = EI.EmployeeID
			INNER JOIN tblEmpLeaveBalance LB ON (LR.EmployeeID = LB.EmployeeID And LB.IsActive=1)
			INNER JOIN tblLeaveType LT ON LR.LeaveTypeID = LT.LeaveTypeID
			where LR.RecommenderID=@EmployeeID and LR.IsRecommended=0 And LR.IsRejected=0 And LR.IsApproved = 0
		   	order by Convert(datetime,LeaveFrom) desc
		end
end 

GO

-- drop table tblLeaveDetails
CREATE TABLE tblLeaveDetails(
	LeaveDetailID nvarchar(50) primary key,
	LeaveBalanceID nvarchar(50) foreign key references tblEmpLeaveBalance(EmpLeaveBalanceID),
	LeaveRequestID nvarchar(50) foreign key references tblLeaveRequest(LeaveRequestID),
	EmployeeID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
	LeaveDate date NOT NULL
);

GO

alter proc spInsertLeaveApprovalLog
@LeaveRequestID nvarchar(50),
@LeaveBalanceID nvarchar(50),
@LeaveFrom datetime,
@leaveTo datetime
as
begin
	Declare @ApprovalLogID as nvarchar(50)
	Declare @EmployeeID as nvarchar(50) Set @EmployeeID=''
	Declare @CurrentApprovalLogID numeric(18,0)
	Declare @ApprovalLogIDPrefix as nvarchar(10)
	
	set @ApprovalLogIDPrefix='LEAVE-DTL-'
	
	declare @TotalApplied as int
	Declare @ToDateext as datetime
	Declare @TotalHolidays as int
	declare @CurrentDate as datetime
	
	set @CurrentDate = @LeaveFrom   
	
	begin tran
	
	Select @EmployeeID=EmployeeID from tblLeaveRequest Where LeaveRequestID = @LeaveRequestID

	select @CurrentApprovalLogID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentLeaveDetailID'
			
	while @CurrentDate<=@leaveTo
	begin
		set @CurrentApprovalLogID=isnull(@CurrentApprovalLogID,0)+1
		Select @ApprovalLogID=dbo.generateID(@ApprovalLogIDPrefix,@CurrentApprovalLogID,8)		
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
			
			if not exists (
				Select *  from tblHolidays  where convert(date, CONVERT(nvarchar,@CurrentDate,101))=convert(date, CONVERT(nvarchar,HolidayDate,101)) 
				)
			begin
				if (datepart(weekday,@CurrentDate)!=6 and datepart(weekday,@CurrentDate)!=7)
				begin
					INSERT INTO tblLeaveDetails(LeaveDetailID,LeaveBalanceID,LeaveRequestID,EmployeeID,LeaveDate)
					VALUES(@ApprovalLogID,@LeaveBalanceID,@LeaveRequestID,@EmployeeID,@CurrentDate)
					IF (@@ERROR <> 0) GOTO ERR_HANDLER
				end
			end
				
			set @CurrentDate=dateadd(day,1,@CurrentDate)
	end
		
	update tblAppSettings set PropertyValue=@CurrentApprovalLogID where PropertyName='CurrentLeaveDetailID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO
/*
-- EMP-00000037
select * from tblLeaveRequest where EmployeeID='EMP-00000037' order by EntryDate desc;
select * from tblEmpLeaveBalance where EmployeeID='EMP-00000037';
LEAVE-REQ-00002423
LEAVE-REQ-00002344
EMP-L-BAL-00001007

exec spChangeStatusForLeaveRequest 'LEAVE-REQ-00002423',
*/

alter proc spChangeStatusForLeaveRequest
@LeaveTypeID nvarchar(50),
@LeaveRequestID nvarchar(50),
@TakenAction nvarchar(100),
@ApproverID nvarchar(50),
@Remarks nvarchar(500)
as
	Declare @LeaveFrom datetime
	Declare @LeaveTo datetime
	Declare @TotlLeaveTakenDay as int
	Declare @LeaveTaken as int
	Declare @TotalTakenDay as int
	Declare @EmployeeID as nvarchar(50)
	Declare @LeaveBalanceID as nvarchar(50)

	Declare @CurCasualLeaveBal int Set @CurCasualLeaveBal = 0;
	Declare @CurMedicalLeaveBal int Set @CurMedicalLeaveBal = 0;
	Declare @CurAnnualLeaveBal int Set @CurAnnualLeaveBal = 0;
	Declare @CurMaternityLeaveBal int Set @CurMaternityLeaveBal = 0;
	Declare @CurLeaveWithOutPayLeaveBal int Set @CurLeaveWithOutPayLeaveBal = 0;
	Declare @CurSpecialLeaveBal int Set @CurSpecialLeaveBal = 0;

begin

begin tran

	Select @CurCasualLeaveBal=ISNULL(CasualLeave,0),@CurMedicalLeaveBal=ISNULL(MedicalLeave,0),@CurAnnualLeaveBal=ISNULL(AnnualLeave,0),
	@CurMaternityLeaveBal=ISNULL(MaternityLeave,0),@CurLeaveWithOutPayLeaveBal=ISNULL(LeaveWithOutPay,0),@CurSpecialLeaveBal=ISNULL(SpecialLeave,0)
	from tblEmpLeaveBalance Where EmployeeID = (
	Select EmployeeID from tblLeaveRequest Where LeaveRequestID = @LeaveRequestID
	);

	Declare @LeaveType as nvarchar(50) Set @LeaveType = '';
	Select @LeaveType = LeaveType from tblLeaveType Where LeaveTypeID = @LeaveTypeID;
		
	if @TakenAction='Recommended'
	begin
		update tblLeaveRequest set LeaveStatus=@TakenAction,IsRecommended=1,RecommendedDate=GETDATE(),RecommendationRemarks=@Remarks 
		where LeaveRequestID=@LeaveRequestID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
	end
	
	else if @TakenAction='Approved'
	begin

		if exists (select * from tblLeaveRequest where IsApproved=1 And LeaveRequestID=@LeaveRequestID)
		begin
			return;
		end
		
		update tblLeaveRequest set LeaveStatus=@TakenAction,IsApproved=1,ApprovalDate=GETDATE(),ApproverRemarks=@Remarks
		where LeaveRequestID=@LeaveRequestID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
				
		select @TotlLeaveTakenDay=TotalWorkingDays,@EmployeeID= EmployeeID from tblLeaveRequest where LeaveRequestID =@LeaveRequestID 
			
		if (select IsDedFrmLeaveBalance from tblLeaveType inner join tblLeaveRequest
		on tblLeaveRequest.LeaveTypeID =tblLeaveType.LeaveTypeID where LeaveRequestID=@LeaveRequestID)=1
			begin
				
				Select @LeaveBalanceID = EmpLeaveBalanceID from tblEmpLeaveBalance where EmployeeID=@EmployeeID and IsActive = 1

				-- if leave balance is lower then reject the leave request
				if @TotlLeaveTakenDay > dbo.fnGetLeaveBalByLeaveType(@EmployeeID,@LeaveTypeID)
				begin
					update tblLeaveRequest set LeaveStatus=@TakenAction,IsRejected=1,RejectorID=@ApproverID,RejectionDate=GETDATE(),RejectionRemarks=@Remarks
					where LeaveRequestID=@LeaveRequestID
					IF (@@ERROR <> 0) GOTO ERR_HANDLER
				end
				-- if leave balance is lower then reject the leave request

				if @LeaveType = 'Casual Leave'
				begin
					if @CurCasualLeaveBal < @TotlLeaveTakenDay
					begin
						GOTO ERR_HANDLER;
					end
					update tblEmpLeaveBalance set CasualLeave = CasualLeave - @TotlLeaveTakenDay where EmployeeID=@EmployeeID and IsActive = 1
					IF (@@ERROR <> 0) GOTO ERR_HANDLER
				end
				else if @LeaveType = 'Medical Leave'
				begin
					--if @CurAnnualLeaveBal > 0
					--begin
					--	GOTO ERR_HANDLER;
					--end
					if @CurMedicalLeaveBal < @TotlLeaveTakenDay
					begin
						GOTO ERR_HANDLER;
					end
					update tblEmpLeaveBalance set MedicalLeave = MedicalLeave - @TotlLeaveTakenDay where EmployeeID=@EmployeeID and IsActive = 1
					IF (@@ERROR <> 0) GOTO ERR_HANDLER
				end
				else if @LeaveType = 'Annual Leave'
				begin
					if @CurAnnualLeaveBal < @TotlLeaveTakenDay
					begin
						GOTO ERR_HANDLER;
					end
					update tblEmpLeaveBalance set AnnualLeave = AnnualLeave - @TotlLeaveTakenDay where EmployeeID=@EmployeeID and IsActive = 1
					IF (@@ERROR <> 0) GOTO ERR_HANDLER
				end
				else if @LeaveType = 'Maternity Leave'
				begin
					if @CurMaternityLeaveBal < @TotlLeaveTakenDay
					begin
						GOTO ERR_HANDLER;
					end
					update tblEmpLeaveBalance set MaternityLeave = MaternityLeave - @TotlLeaveTakenDay where EmployeeID=@EmployeeID and IsActive = 1
					IF (@@ERROR <> 0) GOTO ERR_HANDLER
				end
				else if @LeaveType = 'Leave Without Pay'
				begin
					if @CurLeaveWithOutPayLeaveBal < @TotlLeaveTakenDay
					begin
						GOTO ERR_HANDLER;
					end
					update tblEmpLeaveBalance set LeaveWithOutPay = LeaveWithOutPay - @TotlLeaveTakenDay where EmployeeID=@EmployeeID and IsActive = 1
					IF (@@ERROR <> 0) GOTO ERR_HANDLER
				end
				else if @LeaveType = 'Special Leave'
				begin
					if @CurSpecialLeaveBal < @TotlLeaveTakenDay
					begin
						GOTO ERR_HANDLER;
					end
					update tblEmpLeaveBalance set SpecialLeave = SpecialLeave - @TotlLeaveTakenDay where EmployeeID=@EmployeeID and IsActive = 1
					IF (@@ERROR <> 0) GOTO ERR_HANDLER
				end
				
			end
		
		select @LeaveFrom=LeaveFrom , @LeaveTo=LeaveTo  from tblLeaveRequest where LeaveRequestID=@LeaveRequestID
		
		exec spInsertLeaveApprovalLog @LeaveRequestID,@LeaveBalanceID, @LeaveFrom, @LeaveTo
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
	end
	
	else if @TakenAction='Rejected'
	begin
		update tblLeaveRequest set LeaveStatus=@TakenAction,IsRejected=1,RejectorID=@ApproverID,RejectionDate=GETDATE(),RejectionRemarks=@Remarks
		where LeaveRequestID=@LeaveRequestID
		IF (@@ERROR <> 0) GOTO ERR_HANDLER

	end
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

alter proc spGetLeaveMailInfo
@LeaveRequestID nvarchar(50),
@Event nvarchar(50),
@UniqueUserID nvarchar(50),
@SupervisorComments nvarchar(500)
as
begin

	Declare @EmployeeID as nvarchar(50) Set @EmployeeID = ''
	Declare @ApproverID as nvarchar(50) Set @ApproverID = ''
	Declare @RecommenderID as nvarchar(50) Set @RecommenderID = ''
	Declare @IsApproved as bit Set @IsApproved=0
	Declare @IsRecommended as bit Set @IsRecommended=0
	Declare @LeaveFrom as datetime
	Declare @LeaveTo as datetime
	Declare @TotalWorkingDays as int Set @TotalWorkingDays = 0
	Declare @PurposeOfLeave as nvarchar(500) Set @PurposeOfLeave = ''

	Declare @MailBody as nvarchar(4000) Set @MailBody = ''
	Declare @MailSubject as nvarchar(200) Set @MailSubject = ''
	Declare @MailTo as nvarchar(50) Set @MailTo = ''
	Declare @MailFrom as nvarchar(50) Set @MailFrom =''
	Declare @MailCC as nvarchar(50) Set @MailCC = ''
	Declare @EHRMLink  as nvarchar(500) Set @EHRMLink = 'http://ext.mfilbd.com/mhrm/frmhrmlogin.aspx'

	Select @EmployeeID=EmployeeID,@ApproverID=ApproverID,@RecommenderID=RecommenderID,@IsApproved=IsApproved,
	@IsRecommended=IsRecommended,@LeaveFrom=LeaveFrom,@LeaveTo=LeaveTo,@TotalWorkingDays=TotalWorkingDays,
	@PurposeOfLeave=PurposeOfLeave
	from tblLeaveRequest Where LeaveRequestID=@LeaveRequestID;

	Set @MailBody = '
	<html>
	<body>
	<table border=''1'' width=''100%''>
	<tr>
		<th>Leave From</th>
		<th>Leave To</th>
		<th>Days</th>
		<th>Purpose</th>
		<th>Supervisor Comments</th>
	</tr>
	<tr>
		<td>' + Convert(nvarchar,@LeaveFrom,106) + '</td>
		<td>' + Convert(nvarchar,@LeaveTo,106) + '</td>
		<td>' + Convert(nvarchar,@TotalWorkingDays) + '</td>
		<td>' + @PurposeOfLeave + '</td>
		<td>' + @SupervisorComments + '</td>
	</tr>
	<tr>
		<td colspan=''2''>MHRM</td>
		<td colspan=''3''><a href='+@EHRMLink+'>Link</a> </td>
	</tr>
	</table>
	</body>
	</html>'

	Declare @EntryUser as nvarchar(200) Set @EntryUser= ''
	Declare @EmployeeName as nvarchar(200) Set @EmployeeName = ''
	Declare @Recommender as nvarchar(200) Set @Recommender = ''
	Declare @Approver as nvarchar(200) Set @Approver = ''
	Declare @FunctionalDesignation as nvarchar(200) Set @FunctionalDesignation = ''
	
	Select @EntryUser = EmployeeName from tblEmployeeInfo Where EmployeeID=@UniqueUserID;
	Select @EmployeeName=EmployeeName from tblEmployeeInfo Where EmployeeID=@EmployeeID;
	Select @Recommender=EmployeeName,@FunctionalDesignation=dbo.fnGetDesignationName(FunctionalDesignationID)
	from tblEmployeeInfo Where EmployeeID=@RecommenderID;
	Select @Approver=EmployeeName,@FunctionalDesignation=dbo.fnGetDesignationName(FunctionalDesignationID) 
	from tblEmployeeInfo Where EmployeeID=@ApproverID;
	
	if @Event = 'Requested'
	begin
		if @IsRecommended = 0 And @RecommenderID <> ''
		begin
			Set @MailSubject = 'MHRM : Leave Request From ('+@EmployeeName+') : Need Recommendation '
			Select @MailFrom =Email from tblEmployeeInfo Where EmployeeID=@EmployeeID
			Select @MailTo =Email from tblEmployeeInfo Where EmployeeID=@RecommenderID
			Select @MailCC =Email from tblEmployeeInfo Where EmployeeID=@ApproverID
		end
		else
		begin
			Set @MailSubject = 'MHRM : Leave Request From ('+@EmployeeName+') : Need Approval '
			Select @MailFrom =Email from tblEmployeeInfo Where EmployeeID=@EmployeeID
			Select @MailTo =Email from tblEmployeeInfo Where EmployeeID=@ApproverID
			Set @MailCC = ''
		end
	end
	else if @Event = 'Rejected'
	begin
		Set @MailSubject = 'MHRM : Leave Request From ('+@EmployeeName+') : Rejected By ' + @EntryUser
		Select @MailFrom =Email from tblEmployeeInfo Where EmployeeID=@UniqueUserID;
		Select @MailTo =Email from tblEmployeeInfo Where EmployeeID=@EmployeeID;
		Select @MailCC =Email from tblEmployeeInfo Where EmployeeID=@ApproverID;
	end
	else if @Event = 'Recommended'
	begin
		Set @MailSubject = 'MHRM : Leave Request From ('+@EmployeeName+') : Recommended By ' + @FunctionalDesignation
		Select @MailFrom =Email from tblEmployeeInfo Where EmployeeID=@RecommenderID;
		Select @MailTo =Email from tblEmployeeInfo Where EmployeeID=@ApproverID;
		Select @MailCC =Email from tblEmployeeInfo Where EmployeeID=@EmployeeID;
	end
	else if @Event = 'Approved'
	begin
		Set @MailSubject = 'MHRM : Leave Request From ('+@EmployeeName+') : Approved By ' + @FunctionalDesignation
		Select @MailFrom =Email from tblEmployeeInfo Where EmployeeID=@ApproverID;
		Select @MailTo =Email from tblEmployeeInfo Where EmployeeID=@EmployeeID;
		Select @MailCC =Email from tblEmployeeInfo Where EmployeeID=@RecommenderID;
	end

	Select @MailSubject as 'MailSubject',@MailBody as 'MailBody' ,Case When @MailFrom='' then 'divit@meridianfinancebd.com' else @MailFrom end  as 'MailFrom',
	Case When @MailTo='' then 'divit@meridianfinancebd.com' else @MailTo end as 'MailTo',
	Case When @MailCC='' then 'divit@meridianfinancebd.com' else @MailCC end as 'MailCC',
	'dsamaddar@meridianfinancebd.com' as 'MailBCC'
end

GO

alter proc spGetEmpLeaveReqDetails
@EmployeeID nvarchar(50)
as
begin
	Select LT.LeaveType,Convert(nvarchar,LR.LeaveFrom,106) as 'LeaveFrom',Convert(nvarchar,LR.LeaveTo,106) as 'LeaveTo',
	LR.TotalDays,LR.TotalWorkingDays,LR.PurposeOfLeave,LR.EmergencyAddress,LR.EmergencyContactNo,LR.LeaveStatus
	from tblLeaveRequest LR 
	INNER JOIN tblLeaveType LT ON LR.LeaveTypeID = LT.LeaveTypeID
	INNER JOIN tblEmployeeInfo EI ON LR.EmployeeID=EI.EmployeeID
	Where LR.EmployeeID=@EmployeeID
	order by LeaveFrom asc
end

-- exec spGetEmpLeaveReqDetails 'EMP-00000098'

