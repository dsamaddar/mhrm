
CREATE TABLE tblHolidays(
HolidayID nvarchar(50) Primary Key,
HolidayDate date,
Purpose nvarchar(500),
IsMailSent bit default 0,
MailSentDate datetime,
EntryBy nvarchar(50),
EntryDate datetime default getdate()
);

GO

Create proc spInsertHolidays
@DateFrom datetime,
@DateTo datetime,
@Purpose nvarchar(500),
@EntryBy nvarchar(50)
as
begin
	Declare @HolidayID as nvarchar(50)
	Declare @CurrentHolidayID numeric(18,0)
	Declare @HolidayIDPrefix as nvarchar(8)
	
	declare @CurrentDate as datetime
	
	set @CurrentDate = @DateFrom   

	set @HolidayIDPrefix='HOLIDAY-'

begin tran
	
	select @CurrentHolidayID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentHolidayID'
	
	 while @CurrentDate<=@DateTo
		begin
			set @CurrentHolidayID=isnull(@CurrentHolidayID,0)+1
			Select @HolidayID=dbo.generateID(@HolidayIDPrefix,@CurrentHolidayID,8)		
			IF (@@ERROR <> 0) GOTO ERR_HANDLER
			
			if not exists(select * from tblHolidays where HolidayDate=@CurrentDate)
			begin
				Insert Into tblHolidays(HolidayID,HolidayDate,Purpose,EntryBy)
				Values(@HolidayID,@CurrentDate,@Purpose,@EntryBy)
				IF (@@ERROR <> 0) GOTO ERR_HANDLER
			end
			
			set @CurrentDate=dateadd(day,1,@CurrentDate)
		
		end
			
		update tblAppSettings set PropertyValue=@CurrentHolidayID where PropertyName='CurrentHolidayID'
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
		

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spGetHolidayList
as
begin
	Select HolidayID,convert(nvarchar,HolidayDate,106) as 'HolidayDate',Purpose from tblHolidays 
	order by convert(datetime,HolidayDate) desc
end

GO

Create proc spGetHolidayInfoByID
@HolidayID nvarchar(50)
as
begin
	SELECT HolidayID,HolidayDate,Purpose
	FROM tblHolidays where HolidayID=@HolidayID 
end


GO

Create proc spDeleteHoliday
@HolidayID nvarchar(50)
as
begin
	Delete from tblHolidays Where HolidayID=@HolidayID 
end


GO

Create proc spUpdateHoliday
@HolidayID nvarchar(50),
@HolidayDate datetime,
@Purpose nvarchar(500),
@EntryBy nvarchar(50)
as
begin
	Update tblHolidays Set HolidayDate=@HolidayDate,Purpose=@Purpose,EntryBy=@EntryBy Where HolidayID=@HolidayID
end

GO

Create proc spUpdateHolidays
@DateFrom datetime,
@Purpose nvarchar(500),
@HolidayID nvarchar(50)
as
begin

begin tran

		UPDATE tblHolidays SET HolidayDate = @DateFrom,Purpose = @Purpose
		WHERE HolidayID = @HolidayID 
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
		
COMMIT TRAN
RETURN 0
ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

