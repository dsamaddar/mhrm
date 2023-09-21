

drop table tbl_leave_migration;

GO

create table tbl_leave_migration(
sl int identity(1,1),
emp_code nvarchar(50),
emp_name nvarchar(100),
al_leave int,
cl_leave int,
leave_year int default 2022,
taken bit default 0
);

GO

declare @count as int set @count = 0;
declare @ncount as int set @ncount = 0;
declare @sl as int set @sl = 0;
declare @emp_code as nvarchar(50) set @emp_code = '';
declare @al_leave as int set @al_leave = 0;
declare @cl_leave as int set @cl_leave = 0;
declare @emp_id as nvarchar(50) set @emp_id = '';
declare @leave_year as int set @leave_year=2023;

select @ncount = count(*) from tbl_leave_migration;

while @count < @ncount
begin
	select top 1 @sl=sl,@emp_code=emp_code,@al_leave=al_leave,@cl_leave=cl_leave from tbl_leave_migration where taken=0 and leave_year=@leave_year

	select @emp_id = EmployeeID from tblEmployeeInfo where EmpCode = @emp_code;

	if not exists(select * from tblEmpLeaveBalance where LeaveYear=@leave_year and EmployeeID = @emp_id)
	begin
		print @emp_code;
		exec spInsertEmpLeaveBalance @emp_id,@cl_leave,0,@al_leave,0,0,0,@leave_year,'dsamaddar'
	end

	update tbl_leave_migration set taken = 1 where sl=@sl;
	set @emp_id = '';
	set @al_leave = 0;
	set @cl_leave = 0;
	set @count += 1;
end

/*
select * from tblEmployeeInfo where EmpCode='M20220101179'

select * from tblEmployeeInfo where EmployeeName like '%Noor Mohammad%'

*/