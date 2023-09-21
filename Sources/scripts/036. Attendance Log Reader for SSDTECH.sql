
--select * from Entry_t


alter proc spAttLogWriter
@C_Date nvarchar(50),
@C_Time nvarchar(50),
@L_TID int,
@L_UID nvarchar(50)
as
begin
	
	Declare @SLogTime as datetime Set @SLogTime = GETDATE()
	Declare @AuthType as int Set @AuthType = 100
	Declare @LogTime datetime

begin tran

	Declare @LogIndex as numeric(18,0) Set @LogIndex = Convert(numeric, CONCAT(@C_Date,@C_Time))
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Set @LogTime = Convert(datetime, convert(varchar, convert(datetime, @C_Date), 111)
							+ ' ' + substring(@C_Time, 1, 2)
							+ ':' + substring(@C_Time, 3, 2)
							+ ':' + substring(@C_Time, 5, 2)
							);
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	exec spInsertUserAttendance @L_UID,@LogIndex,@LogTime,@L_TID,@AuthType,@SLogTime
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

exec spAttLogWriter '20181011','152002',7,'307300000000000'
