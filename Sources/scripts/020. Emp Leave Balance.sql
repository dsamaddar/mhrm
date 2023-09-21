
--delete from tblEmpLeaveBalance
create table tblEmpLeaveBalance(
EmpLeaveBalanceID nvarchar(50) primary key,
EmployeeID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
CasualLeave int default 0,
MedicalLeave int default 0,
AnnualLeave int default 0,
MaternityLeave int default 0,
LeaveWithOutPay int default 0,
SpecialLeave int default 0,
TotalLeave as CasualLeave+MedicalLeave+AnnualLeave+MaternityLeave+LeaveWithOutPay+SpecialLeave,
LeaveYear int not null,
IsActive int default 1,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO
-- exec spInsertEmpLeaveBalance 'EMP-00000133',0,0,0,0,0,0,2018,'dsamaddar'
alter proc spInsertEmpLeaveBalance
@EmployeeID nvarchar(50),
@CasualLeave int,
@MedicalLeave int,
@AnnualLeave int,
@MaternityLeave int,
@LeaveWithOutPay int,
@SpecialLeave int,
@LeaveYear int,
@EntryBy nvarchar(50)
as
begin
	Declare @EmpLeaveBalanceID as nvarchar(50)
	Declare @CurrentEmpLeaveBalanceID numeric(18,0)
	Declare @EmpLeaveBalanceIDPrefix as nvarchar(10)

	DECLARE @ErrorNumber INT = 0;
    --DECLARE @ErrorLine INT = ERROR_LINE();
    DECLARE @ErrorMessage NVARCHAR(4000) = '';
    DECLARE @ErrorSeverity INT = 0;
    DECLARE @ErrorState INT = 0;

	set @EmpLeaveBalanceIDPrefix='EMP-L-BAL-'

BEGIN TRY
	if exists(Select * from tblEmpLeaveBalance Where EmployeeID=@EmployeeID and LeaveYear=@LeaveYear)
	begin
		Set @ErrorNumber = 30001
		Set @ErrorMessage = 'Leave Balance Already Exists for the Same Year'
		Set @ErrorSeverity = 16
		Set @ErrorState = 1
		--GOTO ERR_HANDLER
		--ROLLBACK TRAN
		--PRINT 'B'
		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
		
		--return;
	end
	else
	begin
		BEGIN TRANSACTION
			select @CurrentEmpLeaveBalanceID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentEmpLeaveBalanceID'
	
			set @CurrentEmpLeaveBalanceID=isnull(@CurrentEmpLeaveBalanceID,0)+1
			Select @EmpLeaveBalanceID=dbo.generateID(@EmpLeaveBalanceIDPrefix,@CurrentEmpLeaveBalanceID,8)		
			--IF (@@ERROR <> 0) GOTO ERR_HANDLER

			Insert Into tblEmpLeaveBalance(EmpLeaveBalanceID,EmployeeID,CasualLeave,MedicalLeave,AnnualLeave,MaternityLeave,
			LeaveWithOutPay,SpecialLeave,LeaveYear,EntryBy)
			Values(@EmpLeaveBalanceID,@EmployeeID,@CasualLeave,@MedicalLeave,@AnnualLeave,@MaternityLeave,
			@LeaveWithOutPay,@SpecialLeave,@LeaveYear,@EntryBy)
			--IF (@@ERROR <> 0) GOTO ERR_HANDLER

			update tblAppSettings set PropertyValue=@CurrentEmpLeaveBalanceID where PropertyName='CurrentEmpLeaveBalanceID'
			--IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
		COMMIT TRAN
	end
END TRY
BEGIN CATCH
	--PRINT 'C';
	if @@trancount <> 0
		ROLLBACK TRANSACTION
	RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
	THROW
END CATCH
end

GO

alter proc spUpdateEmpLeaveBalance
@EmpLeaveBalanceID nvarchar(50),
@EmployeeID nvarchar(50),
@CasualLeave int,
@MedicalLeave int,
@AnnualLeave int,
@MaternityLeave int,
@LeaveWithOutPay int,
@SpecialLeave int,
@LeaveYear int,
@EntryBy nvarchar(50)
as
begin
	
BEGIN TRY
		BEGIN TRANSACTION
		
		Update 	tblEmpLeaveBalance Set EmployeeID=@EmployeeID,CasualLeave=@CasualLeave,
		MedicalLeave=@MedicalLeave,AnnualLeave=@AnnualLeave,MaternityLeave=@MaternityLeave,
		LeaveWithOutPay=@LeaveWithOutPay,SpecialLeave=@SpecialLeave,LeaveYear=@LeaveYear,EntryBy=@EntryBy,
		EntryDate=GETDATE()
		Where EmpLeaveBalanceID = @EmpLeaveBalanceID
	
		COMMIT TRAN
END TRY
BEGIN CATCH
	if @@trancount <> 0
		ROLLBACK TRANSACTION
	THROW
END CATCH
end

GO
-- exec spGetAllEmpLeaveBalance 'EMP-00000003'
alter proc spGetAllEmpLeaveBalance
@EmployeeID nvarchar(50)
as
begin
	Declare @EmployeeIDParam as nvarchar(50)
	If @EmployeeID = 'N\A'
		Set @EmployeeIDParam = '%'
	else
		Set @EmployeeIDParam = '%'+ @EmployeeID +'%'

	Select EmpLeaveBalanceID,LB.EmployeeID,'( '+ EI.EmpCode +') '+EI.EmployeeName as EmployeeName,CasualLeave,
	MedicalLeave,AnnualLeave,MaternityLeave,LeaveWithOutPay,SpecialLeave,LeaveYear,LB.EntryBy,
	Convert(nvarchar,LB.EntryDate,106) as 'EntryDate'
	from tblEmpLeaveBalance LB INNER JOIN tblEmployeeInfo EI ON LB.EmployeeID = EI.EmployeeID
	Where LB.IsActive = 1 And LB.EmployeeID like @EmployeeIDParam
	and EI.isActive = 1
	Order By EI.EmpCode,EmployeeName
end

GO

Create proc spGetEmpLeaveBalanceByID
@EmpLeaveBalanceID nvarchar(50)
as
begin
	Select EmpLeaveBalanceID,LB.EmployeeID,EI.EmployeeName,CasualLeave,MedicalLeave,AnnualLeave,MaternityLeave,
	LeaveWithOutPay,SpecialLeave,LeaveYear,LB.EntryBy,LB.EntryDate
	from tblEmpLeaveBalance LB INNER JOIN tblEmployeeInfo EI ON LB.EmployeeID = EI.EmployeeID
	Where LB.IsActive = 1 And LB.EmpLeaveBalanceID = @EmpLeaveBalanceID
end

GO
-- drop table tblEmpLeaveBalanceTest
create table tblEmpLeaveBalanceTest(
sl int identity(1,1),
EmployeeID nvarchar(50),
casual int,
medical int,
annual int,
maternity int,
leavewithoutpay int,
special int,
years int
);

/*
Insert into tblEmpLeaveBalance(EmpLeaveBalanceID,EmployeeID,CasualLeave,MedicalLeave,AnnualLeave,MaternityLeave,LeaveWithOutPay,SpecialLeave,LeaveYear)
select Convert(nvarchar,A.sl),B.EmployeeID,A.casual,A.medical,A.annual,A.maternity,A.leavewithoutpay,A.special,A.years 
from tblEmpLeaveBalanceTest A INNER JOIN tblEmployeeInfo B ON A.EmployeeID = B.EmpCode
*/
--select * from tblEmpLeaveBalance

GO

alter proc spGetSubOrdinateLeaveBalance
@EmployeeID nvarchar(50)
as
begin
	select LB.EmployeeID,E.EmployeeName,LB.CasualLeave,LB.MedicalLeave,LB.AnnualLeave,Lb.MaternityLeave,LB.LeaveWithOutPay,LB.SpecialLeave,LB.TotalLeave
	from tblEmpLeaveBalance LB INNER JOIN tblEmployeeInfo E ON LB.EmployeeID=E.EmployeeID
	Where LB.IsActive=1 And E.isActive = 1 And E.CurrentSupervisor = @EmployeeID
	UNION ALL
	select LB.EmployeeID,E.EmployeeName,LB.CasualLeave,LB.MedicalLeave,LB.AnnualLeave,Lb.MaternityLeave,LB.LeaveWithOutPay,LB.SpecialLeave,LB.TotalLeave
	from tblEmpLeaveBalance LB INNER JOIN tblEmployeeInfo E ON LB.EmployeeID=E.EmployeeID
	Where LB.EmployeeID=@EmployeeID AND LB.IsActive=1
	order by EmployeeName;
end

-- exec spGetSubOrdinateLeaveBalance 'EMP-00000070'

