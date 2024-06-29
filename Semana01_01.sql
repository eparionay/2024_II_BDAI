
CREATE DATABASE PRUEBA_BDAI
ON PRIMARY
(
	NAME= 'DATOS', FILENAME='C:\BD\DATOS.mdf', SIZE=10MB, MAXSIZE=UNLIMITED
)
LOG ON(
	NAME= 'LOG', FILENAME='C:\BD\LOG.ldf', MAXSIZE=100MB, FILEGROWTH=5MB
)
GO
-- VER LA ESTRUCTURA DE LA BD
SP_HELPDB PRUEBA_BDAI
GO

CREATE TABLE PRUEBA(
	ID INT
	)
	GO


alter database prueba_bdai add filegroup data_1
alter database prueba_bdai add filegroup data_2

alter database prueba_bdai
add file (name=data1,filename='c:\bd\data1.ndf', size=1mb, maxsize=5mb, filegrowth=1mb)
to filegroup data_1

alter database prueba_bdai
add file (name=data2, filename='c:\bd\data2.ndf', size=1mb, maxsize=5mb, filegrowth=2mb)
to filegroup data_2

ALTER DATABASE prueba_bdai
MODIFY FILE (NAME=data1,
SIZE=10MB,
FILEGROWTH=15%
)
GO
use master 
go
-- Eliminar un archivo secundarios
ALTER DATABASE prueba_bdai
REMOVE FILE data2
GO

CREATE SCHEMA FINANZAS
GO

CREATE SCHEMA RRHH
GO

CREATE SCHEMA CONTABILIDAD
GO

create table [RRHH].TABLA
(
	codigo int,
	nombre varchar(20)
)
go

CREATE TABLE RRHH.TABLA2
(
	codigo int,
	nombre varchar(20)
)
go

sp_help [RRHH.TABLA2]


SELECT * FROM SYS.SCHEMAS
GO

SELECT * FROM SYS.tables



EXEC sp_addtype nombre, 'varchar(10)', 'NOT NULL'

EXEC sp_droptype 'nombre' 

EXEC sp_addtype edad, int, 'NOT NULL'
EXEC sp_droptype 'edad' 

create table persona
(
	id int,
	edad edad
)

sp_help edad









CREATE PARTITION FUNCTION PedidosxDecada(datetime)
AS RANGE RIGHT
FOR VALUES ('2000-01-01', '2010-01-01')
GO
-- Filegroup para pedidos< 01/01/2000
ALTER DATABASE PRUEBA_BDAI
ADD FILEGROUP PedidosA
GO
-- Filegroup para pedidos>= 01/01/2000 AND <= 31/12/2009
ALTER DATABASE PRUEBA_BDAI
ADD FILEGROUP PedidosB
GO
-- Filegroup para pedidos>= 01/01/2010
ALTER DATABASE PRUEBA_BDAI
ADD FILEGROUP PedidosC
GO

ALTER DATABASE PRUEBA_BDAI
ADD FILE(NAME = PedidosA, FILENAME = 'C:\BD\PedidosA.ndf')
TO FILEGROUP PedidosA
GO
-- Pedidos2010B filegroup
ALTER DATABASE PRUEBA_BDAI
ADD FILE(NAME = PedidosB, FILENAME = 'C:\BD\PedidosB.ndf')
TO FILEGROUP PedidosB
GO
-- Pedidos2010A filegroup
ALTER DATABASE PRUEBA_BDAI
ADD FILE(NAME = PedidosC, FILENAME = 'C:\BD\PedidosC.ndf')
TO FILEGROUP PedidosC
GO


CREATE PARTITION SCHEME PedidosxDecadaSC
AS PARTITION PedidosxDecada
TO (PedidosA, PedidosB, PedidosC)
GOCREATE TABLE Pedidos(
idPedido int NOT NULL,
Fecha datetime NULL)
ON PedidosxDecadaSC(Fecha)set dateformat ymdINSERT INTO Pedidos(idPedido, Fecha) values (1,'2010-01-01 00:00:00')INSERT INTO Pedidos(idPedido, Fecha) values (2,'2005-01-01 00:00:00')INSERT INTO Pedidos(idPedido, Fecha) values (3,'2008-01-01 00:00:00')select *, $Partition.PedidosxDecada(Fecha) from Pedidos






























