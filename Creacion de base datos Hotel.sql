--Creacion base datos
Create database ReservasHotel
go 
Use ReservasHotel 

--Creacion de tablas
Create table Cliente (
NoCliente int primary key, 
Nombres varchar(50),
Apellidos varchar(50),
Direccion varchar (50),
Telefono varchar(50),
Correo varchar(50)
)

Create table Empleado (
NoEmpleado int primary key,
Nombres varchar(50),
Apellidos varchar(50),
Direccion varchar(50),
Salario money 
)

Create table Tipo_Habitacion
(
CodigoTipoHab int primary key,
Tipo varchar(50),
Precio float
)

Create table Habitacion (
NoHabitacion int primary key,
Descripcion varchar(50),
Capacidad int,
CodigoTipoHab int foreign key references Tipo_Habitacion(CodigoTipoHab),
Estado varchar (50)
)


Create table Reserva (
IDReserva int primary key,
Fecha datetime,
NoEmpleado int foreign key references Empleado(NoEmpleado),
NoCliente int foreign key references Cliente(NoCliente),
Estado varchar(50),
FormaPago varchar(50),
Pais varchar(50),
Moneda varchar(50),
)

Create Table Reserva_Habitacion(
IDReservaHab int primary key,
FechaEntrada datetime,
FechaSalida datetime,
NoHabitacion int foreign key references Habitacion(NoHabitacion),
IDReserva int foreign key references Reserva (IDReserva),
Precio money
)

Create table Servicio(
NoServicio int primary key,
Descripcion varchar(50),
Precio money
)

Create table ReservaHab_Servicio(
Cantidad int,
Precio money,
NoServicio int foreign key references Servicio (NoServicio),
IDReservaHab int foreign key references Reserva_Habitacion(IDReservaHab),
)


Create table Huesped(
IDHuesped int primary key,
Nombre varchar(50),
Apellido varchar(50),
Direccion varchar(50),
Telefono varchar(50),
Correo varchar(50)
)

Create table ReservaHab_Huesped(
IDHuesped int foreign key references Huesped(IDHuesped),
IDReservaHab int foreign key references Reserva_Habitacion(IDReservaHab)
)

Create table Factura(
IDFactura int primary key,
IDReserva int foreign key references Reserva(IDReserva),
MontoHabitaciones float,
MontoServicios float,
SubTotal float,
TotalIVA float
)

----------------------------------
--Agregando datos

Insert Cliente values (1,'Juan','Mendoza','Managua','9985-4580','Juan.Mendoza89@gmail.com')
Insert Cliente values (2,'Sofia','Perez','Tipitapa','7898-2145','Softper2990@gmail.com')
Insert Cliente values (3, 'Maria','Murillo','Ciudad Sandino','4878-9911','MarthMuril@gmail.com')
Insert Cliente values (4,'Joaquin','Hernandez','Caracaz','58-0879-8548','JHoquin@gmail.com')

Insert Empleado values (1, 'Jose', 'Treminio','Xiloa','15000')
Insert Empleado values (2, 'Estrella','Alvarez','Barrio Montoya','15000')

Insert Tipo_Habitacion values (10,'Basica','150')
Insert Tipo_Habitacion values (11,'Ejecutiva','200')
Insert Tipo_Habitacion values (12, 'Presidencial','500')

Insert Habitacion values (3,'Doble','2','10','Disponible')  
Insert Habitacion values (1,'Multiple','5','12', 'Disponible')
Insert Habitacion values (2, 'Individual','1','10','Disponible')
Insert Habitacion values (4, 'Individual','1','10','Reservada')
Insert Habitacion values (5, 'Multiple', '3', '11', 'Disponible')

Insert Reserva values (1, GETDATE(),2,4,'Reservado','Tarjeta','Venezuela','Dolar')
Insert Reserva values (2, GETDATE(),2,3, 'Cancelado','Contado','Nicaragua','Cordoba')
Insert Reserva values (3, GETDATE(),1,2, 'Pagado','Tarjeta','Nicaragua','Dolar')
Insert Reserva values (4, GETDATE(),2,4, 'Reservado','Tarjeta','Venezuela','Dolar')

Insert Reserva_Habitacion values (1,'2023-03-27','2023-04-01',3,1,'150')
Insert Reserva_Habitacion values (2,'2023-03-27 13:00:00','2023-04-01 8:00:00',2,4,'150')
Insert Reserva_Habitacion values (3, '2023-05-10 07:00:00', '2023-05-13 8:00', 2,2,'150')
Insert Reserva_Habitacion values (4, '2023-05-10','2023-05-13',1,3,'500')
Insert Reserva_Habitacion values (5, '2024-05-10','2024-05-13',1,3,'500')

Insert Servicio values (1,'Buffet',20)
Insert Servicio values (2, 'Spa',30)
Insert Servicio values (3, 'Aguas termales',25)

Insert ReservaHab_Servicio values (1,20,1,1)
Insert ReservaHab_Servicio values (2,40,1,2)
Insert ReservaHab_Servicio values (2,60,2,2)

Insert Huesped values (1,'Joaquin','Hernandez','Caracaz','58-0879-8548','JHoquin@gmail.com')
Insert Huesped values (2, 'Felix','Arguello','Montereal','2281-5478','spnFelixArg@gmail.com')
Insert Huesped values (3, 'Maria','Murillo','Ciudad Sandino','4878-9911','MarthMuril@gmail.com')
Insert Huesped values (4, 'Diego','Buitraigo','Caracas','58-4875-5585','DBDrgo@gmail.com')

Insert ReservaHab_Huesped values (1,1)
Insert ReservaHab_Huesped values (2,2)
Insert ReservaHab_Huesped values (3,3)
Insert ReservaHab_Huesped values (4,4)

use ReservasHotel

select * from Empleado
Select * from Cliente
select * from Habitacion
select * from Tipo_Habitacion
Select * from Reserva_Habitacion
Select * from Reserva
select * from Factura
Select * from ReservaHab_Servicio
select * from Servicio


------------------------------------------
--Procedimiento para la factura
Create Procedure mostrar_factura(@IDReserva int)
AS
BEGIN                                                                         
    Select h.NoHabitacion, h.CodigoTipoHab, COUNT(rh.NoHabitacion) AS 'Por estadia',   /*Detalles de habitacion y subtotal*/
        SUM(rh.Precio) AS 'SubTotal Habitacion'
    From Reserva r
    Inner Join Reserva_Habitacion rh on r.IDReserva = rh.IDReserva
    Inner Join Habitacion h On rh.NoHabitacion = h.NoHabitacion
    WHERE r.IDReserva = @IDReserva
    GROUP BY h.NoHabitacion, h.CodigoTipoHab, h.Estado
    
    Select h.NoHabitacion, s.NoServicio, s.Precio, COUNT(rs.NoServicio) AS 'Servicio', /*Detalles de servicion por habitacion*/
        SUM(s.Precio) AS 'SubTotal Servicio'
    From Reserva r
    Inner Join Reserva_Habitacion rh On r.IDReserva = rh.IDReserva
    Inner Join Habitacion h On rh.NoHabitacion = h.NoHabitacion
    Inner Join ReservaHab_Servicio rs On rh.IDReservaHab = rs.IDReservaHab
    Inner Join Servicio s On rs.NoServicio = s.NoServicio
    Where r.IDReserva = @IDReserva
    GROUP BY h.NoHabitacion, s.NoServicio, s.Precio
    
    Select SUM(rh.Precio) + SUM(s.Precio) AS 'SubTotal'   /*Sub total de habitacion y servicio*/
    From Reserva r
    Inner Join Reserva_Habitacion rh On r.IDReserva = rh.IDReserva
    Inner Join Habitacion h On rh.NoHabitacion = h.NoHabitacion
    Inner Join ReservaHab_Servicio rs On rh.IDReservaHab = rs.IDReservaHab
    Inner Join Servicio s On rs.NoServicio = s.NoServicio
    Where r.IDReserva = @IDReserva
    
    Select (SUM(rh.Precio) + SUM(s.Precio)) * 1.12 AS 'Total (sub total con IVA)' /*Total con el iva*/
    From Reserva r
    Inner Join Reserva_Habitacion rh on r.IDReserva = rh.IDReserva
    Inner Join Habitacion h on rh.NoHabitacion = h.NoHabitacion
    Inner Join ReservaHab_Servicio rs on rh.IDReservaHab = rs.IDReservaHab
    Inner Join Servicio s on rs.NoServicio = s.NoServicio
    Where r.IDReserva = @IDReserva
END
--Ejecutar el procedimiento
EXEC mostrar_factura @IDReserva = 4;

-------------------------------------------------
--Creando el procedimiento para las habitaciones disponibles respecto a su fecha entrada y salida
Create procedure Habitaciones_Disponibles (@IDHabitaciones int)
AS
BEGIN 
    Select h.NoHabitacion, h.CodigoTipoHab, h.Estado, Reserva_Habitacion.FechaEntrada, Reserva_Habitacion.FechaSalida
    From Habitacion h
    Inner join Reserva_Habitacion on h.NoHabitacion = Reserva_Habitacion.NoHabitacion
    Inner join Reserva on Reserva_Habitacion.NoHabitacion = Reserva.IDReserva
    Where Reserva_Habitacion.IDReservaHab = @IDHabitaciones
    GROUP BY h.NoHabitacion, h.CodigoTipoHab, h.Estado, Reserva_Habitacion.FechaEntrada, Reserva_Habitacion.FechaSalida
END

Exec Habitaciones_Disponibles @IDHabitaciones = 1 
drop procedure Habitaciones_Disponibles

------------------------------------------------------------
--Creando procedimiento para las recaudaciones anuales del hotel
Create procedure Recaudaciones(@anio int)
AS
BEGIN
    Select
	MONTH(Fecha) AS Mes, 
    Servicio.Descripcion AS Tipo_Servicio,
	 COUNT(*) AS Cantidad_Solicitada,
    SUM(ReservaHab_Servicio.Precio) AS Total_Recaudado
    From Reserva_Habitacion
	Inner join ReservaHab_Servicio on Reserva_Habitacion.IDReservaHab = ReservaHab_Servicio.IDReservaHab
	Inner join Servicio on ReservaHab_Servicio.NoServicio = Servicio.NoServicio
    Inner join Reserva on Reserva_Habitacion.IDReserva = Reserva.IDReserva
    WHERE YEAR(Fecha) = @anio
    GROUP BY MONTH(Fecha), Servicio.Descripcion
END 


