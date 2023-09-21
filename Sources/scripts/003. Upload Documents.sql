
USE EHRM

GO

Create proc spInsertDocumentList
@DocTypeID nvarchar(50),
@UniqueUserID nvarchar(50),
@DocumentName nvarchar(200),
@FileName nvarchar(200),
@IssueDate datetime,
@EffectiveDate datetime,
@Remarks nvarchar(200),
@UploadedBy nvarchar(50)
as
begin
	Declare @DocumentID nvarchar(50)
	Declare @CurrentDocumentID numeric(18,0)
	Declare @DocumentIDPrefix as nvarchar(7)

	set @DocumentIDPrefix='DOC-'

begin tran
	
	select @CurrentDocumentID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentDocumentID'
	
	set @CurrentDocumentID=isnull(@CurrentDocumentID,0)+1
	Select @DocumentID=dbo.generateID(@DocumentIDPrefix,@CurrentDocumentID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

	Insert into tblUserDocuments(DocumentID,DocTypeID,UniqueUserID,DocumentName,FileName,IssueDate,EffectiveDate,Remarks,UploadedBy)
	Values(@DocumentID,@DocTypeID,@UniqueUserID,@DocumentName,@FileName,@IssueDate,@EffectiveDate,@Remarks,@UploadedBy)

	update tblAppSettings set PropertyValue=@CurrentDocumentID where PropertyName='CurrentDocumentID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO


Create proc spInsertDocumentType
@DocumentType nvarchar(200),
@DocTypeFor nvarchar(100),
@DocumentCategory nvarchar(50),
@IsMandatory bit,
@IsActive bit,
@IsPerformanceFactor bit,
@PerformanceCriteria nvarchar(50),
@EntryBy nvarchar(50)
as
begin

	Declare @DocTypeID as nvarchar(50)
	Declare @CurrentDocTypeID numeric(18,0)
	Declare @DocTypeIDPrefix as nvarchar(9)

	set @DocTypeIDPrefix='DOC-TYPE-'

begin tran
	
	select @CurrentDocTypeID = cast(PropertyValue as numeric(18,0)) from tblAppSettings where  PropertyName='CurrentDocTypeID'
	
	set @CurrentDocTypeID=isnull(@CurrentDocTypeID,0)+1
	Select @DocTypeID=dbo.generateID(@DocTypeIDPrefix,@CurrentDocTypeID,8)		
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
	insert into tblDocumentType(DocTypeID,DocumentType,DocumentFor,DocumentCategory,IsMandatory,IsActive,IsPerformanceFactor,PerformanceCriteria,EntryBy)
	values(@DocTypeID,@DocumentType,@DocTypeFor,@DocumentCategory,@IsMandatory,@IsActive,@IsPerformanceFactor,@PerformanceCriteria,@EntryBy)

	update tblAppSettings set PropertyValue=@CurrentDocTypeID where PropertyName='CurrentDocTypeID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO


Create proc spInsertUserDocuments
@Documents nvarchar(4000),
@UniqueUserID nvarchar(50),
@UploadedBy nvarchar(50)
as
begin
	Declare @CurrentDocumentsID as bigint
	Declare @DocumentID as nvarchar(50)
	Declare @DocumentsPrefix as nvarchar(4)
	Declare @CurrentDocuments as nvarchar(200)	
	Declare @RestDocuments as nvarchar(4000)
	Declare @Title as nvarchar(50)
	Declare @FileName as nvarchar(50)

	Declare @Index as int
	Declare @RestPortion as nvarchar(4000)
	
	declare @Todate datetime	
	set @Todate=getdate()
	
	Declare @DocTypeID as nvarchar(50)

begin tran

	Select @CurrentDocumentsID=PropertyValue from tblAppSettings where PropertyName='CurrentDocumentID'
	set @CurrentDocumentsID=isnull(@CurrentDocumentsID,0)+1
	set @DocumentsPrefix='DOC-'
	Select @DocumentID = dbo.generateID(@DocumentsPrefix,@CurrentDocumentsID,8)		

	set @RestDocuments=@Documents
	while @RestDocuments<>''
	begin
		set @Index=CHARINDEX('|',@RestDocuments)
		set @CurrentDocuments=substring(@RestDocuments,1,@Index-1)
		set @RestDocuments=substring(@RestDocuments,@Index+1,len(@RestDocuments))		

		set @RestPortion=@CurrentDocuments

		set @Index=CHARINDEX('~',@RestPortion)		
		set @Title=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))		

		set @Index=CHARINDEX('~',@RestPortion)		
		set @FileName=substring(@RestPortion,1,@Index-1)
		set @RestPortion=substring(@RestPortion,@Index+1,len(@RestPortion))	

		set @Index=CHARINDEX('~',@RestPortion)		
		set @DocTypeID=substring(@RestPortion,1,@Index-1)
		
		set @CurrentDocumentsID=@CurrentDocumentsID+1
		Select @DocumentID=dbo.generateID(@DocumentsPrefix,@CurrentDocumentsID,8)

		INSERT INTO tblUserDocuments(DocumentID,DocTypeID,UniqueUserID, DocumentName,[FileName],UploadedBy,UploadedDate)
		VALUES(@DocumentID,@DocTypeID,@UniqueUserID,@Title,@FileName,@UploadedBy,@Todate)	
		IF (@@ERROR <> 0) GOTO ERR_HANDLER
		
		set @CurrentDocumentsID=@CurrentDocumentsID + 1
		Select @DocumentID = dbo.generateID(@DocumentsPrefix,@CurrentDocumentsID,8)	
		
	end

	update tblAppSettings set PropertyValue=@CurrentDocumentsID where PropertyName='CurrentDocumentID'
	IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
IF (@@ERROR <> 0) GOTO ERR_HANDLER
	
commit tran
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

Go


Create proc spShowDocumentType
@DocumentFor as nvarchar(100)
as
begin
	Select DocTypeID,DocumentType from tblDocumentType where DocumentFor=@DocumentFor 
	order by DocumentType
end

GO

Create proc spShowDocumentTypeByID
@DocTypeID as nvarchar(50)
as
begin
	Select DocTypeID,DocumentType,DocumentFor,DocumentCategory,IsMandatory,IsActive,IsPerformanceFactor
	from tblDocumentType where DocTypeID=@DocTypeID
end

GO


Create proc spUpdateDocumentType
@DocTypeID nvarchar(50),
@DocumentType nvarchar(200),
@DocTypeFor nvarchar(100),
@DocumentCategory nvarchar(50),
@IsMandatory bit,
@IsActive bit,
@IsPerformanceFactor bit,
@PerformanceCriteria nvarchar(50)
as
begin

begin tran
		
	UPDATE tblDocumentType
	   SET DocumentType = @DocumentType,DocumentFor = @DocTypeFor,DocumentCategory=@DocumentCategory
		  ,IsMandatory = @IsMandatory,IsActive = @IsActive
		  ,IsPerformanceFactor=@IsPerformanceFactor,PerformanceCriteria=@PerformanceCriteria
		WHERE DocTypeID=@DocTypeID
	IF (@@ERROR <> 0) GOTO ERR_HANDLER

COMMIT TRAN
RETURN 0

ERR_HANDLER:
ROLLBACK TRAN
RETURN 1
end

GO

Create proc spGetEmpDocuments
@UniqueUserID nvarchar(50),
@DocumentCategory nvarchar(50)
as
begin
	Select UD.DocumentID,UD.DocumentName,D.DocumentType as 'DocTypeName',D.DocumentCategory,FileName,
	D.DocTypeID,convert(nvarchar,UD.IssueDate,106) IssueDate,convert(nvarchar,UD.EffectiveDate,106) EffectiveDate
	from tblUserDocuments UD inner join tblDocumentType D On UD.DocTypeID=D.DocTypeID 
	where UD.UniqueUserID=@UniqueUserID And D.DocumentCategory=@DocumentCategory
end

Go

Create proc spDeleteUserDocuments
@DocumentID nvarchar(50)
as
begin
	Delete from tblUserDocuments Where DocumentID=@DocumentID
end