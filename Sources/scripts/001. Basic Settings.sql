
/*Clear Database for Meridian Finance & Investment Limited*/

delete from tblEmpSalarySummary;
delete from tblEmpSalaryProfileLog;
delete from tblEmpSalaryProfile;
delete from tblReportQuery;
delete from tblLeaveDetails;
delete from tblLeaveRequest;
delete from tblOutOfOfficeReq;
delete from tblUserDocuments;
delete from tblEmployeeEducationInfo;
delete from tblEmployeeProfessionalCertificationInfo;
delete from tblCallLog;
delete from tblEmpLeaveBalance;
delete from tblHRServiceIssue;
delete from tblCoupons;
delete from tblCouponsPurchase;
delete from tblEmployeeInfo where EmployeeID not in ('EMP-00000098');
delete from leaveinfo;
delete from PrintActivity;
truncate table PrintActivity;

go
/*Clear Database for Meridian Finance & Investment Limited*/

-- exec spCheckUserLogin 'dsamaddar','Farc1lgh#'

alter proc spCheckUserLogin
@EmpCode nvarchar(50),
@UserPassword nvarchar(50)
WITH ENCRYPTION
as
begin
	Declare @LicenseExpiryDate as nvarchar(20)
	Declare @MaximumUser as nvarchar(20) Set @MaximumUser = '0'
	Declare @TotalUser as int Set @TotalUser = 0

	select @LicenseExpiryDate = Convert(nvarchar(20),DECRYPTBYPASSPHRASE('D1g1tal3',CryptedValue))
	from tblAppSettings Where PropertyName='LicenseExpiryDate'

	select @MaximumUser = Convert(nvarchar(20),DECRYPTBYPASSPHRASE('D1g1tal3',CryptedValue))
	from tblAppSettings Where PropertyName='MaximumUser'

	Select @TotalUser = Count(*) from tblEmployeeInfo

	If GETDATE() > Convert(date,@LicenseExpiryDate) 
		return;

	If @TotalUser > Convert(int,@MaximumUser)
		return;

	Select EmployeeID,UserID,UserType,EmployeeName,ULCBranchID,isnull(dbo.fnGetUserPermission(EmployeeID),'') as 'PermittedMenus' from tblEmployeeInfo
	Where UserID=@EmpCode and Password=@UserPassword And EmpStatus='Active' And isActive=1
end

GO

create function fnGetUserPermission(@UniqueUserID nvarchar(50))
returns nvarchar(4000)
as
begin
	Declare @MenuIDs as nvarchar(4000)
	Set @MenuIDs = ''
	Select @MenuIDs = @MenuIDs + isnull(R.MenuIDs,'') from tblUserWiseRole UWR Left Join tblRole R On UWR.RoleID=R.RoleID
	Where UWR.IsActive=1 And UWR.EmployeeID=@UniqueUserID
	
	return isnull(@MenuIDs,'')
end

GO

Create proc spPermissionForOthers
@LoginUserId as nvarchar(50)

as
	Declare @Result as bit

begin
	select @Result=IsPermittedToShowOthers from tblEmployeeInfo where EmployeeID=@LoginUserId
	
	select @Result as Result
end

Go

Create proc spPermissionForOwnInfo
@LoginUserId as nvarchar(50)

as
	Declare @Result as bit

begin
	select @Result=IsPermittedToShowOwn from tblEmployeeInfo where EmployeeID=@LoginUserId
	
	select @Result as Result
end

GO

Create proc spGetEmpNameID
@EmployeeID nvarchar(500)
as
begin
	select EmpCode,
		   isnull(EmployeeName,'') EmployeeName from dbo.tblEmployeeInfo where EmployeeID=@EmployeeID
end

GO

Create proc spGetRelationShipStatus
as
begin
	SELECT RelationshipID,RelName,IsActive,EntryBy,EntryDate FROM tblRelationShipStatus where IsActive =1
end

GO

Create proc spGetBloodGroup
as
begin
	SELECT BloodGroupID,BloodGroupName,isActive,EntryBy,EntryDate FROM tblBloodGroup
	where IsActive =1
end

GO

Create proc spGetOccupationList
as
SELECT OccupationID,OccupationName  FROM tblOccupation where isActive=1 order by OccupationName

GO

Create proc spGetFunctionalDesignation
as
begin
	SELECT DesignationID,DesignationName,DesignationLabel FROM tblDesignation
	where isActive =1 and DesignationType='Functional' order by intOrder
end

GO

Create proc spGetOfficialDesignation
as
	SELECT DesignationID,DesignationName,DesignationLabel FROM tblDesignation
	where isActive =1 and DesignationType='Official' order by intOrder desc

GO

Create proc spGetPreDistrictName
as
begin
	SELECT DISTINCT DistrictName,DistrictID FROM tblDistrict ORDER BY DistrictName
end

GO

Create proc spGetUpazillaName
@DistrictID int
as
begin
	SELECT UpazilaName, UpazilaID FROM tblUpazila WHERE (DistrictID = @DistrictID) ORDER BY UpazilaName
end

GO

Create proc spGetULCBranchList
as
begin
	Select distinct ULCBranchID,ULCBranchName from tblULCBranch Where IsActive=1 and ULCBranchName<>'' order by ULCBranchName
end

GO

Create proc spGetEmployeeList
as
begin
	SELECT EmployeeID,EmployeeName + ' ( ' + EmpCode + ' )' as 'EmployeeName'
	FROM [dbo].tblEmployeeInfo
	where isActive =1 order by EmployeeName
end

GO

Create proc spGetDeptList
as
begin
	Select distinct DepartmentID,DeptName from tblDepartment Where IsActive=1 order by DeptName 
end

GO

Create proc spGetULCBranch
as
begin
	SELECT ULCBranchID,ULCBranchName FROM [dbo].[tblULCBranch]
	where isActive =1 order by ULCBranchName 
end

GO

Create proc spGetEmployeeType
as
begin
	SELECT EmployeeTypeID,EmployeeTypeName FROM tblEmployeeType where isActive =1
end

GO

Create proc spGetBankName
as
begin
	SELECT BankID,BankName FROM tblBank where isActive =1 order by BankName
end

GO

Create proc spGetBranchName
@BankID nvarchar(50)
as
begin
	SELECT BranchID,BranchName FROM tblBranch
	where isActive =1 and BankID=@BankID order by BranchName
end

GO

Create procedure spGetHealthPlanType
as
begin 
	select HealthPlanID,HealthPlanName from tblHealthPlan where IsActive=1 order by HealthPlanName
end

GO

Create function fnGetAgeC(@DOB datetime,@Today datetime)
returns nvarchar(100)
as
begin

	
	DECLARE @tmpdate datetime, @years int, @months int, @days int
	Declare @Result as nvarchar(100)
	SELECT @tmpdate = @DOB

	SELECT @years = DATEDIFF(yy, @tmpdate, @Today) - CASE WHEN (MONTH(@DOB) > MONTH(@Today)) OR (MONTH(@DOB) = MONTH(@Today) AND DAY(@DOB) > DAY(@Today)) THEN 1 ELSE 0 END
	SELECT @tmpdate = DATEADD(yy, @years, @tmpdate)
	SELECT @months = DATEDIFF(m, @tmpdate, @Today) - CASE WHEN DAY(@DOB) > DAY(@Today) THEN 1 ELSE 0 END
	SELECT @tmpdate = DATEADD(m, @months, @tmpdate)
	SELECT @days = DATEDIFF(d, @tmpdate, @Today)
	
	Set @Result = Convert(nvarchar,@years) + ' Years ' + convert(nvarchar,@months) + ' Months ' + convert(nvarchar,@days) + ' Days ' 
	
	return @Result
end

GO

Create function fnGetAgeE(@EmployeeID nvarchar(50))
returns nvarchar(100)
as
begin
	
	Declare @DOB as date;
	Declare @Today as date;
	Declare @IsReleased as bit set @IsReleased = 0;
	Declare @ReleaseDate as date;

	select @DOB = JoiningDate,@IsReleased=IsReleased,@ReleaseDate=ReleaseDate from tblEmployeeInfo where EmployeeID = @EmployeeID;

	DECLARE @tmpdate datetime, @years int, @months int, @days int
	Declare @Result as nvarchar(100)
	SELECT @tmpdate = @DOB

	if @IsReleased = 1
		set @Today = @ReleaseDate;
	else
		set @Today = GETDATE();

	SELECT @years = DATEDIFF(yy, @tmpdate, @Today) - CASE WHEN (MONTH(@DOB) > MONTH(@Today)) OR (MONTH(@DOB) = MONTH(@Today) AND DAY(@DOB) > DAY(@Today)) THEN 1 ELSE 0 END
	SELECT @tmpdate = DATEADD(yy, @years, @tmpdate)
	SELECT @months = DATEDIFF(m, @tmpdate, @Today) - CASE WHEN DAY(@DOB) > DAY(@Today) THEN 1 ELSE 0 END
	SELECT @tmpdate = DATEADD(m, @months, @tmpdate)
	SELECT @days = DATEDIFF(d, @tmpdate, @Today)
	
	Set @Result = Convert(nvarchar,@years) + ' Years ' + convert(nvarchar,@months) + ' Months ' + convert(nvarchar,@days) + ' Days ' 
	
	return @Result
end

GO

Create function generateID(@Prefix nvarchar(50),@sl int, @Len int)
returns nvarchar(50)
as
begin
	Declare @SLen as int
	declare @GID as nvarchar(50)

	set @SLen = @Len - len(@sl)
	set @GID=''

	while @SLen>0
	begin
		set @GID=@GID+'0'
		set @SLen=@SLen-1
	end


	set @GID = @Prefix + @GID + convert(nvarchar,@sl)
	
	return @GID
end

GO

Create FUNCTION Split(@Delimiter varchar(5), @List varchar(8000) ) 
RETURNS @TableOfValues table 
(  [Value] varchar(50)   ) 
AS 
BEGIN

DECLARE @LenString int 

WHILE len( @List ) > 0 
 BEGIN 
 
    SELECT @LenString = 
       (CASE charindex( @Delimiter, @List ) 
           WHEN 0 THEN len( @List ) 
           ELSE ( charindex( @Delimiter, @List ) -1 )
        END
       ) 
                        
    INSERT INTO @TableOfValues 
       SELECT substring( @List, 1, @LenString )
        
    SELECT @List = 
       (CASE ( len( @List ) - @LenString ) 
           WHEN 0 THEN '' 
           ELSE right( @List, len( @List ) - @LenString - 1 ) 
        END
       ) 
 END
  
RETURN 

END 
