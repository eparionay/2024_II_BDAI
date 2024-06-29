create database bdprueba01
go

use bdprueba01
go

alter database bdprueba01 add filegroup grupo01
go

alter database bdprueba01 add filegroup grupo02
go

alter database bdprueba01
add file 
(
	name= bdprueba01_sec01, filename = 'D:\bd\bdprueba01.ndf', size= 100MB
) to filegroup grupo01
go

alter database bdprueba01
add file 
(
	name= bdprueba01_sec02, filename = 'D:\bd\bdprueba02.ndf', size= 100MB
) to filegroup grupo02
go


alter database bdprueba01 remove file bdprueba01_sec01
go

sp_helpdb bdprueba01
go





create table persona(
	codigo int, nombre varchar(50)
)
go

create table direccion( codigo int, descripcion varchar(100))
go
-- CONSULTAR LOS GRUPOS DE ARCHIVOS
select * from sys.filegroups
go
-- CONSULTAR LAS TABLAS
select * from sys.tables
go
-- CONSULTAR LOS OBJETOS DE LA BD -- U => tablas  P=> USP
select * from sys.objects where type='U'   
GO
-- CONSULTAR LOS PROCEDIMIENTOS ALMACENADOS
SELECT * from INFORMATION_SCHEMA.ROUTINES
GO


-- CREACION DE ESQUEMAS

CREATE SCHEMA RECURSOSHUMANOS
GO

CREATE SCHEMA MARKETING 
GO

CREATE SCHEMA COMUNICACIONES
GO

CREATE TABLE RECURSOSHUMANOS.TABLA01(
	codigo int, nombre varchar(50)
)
go

select * from RECURSOSHUMANOS.TABLA01
go
-- ver la estructura de la tabla persona
sp_help persona
go

sp_help [RECURSOSHUMANOS.TABLA01]
go

select * from sys.schemas
go

SELECT TOP 1 * from SYS.indexes
select top 20 * from sys.objects  where type='U'
select top 10 * from sys.filegroups


create table empleado
( codigo int, nombre varchar(50)) on grupo01
go


		   SELECT o.[name] AS 'TABLE', f.[name] AS 'FILE_GROUP'
			FROM sys.indexes i inner JOIN sys.filegroups f ON i.data_space_id = f.data_space_id INNER JOIN sys.objects o
			ON i.[object_id] = o.[object_id]
			WHERE
			o.type = 'U' and
			i.type < 2
			Order by O.name
			GO