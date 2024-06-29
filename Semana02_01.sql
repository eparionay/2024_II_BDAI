create database semana02
go
use semana02
go


-- 1era forma
create table persona
(
	codigo int primary key,
	nombre varchar(50)
)
go
-- 2da forma
create table persona
(
	codigo int not null ,
	nombre varchar(50)
)
go

alter table persona
add constraint pk_persona_codigo
primary key (codigo)
go


-- 3era forma
drop table persona
go

create table persona(
	codigo int not null,
	nombre varchar(50),
	primary key(codigo)
)
go


create table paises(
	idPais int not null,
	nombrePais varchar(50)
)
go
create table clientes(
	idCliente int not null,
	nomCliente varchar(50),
	dirCliente varchar(50),
	idPais int,
	fonoCliente varchar(8)
)
go

alter table paises
add constraint pk_paises_id
primary key (idPais)
go
alter table clientes
add constraint pk_clientes_id
primary key (idCliente)
go
alter table clientes
add constraint fk_cli_pais_id
foreign key (idPais) references paises
go

alter table paises
add constraint uq_paises_nom
unique (nombrePais)
go




-- Consulta de 2 tablas
SELECT *
		 from paises paises 
				inner join clientes clientes
				on paises.idPais = clientes.idPais


CREATE TABLE ERROR_SISTEMA(
	ID int primary key identity(1,1),
	mensaje varchar(500),
	linea int,
	severidad int,
	estado int,
	procedimiento varchar(200),
	numero int
)
GO

SELECT * FROM ERROR_SISTEMA
GO



BEGIN TRY
	insert into paises(idPais, nombrePais) values (2, 'Peru')
END TRY
BEGIN CATCH
	INSERT INTO ERROR_SISTEMA(mensaje, linea,severidad, estado, procedimiento, numero)
	SELECT ERROR_MESSAGE(), ERROR_LINE(), ERROR_SEVERITY(),
	ERROR_STATE(), ERROR_PROCEDURE(), ERROR_NUMBER()
END CATCH

create table empleados
(
	id int primary key identity(1,1),
	nombre varchar(50) not null,
	edad int null,
	fechaRegistro datetime
)
go

alter table empleados
add constraint df_empleados_Fecha
default getDate() for fechaRegistro
go

insert into empleados (nombre, edad, fechaRegistro) values ('Juan', 20, '2024-05-01 23:40')
go
insert into empleados (nombre, edad) values ('Roberto', 30)
go
select * from empleados
go



-- Ejecuta normal
insert into empleados(id, nombre) values (1, 'Juan')
-- Error porque el campo nombre tiene que ser un valor 
insert into empleados(id, edad) values (1, 10)


create table producto(
	codigo int primary key identity (100,2),
	nombre varchar(50)
)
go



-- identity (100,2)  //1er parametro es valor inicial  //2do parametro es el incremento
insert into producto(nombre) values ('inca cola')
go

select * from producto
go



create table empleado2
(
	codigo int primary key identity(1,1),
	nombre varchar(20),
	genero char(1), -- [M] o [F]
	edad int   -- >= 18
)
go

alter table empleado2
add constraint chk_empleado2_genero
check ( genero in ('M','F')    )
go

alter table empleado2
add constraint chk_empleado2_edad
check ( edad >= 18)
go




