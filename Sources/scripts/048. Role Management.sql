create proc spInsertUserWiseRole
@EmployeeID nvarchar(50),
@RoleID nvarchar(50),
@EntryBy nvarchar(50)
as
begin
	Declare @UserWiseRoleID nvarchar(50)
	Declare @CurrentUserWiseRoleID numeric(18,0)
	Declare @UserWiseRoleIDPrefix as nvarchar(7)

	set @UserWiseRoleIDPrefix='USR-RL-'

begin tran

	select @CurrentUserWiseRoleID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentUserWiseRoleID'
	
	set @CurrentUserWiseRoleID=isnull(@CurrentUserWiseRoleID,0)+1
	Select @UserWiseRoleID=dbo.generateID(@UserWiseRoleIDPrefix,@CurrentUserWiseRoleID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblUserWiseRole(UserWiseRoleID,EmployeeID,RoleID,EntryBy)
	Values(@UserWiseRoleID,@EmployeeID,@RoleID,@EntryBy)
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	update tblAppSettings set PropertyValue=@CurrentUserWiseRoleID where PropertyName='CurrentUserWiseRoleID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

create proc spInActiveUsrPermission
@UserWiseRoleID nvarchar(50)
as
begin
	Update tblUserWiseRole Set IsActive=0
	Where UserWiseRoleID=@UserWiseRoleID
end

GO

create proc spShowUserWiseRole
@EmployeeID nvarchar(50)
as
begin
	Select UWR.UserWiseRoleID,R.RoleID,R.RoleName from tblUserWiseRole UWR Left Join tblRole R On UWR.RoleID=R.RoleID
	Where UWR.IsActive=1 And UWR.EmployeeID=@EmployeeID
end

GO

create proc spGetUserPermission
@EmployeeID nvarchar(50)
as
begin
	Declare @MenuIDs as nvarchar(4000)
	Set @MenuIDs = ''
	Select @MenuIDs = @MenuIDs + isnull(R.MenuIDs,'') from tblUserWiseRole UWR Left Join tblRole R On UWR.RoleID=R.RoleID
	Where UWR.IsActive=1 And UWR.EmployeeID=@EmployeeID

	Select @MenuIDs as 'MenuIDs'
end