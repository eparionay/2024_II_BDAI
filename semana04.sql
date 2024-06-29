-- DECLARACION DE VARIABLES
DECLARE @numero1 int
DECLARE @numero2 int
DECLARE @resultado int
-- ASIGNACION
SET @numero1 = 1
SET @numero2 = 15
SET @resultado = @numero1 + @numero2
-- MOSTRAR 
PRINT @resultado
select @resultado as Resultado


-- CREAR VARIABLES NOMBRE Y APELLIDO
-- ASIGNARLE EL VALOR DE SUS DATOS
DECLARE @nombre varchar(30)
DECLARE @apellido varchar(50)

SET @nombre = 'E'
SET @apellido = 'PY'

PRINT 'Nombre: ' + @nombre + 
	  ' - Apellido : '+ @apellido
SELECT * from employees  where employee_id=100
go
/* DECLARAR VARIABLES Y ASIGNAR LOS DATOS
DEL EMPLEADO CON CODIGO 100 
CODIGO, NOMBRE, APELLIDO Y CORREO
*/
sp_help employees
go
DECLARE @codigo		int, 
		@nombre		varchar(20),
		@apellido	varchar(25),
		@correo		varchar(100)

select @codigo=employee_id, 
	   @nombre=first_name, 
	   @apellido=last_name, 
	   @correo=email from employees where employee_id=100

Select @codigo as Codigo, @nombre as Nombre, 
	   @apellido as Apellido, @correo as Correo
/* OBTENER EL NOMBRE DEL DEPARTAMENTO Y LOS DATOS DEL
 EMPLEADO (CODIGO, NOMBRE) CON EL CODIGO 104
 EMPLOYEES => CODIGO, NOMBRE
 DEPARTMENTS => NOMBRE
 */
 DECLARE @codigo int, 
	     @nombre varchar(20),
		 @departamento varchar(30)

 select @codigo=e.employee_id, 
	    @nombre=e.first_name, 
		@departamento= d.department_name
		 from employees e inner join departments d
		 on e.department_id = d.department_id
		 where e.employee_id=104

		 select @codigo as Codigo, @nombre as Nombre, 
			    @departamento as Departamento

/*
	Ejercicios Propuestos : Con creacion de variables
	1- De un determinado departamento mostrar la calle, 
	codigo postal, ciudad y nombre del departamento.
*/
declare @nombre_dep		varchar(30),
		@direccion		varchar(40), 
		@codigo_postal	varchar(12),
		@ciudad			varchar(30)

select @direccion=l.street_address, 
	   @codigo_postal= l.postal_code,
	   @ciudad= l.city, 
	   @nombre_dep=d.department_name  from departments d 
		inner join locations l
		on d.location_id = l.location_id
		where d.department_id=1
Select @nombre_dep as Departamento,
	   @direccion as Direccion, 
	   @codigo_postal as CodigoPostal, 
	   @ciudad as Ciudad
/*
	2- De un determinado empleado mostrar los siguientes datos:
	Puesto, Nombre y Apellido Empleado, Salario, 
	Nombre Departamento
*/




/*
	Indicar una edad, mostrar si es mayor o menor de edad.
	Se considera mayor o igual a 18
*/

Declare @edad int
Declare @mensaje varchar(30)
SET @edad = 19

IF @edad >=18
	BEGIN
		SET @mensaje = 'Mayor de edad'
	END
ELSE
	BEGIN 
		SET @mensaje = 'Menor de edad'
	END
SELECT @mensaje as Mensaje

/*
	De un determinado empleado se dice que recibe un bono siempre y cuando
	su departamento sea con codigo=4. El bono es de una laptop
*/

Declare @codigo_dep int
-- Obtencion de una columna
SET @codigo_dep = (SELECT department_id from employees where employee_id=203)

if @codigo_dep = 4
Begin
	Select 'Empleado recibe una laptop' as Mensaje
end

-- Obtener el tiempo de servicio a partir
-- de la fecha de contratacion y el ano actual
select hire_date , * from employees
select datediff(year,e.hire_date, GETDATE()) as YearWorked,
	   e.employee_id, e.first_name
		from employees e
/*
	Si el empleado cuenta con años de servicio se le indicara 
	su nueva categoria(A,B,C,D) en base a la siguiente tabla:
	CATEGORIA   TIEMPO DE SERVICIO
	D			1 - 10 (AÑOS)
	C		    11 - 20 (AÑOS)
	B			21 - 30 (AÑOS)
	A			31 A + (AÑOS)
*/
declare @tiempo_servicio int
set @tiempo_servicio = ( select  DATEDIFF(year, hire_date, GETDATE())  
							from employees where employee_id= 176 )
select @tiempo_servicio as TiempoServicio

IF @tiempo_servicio >=1 and @tiempo_servicio <=10
Begin
	select 'D' AS Mensaje
end
else if @tiempo_servicio>=11 and @tiempo_servicio<=20
Begin
	Select 'C' as Mensaje
end
else if @tiempo_servicio>=21 and @tiempo_servicio<=30
begin
	select 'B' as Mensaje
end
else
begin
	select 'A' as Mensaje
end

/*
ESTRUCTURA REPETITIVA
IMPRIMIR LOS 50 PRIMEROS NUMEROS
*/
declare @contador int
set @contador= 1
while @contador<=50
Begin
	print 'Numero ' + convert(varchar,@contador)
	set @contador= @contador+1
End

/*Indicar si el numero es par o impar*/
declare @contador int
set @contador= 1
while @contador<=50
Begin	
	if @contador % 2 = 0
		Begin
			print 'El numero : ' + Convert(varchar, @contador) + ' es par'
		End
	else
		begin
			print 'El numero : ' + Convert(varchar, @contador) + ' es impar'
		end
	set @contador= @contador+1
End





/*
	Mostrar los datos del empleado: Codigo, Nombre y Apellido. 
	Usando while que inicie en 100 y termine en 200.
	En caso no exista que indique un mensaje. El codigo indicado no existe.
*/
declare @cont int
set @cont = 100
Declare @codigo int
Declare @nombre varchar(30)
Declare @apellido varchar(50)

while @cont <=200
Begin
	if exists (Select 0 from employees where employee_id= @cont)
		Begin
			select @codigo= employee_id, @nombre =first_name, 
			@apellido = last_name  from employees where employee_id=@cont
			print 'ID : '+ str(@codigo) + ' - Nombre : ' + @nombre + ' - Apellido : ' +@apellido
		End
	Else
		Begin
			print 'ID : ' + str(@cont) + ' no existe'
		End
	SET @cont = @cont + 1
end


-- Otra forma

declare @cont int
set @cont = 100
Declare @codigo int
Declare @nombre varchar(30)
Declare @apellido varchar(50)

while @cont <=200
Begin
	if not exists (Select 0 from employees where employee_id= @cont)
		Begin
			print 'ID : ' + str(@cont) + ' no existe'
		End
	Else
		Begin
			select @codigo= employee_id, @nombre =first_name, 
			@apellido = last_name  from employees where employee_id=@cont
			print 'ID : '+ str(@codigo) + ' - Nombre : ' + @nombre + ' - Apellido : ' +@apellido
		End
	SET @cont = @cont + 1
end


-- Otra forma
declare @cont int
set @cont = 100
Declare @codigo int
Declare @nombre varchar(30)
Declare @apellido varchar(50)

while @cont <=200
Begin
	Declare @contador_registros int
	SET @contador_registros = (select count(*) from employees where employee_id= @cont)
	if  @contador_registros = 0
		Begin
			print 'ID : ' + str(@cont) + ' no existe'
		End
	Else
		Begin
			select @codigo= employee_id, @nombre =first_name, 
			@apellido = last_name  from employees where employee_id=@cont
			print 'ID : '+ str(@codigo) + ' - Nombre : ' + @nombre + ' - Apellido : ' +@apellido
		End
	SET @cont = @cont + 1
end

-- tablas declarativas

DECLARE @TABLA_empleados table(
	codigo int, nombre varchar(30), apellido varchar(30)
)
insert into @TABLA_empleados(codigo, nombre, apellido)
select employee_id, first_name, last_name    from employees

select * from @TABLA_empleados



-- #  tabla temporal local
create table #empleado
(
	codigo int, nombre varchar(30), apellido varchar(30)
)

insert into #empleado(codigo, nombre, apellido)
select employee_id, first_name, last_name    from employees

select * from #empleado

drop table #empleado

-- ## tabla temporal global
create table ##empleado
(
	codigo int, nombre varchar(30), apellido varchar(30)
)
insert into ##empleado(codigo, nombre, apellido)
select employee_id, first_name, last_name    from employees

select * from ##empleado

drop table ##empleado


-- TRANSACCIONES
select * from employees where employee_id=100



update employees set email='epy@cibertec.edu.pe'
where employee_id=100
-- EJEMLO 01 - TRANSACCION

BEGIN TRAN
update employees set email='epya@gmail.com' where employee_id=100

commit tran
select * from employees where employee_id=100

-- EJEMLO 02 - TRANSACCION
SET NOCOUNT ON
BEGIN TRY
	BEGIN TRAN
	update employees set email='epyab@gmail.com' where employee_id=100
	select 1/0 -- Provocando un error
	select * from employees where employee_id=100
	PRINT 'SE EJECUTO CORRECTAMENTE'
	PRINT 'INICIO DE CONFIRMACION'
	COMMIT TRAN
	PRINT 'FIN DE CONFIRMACION'

END TRY
BEGIN CATCH
	SELECT ERROR_MESSAGE() AS MENSAJE
	PRINT 'INICIO DE ROLLBACK'
	ROLLBACK TRAN
	PRINT 'FIN DE ROLLBACK'
END CATCH



CREATE TABLE tbl_prueba
(
	codigo int primary key identity(1,1),
	fechaRegistro datetime
)
select * from tbl_prueba
-- insert into tbl_prueba(fechaRegistro) values (GETDATE())

-- TAREA CREAR EVIDENCIA DEL JOB
-- QUE SE INSERTE EN LA TABLA TBL_PRUEBA
-- LA TAREA LA ENVIAN EN FORMATO WORD CON LAS IMAGENES
-- RESPECTIVAS
