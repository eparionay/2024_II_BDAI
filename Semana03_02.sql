-- Uso de Select
-- Seleccionar el title, firstname, middlename y lastname
select Isnull(Title,'') as Title, FirstName, 
	MiddleName, LastName
from Person.Person
-- Selecciona las personas que su middlename sea nulo
select * from Person.Person where Middlename is null
go
-- Selecciona las personas que su middlename sea no nulo
select * from Person.Person WHERE MiddleName is not null
go
-- cambiar el titulo de firstname a nombre
select FirstName as Nombre from Person.Person WHERE MiddleName is not null
go
-- Ordenar la tabla Persona por el lastname de forma ascendente
select * from Person.Person order by LastName asc
-- Ordenar la tabla Persona por el lastname de forma descendente
select * from Person.Person order by LastName desc

-- Consultar la tabla producto para el campo Name Guide Pulley
select * from Production.Product 
where Name= 'Guide Pulley'
go
-- Consultar el stock mayor a 500 de la tabla Product
select * from Production.Product
where SafetyStockLevel > 500
go
-- Consultar el stock entre 400 y 500 de la tabla Product
select * from Production.Product
where SafetyStockLevel between 400 and 500
go
-- Consultar aquellos productos que tengan como stock 400 y 402
select * from Production.Product
where SafetyStockLevel in (400, 402)
go
-- Consultar los productos que inicien con la letra A
-- Like 
Select * from Production.Product
where Name like 'a%'
go
-- Consultar los productos que terminen con la letra A
-- Like 
Select * from Production.Product
where Name like '%a'
go
-- Consultar los productos con stock mayor a 500 
-- y que tengan como  fecha de modificacion 2014
select * from Production.Product
where SafetyStockLevel > 500 and Year(ModifiedDate) =2014
go
-- Seleccionar las provincias de Sarthe, Tame y Var
select * from Person.StateProvince
where Name in ('Sarthe','Tame','Var')
go
-- Listar las fechas de modificacion de los
-- celulares de las personas(Que no se repitan)
select distinct year(ModifiedDate) as Year
fROM Person.PersonPhone
--- Listar el año de modificacion y el total
-- de celulares modificados en esa fecha
SELECT YEAR(ModifiedDate) as [Año],
COUNT(*) as [Total] FROM Person.PersonPhone
group by YEAR(ModifiedDate)
having COUNT(*) > 200
order by 2 asc
go
-- Seleccionar las ordenes de trabajo del producto 820
-- que se hayan dado entre el año 2010 y 2018
-- Mostrar el nombre del producto.
select * from Production.WorkOrder
select * from Production.Product
set dateformat ymd
select  p.Name, wo.WorkOrderID, wo.StartDate
		from Production.WorkOrder wo
		inner join Production.Product p
		on wo.ProductID= p.ProductID
		where p.ProductID=820 and 
		wo.StartDate between '2010-01-01 00:00:00' 
		and '2018-12-31 23:59:59'
		order by wo.StartDate asc








