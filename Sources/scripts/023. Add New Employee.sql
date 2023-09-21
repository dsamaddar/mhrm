
-- exec spAddNewEmployee 'Shanjid Yousuf Tanim','I2021122110','shanjid','Standard@1','dsamaddar'
alter proc spAddNewEmployee
@EmployeeName nvarchar(50),
@EmpCode nvarchar(50),
@UserID nvarchar(50),
@Password nvarchar(50),
@EntryBy nvarchar(50)
WITH ENCRYPTION
as
begin
	Declare @EmployeeID as nvarchar(50)
	Declare @CurrentEmployeeID numeric(18,0)
	Declare @EmployeeIDPrefix as nvarchar(8)
	Declare @MaximumUser as nvarchar(20) Set @MaximumUser = '0'
	Declare @TotalUser as int Set @TotalUser = 0
	
	set @EmployeeIDPrefix='EMP-'

begin tran

	select @MaximumUser = Convert(nvarchar(20),DECRYPTBYPASSPHRASE('D1g1tal3',CryptedValue))
	from tblAppSettings Where PropertyName='MaximumUser';

	Select @TotalUser = Count(*) from tblEmployeeInfo;

	If @TotalUser > Convert(int,@MaximumUser)
		GOTO ERR_HANDLER
	
	select @CurrentEmployeeID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentEmployeeID'
	set @CurrentEmployeeID=isnull(@CurrentEmployeeID,0)+1

	Select @EmployeeID=dbo.generateID(@EmployeeIDPrefix,@CurrentEmployeeID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert Into tblEmployeeInfo(EmployeeID,EmployeeName,EmpCode,UserID,Password,EntryBy,AttendanceID)
	Values(@EmployeeID,@EmployeeName,@EmpCode,@UserID,@Password,@EntryBy,@EmpCode)
	
	update tblAppSettings set PropertyValue=@CurrentEmployeeID where PropertyName='CurrentEmployeeID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
		
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end
