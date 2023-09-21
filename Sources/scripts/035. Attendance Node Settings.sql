
Create table tblNodes(
NodeID nvarchar(50) primary key,
NodeCode int unique(NodeCode),
NodeName nvarchar(50) unique(NodeName),
NodeBranchID nvarchar(50) foreign key references tblULCBranch(ULCBranchID),
NodeDescription nvarchar(50),
IsActive bit default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

Create proc spInsertAttendanceNode
@NodeCode int,
@NodeName nvarchar(50),
@NodeBranchID nvarchar(50),
@NodeDescription nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @NodeID as nvarchar(50)
	Declare @CurrentNodeID numeric(18,0)
	Declare @NodeIDPrefix as nvarchar(2)
		
	set @NodeIDPrefix='N-'

begin tran
	
	select @CurrentNodeID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentNodeID'
	
	set @CurrentNodeID=isnull(@CurrentNodeID,0)+1
	Select @NodeID=dbo.generateID(@NodeIDPrefix,@CurrentNodeID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	Insert Into tblNodes(NodeID,NodeCode,NodeName,NodeBranchID,NodeDescription,IsActive,EntryBy)
	Values(@NodeID,@NodeCode,@NodeName,@NodeBranchID,@NodeDescription,@IsActive,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	update tblAppSettings set PropertyValue=@CurrentNodeID where PropertyName='CurrentNodeID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spUpdateAttendanceNode
@NodeID nvarchar(50),
@NodeCode int,
@NodeName nvarchar(50),
@NodeBranchID nvarchar(50),
@NodeDescription nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Update tblNodes Set NodeCode=@NodeCode,NodeName=@NodeName,NodeBranchID=@NodeBranchID,
	NodeDescription=@NodeDescription,IsActive=@IsActive,EntryBy=@EntryBy
	Where NodeID=@NodeID
end

GO

Create proc spShowNodeList
as
begin
	Select NodeID,NodeCode,NodeName,NodeBranchID,B.ULCBranchName as 'Branch',NodeDescription,N.IsActive,N.EntryBy
	from tblNodes N INNER JOIN tblULCBranch B ON N.NodeBranchID = B.ULCBranchID
	order by NodeCode,NodeName
end