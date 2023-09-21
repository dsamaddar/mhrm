
Create proc spInsertULCBranch
@ULCBranchName nvarchar(200),
@BranchLocation nvarchar(500),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @ULCBranchID nvarchar(50)
	Declare @CurrentULCBranchID numeric(18,0)
	Declare @ULCBranchIDPrefix as nvarchar(10)

	set @ULCBranchIDPrefix='ULCBranch-'

begin tran
	
	select @CurrentULCBranchID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentULCBranchID'
	
	set @CurrentULCBranchID=isnull(@CurrentULCBranchID,0)+1
	Select @ULCBranchID=dbo.generateID(@ULCBranchIDPrefix,@CurrentULCBranchID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblULCBranch(ULCBranchID,ULCBranchName,BranchLocation,IsActive,EntryBy)
	Values(@ULCBranchID,@ULCBranchName,@BranchLocation,@IsActive,@EntryBy)

	update tblAppSettings set PropertyValue=@CurrentULCBranchID where PropertyName='CurrentULCBranchID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spGetULCBranch
as
begin
	SELECT ULCBranchID,ULCBranchName FROM tblULCBranch
	where isActive =1 order by ULCBranchName
end

GO

Create proc spGetULCBranchList
as
begin
	Select distinct ULCBranchID,ULCBranchName from tblULCBranch Where IsActive=1 and ULCBranchName<>'' order by ULCBranchName
end

GO

Create proc spUpdateULCBranch
@ULCBranchID nvarchar(50),
@ULCBranchName nvarchar(200),
@BranchLocation nvarchar(500),
@isActive bit
as
begin
	Update tblULCBranch Set ULCBranchName=@ULCBranchName,BranchLocation=@BranchLocation,isActive=@isActive
	Where ULCBranchID=@ULCBranchID
end

GO

Create proc spGetTotalULCBranch
as
begin
	Select UB.ULCBranchID,UB.ULCBranchName,UB.BranchLocation,
	Case isActive When 1 Then 'YES' Else 'NO' end as 'isActive',UB.EntryBy,
	Convert(nvarchar,UB.EntryDate,106) as 'EntryDate' 
	from tblULCBranch UB
	order by ULCBranchName
end