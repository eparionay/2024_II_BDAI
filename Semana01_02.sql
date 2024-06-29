
create database prueba03
on primary 
(
	name = 'prueba03_data', filename='D:\basedatos\prueba03_data.mdf', 
	size = 10 MB, maxsize = unlimited
),
(
	name='prueba03_sec1', filename='D:\basedatos\prueba03_sec1.ndf', size= 10mb, maxsize=500mb
)
log on
(
	name= 'prueba03_log', filename='D:\basedatos\prueba03_log.ldf', size= 5MB, maxsize= 100 MB,
	filegrowth= 5MB
)
go

use prueba03
go

alter database prueba03 add filegroup grupo01
go
alter database prueba03 add filegroup grupo02
go

alter database prueba03
add file
(
	name='prueba02_sec01', filename='D:\basedatos\prueba02_sec01.ndf', size= 10mb, maxsize=500mb
) to filegroup grupo01
go

alter database prueba03
add file
(
	name='prueba02_sec02', filename='d:\basedatos\prueba02_sec02.ndf', size= 10mb, maxsize= 500mb
)
to filegroup grupo02
go


ALTER DATABASE ejemplo2
modify file(Name=nombreLogicoejemplo2_MDF, size=20mb)
GO

alter database ejemplo03
remove file nombreLogico 
go






create partition function fn_porFecha(datetime)
as range right for values ('2010-01-01 00:00:00','2020-01-01 00:00:00')
go



