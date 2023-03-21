/*Management 
Database mail
smtp.office365.com (se pone en el server name, puerto 587, this server requiere coneccion a sql activar ,authentificacion basica 


Para enviar mensaje 
Click derecho database mail, send email, se agrega el correo
*/


Restore Database Northwind
from disk = 'D:\Base datos\Northwind.bak'
with file = 1,

move 'Northwind' to 'D:\Base datos\ArchivosBD\MDF\Northwind.mdf',
move 'Northwind_1' to 'D:\Base datos\ArchivosBD\NDF\Northwind_1.ndf',
move 'Northwind_2' to 'D:\Base datos\ArchivosBD\NDF\Northwind_2.ndf',
move 'Northwind_log' to 'D:\Base datos\ArchivosBD\LDF\Northwind_Log.ldf'

Restore Filelistonly from disk = 'D:\Base datos\Northwind.bak' 
with File = 1	

Backup database Northwind to disk =
'D:\Base datos\Respaldos\RespaldosNorthwind.bak'

Restore headeronly from disk = 'D:\Base datos'


use model
go 
create table Estudiante(IDEstudiante int)

Create database Universidad

Execute msdb.dbo.sp_send_dbmail
@profile_name = 'Administrador de Base de Datos'
,@recipients = 'dougMontielr@outlook.com',
@copy_recipients = 'dougMontielr@outlook.com',
@subject = 'Catalogos de Regiones',
@body = 'Lista de regiones en el sistema',
@query = 'Exec Northwind.dbo.Regiones',
@attach_query_result_as_file = 1


Use Northwind
Create procedure Regiones
as 
Select * from Northwind.dbo.Region
go
select * from Northwind.dbo.Region


select * from Products
Select * from Orders
select * from [Order Details]

Create Procedure Factura (@NoProducto int)



/* Realizar un procedimiento almacenado que reciba el numero de la orden y enviar por correo electronico la factura mostrar:
NoProducto, NombreProducto, Cantidad, Precio, Descuento, SubTotal, Total IVA, y enviarlo al correo del cliente

Investigar como insertar con html en sql para darle formato a la factura
*/ 