Create Database BDRepositorios
go
use BDRepositorios

Create table Recaudaciones 
(
IDRecaudacion int primary key,
Fecha date,
Anio int,
Mes int,
Monto float,
Descuento float,
MontoFinal float,
CantidadOrdenes int
)


use Northwind
select * from Northwind.dbo.Orders where cast(orderdate as date ) = CAST(getdate() as date)
update Orders set orderdate = getdate()
where year (orderdate)= 2018 and MONTH(OrderDate) = 5

Select   
         CAST(GETDATE() as date) as fecha,
        (Select year(getdate()))  as anio,
         (Select month(getdate())) as Mes,
         round(sum((od.UnitPrice*od.Quantity)),2) as Monto,
         round(sum((od.UnitPrice*od.Quantity) * od.Discount),2) as Descuento,
         round(sum((od.UnitPrice*od.Quantity) *(1-od.Discount)),2) as MontoFinal

		 from [Order Details] od 
		 inner join Orders o on o.OrderID = od.OrderID
		 where year (o.OrderDate) = year (getdate())
		 and
		 MONTH(o.OrderDate) = MONTH(getdate())
































