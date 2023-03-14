
--Visualizar el contenido del archivo .BAK

Restore Headeronly from disk = 
'D:\Base de datos\Respaldo\Northwind.bak'

Restore Filelistonly from disk = 'D:\Base de datos\Respaldo\Northwind.bak' 
with File = 1	

--Restaurando la base de datos Northwind

Restore Database Northwind
from disk = 'D:\Base de datos\Respaldo\Northwind.bak'
with file = 1,
/*Este backup se encuentra en otra direccion asi que hay que moverlo*/
--Movemos creando carpetas MDF, NDF, LDF

move 'Northwind' to 'D:\Base de datos\Archivos BD\MDF\Northwind.mdf',
move 'Northwind_1' to 'D:\Base de datos\Archivos BD\NDF\Northwind_1.ndf',
move 'Northwind_2' to 'D:\Base de datos\Archivos BD\NDF\Northwind_2.ndf',
move 'Northwind_log' to 'D:\Base de datos\Archivos BD\LDF\Northwind_Log.ldf'

--Respaldo BD Northwind con nueva ubicacion
Backup database Northwind to disk =
'D:\Base de datos\Respaldo\NorthwindRespaldo.bak'

Restore Headeronly from disk = 
'D:\Base de datos\Respaldo\NorthwindRespaldo.bak'

Restore filelistonly from disk = 
'D:\Base de datos\Respaldo\NorthwindRespaldo.bak'
with file =2

--Ya cambio la ubicacion
Restore filelistonly from disk = 
'D:\Base de datos\Respaldo\NorthwindRespaldo.bak'

------------------
use master
go
drop database Northwind
----------------------
Restore Database Northwind
from disk = 'D:\Base de datos\Respaldo\NorthwindRespaldo.bak'
with file = 1

------ Separacion y vinculacion de base de datos Northwind
--para separar se usa la siguiente:

sp_detach_db Northwind

--para vincular:
sp_attach_db Northwind,
'D:\Base de datos\Archivos BD\Archivod BD Northwind\MDF\Northwind.mdf',
'D:\Base de datos\Archivos BD\Archivod BD Northwind\NDF\Northwind_1.ndf',
'D:\Base de datos\Archivos BD\Archivod BD Northwind\NDF\Northwind_2.ndf',
'D:\Base de datos\Archivos BD\Archivod BD Northwind\LDF\Northwind_Log.ldf'

--Respaldo del Registro de transacciones 

use Northwind
go
Select * from Region
----------------------------------------------------
Backup database Northwind to disk =
'D:\Base de datos\Respaldo\NorthwindRespaldo.bak'
---------------------------------------------------

Backup database Northwind to disk =
'D:\Base de datos\Respaldo\NorthwindRespaldo.bak'
with 
Differential
------------------------------------------------

Backup log Northwind to disk =
'D:\Base de datos\Respaldo\NorthwindRespaldo.bak'


insert into Region values (5,'Norte')
insert into Region values (6, 'Sur')
insert into Region values (7, 'Centro america')
insert into Region values (8, 'America')
insert into Region values (9, 'America del sur')

Restore headeronly from disk =
'D:\Base de datos\Respaldo\NorthwindRespaldo.bak'

Restore Database Northwind from disk =
'D:\Base de datos\Respaldo\NorthwindRespaldo.bak'
with file = 6,
recovery

Use Northwind
go 
select * from region 

--Modelo de recuperacion: Full -simple- Insercion Masiva
-- se puede ver en: en la base datos click derecho/propiedades/options

Alter database Northwind   --el simple solo permite usar backup full y bacukps diferencial
set recovery Simple

Alter database Northwind   --El full permite usar los tres tipos de backups
set recovery Full

----------------------------------------------------------------------
--Creacion de dispositivo de almacenamiento

sp_addumpdevice 
'Disk' --Medio 
,'Respaldo_Northwind', --Nombre del dispositivo
'D:\Base de datos\Respaldo\NorthwindRespaldo.bak' --Direccion

Backup database Northwind to Respaldo_Northwind --Solo se pone el nombre del dispositivo

Restore headeronly from disk = 'D:\Base de datos\Respaldo\NorthwindRespaldo.bak'

Restore database Northwind 
from  Respaldo_Northwind
with file = 7,
Replace