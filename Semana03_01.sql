/*
Definir una tabla persona con los campos
id, nombre, apellido y edad*/
create database semana03
go
use semana03
go
create table persona(
	id int not null,
	nombre varchar(30),
	apellido varchar(50),
	edad smallint
)
go
-- alterar la tabla y agregar la llave primaria al campo id
alter table persona
add constraint pk_persona_id
primary key (id)
go
-- alterar la tabla y agregar un constraint unique al campo apellido


-- ver los indices de una tabla X
sp_helpindex 'persona'

-- Agregar el campo fechaRegistro
alter table persona
add fechaRegistro datetime
go





-- Creacion de indice no agrupado
create nonclustered index idx_persona_apellido
on persona(apellido)
go
-- borrar un indice
drop index idx_persona_apellido on persona
go
-- crear un indice no agrupado al campo edad descendente
create nonclustered index idx_persona_edad
on persona(edad desc)
go
-- Crear un indice incluyendo los campos de apellido y edad
create nonclustered index idx_persona_multi
on persona(nombre)
include (apellido, edad)
go

