
-- 1er ejercicio
-- Seleccionar las ordenes del Cliente VINET 
-- Tablas Orders y Customers
select  *
	from Customers c inner join Orders o
		on c.CustomerID = o.CustomerID
		where c.CustomerID = 'VINET'

-- Seleccionar las ordenes del a�o 1996
-- Tabla Orders

select * from Orders 
where OrderDate between '1996-01-01 00:00:00'
					and '1996-12-31 23:59:59'
go

select * from Orders where YEAR(OrderDate) = 1996
go

-- Seleccionar las ordenes vendidas por el empleado Buchanan
-- Mostrar el nombre de contacto y titulo del cliente
-- Employees, Orders y Customers

select c.ContactTitle, c.ContactName
			 from Employees e inner join Orders o
				  on e.EmployeeID= o.EmployeeID
				  inner join Customers c 
				  on c.CustomerID = o.CustomerID
				  where e.LastName= 'Buchanan'

-- Seleccionar el total de empleados (Employees)
select COUNT(*) as Contador  from Employees
go

-- Seleccionar las ordenes del transportista Speedy Express
-- Orders  -- Suppliers

select  o.OrderID, s.CompanyName, s.Phone 
		from Orders o inner join Shippers  s
		on o.ShipVia = s.ShipperID
		where s.CompanyName='Speedy Express'


select * from Employees
-- Mostrar el siguiente mensaje "El empleado con codigo 10 - Nombre: Davolio del pais de PERU"
-- EmployeeId, FirstName, Country

select  'El empleado con codigo : ' + Convert(varchar, e.EmployeeID) +
		'Nombre : '+	e.FirstName + 
		' del pais de : ' + e.Country  
		from Employees e 

select  'El empleado con codigo : ' + cast( e.EmployeeID As varchar ) +
		'Nombre : '+	e.FirstName + 
		' del pais de : ' + e.Country  
		from Employees e 

select  'El empleado con codigo : ' + str(e.EmployeeID) +
		'Nombre : '+	e.FirstName + 
		' del pais de : ' + e.Country  
		from Employees e 

-- Seleccionar las 5 primeras ordenes del a�o 1996 del cliente VINET
-- ordenar de manera ascendente

select top 5 * from Orders o inner join Customers c on c.CustomerID= o.CustomerID 
where o.CustomerID='VINET' and YEAR(OrderDate)=1996
order by  o.OrderDate asc

-- Seleccionar los 10 primeros registros de una tabla X
select top 10 * from Customers


create table monto(
	id int primary key,
	monto int
)
go

BULK INSERT MONTO
FROM 'D:\carga\cargardatos.txt'
WITH (FIELDTERMINATOR = ',' );


select * from monto

-- TABLA CUSTOMERS
-- ACTUALIZAR LOS DATOS DEL CLIENTE ANTON  CON SUS DATOS DE USTEDES.

UPDATE Customers
set 
	CompanyName = 'EPY', ContactName='EPY', Address='cib brena', City='lima'
	where 
		CustomerID='ANTON'
		GO

select * from Customers WHERE CustomerID='ANTON'
GO


-- Eliminacion de un registro
INSERT INTO Customers (CustomerID, CompanyName, ContactName, ContactTitle)
values ('EPY', 'EPY', 'EPY', 'EPY')

SELECT * FROM Customers WHERE CustomerID='EPY'
GO

DELETE FROM Customers WHERE CustomerID='EPY'
GO

-- TABLA PRINCIPAL    (X)
-- TABLA SECUNDARIA

CREATE TABLE producto1
(
	codigo int primary key,
	nombre varchar(50)
)
go

CREATE TABLE producto2
(
	codigo int primary key,
	nombre varchar(50)
)
go



MERGE producto1 as Principal
using (
	select codigo, nombre from producto2
) as Secundaria
on (Principal.codigo = Secundaria.codigo)
-- Cuando tengamos datos con codigo iguales
when MATCHED THEN
	UPDATE set nombre = Secundaria.Nombre
-- Cuando tengamos datos que no existen en la 1era tabla
WHEN NOT MATCHED THEN
	INSERT (codigo, nombre)
	values (Secundaria.codigo, Secundaria.nombre);

BULK INSERT MONTO
FROM 'D:\carga\cargardatos.txt'
WITH (FIELDTERMINATOR = ',' );


	select * from producto1


	insert into producto1 (codigo, nombre)
values (1,'leche')
insert into producto1 (codigo, nombre)
values (2,'coca cola')


insert into producto2 (codigo, nombre)
values (2,'coca cola 3l')
insert into producto2 (codigo, nombre)
values (3,'arroz micasita')



















