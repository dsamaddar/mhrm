

update tblAppSettings Set CryptedValue=ENCRYPTBYPASSPHRASE('D1g1tal3',PropertyValue)
Where PropertyName='LicenseExpiryDate';

update tblAppSettings Set CryptedValue=ENCRYPTBYPASSPHRASE('D1g1tal3',PropertyValue)
Where PropertyName='MaximumUser';


select PropertyName,PropertyValue,Convert(nvarchar(50),DECRYPTBYPASSPHRASE('D1g1tal3',CryptedValue)) as 'DecryptedText'
from tblAppSettings Where CryptedValue is not null
