
/** Merge With Chaser **/

Create proc spMergeChaserDesignationWithHRM
as
begin
-- Create a temporary table variable to hold the output actions.
DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

MERGE INTO Chaser.dbo.tblDesignation AS Target
USING EHRM.dbo.tblDesignation As Source
ON Target.DesignationID = Source.DesignationID
WHEN MATCHED THEN
UPDATE SET DesignationID = Source.DesignationID,DesignationName=Source.DesignationName,
DesignationLabel=Source.DesignationLabel,DesignationType=Source.DesignationType,
HealthPlanID = Source.HealthPlanID,intOrder=Source.intOrder,
IsActive=Source.IsActive,EntryBy=Source.EntryBy,EntryDate=Source.EntryDate
WHEN NOT MATCHED BY TARGET THEN
INSERT (DesignationID, DesignationName,DesignationLabel,DesignationType,HealthPlanID,intOrder,IsActive,EntryBy,EntryDate) 
VALUES (Source.DesignationID, Source.DesignationName,Source.DesignationLabel,Source.DesignationType,Source.HealthPlanID,Source.intOrder,Source.IsActive,Source.EntryBy,Source.EntryDate)
OUTPUT $action INTO @SummaryOfChanges;

-- Query the results of the table variable.
SELECT Change, COUNT(*) AS CountPerChange
FROM @SummaryOfChanges
GROUP BY Change;
End

GO

Create proc spMergeChaserDeptWithHRM
as
begin
-- Create a temporary table variable to hold the output actions.
DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

MERGE INTO Chaser.dbo.tblDepartment AS Target
USING EHRM.dbo.tblDepartment As Source
ON Target.DepartmentID = Source.DepartmentID
WHEN MATCHED THEN
UPDATE SET DepartmentID = Source.DepartmentID,DeptName=Source.DeptName,DeptCode=Source.DeptCode,
IsActive=Source.IsActive,EntryBy=Source.EntryBy,EntryDate=Source.EntryDate
WHEN NOT MATCHED BY TARGET THEN
INSERT (DepartmentID, DeptName,DeptCode,IsActive,EntryBy,EntryDate) 
VALUES (Source.DepartmentID, Source.DeptName,Source.DeptCode,Source.IsActive,Source.EntryBy,Source.EntryDate)
OUTPUT $action INTO @SummaryOfChanges;

-- Query the results of the table variable.
SELECT Change, COUNT(*) AS CountPerChange
FROM @SummaryOfChanges
GROUP BY Change;
End

GO


Create proc spMergeChaserBranchWithHRM
as
begin

-- Create a temporary table variable to hold the output actions.
DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

MERGE INTO Chaser.dbo.tblULCBranch AS Target
USING EHRM.dbo.tblULCBranch As Source
ON Target.ULCBranchID = Source.ULCBranchID
WHEN MATCHED THEN
UPDATE SET ULCBranchID = Source.ULCBranchID,ULCBranchName=Source.ULCBranchName,
BranchLocation=Source.BranchLocation,IsActive=Source.IsActive,EntryBy=Source.EntryBy,EntryDate=Source.EntryDate
WHEN NOT MATCHED BY TARGET THEN
INSERT (ULCBranchID, ULCBranchName,BranchLocation,IsActive,EntryBy,EntryDate) 
VALUES (Source.ULCBranchID, Source.ULCBranchName,Source.BranchLocation,Source.IsActive,Source.EntryBy,Source.EntryDate)
OUTPUT $action INTO @SummaryOfChanges;

-- Query the results of the table variable.
SELECT Change, COUNT(*) AS CountPerChange
FROM @SummaryOfChanges
GROUP BY Change;

End



GO

Create proc spMergeChaserEmpListWithHRM
as
begin

-- Create a temporary table variable to hold the output actions.
DECLARE @SummaryOfChanges TABLE(Change VARCHAR(20));

MERGE INTO Chaser.dbo.tblEmployeeInfo AS Target
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

-- exec spMergeChaserBranchWithHRM
-- exec spMergeChaserDeptWithHRM
-- exec spMergeChaserDesignationWithHRM
-- exec spMergeChaserEmpListWithHRM


/** Merge With Chaser **/