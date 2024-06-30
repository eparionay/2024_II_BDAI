-- Ejercicio 01
Declare @codigo int, @nombre varchar(20), @apellido varchar(25)
Declare cursor_emp cursor
for select employee_id, first_name,last_name from employees
Open cursor_emp
Fetch next from cursor_emp into @codigo, @nombre, @apellido
while @@FETCH_STATUS = 0
Begin
	PRINT str(@codigo) + '-' + @nombre
	Fetch next from cursor_emp into @codigo, @nombre, @apellido
End
Close cursor_emp
Deallocate cursor_emp

-- Ejercicio 02
-- Cursor para la tabla departamentos
Declare @cod_dep int, @nom_dep varchar(30), @location_id int
declare cursor_dep cursor for 
select department_id, department_name, location_id  from departments
Open cursor_dep
FETCH NEXT FROM cursor_dep into @cod_dep,@nom_dep,@location_id
PRINT space(5)+'Codigo' + space(10) + 'Nombre Departamento'
while @@FETCH_STATUS = 0
begin
	print str(@cod_dep) + space(10)+@nom_dep
	FETCH NEXT FROM cursor_dep into @cod_dep,@nom_dep,@location_id
end
Close cursor_dep
deallocate cursor_dep
-- Ejercicio 03

Declare @codigo int, @nombre varchar(20), @apellido varchar(25)
Declare cursor_emp cursor
for select employee_id, first_name,last_name from employees
Open cursor_emp
Fetch next from cursor_emp into @codigo, @nombre, @apellido
Print 'Codigo'+ space(10)+ 'Nombre'+ space(10)+ 'Apellido'
while @@FETCH_STATUS = 0
Begin
	PRINT str(@codigo) + space(10) + dbo.fn_formatearTexto(@nombre) +space(10)+ @apellido
	Fetch next from cursor_emp into @codigo, @nombre, @apellido
End
Close cursor_emp
Deallocate cursor_emp

-- Nombre maximo => 11   (20)
-- Apellido maximo => 11 (20)

Create or alter function fn_formatearTexto
(	@texto varchar(20))
returns varchar(20)
as
begin
	-- Limite 20
	Declare @formato varchar(20)
	Declare @cantidad int
	Declare @resta int
	set @cantidad = len(@texto) -- 15
	set @resta = 20 - @cantidad -- 20-15 = 5
	SET @formato =  @texto + space(@resta)
return @formato
end

-- Ejercicio 04

Declare @cod_dep int, @nom_dep varchar(30), @location_id int
declare cursor_dep cursor for 
select department_id, department_name, location_id  from departments
Open cursor_dep
FETCH NEXT FROM cursor_dep into @cod_dep,@nom_dep,@location_id
while @@FETCH_STATUS = 0
begin
	Declare @total_empleado int 
	set @total_empleado = (select count(*) from employees where department_id= @cod_dep)

	print 'Codigo Departamento : ' + str(@cod_dep) + space(5) + 'Nombre Departamento : ' + @nom_dep
	print 'Total Empleados: '  + str(@total_empleado)
	print '***************************************************************'
	FETCH NEXT FROM cursor_dep into @cod_dep,@nom_dep,@location_id
end
Close cursor_dep
deallocate cursor_dep


-- Ejercicio 05
Declare @cod_dep int, @nom_dep varchar(30), @location_id int
declare cursor_dep cursor for 
select department_id, department_name, location_id  from departments
Open cursor_dep
FETCH NEXT FROM cursor_dep into @cod_dep,@nom_dep,@location_id
while @@FETCH_STATUS = 0
begin
	Declare @total_empleado int 
	set @total_empleado = (select count(*) from employees where department_id= @cod_dep)
	print 'Codigo Departamento : ' + str(@cod_dep) + space(5) + 'Nombre Departamento : ' + @nom_dep
	print 'Total Empleados: '  + str(@total_empleado)

	Declare @nombre varchar(20), @apellido varchar(20)
	Declare cursor_empleados cursor for 
			select first_name, last_name  from employees where department_id= @cod_dep
	Open cursor_empleados
	FETCH NEXT FROM cursor_empleados into @nombre, @apellido
	print '----------------------------------------------------------------'
	PRINT dbo.fn_formatearTexto('Nombre') + dbo.fn_formatearTexto('Apellido')
	print '----------------------------------------------------------------'
	WHILE @@FETCH_STATUS = 0
	Begin
		print dbo.fn_formatearTexto(@nombre) + space(5) + dbo.fn_formatearTexto(@apellido)
		FETCH NEXT FROM cursor_empleados into @nombre, @apellido
	End
	Close cursor_empleados
	Deallocate cursor_empleados
	print '***************************************************************'
	FETCH NEXT FROM cursor_dep into @cod_dep,@nom_dep,@location_id
end
Close cursor_dep
deallocate cursor_dep
-- Ejercicio 06
Declare @codigo_reg int, @nombre_reg varchar(30)
Declare cursor_regiones cursor for
select region_id, region_name  from regions
Open cursor_regiones
Fetch next from cursor_regiones into @codigo_reg, @nombre_reg
while @@FETCH_STATUS = 0
Begin
	PRINT 'Nombre Region : '+ @nombre_reg
	PRINT 'LISTADO DE PAISES'
	-- Inicio Cursor interno
	Declare @codigo_pais char(2), @nombre_pais varchar(50)
	Declare cursor_paises cursor for
		select country_id, country_name from countries where region_id=@codigo_reg
	Open cursor_paises
	Fetch next from cursor_paises into @codigo_pais, @nombre_pais
	PRINT 'Codigo'+ space(2) + 'Nombre'
	while @@FETCH_STATUS = 0
	begin
		PRINT @codigo_pais + space(5) + @nombre_pais
		Fetch next from cursor_paises into @codigo_pais, @nombre_pais
	end
	Close cursor_paises
	Deallocate cursor_paises
	-- Fin Cursor interno
	PRINT '********************************************************'
	Fetch next from cursor_regiones into @codigo_reg, @nombre_reg
End
Close cursor_regiones
Deallocate cursor_regiones



CREATE OR ALTER TRIGGER TRG_PAISES_ACTUALIZAR
ON countries
after insert
as
	print 'Se realizo una insercion'
GO

drop trigger TRG_PAISES_ACTUALIZAR
go

CREATE OR ALTER TRIGGER TRG_PAISES_ACTUALIZAR
ON countries
for update
as
	SELECT * from inserted
	select * from deleted
go
	update countries set country_name='PAIS 4', region_id=1 where country_id='A1'
	go

	INSERT INTo countries (country_id, country_name, region_id)
	VALUES ('A2','PAIS A', 1)
	go

drop trigger TRG_PAISES_ACTUALIZAR
go

select * from countries
go


create or alter trigger trg_paises_auditoria
on countries
for insert, delete, update
as
begin
	IF EXISTS( SELECT 0 FROM inserted) AND exists(select 0 from deleted)
	Begin
		PRINT 'Se esta realizacion una actualizacion'
	End
	else if exists(select 0 from inserted)
	begin
		print 'Se esta realizando una insercion'
	end
	else
	begin
		print 'Se esta realizando una eliminacion'
	end
end
go


	update countries set country_name='PAIS 4', 
	region_id=1 where country_id='A1'
	go

	INSERT INTo countries (country_id, country_name, region_id)
	VALUES ('A3','PAIS A', 1)
	go

	delete from countries where country_id='A3'
	GO

Create table auditoria_paises
(
	idTbl int primary key identity(1,1),
	country_id char(2),
	country_name varchar(40),
	region_id int,
	fechaRegistro datetime,
	accion varchar(20) -- Insercion, Eliminacion, Actualizacion
)
go

create or alter trigger trg_paises_auditoria
on countries
for insert, delete, update
as
begin
	IF EXISTS( SELECT 0 FROM inserted) AND exists(select 0 from deleted)
	Begin
		INSERT INTO auditoria_paises(country_id, country_name, region_id, fechaRegistro, accion)
		select country_id, country_name, region_id, getdate(), 'Actualizacion'   from inserted
		PRINT 'Se esta realizacion una actualizacion'
	End
	else if exists(select 0 from inserted)
	begin
		INSERT INTO auditoria_paises(country_id, country_name, region_id, fechaRegistro, accion)
		select country_id, country_name, region_id , getdate(), 'Insercion' from inserted
		print 'Se esta realizando una insercion'
	end
	else
	begin
	    INSERT INTO auditoria_paises(country_id, country_name, region_id, fechaRegistro, accion)
		select country_id, country_name, region_id , getdate(), 'Eliminacion' from deleted
		print 'Se esta realizando una eliminacion'
	end
end
go

	update countries set country_name='PAIS 4', 
	region_id=1 where country_id='A1'
	go

	INSERT INTo countries (country_id, country_name, region_id)
	VALUES ('A5','PAIS A', 1)
	go

	delete from countries where country_id='A5'
	GO

	Select * from auditoria_paises
	go

	truncate table auditoria_paises
	go
	-- CREAR UN TRIGGER CUANDO SE REGISTRE UN NUEVO EMPLEADO
	-- MOSTRAR LA FECHA Y HORA DE CREACION, ACCION (Insercion)















