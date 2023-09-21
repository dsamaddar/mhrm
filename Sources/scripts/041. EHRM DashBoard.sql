

alter proc spGetDashBoardInfo
WITH ENCRYPTION
as
begin
	
	Declare @LicenseExpiryDate as nvarchar(20)
	Declare @MaximumUser as nvarchar(20) Set @MaximumUser = '0'
	Declare @ActiveUser as int Set @ActiveUser = 0
	Declare @InActiveUser as int Set @InActiveUser = 0
	Declare @AvailableUser as int Set @AvailableUser = 0
	Declare @TotalUser as int Set @TotalUser = 0

	select @LicenseExpiryDate = Convert(nvarchar(20),DECRYPTBYPASSPHRASE('D1g1tal3',CryptedValue))
	from tblAppSettings Where PropertyName='LicenseExpiryDate'

	select @MaximumUser = Convert(nvarchar(20),DECRYPTBYPASSPHRASE('D1g1tal3',CryptedValue))
	from tblAppSettings Where PropertyName='MaximumUser'


	Select @ActiveUser=Count(*) from tblEmployeeInfo Where isActive=1
	Select @InActiveUser=Count(*) from tblEmployeeInfo Where isActive=0
	Select @TotalUser = Count(*) from tblEmployeeInfo

	Set @AvailableUser = Convert(int,@MaximumUser) - @ActiveUser - @InActiveUser

	select @LicenseExpiryDate as 'LicenseExpiryDate',@MaximumUser as 'MaximumUser',@ActiveUser as 'ActiveUser',
	@InActiveUser as 'InActiveUser',@AvailableUser as 'AvailableUser',@TotalUser as 'TotalUser'

end

GO

-- exec spGetDashBoardInfo

GO
