--Cifrar una columna de datos
/*///////////////////////////////////////

Seguridad
Permisos
Los siguientes permisos son necesarios para realizar los pasos siguientes:
Permiso CONTROL en la base de datos.
Permiso CREATE CERTIFICATE en la base de datos. Solo los inicios de sesión de Windows, los inicios de sesión de SQL Server y los roles de aplicación pueden poseer certificados. Los grupos y roles no pueden poseer los certificados.
Permiso ALTER en la tabla.
Algún permiso en la clave y no debe haberse denegado el permiso VIEW DEFINITION.

*////////////////////////////////////////
--creacion Tabla Demo
use PRUEBA; 
go

--drop table ntarjetas
create table ntarjetas (
id int identity (1,1),
nombre nvarchar (50),
Ntarjeta varbinary (max)
);
go

insert into ntarjetas (nombre,Ntarjeta) values
(
'prueba1',
cast ('80730304' as varbinary) -- la conversion es implicita para los tipo numerico
)
go

--------------------creacion de llave 

CREATE MASTER KEY ENCRYPTION BY
PASSWORD = 'Bogota123*';
go

--Nota
--Realice siempre una copia de seguridad de la clave maestra de base de datos

--Para cifrar una columna de datos usando el cifrado simétrico que incluye un autenticador

USE prueba;  
GO  

CREATE CERTIFICATE cerTC 
   WITH SUBJECT = 'Customer Credit Card Numbers';  
GO  

CREATE SYMMETRIC KEY CreditCards_Key11  
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE cerTC;  
GO  

-- Create a column in which to store the encrypted data.  
ALTER TABLE dbo.ntarjetas    
    ADD CardNumber_Encrypted varbinary(160);   
GO  

-- Open the symmetric key with which to encrypt the data.  
OPEN SYMMETRIC KEY CreditCards_Key11  
   DECRYPTION BY CERTIFICATE cerTC ;  

-- Encrypt the value in column CardNumber using the  
-- symmetric key CreditCards_Key11.  
-- Save the result in column CardNumber_Encrypted.    
UPDATE dbo.ntarjetas
SET CardNumber_Encrypted = EncryptByKey(Key_GUID('CreditCards_Key11')  
    , Ntarjeta, 1, HashBytes('SHA1', CONVERT( varbinary  
    , ID)));  
GO  

-- Verify the encryption.  
-- First, open the symmetric key with which to decrypt the data.  

OPEN SYMMETRIC KEY CreditCards_Key11  
   DECRYPTION BY CERTIFICATE cerTC;  
GO  

-- Now list the original card number, the encrypted card number,  
-- and the decrypted ciphertext. If the decryption worked,  
-- the original number will match the decrypted number.  

SELECT Ntarjeta, 

CardNumber_Encrypted   
    AS 'Encrypted card number', 

	CONVERT(nvarchar,  DecryptByKey(CardNumber_Encrypted, 1 ,  HashBytes('SHA1', CONVERT(varbinary, id))))  
    AS 'Decrypted card number' 
	
	FROM dbo.ntarjetas;  
GO