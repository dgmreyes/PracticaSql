Restore Database Northwind
from disk = 'C:\Base\Base datos\Northwind.bak'
with file = 1,

move 'Northwind' to 'C:\Base\Base datos\ArchivsoBD Northwind\MDF\Northwind.mdf',
move 'Northwind_1' to 'C:\Base\Base datos\ArchivsoBD Northwind\NDF\Northwind_1.ndf',
move 'Northwind_2' to 'C:\Base\Base datos\ArchivsoBD Northwind\NDF\Northwind_2.ndf',
move 'Northwind_log' to 'C:\Base\Base datos\ArchivsoBD Northwind\LDF\Northwind_Log.ldf'

backup database Northwind to disk = 'C:\Base\Base datos\RespaldosNorthwind\RespaldoNorthwind.bak'

Restore filelistonly from disk = 'C:\Base\Base datos\Northwind.bak'


Restore Database Northwind
from disk = 'C:\Base\Base datos\RespaldosNorthwind\RespaldoNorthwind.bak'
with file = 1

use Northwind

select * from Products
Select * from Orders
select * from [Order Details]

Create procedure Facturacion  (@ProductID int)
AS 
BEGIN
Select o.OrderID, o.ProductID, p.ProductName, o.UnitPrice,o.Quantity, o.Discount,SUM(o.UnitPrice * o.Quantity)as 'SubTotal sin descuento',
SUM(o.Quantity * o.UnitPrice - ( (o.UnitPrice*  o.Discount))) as 'SubTotal con descuento (sin iva)',
SUM ((o.UnitPrice * o.Quantity-(o.UnitPrice*  o.Discount)) *1.15) as 'Total con IVA'
From  [Order Details] o
inner join  Products p on o.ProductID = p.ProductID
where o.OrderID = @ProductID
Group by o.OrderID, o.ProductID, p.ProductName , o.UnitPrice,o.Quantity, o.Discount

END

Create procedure Facturacion2 
AS 
BEGIN
Select o.OrderID, o.ProductID, p.ProductName, o.UnitPrice,o.Quantity, o.Discount,SUM(o.UnitPrice * o.Quantity)as 'SubTotal sin descuento',
SUM(o.Quantity * o.UnitPrice - ( (o.UnitPrice*  o.Discount))) as 'SubTotal con descuento (sin iva)',
SUM ((o.UnitPrice * o.Quantity-(o.UnitPrice*  o.Discount)) *1.15) as 'Total con IVA'
From  [Order Details] o
inner join  Products p on o.ProductID = p.ProductID
Group by o.OrderID, o.ProductID, p.ProductName , o.UnitPrice,o.Quantity, o.Discount

END
drop procedure Facturacion
Exec Facturacion @ProductID = '10548'
Exec Facturacion2 

use Northwind

Execute msdb.dbo.sp_send_dbmail
@profile_name = 'Administrador BD'
,@recipients = 'dougMontielr@outlook.com',
@copy_recipients = 'dougMontielr@outlook.com',
@subject = 'Facturacion',
@body = 'Factura base datos northwind',
@query = 'Exec Northwind.dbo.Facturacion2',
@attach_query_result_as_file = 0



/* Create table Facturas
(
FacturaID int identity(1,1) primary key,
OrderID int,
ProductID int,
ProductName varchar(50),
UnitPrice money,
Quantity int,
Discount money,
SubTotalSinDescuento money,
SubTotalConDescuento money,
TotalConIVA money
)
drop table Facturas

CREATE PROCEDURE FacturacionTabla
AS
BEGIN
INSERT INTO Facturacion (OrderID, ProductID, ProductName, UnitPrice, Quantity, Discount, SubtotalSinDescuento, SubtotalConDescuentoSinIVA, TotalConIVA)
Select o.OrderID, o.ProductID, p.ProductName, o.UnitPrice,o.Quantity, o.Discount,SUM(o.UnitPrice * o.Quantity)as 'SubTotal sin descuento',
SUM(o.Quantity * o.UnitPrice - ( (o.UnitPrice* o.Discount))) as 'SubTotal con descuento (sin iva)',
SUM ((o.UnitPrice * o.Quantity-(o.UnitPrice* o.Discount)) *1.15) as 'Total con IVA'
From [Order Details] o
inner join Products p on o.ProductID = p.ProductID
Group by o.OrderID, o.ProductID, p.ProductName , o.UnitPrice,o.Quantity, o.Discount
END

drop procedure FacturacionTabla */