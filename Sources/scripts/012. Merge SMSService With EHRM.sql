
Create proc spMergeSMSServiceEmpListWithHRM
as
begin

-- Create a temporary table variable to hold the output actions.
DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

MERGE INTO SMSService.dbo.tblEmployeeInfo AS Target
USING EHRM.dbo.tblEmployeeInfo As Source
ON Target.EmployeeID = Source.EmployeeID
WHEN MATCHED THEN

UPDATE SET 
UserID=Source.UserID,UserPassword=Source.Password,EmployeeName=Source.EmployeeName,
EmpCode=Source.EmpCode,DateOfBirth=Source.DateOfBirth,JoiningDate=Source.JoiningDate,DesignationID=Source.OfficialDesignationID,
DepartmentID=Source.DepartmentID,ULCBranchID=Source.ULCBranchID,CurrentSupervisor=Source.CurrentSupervisor,
EmpStatus=Source.EmpStatus,MailAddress=Source.Email,MobileNo=Source.MobileContact,IsActive=Source.IsActive

WHEN NOT MATCHED BY TARGET THEN
INSERT (EmployeeID,UserID,UserPassword,UserType,EmployeeName,EmpCode,DateOfBirth,JoiningDate,DesignationID,DepartmentID,ULCBranchID,
CurrentSupervisor,EmpStatus,MailAddress,MobileNo,IsActive,EntryBy,EntryDate) 
VALUES (Source.EmployeeID,Source.UserID,Source.Password,Source.UserType,Source.EmployeeName,Source.EmpCode,Source.DateOfBirth,
Source.JoiningDate,Source.OfficialDesignationID,Source.DepartmentID,Source.ULCBranchID,Source.CurrentSupervisor,
Source.EmpStatus,Source.Email,Source.MobileContact,Source.IsActive,Source.EntryBy,Source.EntryDate)
OUTPUT $action INTO @SummaryOfChanges;

-- Query the results of the table variable.
SELECT Change, COUNT(*) AS CountPerChange
FROM @SummaryOfChanges
GROUP BY Change;

End