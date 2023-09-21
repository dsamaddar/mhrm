Create proc spShowLateAttCauseList
as
begin
	Select distinct LateAttCauseID,Cause,
	Case IsDetailsMandatory When 1 Then 'YES' else 'NO' end as 'IsDetailsMandatory',
	Case IsReportable When 1 Then 'YES' else 'NO' end as 'IsReportable',isnull(ReportableToDept,'N\A') as 'ReportableToDept', 
	Case IsActive when 1 Then 'YES' else 'NO' end as 'IsActive',
	EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate'
	from tblLateAttCause
	Order by Cause
end

GO

Create proc spInsertLateAttCause
@Cause nvarchar(200),
@IsDetailsMandatory bit,
@IsReportable bit,
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @LateAttCauseID as nvarchar(50)
	Declare @CurrentLateAttCauseID numeric(18,0)
	Declare @LateAttCauseIDPrefix as nvarchar(9)
	Declare @ReportableToDept as nvarchar(50)
	
	Set @ReportableToDept = null
	set @LateAttCauseIDPrefix='LATE-ATT-'

begin tran
	
	select @CurrentLateAttCauseID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentLateAttCauseID'
	
	set @CurrentLateAttCauseID=isnull(@CurrentLateAttCauseID,0)+1
	Select @LateAttCauseID=dbo.generateID(@LateAttCauseIDPrefix,@CurrentLateAttCauseID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	Insert Into tblLateAttCause(LateAttCauseID,Cause,IsDetailsMandatory,IsReportable,ReportableToDept,IsActive,EntryBy)
	Values(@LateAttCauseID,@Cause,@IsDetailsMandatory,@IsReportable,@ReportableToDept,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	update tblAppSettings set PropertyValue=@CurrentLateAttCauseID where PropertyName='CurrentLateAttCauseID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end


GO

Create proc spUpdateLateAttCause
@LateAttCauseID nvarchar(50),
@Cause nvarchar(200),
@IsDetailsMandatory bit,
@IsReportable bit,
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	
	Declare @CurrentLateAttCauseID numeric(18,0)
	Declare @LateAttCauseIDPrefix as nvarchar(9)
	Declare @ReportableToDept as nvarchar(50)
begin tran
	
	Update tblLateAttCause Set Cause=@Cause,IsDetailsMandatory=@IsDetailsMandatory,IsReportable=@IsReportable,
	IsActive=@IsActive,EntryBy=@EntryBy
	Where LateAttCauseID=@LateAttCauseID

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end