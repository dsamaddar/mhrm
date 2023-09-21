Create proc spShowDocumentTypeForGrid
as
begin
	Select DocTypeID,DocumentType,DocumentFor,DocumentCategory,case when IsMandatory='True' 
	then 'Mandatory' else 'Not Mandatory' end as IsMandatory,
	case when IsActive = 1 then 'Active' else 'InActive' end as IsActive,
	Case When IsPerformanceFactor = 1 Then 'YES' Else 'NO' End as 'IsPerformanceFactor',
	PerformanceCriteria
	from tblDocumentType
	order by DocumentType
end