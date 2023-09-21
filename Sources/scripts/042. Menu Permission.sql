
Create table tblMenu(
MenuID nvarchar(10) primary key,
MenuName nvarchar(100),
MenuGroupID nvarchar(50),
ViewOrder int
);

GO

Create proc spGetMenuGroupList
as
begin
	Select Distinct MenuGroupID from tblMenu Order by MenuGroupID
end

GO

Create proc spGetMenuListByGroup
@MenuGroupID nvarchar(50)
as
begin
	Select MenuID,MenuName from tblMenu
	Where MenuGroupID=@MenuGroupID
	Order by ViewOrder
end

GO

Insert Into tblAppSettings(PropertyName,PropertyValue)Values('CurrentRoleID',0)

GO

Create table tblRole(
RoleID nvarchar(50) primary key,
RoleName nvarchar(50),
isActive bit default 1,
MenuIDs nvarchar(4000),
CreatedBy nvarchar(50),
CreatedDate datetime,
LastUpdatedBy nvarchar(50),
LastUpdatedDate datetime
);

GO

Create proc spInsertRole
@RoleName nvarchar(50),
@isActive bit,
@CreatedBy nvarchar(50)
as
begin
	Declare @RoleID nvarchar(50)
	Declare @CurrentRoleID numeric(18,0)
	Declare @RoleIDPrefix as nvarchar(5)

	set @RoleIDPrefix='ROLE-'

begin tran

	select @CurrentRoleID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentRoleID'
	
	set @CurrentRoleID=isnull(@CurrentRoleID,0)+1
	Select @RoleID=dbo.generateID(@RoleIDPrefix,@CurrentRoleID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblRole(RoleID,RoleName,isActive,CreatedBy)Values(@RoleID,@RoleName,@isActive,@CreatedBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentRoleID where PropertyName='CurrentRoleID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spUpdateRole
@RoleID nvarchar(50),
@RoleName nvarchar(50),
@isActive bit,
@LastUpdatedBy nvarchar(50)
as
begin
	Update tblRole Set RoleName=@RoleName,isActive=@isActive,LastUpdatedBy=@LastUpdatedBy,LastUpdatedDate=getdate()
	Where RoleID=@RoleID
end

GO

Create proc spGetRoleList
as
begin
	Select Distinct RoleID,RoleName from tblRole Where isActive=1
	Order by RoleName
end

GO

Create proc spGetDetailsRoleList
as
begin
	Select RoleID,RoleName,isActive=Case isActive When 1 Then 'YES' Else 'NO' End,
	CreatedBy,Convert(nvarchar,CreatedDate,106) as 'CreatedDate'
	from tblRole Order by RoleName
end

GO

Create proc spUpdateRolePermission
@RoleID nvarchar(50),
@MenuIDList nvarchar(4000),
@LastUpdatedBy nvarchar(50)
as
begin
	Update tblRole Set MenuIDs=@MenuIDList,LastUpdatedBy=@LastUpdatedBy,LastUpdatedDate=getdate()
	Where RoleID=@RoleID
end

GO

Create proc spGetRoleWiseMenuIDs
@RoleID nvarchar(50)
as
begin
	Select MenuIDs from tblRole Where RoleID=@RoleID
end

GO

Create table tblUserRole(
SL bigint identity(1,1) primary key,
RoleID nvarchar(50),
EmployeeID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
CreatedBy nvarchar(50),
CreatedDate datetime,
UpdatedBy nvarchar(50),
UpdatedDate datetime
);