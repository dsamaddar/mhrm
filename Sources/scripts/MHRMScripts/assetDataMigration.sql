/*
EXEC sp_configure 'Show Advanced Options', 1
RECONFIGURE
GO
EXEC sp_configure 'Ad Hoc Distributed Queries', 1
RECONFIGURE
GO
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1
GO
EXEC sp_MSSet_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1
*/

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'tblAssetList')
BEGIN
    drop table tblAssetList
END

GO

create table tblAssetList(
DEVICE_TYPE nvarchar(50),
BRANCH nvarchar(50),
USER_NAME nvarchar(50),
MODEL nvarchar(50),
ASSET_TAG nvarchar(50),
HOST_NAME nvarchar(50),
DESCRIPTION nvarchar(300),
VENDOR nvarchar(100),
PURCHASE_DATE date,
WARRANTY nvarchar(50),
ASSIGNED_IP nvarchar(50),
LICENSE_KEY nvarchar(100),
PRICE numeric(18,2),
STATUS nvarchar(50),
ENTRY_DT datetime default getdate()
);

GO

insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [Desktop$]')

GO
insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [Monitor$]')

GO
insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [Laptop$]')

GO
insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [Printer$]')

GO
insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [Scanner$]')

GO
insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [Switch$]')

GO
insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [Router$]')

GO
insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [Firewall$]')

GO
insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [HyperV$]')

GO
insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [StorageServer$]')

GO
insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [IPPBXServer$]')

GO
insert into tblAssetList(DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS)
select DEVICE_TYPE,BRANCH,USER_NAME,MODEL,ASSET_TAG,HOST_NAME,DESCRIPTION,VENDOR,PURCHASE_DATE,WARRANTY,ASSIGNED_IP,LICENSE_KEY,PRICE,STATUS 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 8.0;Database=C:\db_bck\asset_list.xlsx;','SELECT * FROM [IPPBXPhoneSet$]')

GO

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spGetAssetList')
BEGIN
    DROP  Procedure  spGetAssetList
END

GO
create proc spGetAssetList
@UserID nvarchar(50)
as
begin

	Declare @usr_id as nvarchar(50) set @usr_id = '';

	select @usr_id = UserID from tblEmployeeInfo where EmployeeID = @UserID;

	select * from tblAssetList where [USER_NAME]= @usr_id
end

-- exec spGetAssetList 'dsamaddar'