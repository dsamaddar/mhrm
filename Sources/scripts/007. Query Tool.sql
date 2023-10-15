
if OBJECT_ID('spGetAllEntityByType') is not null
	drop proc spGetAllEntityByType

GO

Create  proc spGetAllEntityByType
@TABLE_CATALOG as nvarchar(200),
@TABLE_TYPE as nvarchar(200)
as
begin
	Select distinct TABLE_NAME from  information_schema.tables 
	Where TABLE_CATALOG=@TABLE_CATALOG and TABLE_TYPE=@TABLE_TYPE
	--and TABLE_NAME not in(
	--	'tblUser','tblUserRole','AppSetting','_1190'
	--)	
	Order By TABLE_NAME
end

GO

if OBJECT_ID('spGetColumnNamesByEntity') is not null
	drop proc spGetColumnNamesByEntity

GO

Create proc spGetColumnNamesByEntity
@TABLE_CATALOG as nvarchar(200),
@TABLE_NAME as nvarchar(200)
as
begin
	Select COLUMN_NAME,DATA_TYPE from information_schema.columns 
	Where TABLE_CATALOG=@TABLE_CATALOG and TABLE_NAME=@TABLE_NAME
end

GO

Create View vwKeyConstraintList
as
SELECT        TC.CONSTRAINT_SCHEMA + '.' + TC.TABLE_NAME AS PRIMARYKEYTABLE, TC.CONSTRAINT_NAME AS PRIMARYKEY, 
CU.COLUMN_NAME AS [PRIMARY COLUMN Name], COALESCE (RC1.CONSTRAINT_NAME, N'N/A') AS FOREIGNKEY, COALESCE (CFU.COLUMN_NAME, N'N/A') 
AS [FOREIGN COLUMN Name], CASE WHEN TC2.TABLE_NAME IS NULL 
THEN 'N/A' ELSE TC.CONSTRAINT_SCHEMA + '.' + TC2.TABLE_NAME END AS FOREIGNKEYTABLE
FROM            INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC INNER JOIN
INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS CU ON TC.TABLE_NAME = CU.TABLE_NAME AND TC.TABLE_SCHEMA = CU.TABLE_SCHEMA AND 
TC.CONSTRAINT_NAME = CU.CONSTRAINT_NAME LEFT OUTER JOIN
INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS AS RC1 ON TC.CONSTRAINT_NAME = RC1.UNIQUE_CONSTRAINT_NAME LEFT OUTER JOIN
INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS TC2 ON TC2.CONSTRAINT_NAME = RC1.CONSTRAINT_NAME LEFT OUTER JOIN
INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE AS CFU ON RC1.CONSTRAINT_NAME = CFU.CONSTRAINT_NAME
WHERE        (TC.CONSTRAINT_TYPE = 'PRIMARY KEY')
GO
