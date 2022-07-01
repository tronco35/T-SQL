use AWDataWarehouse
go

exec sys.sp_cdc_enable_db
go

exec sys.sp_cdc_enable_table
@source_schema = N'dbo',

@source_name = N'Product',

@role_name = null ,
/* Es el nombre de la funci�n de la base de datos utilizada para acceder a la 
puerta de acceso para cambiar los datos. role_name es sysname y debe ser especificado. 
Si se establece expl�citamente en NULL, no se usa ninguna funci�n de compuerta para limitar el 
acceso a los datos de cambio. */

@supports_net_changes = 1
/*Indica si la compatibilidad para consultar los cambios en la red debe habilitarse para esta 
instancia de captura. supports_net_changes est� bit con un valor predeterminado de 1 si la tabla 
tiene una clave principal o la tabla tiene un �ndice �nico que se ha identificado mediante el uso 
del par�metro @index_name. De lo contrario, el par�metro predeterminado es 0. */


	