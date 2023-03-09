create database Universidad

go

use Universidad

create table Estudiantes 
(
IdEstudiante int primary key,
primernombre varchar(50)
)

insert into Estudiantes values (0,'Ana')
Select * from Estudiantes

--Respaldo full de la base de datos de la universida
Backup database Universidad
to disk = 'D:\Base de datos\Repaldos\Universidad.bak'
with name = 'Respaldo Full 1',
Description = 'Copia completa de archivos de BD'

--Respaldo diferencial de base de datos
Backup database Universidad
to disk = 'D:\Base de datos\Repaldos\Universidad.bak'
with name = 'Respaldo Diferencial 1',
Description = 'Copia parcial de archivos de BD',
Differential

insert into Estudiantes values (1,'Pedro')

--Generando un segundo diferencial
Backup database Universidad
to disk = 'D:\Base de datos\Repaldos\Universidad.bak'
with name = 'Respaldo Diferencial 1',
Description = 'Copia parcial de archivos de BD',
Differential

insert into Estudiantes values (2,'Juan')

Backup database Universidad
to disk = 'D:\Base de datos\Repaldos\Universidad.bak'
with name = 'Respaldo Diferencial 3',
Description = 'Copia parcial de archivos de BD',
Differential


--Visualizar archivos de respaldo de la base de datos   //tipo 5 diferenciales, tipo 1 es un completo, tipo 2 parciales
Restore headeronly 
from disk= 'D:\Base de datos\Repaldos\Universidad.bak'

--Restauracion comprimido
Backup database Universidad
to disk = 'D:\Base de datos\Repaldos\UniversidadComprimido.bak'
with name = 'Respaldo full comprimido',
Description = 'Copia full de archivos de BD',
Compression

Restore headeronly 
from disk= 'D:\Base de datos\Repaldos\UniversidadComprimido.bak'

use master
go
drop database Universidad

--Restauracion de la base de datos Universidad
Restore database Universidad
from disk= 'D:\Base de datos\Repaldos\Universidad.bak'
with 
file = 4,
recovery



use Universidad
select * from Estudiantes

--Respaldo del registro de transacciones sql server /solo sirve para insertar eliminar o modificar este 

sp_helpdb Universidad   

backup log Universidad 
to disk = 'D:\Base de datos\Repaldos\Universidad.bak'
go 

Restore headeronly 
from disk= 'D:\Base de datos\Repaldos\Universidad.bak'
go

insert into Estudiantes values (3, 'Maria')
insert into Estudiantes values (4,'Axel')

insert into Estudiantes values (5, 'Maria')

--Para restaurar un back log se hace uno a uno (noRecovery)
Restore database Universidad
from disk= 'D:\Base de datos\Repaldos\Universidad.bak'
with 
file = 7,
recovery

--Tarea Como enctriptar un backup, certificados e incriptacion de base de datos
