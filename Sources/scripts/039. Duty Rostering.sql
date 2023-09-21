
GO

alter proc spListAllActiveEmpAttSettings
as
begin
	Select EmpCode,UPPER(EmployeeName) + ' ('+EmpCode+') [' + ISNULL(EI.IdealLoginTime,'')+'-'+ ISNULL(EI.IdealLogOutTime,'') +']' as 'EmployeeName' 
	from tblEmployeeInfo EI 
	INNER JOIN tblDesignation D ON EI.OfficialDesignationID = D.DesignationID
	Where EI.IsActive=1
	order by D.intOrder desc,EI.JoiningDate
end

GO

Create proc spUpdateEmpWiseAttSettings
@EmpList varchar(MAX),
@IdealLoginTime nvarchar(50),
@IdealLogOutTime nvarchar(50)
as
begin
	Update tblEmployeeInfo Set IdealLoginTime = @IdealLoginTime,IdealLogOutTime=@IdealLogOutTime
	Where EmployeeID IN (
	Select dbo.fnGetEmpIDByEmpCode(Value) from dbo.Split(',',@EmpList)
	)
end

GO

Create function fnGetEmpIDByEmpCode(@EmpCode nvarchar(50))
returns nvarchar(50)
as
begin
	Declare @EmployeeID as nvarchar(50) Set @EmployeeID = ''
	Select @EmployeeID=EmployeeID from tblEmployeeInfo Where EmpCode=@EmpCode
	return @EmployeeID
end