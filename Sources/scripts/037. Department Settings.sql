
GO

alter proc spInsertDepartment
@DeptName nvarchar(200),
@DeptCode nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Declare @DepartmentID nvarchar(50)
	Declare @CurrentDepartmentID numeric(18,0)
	Declare @DepartmentIDPrefix as nvarchar(5)

	set @DepartmentIDPrefix='DEPT-'

begin tran
	
	select @CurrentDepartmentID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentDeptID'
	
	set @CurrentDepartmentID=isnull(@CurrentDepartmentID,0)+1
	Select @DepartmentID=dbo.generateID(@DepartmentIDPrefix,@CurrentDepartmentID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblDepartment(DepartmentID,DeptName,DeptCode,IsActive,EntryBy)
	Values(@DepartmentID,@DeptName,@DeptCode,@IsActive,@EntryBy)

	update tblAppSettings set PropertyValue=@CurrentDepartmentID where PropertyName='CurrentDeptID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

alter proc spGetDepartmentDetails
as
begin
	Select DepartmentID,DeptName,DeptCode,Case IsActive When 1 then 'YES' else 'NO' end as 'IsActive',
	EntryBy,Convert(nvarchar,EntryDate,106) as 'EntryDate' from tblDepartment 
	order by DeptName 
end

GO

alter proc spUpdateDeptInfoByID
@DepartmentID nvarchar(50),
@DeptName nvarchar(200),
@DeptCode nvarchar(50),
@IsActive bit,
@EntryBy nvarchar(50)
as
begin
	Update tblDepartment Set DeptName=@DeptName,DeptCode=@DeptCode,IsActive=@IsActive,EntryBy=@EntryBy,EntryDate=getdate()
	Where DepartmentID=@DepartmentID
end

GO

Create proc spGetDeptList
as
begin
	Select distinct DepartmentID,DeptName from tblDepartment Where IsActive=1 order by DeptName 
end