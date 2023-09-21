

declare @leavetbl table(
slno int,
empid nvarchar(50),
startdate date,
enddate date,
taken bit default 0
);

insert into @leavetbl(slno,empid,startdate,enddate)
select slno,empid,startdate,enddate from leaveinfo

declare @id as int set @id = 0
declare @slno as int Set @slno = 0
Declare @EmployeeID as nvarchar(50) Set @EmployeeID = ''
Declare @empid as nvarchar(50) Set @empid = ''
Declare @startdate as date
Declare @enddate as date
declare @Count as int Set @Count = 1
declare @NCount as int Set @NCount = 0

select @NCount = Count(*) from @leavetbl

while @Count <= @NCount
begin
	select top 1 @slno = slno,@empid=empid,@startdate=startdate,@enddate=enddate  from @leavetbl where taken = 0
	Set @id = @id + 1
	select @EmployeeID=EmployeeID from tblEmployeeInfo Where EmpCode=@empid

	while @startdate <= @enddate
	begin
				
		INSERT INTO tblLeaveDetails(LeaveDetailID,LeaveBalanceID,LeaveRequestID,EmployeeID,LeaveDate)
		VALUES(@id,NULL,NULL,@EmployeeID,@startdate)

		Set @startdate = DATEADD(DAY,1,@startdate)
		Set @id = @id + 1
	end

	update @leavetbl set taken = 1 where slno = @slno
	Set @Count = @Count + 1
end

