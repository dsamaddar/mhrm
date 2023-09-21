

/**** Inserting Coupon Number ***/

/*Step-01: Make A Backup of Previous Year*/
Select * Into tblCoupons2017 from tblCoupons;

/*Step-02: Reset Previous Entry*/
delete from tblCoupons;

/*Step-03: Inserting Coupon Nos*/

Declare @NoOfTicket as int Set @NoOfTicket=500
Declare @StartingCouponNo as int Set @StartingCouponNo = 1000

While @NoOfTicket >= 0
begin
	Insert Into tblCoupons(CouponNo)
	Values(Convert(nvarchar,@StartingCouponNo))
	
	Set @StartingCouponNo += 1
	Set @NoOfTicket -= 1
end

GO

/*Step-04: No of Prize Need to Set*/
Insert Into tblAppSettings(PropertyName,PropertyValue)
Values('CurrentPrizeNo',60)

GO

/*Step-05: Get Available Tickets to Sell*/
Create proc spGetAvailableTickets
as
begin
	Select SLNO,CouponNo from tblCoupons Where IsSold=0
	order by CouponNo
end
-- exec spGetAvailableTickets

GO

/*Step-06: Confirm Selection*/
alter proc spConfirmTicketSelection
@SLNO int,
@EmployeeID nvarchar(50),
@SoldBy nvarchar(50)
as
begin
	
	Declare @AlreadyOwned as int Set @AlreadyOwned = 0

	Select @AlreadyOwned = Count(*) from tblCoupons Where EmployeeID=@EmployeeID

	--if @AlreadyOwned >= 2
	--	return;

	if not exists(Select * from tblCoupons Where SLNO=@SLNO And IsSold=1)
	begin
		Update tblCoupons Set EmployeeID = @EmployeeID,IsSold=1,SoldBy=@SoldBy,SoldTime=GETDATE()
		Where SLNO = @SLNO
	end
	else
		return;
end

GO

/*Step-07: Get Tickets Owned By Employee*/
Create proc spGetTicketsOwnedByEmp
@EmployeeID nvarchar(50)
as
begin
	Declare @TicketList as nvarchar(200) Set @TicketList=''
	Select @TicketList = @TicketList + CouponNo + ' | ' from tblCoupons
	Where EmployeeID = @EmployeeID And IsSold = 1
	order by CouponNo

	Select @TicketList as 'TicketList'
end

-- exec spGetTicketsOwnedByEmp 'EMP-00000098'
GO

/*Step-08: Export Ticket*/
GO

Create function fnGetTicketsOwnedByEmp(@EmployeeID as nvarchar(50))
returns nvarchar(200)
as
begin
	Declare @TicketList as nvarchar(200) Set @TicketList=''
	Select @TicketList = @TicketList + CouponNo + ' | ' from tblCoupons
	Where EmployeeID = @EmployeeID And IsSold = 1
	order by CouponNo

	return ISNULL(@TicketList,'')
end

-- select dbo.fnGetTicketsOwnedByEmp('EMP-00000098')

GO

alter proc spShowTicketStructureReport
as
begin

	Declare @TicketTbl table(
	EmployeeName nvarchar(200),
	TicketList nvarchar(200),
	Photos nvarchar(50),
	Picture image
	);

	Select * from @TicketTbl Order by EmployeeName
end

GO
-- exec spRptExportTicket 'DEPT-00000003','ALL'

alter proc spRptExportTicket
@DepartmentID nvarchar(50),
@EmployeeID nvarchar(50)
as
begin
	Declare @EmployeeIDParam as nvarchar(50) Set @EmployeeIDParam = ''
	Declare @DepartmentIDParam as nvarchar(50) Set @DepartmentIDParam = ''
	Declare @Picture as varbinary(max)

	if @EmployeeID = 'ALL'
		Set @EmployeeIDParam = '%'
	else
		Set @EmployeeIDParam = '%'+ @EmployeeID +'%'

	if @DepartmentID = 'ALL'
		Set @DepartmentIDParam = '%'
	else
		Set @DepartmentIDParam = '%'+ @DepartmentID +'%'

	Select E.EmployeeID,E.EmployeeName,dbo.fnGetTicketsOwnedByEmp(E.EmployeeID) as 'TicketList',
    CASE E.Photos WHEN NULL THEN 'male_na.png' WHEN '' THEN 'male_na.png' WHEN 'NULL' THEN 'male_na.png' ELSE E.Photos END as 'Photos',
	@Picture as 'Picture'
	from tblEmployeeInfo E
	Where E.EmployeeID like @EmployeeIDParam
	And E.DepartmentID like @DepartmentIDParam
	And E.isActive = 1
	And dbo.fnGetTicketsOwnedByEmp(E.EmployeeID) <> ''
	order by E.EmpCode
end

GO

select * from tblDepartment where Dept

alter proc spRptExportCounterTicket
as
begin
	Select E.EmployeeName,E.EmpCode,E.OfficialDesignation,C.CouponNo
	from tblCoupons C INNER JOIN vwEmpInfo E ON C.EmployeeID=E.EmployeeID
	Where IsSold=1
	order by CouponNo
end

-- exec spRptExportCounterTicket

GO
/*---------------------------------------------------------------------------------------*/

if object_id('tblCoupons') is not null
	drop table tblCoupons

Create table tblCoupons(
SLNO int identity(1,1) primary key,
EmployeeID nvarchar(50) foreign key references tblEmployeeInfo(EmployeeID),
CouponNo nvarchar(10) unique(CouponNo),
IsSold bit default 0,
SoldBy nvarchar(50),
SoldTime datetime,
IsSelected bit default 0,
SelectionTime datetime,
PrizeNo	int default 0
);

GO

/*

Declare @EmpTbl as table(
EmployeeID nvarchar(50),
Taken bit default 0
);

Insert Into @EmpTbl(EmployeeID)
Select EmployeeID from tblEmployeeInfo Where isActive=1 

--Select * from @EmpTbl

Declare @Count as int Set @Count=1
Declare @NCount as int Set @NCount=0

Select @Count=Count(*) from tblCoupons
Set @Count = @Count + 1
Select @NCount=Count(*) from @EmpTbl
Set @NCount = @NCount + @Count

Declare @EmployeeID as nvarchar(50) Set @EmployeeID=''
Declare @CouponNo as nvarchar(4) Set @CouponNo=''
Declare @CurrentCouponNo as nvarchar(4) Set @CurrentCouponNo=''
Declare @CouponPrefix as nvarchar(1)
set @CouponPrefix=''

While @Count < @NCount
begin

	Select top 1 @EmployeeID=EmployeeID from @EmpTbl Where Taken=0
	
	set @CurrentCouponNo= Convert(nvarchar,@Count)
	Select @CouponNo=dbo.generateID(@CouponPrefix,@CurrentCouponNo,4)

	Insert into tblCoupons(EmployeeID,CouponNo)
	Values(@EmployeeID,@CouponNo)

	Update @EmpTbl Set Taken=1 Where EmployeeID=@EmployeeID
	Set @Count = @Count + 1
	Set @EmployeeID = ''
	Set @CouponNo = ''

end

select * from tblCoupons

*/

GO

if object_id('spSelectWinner') is not null
	drop proc spSelectWinner
GO

Create proc spSelectWinner
as
begin

	DECLARE @Random as INT 
	DECLARE @Upper as INT SET @Upper = 0
	DECLARE @Lower as INT SET @Lower = 1
	
	Declare @RaffleDrawBox as table(
	SLNO int identity(1,1),
	EmployeeID nvarchar(50),
	CouponNo nvarchar(10)
	);

	Insert Into @RaffleDrawBox(EmployeeID,CouponNo)
	Select EmployeeID,CouponNo from tblCoupons Where IsSelected=0

	Select @Upper = Count(*) from @RaffleDrawBox
	

	SELECT @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)

	Select RB.EmployeeID,RB.CouponNo,EI.EmployeeName,ISNULL(EI.Photos,'') as 'Photos'
	from @RaffleDrawBox RB Inner Join tblEmployeeInfo EI On RB.EmployeeID=EI.EmployeeID
	Where RB.SLNO = @Random
	
end

-- exec spSelectWinner

GO

If object_id('spUpdateSelection') is not null
	drop proc spUpdateSelection

GO

Create proc spUpdateSelection
@CouponNo nvarchar(50)
as
begin
	Declare @CurrentPrizeNo as numeric(18,0) Set @CurrentPrizeNo = 0

	select @CurrentPrizeNo = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentPrizeNo'
	
	Update tblCoupons Set IsSelected=1,SelectionTime=GETDATE(),PrizeNo=@CurrentPrizeNo Where CouponNo=@CouponNo

	Set @CurrentPrizeNo = @CurrentPrizeNo - 1
	update tblAppSettings set PropertyValue=@CurrentPrizeNo where PropertyName='CurrentPrizeNo'
end
	
GO

if object_id('spGetCurrentPrizeNo') is not null
	drop proc spGetCurrentPrizeNo

GO

Create proc spGetCurrentPrizeNo
as
begin
	Declare @CurrentPrizeNo as numeric(18,0) Set @CurrentPrizeNo = 0

	select @CurrentPrizeNo = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentPrizeNo'
	
	Select @CurrentPrizeNo as 'CurrentPrizeNo'
end

-- exec spGetCurrentPrizeNo

GO

-- Uploading Data
/*
Insert into tblCoupons(EmployeeID,CouponNo)
select EI.EmployeeID,CP.CouponNo from tblCouponsPurchase CP INNER JOIN tblEmployeeInfo EI ON CP.EmpCode=EI.EmpCode
*/

GO

--update tblCoupons Set IsSelected=0,SelectionTime=NULL,PrizeNo=0

