/*Ejercicio 5.2 (2-4)*/
Select ProductID, SpecialOfferID
From AdventureWorks2019.Sales.SalesOrderDetail
Group BY ProductID, SpecialOfferID
Order by 1, 2

Select ProductID, COUNT(SpecialOfferID) Cantidad
From AdventureWorks2019.Sales.SalesOrderDetail
Group BY ProductID
Order By Cantidad

/*Ejercicio 5.3 */
Select DATEPART(year,OrderDate)
 AS N'Year',Sum(TotalDue) AS N'Total order amount'
From AdventureWorks2019.Sales.SalesOrderHeader
Group by DATEPART(year, OrderDate)
Order By DATEPART (year, Orderdate)

Select DATEPART(year, OrderDate)
 AS N'Year',Sum(TotalDue) AS N'Total order amount'
From AdventureWorks2019.Sales.SalesOrderHeader
Group by DATEPART(year, OrderDate)
HAVING DATEPART(year, OrderDate) >= N'2013'
Order By DATEPART (year, Orderdate)

/*Utilizando un where*/
Select DATEPART(year, OrderDate)
 AS N'Year',Sum(TotalDue) AS N'Total order amount'
From AdventureWorks2019.Sales.SalesOrderHeader
where   OrderDate >= N'2013'
Group by DATEPART(year, OrderDate)
Order By DATEPART (year, Orderdate)






