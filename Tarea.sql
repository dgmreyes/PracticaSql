Create Database BDRepositorios
go
use BDRepositorios

Create table Recaudaciones 
(
IDRecaudacion int identity (1,1) primary key,
Fecha date,
Anio int,
Mes varchar(50),
Monto float,
Descuento float,
MontoFinal float,
--CantidadOrdenes int
) 
use BDRepositorios
drop table Recaudaciones

use Northwind
select * from Northwind.dbo.Orders where cast(orderdate as date ) = CAST(getdate() as date)

update Orders set orderdate = getdate()
where year (orderdate)= 2018 and MONTH(OrderDate) = 5

use Northwind
Select   
         CAST(GETDATE() as date) as fecha,
        (Select year(getdate()))  as anio,
          (Select DATENAME( month,getdate())) as Mes,
         round(sum((od.UnitPrice*od.Quantity)),2) as Monto,
         round(sum((od.UnitPrice*od.Quantity) * od.Discount),2) as Descuento,
         round(sum((od.UnitPrice*od.Quantity) *(1-od.Discount)),2) as MontoFinal

		 from [Order Details] od 
		 inner join Orders o on o.OrderID = od.OrderID
		 where year (o.OrderDate) = year (getdate())
		 and
		 MONTH(o.OrderDate) = MONTH(getdate())

		
		create procedure sp_recaudaciones
		as 
		begin 
		 Insert into BDRepositorios.dbo.Recaudaciones (Fecha,Anio,Mes,Monto,Descuento,MontoFinal) /*Para pasar los datos del procedimiento de almacenado
		 se usa Insert into agregando La base de datos de destinatario y su tabla asi como las variables que lleva dicha tabla y luego se prosigue con el procedure*/
		Select   
         CAST(GETDATE() as date) as fecha,
         year(getdate())  as anio,
         DATENAME( month,getdate()) as Mes,
         round(sum((od.UnitPrice*od.Quantity)),2) as Monto,
         round(sum((od.UnitPrice*od.Quantity) * od.Discount),2) as Descuento,
         round(sum((od.UnitPrice*od.Quantity) *(1-od.Discount)),2) as MontoFinal

		 from [Order Details] od 
		 inner join Orders o on o.OrderID = od.OrderID
		 where year (o.OrderDate) = year (getdate())
		 and
		 MONTH(o.OrderDate) = MONTH(getdate())


		 end
		 /*Luego se ejecuta el procedimiento y revisa si ya se subieron los datos gg*/
	exec sp_recaudaciones

	drop procedure sp_recaudaciones

	use BDRepositorios

	select * from Recaudaciones

 
