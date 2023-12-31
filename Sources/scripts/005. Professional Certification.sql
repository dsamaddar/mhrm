
if OBJECT_ID('spAddEmpProfCertification') is not null
	drop proc spAddEmpProfCertification

GO

Create procedure spAddEmpProfCertification
@EmployeeID as nvarchar(100),
@isoProfessionalCertificationParts as nvarchar(4000)
as
begin

	Declare @LogID  as nvarchar(50)
	Declare @Coverage as numeric(18,2)
	Declare @RestISOParts as nvarchar(4000)
	Declare @CurrentISOParts as nvarchar(4000)
	Declare @Index as int
	Declare @RestPortion as nvarchar(1000)
	declare @CertificationName as varchar(500)
	declare @InstituteName as varchar(500)
	declare @Location as varchar(500)
	declare @DateFrom as datetime
	declare @DateTo as datetime
	declare @NeverExpire as bit
	Declare @ProfessionalID as nvarchar(50)
	Declare @CurrentProfessionalID as numeric(18,0)
	Declare @ProfessionalIDPrefix as nvarchar(9)
	
	begin tran
	
	set @ProfessionalIDPrefix='EMP-PrCr-'
		
	DELETE FROM tblEmployeeProfessionalCertificationInfo
    WHERE EmployeeID =@EmployeeID 
    
		set @RestISOParts=@isoProfessionalCertificationParts
		while @RestISOParts<>''
		begin
			
			select @CurrentProfessionalID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentEmployeeProCertiID'
	
			set @CurrentProfessionalID=isnull(@CurrentProfessionalID,0)+1
			Select @ProfessionalID=dbo.generateID(@ProfessionalIDPrefix,@CurrentProfessionalID,8)		
			IF (@@ERROR <> 0) GOTO ERR_HANDLER
								
			set @Index=CHARINDEX('|',@RestISOParts)
			set @CurrentISOParts=substring(@RestISOParts,1,@Index-1)
			set @RestISOParts=substring(@RestISOParts,@Index+1,len(@RestISOParts))	

			set @RestPortion=@CurrentISOParts

			set @Index=CHARINDEX('~',@RestPortion)		
			set @CertificationName=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))		

			set @Index=CHARINDEX('~',@RestPortion)		
			set @InstituteName=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	

			set @Index=CHARINDEX('~',@RestPortion)		
			set @Location=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
				
			set @Index=CHARINDEX('~',@RestPortion)		
			set @DateFrom=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
				
			set @Index=CHARINDEX('~',@RestPortion)		
			set @DateTo=substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
				
			set @Index=CHARINDEX('~',@RestPortion)		
			set @NeverExpire =substring(@RestPortion,1,@Index-1)
			set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	
			
			INSERT INTO tblEmployeeProfessionalCertificationInfo
			 (EmployeeProCerID,EmployeeID,CertificationName,InstituteName,Location,IssuingDate,ExpireDate,NeverExpire )
			 VALUES
			 (@ProfessionalID,@EmployeeID,@CertificationName,@InstituteName,@Location,@DateFrom,@DateTo,@NeverExpire )
           
			update tblAppSettings set PropertyValue=@CurrentProfessionalID where PropertyName='CurrentEmployeeProCertiID'
			IF (@@ERROR <> 0) GOTO ERR_HANDLER
		end

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

if OBJECT_ID('spGetEmpProfCertification') is not null
	drop proc spGetEmpProfCertification

GO

Create proc spGetEmpProfCertification
@EmployeeID nvarchar(50)
as
begin
	Select CertificationName as 'Certification',InstituteName as 'Authority' 
	from tblEmployeeProfessionalCertificationInfo Where EmployeeID=@EmployeeID
	order by IssuingDate desc
end

GO

if OBJECT_ID('spGetEmployeeProCertiInformation') is not null
	drop proc spGetEmployeeProCertiInformation

GO

Create proc spGetEmployeeProCertiInformation
@EmployeeID varchar(50)
as
begin
SELECT EmployeeProCerID
      ,EmployeeID
      ,[CertificationName]
      ,[InstituteName]
      ,[Location]
       ,convert(varchar,IssuingDate,106)[IssuingDate]
      ,(case when [ExpireDate]='01-01-1911' then '' else convert(varchar,[ExpireDate],106) end)as [ExpireDate]
      ,case when NeverExpire=1 then 'Never Expire' else '' end as NeverExpire

  FROM [dbo].tblEmployeeProfessionalCertificationInfo
 where EmployeeID=@EmployeeID

end