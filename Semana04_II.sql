-- CONSULTAR EL NOMBRE Y DEPARTAMENTO 
-- DEL EMPLEADO
-- ENVIAR QUERY
--959714615
select e.first_name, d.department_name
	from employees e
	inner join departments d
	on e.department_id=d.department_id
-- Ejercicio 02
-- Declaracion de tipo tabla
create table tabla_persona
(
	codigo int,
	nombre varchar(100)
)

declare @tabla_persona table
(
	codigo int,
	nombre varchar(100)
)
insert into @tabla_persona (codigo, nombre)
select employee_id, first_name  from employees

select * from @tabla_persona



create table ##empleado_temp
(
	codigo int,
	nombre varchar(30)
)
go

insert into ##empleado_temp(codigo, nombre)
select employee_id, first_name  from  employees

select * from ##empleado_temp
go
---

select * from ##empleado_temp
go
/*
Crear una tabla temporal (local o global)
que guarde los siguiente datos:
Empleado = > codigo, nombre, salario
Jobs     = >  Nombre Cargo
Departamento = > Nombre Departamento
*/

create table #tabla_temp
(
	codigo int,
	nombre varchar(100),
	salario decimal(8,2),
	cargo varchar(100),
	departamento varchar(100)
)
go

insert into #tabla_temp (codigo, nombre, salario, cargo, departamento)
SELECT 
e.employee_id, e.first_name, e.salary,
	j.job_title, d.department_name
from employees e inner join 
	 jobs j
	 on e.job_id= j.job_id
	 inner join departments d
	 on d.department_id= e.department_id

select * from #tabla_temp
go

sp_help employees
go
sp_help jobs
go
sp_help departments
go
-- 959714615
-- recuperacion 28/06 02:00 a 6:30
--T2 = > 21/06 12:00 p.m => 24 horas
--EF = > 03/07 02:00 p.m => 8 horas


-- declarar y almacenar el valor de su apellido

DECLARE @apellido varchar(50)
SET @apellido = 'PY'
select @apellido as Apellido

/*
CREAR 3 VARIABLES PARA ALMACENAR EL CODIGO, NOMBRE Y SALARIO
DE UN EMPLEADO (EMPLOYEE_ID=100). MOSTRAR LAS VARIABLES
*/
SET NOCOUNT ON
DECLARE @codigo int
Declare @nombre varchar(100)
Declare @salario decimal(8,2)
select  @codigo = employee_id, @nombre= first_name, @salario =salary 
from employees where employee_id=100
print 'Nombre : ' + @nombre
/*
	Crear una variable cantidad y almacenar la cantidad 
	de registros de la tabla empleados
*/
-- 1era forma
DECLARE @cantidad int
set @cantidad = (select COUNT(*) from employees   )
print @cantidad
-- 2da forma
DECLARE @cantidad1 int
select @cantidad1 = COUNT(*) from employees
print @cantidad1
-- Crear una variable salario maximo que almacene
-- el salario mayor de la tabla empleados
sp_help employees -- para verificar los campos de la tabla
go
declare @salario_maximo decimal(8,2)
set @salario_maximo = ( select MAX(salary) from employees)
print @salario_maximo
select @salario_maximo as Salario_Maximo
/*
De un determinado empleado indicar la categoria
en base a su salario, tener en cuenta lo sgte:
Categoria A => 1 a 5000
Categoria B => 5001 a 10000
Categoria C => 10001 en adelante
Use condicionales
*/
declare @salario decimal(8,2)
declare @categoria char(1)
-- set @salario= 10001
SET @salario = ( select salary from employees where employee_id=112)

if @salario>=1 and @salario <=5000
begin
	set @categoria='A'
	print 'A'
end
else if @salario >=5001 and @salario<=10000
begin
	set @categoria='B'
	print 'B'
end
else
begin
	set @categoria='C'
	print 'C'
end
select 'Categoria : ' + @categoria + ' - Sueldo : ' + Convert(varchar, @salario)  as Mensaje

/*
	De un determinado numero indicar si es par o impar
*/
declare @numero  int
set @numero = 14
if @numero % 2 = 0
begin
	select 'PAR'
end
ELSE
begin
	select 'IMPAR'
end


/*
	MOSTRAR DESDE EL 1 AL 100
*/
declare @contador int
set @contador = 1
while (@contador<=100)
begin
	print @contador
	set @contador = @contador + 1
end
/*Usando while de 1 al 100 para indicar
si el numero es par o impar
Ejemplo =>    1   => Impar 2 => Par
*/

Declare @con int
set @con= 1
while @con <=100
begin
	declare @mensaje varchar(50)
	if @con % 2 = 0
	begin
		set @mensaje ='par'
	end
	else
	begin
		set @mensaje = 'impar'
	end
	print 'Numero : ' +  cast(@con as varchar) + ' - Mensaje : ' + @mensaje
	set @con = @con +1
end
--- Usando break, terminar el bucle al llegar al numero 50
declare @numero int
set @numero = 1
while (@numero<100)
begin
	print @numero
	if @numero = 50
	begin
		continue
	end	
	-- set @numero = @numero +1 
end


-- BUCLE INFINITO
declare @numero1 int
set @numero1 = 1
while (@numero1<100)
begin
	print @numero1
	if @numero1 = 50
	begin
		continue
	end	
	-- set @numero = @numero +1 
end

-- USAR CONTINUE 
declare @numero int
set @numero = 0
while (@numero<100)
begin
	set @numero = @numero +1 
	print @numero
	if @numero = 50
	begin
		continue
	end	
	print 'mensaje *******'
end


DECLARE @genero varchar(10)
set @genero = 'M'
select 
	case @genero  
	when 'F' then 'Femenino'
	when 'M' then 'Masculino'
	else 'Indefinido' end as Genero

	-- EJEMPLO DE TRY CATCH

	declare @numerador int
	declare @denominador int
	declare @resultado int
	begin try
		set @numerador = 10
		set @denominador = 0
		set @resultado = @numerador / @denominador
	end try
	begin catch
		select @@ERROR
		select ERROR_MESSAGE() AS MENSAJE, 
			   ERROR_LINE() AS LINEA,
			   ERROR_SEVERITY() AS SEVERIDAD,
			   ERROR_STATE() AS ESTADO
			-- Error de división entre cero.
	end catch


	DECLARE @contador2 INT
	SET @contador2 = 1

	if @contador2 = 1
	begin
		raiserror('ERROR PROVOCADO',10,1)
	end


	-- EJEMPLO

	declare @numerador int
	declare @denominador int
	declare @resultado int
	set @numerador = 10
	set @denominador = 0
	set @resultado = @numerador / @denominador
	select @@ERROR
	SELECT @resultado
	



	select * from regions
	go
	sp_help regions
	go

	insert into regions(region_name) values ('REGION5')

	SELECT * FROM regions


	BEGIN TRAN
	insert into regions(region_name) values ('REGION6')
	commit tran

	SELECT * FROM regions


-- MOSTRAR LOS NUMEROS DE 1 AL 50
create table prueba (
	codigo int, nombre varchar(50), fechaRegistro datetime 
)
go

DECLARE @NUMERO  INT
SET @NUMERO = 1
WHILE @NUMERO <=50
BEGIN
	PRINT @NUMERO
	insert into prueba(codigo, nombre, fechaRegistro)
	values (@NUMERO, 'Nombre' + convert(varchar,@numero), GETDATE())
	SET  @NUMERO = @NUMERO + 1
END

select top 3 * FROM prueba
ORDER BY codigo desc

/*
	CREAR UN JOB QUE SE EJECUTE CADA 1 MINUTO 
	QUE REGISTRE LOS DATOS EN LA TABLA PRUEBA
	1ER HORARIO => 1 AL 50
	2DO HORARIO => 51 AL 100
	3ER HORARIO => 101 AL 150
	.....
	.....
	.....
	
*/





