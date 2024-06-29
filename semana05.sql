 select * from employees
 go

 -- sin parametros de entrada
 -- los parametros se inician con un @
 -- ejemplo @codigo ,  @nombre,  @apellido
-- Consultar 3 campos de la tabla empleados
 CREATE or alter PROCEDURE sp_empleado_consultar
 as
 begin
	select  employee_id, first_name, last_name
	from employees
 end
 go
 -- Formas de ejecutar
 execute sp_empleado_consultar
 go
 exec sp_empleado_consultar
 go
 sp_empleado_consultar
 go


 -- procedimiento con parametro

CREATE OR ALTER PROCEDURE sp_empleado_consultar_x_id
(@codigo int )
as
begin
	select employee_id, last_name, first_name
		from employees where employee_id = @codigo
end
go
-- Consultar la estructura de la tabla empleados
sp_help employees
go
-- Ejecutar el procedimiento sp_empleado_consultar_x_id
Execute sp_empleado_consultar_x_id 100
go
--  Procedimiento con 2 parametros 
CREATE OR ALTER PROCEDURE sp_empleado_consultar_x_n_id
(@codigo1 int, @codigo2 int )
as
begin
	select employee_id, last_name, first_name
		from employees where employee_id in (@codigo1, @codigo2)
end
go
execute sp_empleado_consultar_x_n_id 100,101
go

-- CREAR UN PROCEDIMENTO QUE CONSULE N CODIGOS EN UN MISMO PARAMETRO
CREATE OR ALTER PROCEDURE sp_empleado_consultar_n
(@codigo_n varchar(250))
as
begin
	select employee_id, last_name, first_name
		from employees where employee_id in (
			select value from  string_split(@codigo_n,',')
		)
end
go
execute sp_empleado_consultar_n '100,101,102,103,104,200'
go
-- 
 select value from  string_split('MANZANA, PERA, MANDARINA',',')
 go
 select * from countries
 go
-- CREAR UN PROCEDIMIENTO PARA INSERTAR A LA TABLA PAISES(COUNTRIES)0
sp_help countries
go

CREATE PROCEDURE sp_paises_insertar
(
@country_id char(2),
@country_name varchar(40),
@region_id int
)
as
begin
	INSERT into countries(country_id,country_name,region_id)
	values(@country_id,@country_name,@region_id )
end
go
-- PARA ALTERAR => SE USA => ALTER
-- PARA CONSULTAR LA ESTRUCTURA SE USA = > sp_helptext sp_paises_insertar
-- PARA BORRAR UN PROCEDIMIENTO => drop procedure sp_paises_insertar
execute sp_paises_insertar 'PE','PERU',1
go
-- PROCEDIMIENTO PARA ACTUALIZAR LA TABLA PAISES
CREATE PROCEDURE sp_paises_actualizar
(
@country_id char(2),
@country_name varchar(40),
@region_id int
)
as
begin
	UPDATE countries 
	SET country_name=@country_name , region_id=@region_id 
	WHERE country_id= @country_id
end
go
sp_paises_actualizar 'PE','NOM PE',2
GO
SELECT * from countries where country_id='PE'
GO
-- PROCEDIMIENTO PARA ELIMINAR UN PAIS
CREATE PROCEDURE sp_paises_eliminar
@codigo char(2)
as
begin
	delete from countries where country_id= @codigo
end
go
execute sp_paises_eliminar 'PE'
GO
SELECT * from countries where country_id='PE'
GO
--- PROCEDIMIENTO PARA CONSULTAR LOS PAISES
CREATE PROCEDURE sp_paises_consultar
as
begin
	select country_id, country_name, region_id  from countries
end
go
execute sp_paises_consultar
go

--- PROCEDIMIENTO PARA CONSULTAR LOS PAISES en base al campo nombre
CREATE PROCEDURE sp_paises_consultar_x_nombre
@texto varchar(100)
as
begin
	select country_id, country_name, region_id  from countries
	where country_name like CONCAT(@texto, '%')
end
go
execute sp_paises_consultar_x_nombre 'a'
go
/*Procedimientos para la tabla paises
	SP=>SIN PARAMETROS  TP=>TODOS LOS PARAMETROS
	sp_paises_consultar_x_nombre =>nombre
	sp_paises_consultar  => SP
	sp_paises_eliminar   => codigo
	sp_paises_actualizar => TP
	sp_paises_insertar   => TP
*/


CREATE or alter PROCEDURE sp_paises_crud
@indicador varchar(30),
@country_id char(2),
@country_name varchar(40),
@region_id int
as
begin
	IF @indicador = 'INSERTAR'
	begin
		PRINT 'INSERTAR'
		insert into countries(country_id, country_name, region_id) 
		values (@country_id, @country_name, @region_id)
	end
	IF @indicador = 'ACTUALIZAR'
	begin
		PRINT 'ACTUALIZAR'
		update countries set 
		country_name=@country_name, region_id=@region_id
		where country_id= @country_id
	end
	IF @indicador = 'ELIMINAR'
	BEGIN
		PRINT 'ELIMINAR'
		delete from countries where country_id= @country_id
	END
	IF @indicador = 'CONSULTAR'
	BEGIN
		PRINT 'CONSULTAR'
		select country_id, country_name, region_id  from countries
	END
	IF @indicador = 'CONSULTAR_X_NOMBRE'
	BEGIN
		PRINT 'CONSULTAR_X_NOMBRE'
		select country_id, country_name, region_id 
		from countries where country_name like CONCAT(@country_name, '%')	
	END
end
go
/*
@indicador varchar(30),
@country_id char(2),
@country_name varchar(40),
@region_id int
*/
sp_paises_crud 'CONSULTAR_X_NOMBRE', '','F', 0
go






-- CREAR UN PROCEDIMIENTO QUE NOS CONSULTE LOS EMPLEADOS
-- E INDIQUE LA CANTIDAD DE REGISTROS CONSULTADOS

CREATE PROCEDURE sp_empleados_reporte_1
@mensaje varchar(50) OUT
as
begin
	Declare @contador int 
	select employee_id, last_name, first_name  from employees
	set @contador = (select @@ROWCOUNT)
	set @mensaje = 'Filas afectadas : ' + CAST(@contador as varchar)
end
go

Declare @mensaje1 varchar(50)
Execute sp_empleados_reporte_1 @mensaje1 out
select @mensaje1 as Mensaje


-- SUMAR 2 NUMEROS
DECLARE @numero1 int
Declare @numero2  int
Declare @resultado int
SET @numero1 = 10
SET @numero2 = 20
SET @resultado = @numero1 + @numero2
PRINT @resultado
SELECT @resultado AS Resultado
-- DECLARAR VARIABLES PARA LA OBTENCION DE LOS CAMPOS DEL EMPLEADO 100
-- NOMBRE, APELLIDO Y CORREO
DECLARE @nombre varchar(20), @apellido varchar(25), 
		@correo varchar(100)

SELECT  @nombre=first_name,@apellido= last_name,
	    @correo= email  from employees where employee_id=100
Select @nombre as Nombre, @apellido AS Apellido, @correo as Correo

-- Declarar un contador que almacene el total de registros de la tabla empleados
Declare @contador int
set @contador = (  select count(*) from employees )
select @contador as [Total de Registros]
go



-- crear una funcion para la suma de 2 numeros
CREATE FUNCTION fn_sumar(@num1 int, @num2 int)
returns int
as
begin
	DECLARE @resultado int 
	set @resultado = @num1 + @num2
	return @resultado
end
go
SELECT dbo.fn_sumar(10,20) as Suma
go
print dbo.fn_sumar(10,20) 
go

create function fn_consultar_empleados_x_fechaContratacion(@year int)
returns table
as
	return (
		select * from employees where year(hire_date)= @year
	)

select * from dbo.fn_consultar_empleados_x_fechaContratacion(1994)
go

sp_help employees
go
create procedure sp_empleados_actualizar(
@correo varchar(100), @telefono varchar(20), @codigo int)
as
begin
	update employees set email=@correo, phone_number=@telefono where employee_id= @codigo

end
go


create or alter function fn_empleado_verificar_existencia
(
	@codigo int
)
returns varchar
as
begin
	DECLARE @mensaje varchar(100)
	Declare @contador int

	set @contador = ( select count(*) from employees WHERE employee_id= @codigo)
	if @contador = 1
		Begin
			set @mensaje= 'Se encontro el empleado : ' + CAST(@codigo as varchar)
		End
	else
		begin 
			set @mensaje = 'Empleado no se encuentra en la BD'
		end
	return @mensaje
end
go

-- CREAR LOGIN 
CREATE LOGIN LPARIONA WITH PASSWORD='3r1ck2024'
GO
-- CREAR USUARIO Y ASOCIAR LOGIN
CREATE USER UPARIONA for login LPARIONA
GO
-- CONCEDER PERMISO DE SELECCIONAR EN TABLA PAISES
GRANT SELECT ON countries to UPARIONA
GO
-- CONCEDER PERMISO DE ACTUALIZAR EN TABLA PAISES
GRANT UPDATE ON countries to UPARIONA
GO
-- CONCEDER PERMISO DE ELIMINAR EN TABLA PAISES
GRANT DELETE ON countries to UPARIONA
GO




