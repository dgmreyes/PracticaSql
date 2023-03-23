Create Database BDRepositorios
go
use BDRepositorios

Create table Recaudaciones 
(
IDRecaudacion int identity (1,1) primary key,
Fecha date,
BD varchar (100),
Anio int,
Mes varchar(50),
Monto float,
Descuento float,
MontoFinal float,
CantidadOrdenes int
) 

Create table Detalle_Recaudacion
(
IDDetalleRecaudacion int primary key identity (1,1),
IDRecaudacion int foreign key (IDRecaudacion) references Recaudaciones(IDRecaudacion) ,
IDEmpleado int,
Monto float,
Descuento float,
MontoFinal float,
CantidadOrdenes int

)


drop table Recaudaciones

use Northwind
update Orders set Orderdate = getdate()
where 
year(Orderdate) = 2018
and
month(Orderdate) = 5


		 Insert into BDRepositorios.dbo.Recaudaciones (Fecha,BD,Anio,Mes,Monto,Descuento,MontoFinal,CantidadOrdenes) 
		 Select
         CAST(GETDATE() as date) as fecha,
		 'Northwind' as BD,
         year(getdate())  as anio,
         DATENAME( month,getdate()) as Mes,
         round(sum((od.UnitPrice*od.Quantity)),2) as Monto,
         round(sum((od.UnitPrice*od.Quantity) * od.Discount),2) as Descuento,
         round(sum((od.UnitPrice*od.Quantity) *(1-od.Discount)),2) as MontoFinal,
		 count(distinct o.OrderID) as CantidadOrdenes

		 from [Order Details] od 
		 inner join Orders o on o.OrderID = od.OrderID
		 where year (o.OrderDate) = year (getdate())
		 and
		 MONTH(o.OrderDate) = MONTH(getdate())

	

	select * from Recaudaciones
	

	--Sql server agent propiedades y luego alert system para selecionar el perfil de mandador de emails
	--Para hacer la consulta automatica se crea un job, --steps seleciona la base de datos a usar y luego copiar la consulta que se va a utilizar
	--Schedule para programar cada cuanto se hace 
	--Crear un operador en operators 



	----------------------------------

	insert into BDRepositorios.dbo.Detalle_Recaudacion
	Select
         (Select IDRecaudacion from BDRepositorios.dbo.Recaudaciones 
	where  year (Fecha) = year (getdate())
		 and
		 MONTH(Fecha) = MONTH(getdate())) as IdRecaudacion, --identity retorna el ultimo id insertado en la base de datos
		 o.EmployeeID,
         round(sum((od.UnitPrice*od.Quantity)),2) as Monto,
         round(sum((od.UnitPrice*od.Quantity) * od.Discount),2) as Descuento,
         round(sum((od.UnitPrice*od.Quantity) *(1-od.Discount)),2) as MontoFinal,
		 count(distinct o.OrderID) as CantidadOrdenes

		 from [Order Details] od 
		 inner join Orders o on o.OrderID = od.OrderID
		 where 
		 year (o.OrderDate) = year (getdate())
		 and
		 MONTH(o.OrderDate) = MONTH(getdate())
	Group by o.EmployeeID

	Select IDRecaudacion from BDRepositorios.dbo.Recaudaciones 
	where  year (Fecha) = year (getdate())
		 and
		 MONTH(Fecha) = MONTH(getdate())) as IdRecaudacion

	
		

	select * from BDRepositorios.dbo.Detalle_Recaudacion
	select * from BDRepositorios.dbo.Recaudaciones
	
	delete  from BDRepositorios.dbo.Recaudaciones
	delete from BDRepositorios.dbo.Detalle_Recaudacion

	--Enviar estos reportes por correo electronico 
	--Agregar otra recaudacion pero esta vez de la base adventure -Sales.SalesOrderHeader
	
	select * from Adventure.Sales.SalesOrderHeader
	select * from Adventure.Sales.SalesOrderDetail
	Select * from Adventure.Person.Person