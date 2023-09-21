
if object_id('spGetMajorTypeName') is not null
	drop proc spGetMajorTypeName
GO

Create proc spGetMajorTypeName
as
begin
	SELECT DISTINCT [MajorType], [MajorTypeID] FROM [tblMajorType] where IsActive=1 ORDER BY [MajorType]
end

GO

if object_id('spGetExamName') is not null
	drop proc spGetExamName
GO

Create proc spGetExamName
as
begin
	SELECT ExamName,ExamID FROM tblExamName where bitActive=1 ORDER BY ExamOrder asc
end

GO

if object_id('spGetExamName') is not null
	drop proc spGetExamName
GO

Create proc spGetInstitutionList
as
begin
SELECT InstitutionID,InstitutionName FROM tblInstitutionName 
where isActive=1 order by InstitutionName
end

GO

if object_id('spEmployeeEducationInputAdd') is not null
	drop proc spEmployeeEducationInputAdd

GO

Create procedure spEmployeeEducationInputAdd
@EmployeeID as nvarchar(100),
@IsoParts as nvarchar(4000)
as
begin

	Declare @LogID  as nvarchar(50)
	Declare @RestISOParts as nvarchar(4000)
	Declare @CurrentISOParts as nvarchar(4000)
	Declare @Index as int
	Declare @RestPortion as nvarchar(1000)
	declare @DegreeType as varchar(500)
	declare @ExamID as varchar(500)
	declare @Major as varchar(500)
	declare @InstitutionID as varchar(500)
	declare @OtherInstitutionName as varchar(500)
	declare @PassingYear as integer
	declare @ResultType as varchar(50)
	declare @Result as varchar(500)
	declare @OutOf as numeric(18,2)
	DECLARE @count as int
	Declare @EduID as nvarchar(50)
	Declare @CurrentEduID as numeric(18,0)
	Declare @EduIDPrefix as nvarchar(8)

	set @EduIDPrefix='EMP-EDU-'
		
begin tran
			
		DELETE FROM [dbo].tblEmployeeEducationInfo
		WHERE EmployeeID=@EmployeeID
    
		set @RestISOParts=@IsoParts

		while @RestISOParts<>''
		begin
			
			select @CurrentEduID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentEmployeeEducationID'
	
			set @CurrentEduID=isnull(@CurrentEduID,0)+1
			Select @EduID=dbo.generateID(@EduIDPrefix,@CurrentEduID,8)		
			IF (@@ERROR <> 0) GOTO ERR_HANDLER


			set @Index=CHARINDEX('|',@RestISOParts)
			set @CurrentISOParts=substring(@RestISOParts,1,@Index-1)
			set @RestISOParts=substring(@RestISOParts,@Index+1,len(@RestISOParts))	


			set @RestPortion=@CurrentISOParts
				
			set @Index=CHARINDEX('~',@RestPortion)		
			set @DegreeType=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))		


			set @Index=CHARINDEX('~',@RestPortion)		
			set @ExamID=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))		

			set @Index=CHARINDEX('~',@RestPortion)		
			set @Major=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	

			set @Index=CHARINDEX('~',@RestPortion)		
			set @PassingYear=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
				
			set @Index=CHARINDEX('~',@RestPortion)		
			set @InstitutionID=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
				
			set @Index=CHARINDEX('~',@RestPortion)		
			set @OtherInstitutionName=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
				
			set @Index=CHARINDEX('~',@RestPortion)		
			set @ResultType=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	

			set @Index=CHARINDEX('~',@RestPortion)		
			set @Result=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))
				
			set @Index=CHARINDEX('~',@RestPortion)		
			set @OutOf=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))
				
			INSERT INTO tblEmployeeEducationInfo (EmployeeEducationID,EmployeeID,DegreeType,ExamID,Major,InstitutionID,OtherInstitutionName,PassingYear,ResultType,Result,OutOf )
				VALUES(@EduID,@EmployeeID,@DegreeType,@ExamID,@Major,@InstitutionID,@OtherInstitutionName,@PassingYear,@ResultType,@Result,@OutOf )
				   				   
			update tblAppSettings set PropertyValue=@CurrentEduID where PropertyName='CurrentEmployeeEducationID'
			IF (@@ERROR <> 0) GOTO ERR_HANDLER
			
			Set @InstitutionID = ''

		end

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

if object_id('spGetEmployeeEduInformation') is not null
	drop proc spGetEmployeeEduInformation

GO

Create proc spGetEmployeeEduInformation
@EmployeeID varchar(50)
as
begin

SELECT EmployeeEducationID
      ,EmployeeID
      ,DegreeType 
      ,(select ExamName from  dbo.tblExamName where tblExamName.ExamID=tblEmployeeEducationInfo.ExamID ) ExamName
      ,(select MajorType from dbo.tblMajorType where MajorTypeID=tblEmployeeEducationInfo.Major)[Major]
      ,tblEmployeeEducationInfo.InstitutionID InstitutionID
      ,(select CASE InstitutionName WHEN 'Others' THEN 'Others ( ' + OtherInstitutionName + ' )' ELSE InstitutionName END from dbo.tblInstitutionName where InstitutionID=tblEmployeeEducationInfo.[InstitutionID]) InstitutionName
      ,OtherInstitutionName 
      ,[PassingYear]
      ,[ResultType]
      ,[Result]
      ,tblEmployeeEducationInfo.ExamID ExamID
      ,tblEmployeeEducationInfo.Major MajorID
      ,case when OutOf =0 then 'N\A' else convert(nvarchar,OutOf) end as OutOf
  FROM [dbo].tblEmployeeEducationInfo where EmployeeID=@EmployeeID
  order by PassingYear 
end
