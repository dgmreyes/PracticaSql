
/*Ejercico 3.1*/
Select BusinessEntityID
,NationalIDNumber,LoginID, JobTitle, BirthDate, MaritalStatus, HireDate
From AdventureWorks2019.HumanResources.Employee

/*Ejercicio 3.2 sacar la diferencia entre hiredate y birthdate*/
Select DATEDIFF (year, BirthDate, HireDate) as datediff 
From AdventureWorks2019.HumanResources.Employee

/*Ejercicio 3.3 Regrese todos los registros de Product en la tabla
[Production.Product] en AdventureWorks que tiene 3 días o más para su 
producción.  Incluya el nombre [Name] y el precio de lista [ListPrice]*/

Select Name,ListPrice, DaysToManufacture
From AdventureWorks2019.Production.Product
Where DaysToManufacture >= 3


/*Ejercicio 3.4 */
Select ProductID, Name, ProductNumber, Color, ListPrice
From AdventureWorks2019.Production.Product
where ProductNumber LIKE '%BK%' 
Order BY (listPrice) desc


/*Ejercicio 3.5 */
Select * From AdventureWorks2019.Production.ProductSubcategory

Select ProductSubcategoryID, ProductCategoryID, Name, ModifiedDate
From AdventureWorks2019.Production.ProductSubcategory

Select * From AdventureWorks2019.Production.ProductSubcategory
Where Name Like '%Bike%'

Select Name As Bicicletas
From AdventureWorks2019.Production.ProductSubcategory

Select Name
From AdventureWorks2019.Production.ProductSubcategory


/*Ejercicio 3.6*/
Select * From AdventureWorks2019.Sales.SalesOrderHeader where GETDATE() > DATEADD(MONTH,2004,ModifiedDate)

/*Ejercicio 3.7*/
Select * From AdventureWorks2019.Sales.SalesOrderHeader
Order By (ModifiedDate)desc

/*Ejercicio 3.8*/

Select * From AdventureWorks2019.Person.Person
where (LastName Like '%A'+'%A'+'%A')

/*Ejercicio 3.9 */
Select BusinessEntityID, FirstName, LastName, Title, PersonType
From AdventureWorks2019.Person.Person
where Title Like 'Ms' 