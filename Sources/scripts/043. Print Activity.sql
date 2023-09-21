
CREATE TABLE [dbo].[PrintActivity](
	[ClientDate] [datetime] NOT NULL,
	[ClientTime] [nvarchar](max) NOT NULL,
	[MachineName] [nvarchar](max) NOT NULL,
	[IPAddress] [nvarchar](max) NOT NULL,
	[IPinDWord] [bigint] NOT NULL,
	[UserName] [nvarchar](max) NOT NULL,
	[ModuleName] [nvarchar](max) NOT NULL,
	[ProductName] [nvarchar](max) NOT NULL,
	[PrinterName] [nvarchar](max) NOT NULL,
	[PrintMachine] [nvarchar](max) NOT NULL,
	[PrintCopies] [bigint] NOT NULL,
	[PrintDocument] [nvarchar](max) NOT NULL,
	[PrintPages] [bigint] NOT NULL,
	[ServerName] [nvarchar](max) NOT NULL,
	[ClientOSType] [int] NOT NULL,
	[EntryDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[PrintActivity] ADD  CONSTRAINT [DF_Table_1_Copies]  DEFAULT ((0)) FOR [PrintCopies]
GO

ALTER TABLE [dbo].[PrintActivity] ADD  CONSTRAINT [DF_PrintActivity_ClientOSType]  DEFAULT ((0)) FOR [ClientOSType]
GO

ALTER TABLE [dbo].[PrintActivity] ADD  CONSTRAINT [DF_PrintActivity_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO



Create proc spFetchPrintActivity
as
begin
	
	Declare @MaxEntryDate datetime 
	Select @MaxEntryDate = ISNULL(MAX(EntryDate),DATEADD(DAY,-365,GETDATE())) from PrintActivity;

	Insert Into PrintActivity
	Select * from [ESCAN].[eWconsole_Db].dbo.PrintActivity Where EntryDate > @MaxEntryDate

end

-- exec spFetchPrintActivity

GO

alter proc spGetPrintActivityByUser
@EmployeeID nvarchar(50)
as
begin
	Declare @IPAddress as nvarchar(20) Set @IPAddress = ''
	Select @IPAddress=ISNULL(IPAddress,'') from tblEmployeeInfo Where EmployeeID = @EmployeeID

	Select Convert(nvarchar,ClientDate,106) as 'ClientDate',MachineName,UserName,PrinterName,PrintDocument,PrintCopies,PrintPages
	from PrintActivity Where IPAddress = @IPAddress
	Order by Convert(date,ClientDate) desc
end

-- exec spGetPrintActivityByUser 'EMP-00000098'

GO

-- Top 30 Print Activity

Select top 30 EI.EmployeeName,EI.DeptName,EI.OfficialDesignation,SUM(P.PrintCopies * P.PrintPages) as 'TotalPrint'
from vwEmpInfo EI INNER JOIN PrintActivity P ON EI.IPAddress = P.IPAddress
Where EI.IPAddress IS NOT NULL And DATEPART(MONTH,P.ClientDate)=10 And DATEPART(YEAR,P.ClientDate)=2018
group by EI.EmployeeName,EI.DeptName,EI.OfficialDesignation
order by TotalPrint desc