
CREATE TABLE TBL_ERROR(
	id int primary key identity(1,1),
	mensaje varchar(500),
	linea int,
	estado int,
	procedimiento varchar(200),
	severidad int,
	numero int,
	fechaRegistro datetime
)
go


BEGIN TRY
	SELECT 1/0
END TRY
BEGIN CATCH
	INSERT INTO TBL_ERROR( mensaje, linea, estado, procedimiento,
				severidad, numero, fechaRegistro
				)
	SELECT ERROR_MESSAGE(), ERROR_LINE(), ERROR_STATE(),
		   ERROR_PROCEDURE(), ERROR_SEVERITY(), ERROR_NUMBER(), getdate()
END CATCH



select * from TBL_ERROR
go
-- 1era forma
CREATE TABLE EMPLEADO(
	codigo int primary key not null,
	nombre varchar(30),
	apellido varchar(50)
)
go
-- 2da forma
CREATE TABLE EMPLEADO1(
	codigo int not null,
	nombre varchar(30),
	apellido varchar(50),
	primary key(codigo)
)
go
-- 3era forma
CREATE TABLE EMPLEADO2(
	codigo int not null,
	nombre varchar(30),
	apellido varchar(50)
)
GO

ALTER TABLE EMPLEADO2
ADD CONSTRAINT PK_EMPLEADO2_CODIGO
PRIMARY KEY (codigo)
go

-- ELIMINAR CONSTRAINT PK_EMPLEADO2_CODIGO
ALTER TABLE EMPLEADO2
DROP CONSTRAINT PK_EMPLEADO2_CODIGO
GO


CREATE TABLE PAISES(
	IDPAIS INT PRIMARY KEY NOT NULL, ---
	NOMBREPAIS VARCHAR(100)
)
GO

CREATE TABLE CLIENTES(
	IDCLIENTE INT PRIMARY KEY NOT NULL,
	NOMCLIENTE VARCHAR(50),
	DIRCLIENTE VARCHAR(50),
	IDPAIS INT, --- 
	FONOCLIENTE VARCHAR(9)
)
GO

ALTER TABLE CLIENTES
ADD CONSTRAINT FK_CLIENTES_IDPAIS
FOREIGN KEY (IDPAIS) REFERENCES PAISES
GO

ALTER TABLE PAISES
ADD CONSTRAINT UQ_PAISES_NOM
UNIQUE (NOMBREPAIS)
GO

 -- INSERTANDO 2 PAISES CON EL MISMO NOMBRE
BEGIN TRY
	-- INSERT INTO PAISES (IDPAIS, NOMBREPAIS) VALUES (1, 'PERU')
	INSERT INTO PAISES (IDPAIS, NOMBREPAIS) VALUES (2, 'PERU')
END TRY
BEGIN CATCH
	INSERT INTO TBL_ERROR( mensaje, linea, estado, procedimiento,
				severidad, numero, fechaRegistro
				)
	SELECT ERROR_MESSAGE(), ERROR_LINE(), ERROR_STATE(),
		   ERROR_PROCEDURE(), ERROR_SEVERITY(), ERROR_NUMBER(), getdate()
END CATCH

SELECT * FROM TBL_ERROR


CREATE TABLE CLIENTES2(
	ID INT PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(50) NOT NULL,
	GENERO CHAR(1) NULL
)
GO
-- EJECUTA
INSERT INTO CLIENTES2(ID, NOMBRE ) VALUES (1, 'JUANA')
-- EJECUTA
INSERT INTO CLIENTES2(ID, NOMBRE, GENERO ) VALUES (2, 'LUCCIA', 'F')
-- NO EJECUTA
INSERT INTO CLIENTES2(ID, GENERO) VALUES (3, 'F')

DROP TABLE CLIENTES2
GO
CREATE TABLE CLIENTES2(
	ID INT PRIMARY KEY NOT NULL,
	NOMBRE VARCHAR(50) NOT NULL,
	GENERO CHAR(1) NULL,
	FECHAREGISTRO DATETIME
)
GO

ALTER TABLE CLIENTES2
ADD CONSTRAINT DF_CLIENTES2_FECHA
DEFAULT GETDATE() FOR FECHAREGISTRO  --- DEFAULT VALOR PARA EL CAMPO
GO

ALTER TABLE CLIENTES2
ADD CONSTRAINT DF_CLIENTES2_GENERO
DEFAULT 'M' FOR GENERO
GO

INSERT INTO CLIENTES2 (ID, NOMBRE, GENERO) VALUES (1, 'LUCIA', 'F')
GO
INSERT INTO CLIENTES2 (ID, NOMBRE) VALUES (2, 'PEPE')
GO
INSERT INTO CLIENTES2 (ID, NOMBRE) VALUES (3, 'LUIS')
GO
SELECT * FROM CLIENTES2
GO

CREATE TABLE PERSONA(
	CODIGO INT PRIMARY KEY IDENTITY(100,2),
	NOMBRE VARCHAR(30) NOT NULL,
	EDAD INT NOT NULL
)
GO
--- 100 -- 102 -- 104
ALTER TABLE PERSONA
ADD CONSTRAINT DF_PERSONA_EDAD
DEFAULT 1 FOR EDAD
GO

INSERT INTO PERSONA (NOMBRE, EDAD) VALUES ('JUAN', 10)
GO
INSERT INTO PERSONA (NOMBRE, EDAD) VALUES ('ERICKA', 12)
GO
INSERT INTO PERSONA (NOMBRE) VALUES ('LUISA')
GO
INSERT INTO PERSONA (NOMBRE, EDAD) VALUES ('NORMA', 35)
GO
SELECT * FROM PERSONA
GO

DROP TABLE PERSONA
GO


CREATE TABLE PERSONA(
	ID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	NOMBRE VARCHAR(30) NOT NULL,
	EDAD INT NOT NULL,
	GENERO CHAR(1) NOT NULL
)
GO
ALTER TABLE PERSONA
DROP CONSTRAINT CHK_PERSONA_GENERO
GO
-- 1ERA RESTRICCION GENERO SOLO ACEPTE M O F AL CAMPO GENERO
ALTER TABLE PERSONA
ADD CONSTRAINT CHK_PERSONA_GENERO
CHECK ( GENERO IN ('M','F') )
GO
-- 2DA RESTRICCION EDAD > 18 AL CAMPO EDAD
ALTER TABLE PERSONA
ADD CONSTRAINT CHK_PERSONA_EDAD
CHECK ( EDAD > 18)
GO
INSERT INTO PERSONA (NOMBRE, EDAD, GENERO) VALUES ('LUISA', 17, 'F') -- NO INSERTA
INSERT INTO PERSONA (NOMBRE, EDAD, GENERO) VALUES ('LUISA', 19, 'F') -- INSERTA
INSERT INTO PERSONA (NOMBRE, EDAD, GENERO) VALUES ('ROBERT', 20, 'I') --NO INSERTA

CREATE TABLE PERSONA4
(
	CODIGO INT,
	NOMBRE VARCHAR(50),
	EDAD INT
)
GO

BULK INSERT PERSONA4
FROM  'D:\prueba\prueba.txt' -- DIRECCION DE SU ARCHIVO
WITH (FIELDTERMINATOR = ',');

select * from PERSONA4
go

-- levelType,code,catalogType,name,description,sourceLink
create table catalogo
(	
	levelType varchar(500),
	code varchar(500),
	catalogType varchar(500),
	name varchar(500),
	description varchar(500),
	sourceLink varchar(500)
)
go

BULK INSERT catalogo
FROM  'D:\prueba\catalogo.csv' -- DIRECCION DE SU ARCHIVO
WITH (FIELDTERMINATOR = ',');

select * from catalogo
go

-- ELEGIR 2 ARCHIVOS CUALQUIERA Y HACER EL REGISTRO CON BULK INSERT
-- ESTA TABLA ES DE AMBIENTE DESARROLLO
CREATE TABLE TABLA1(
	CODIGO INT PRIMARY KEY,
	NOMBRE VARCHAR(30),
	EDAD INT
)
GO
-- ESTA TABLA ES DE AMBIENTE PRODUCCION
CREATE TABLE TABLA2(
	CODIGO INT PRIMARY KEY,
	NOMBRE VARCHAR(30),
	EDAD INT	
)
GO
BULK INSERT TABLA1
FROM  'D:\prueba\tabla1.txt'
WITH (FIELDTERMINATOR = ',');

BULK INSERT TABLA2
FROM  'D:\prueba\tabla2.txt' 
WITH (FIELDTERMINATOR = ',');

select * from tabla1
select * from tabla2


MERGE TABLA1 AS PRINCIPAL
USING 
(
  SELECT CODIGO, NOMBRE, EDAD FROM TABLA2
) AS SECUNDARIA
ON
(
	PRINCIPAL.CODIGO = SECUNDARIA.CODIGO
)
WHEN MATCHED THEN
	UPDATE SET NOMBRE = SECUNDARIA.NOMBRE,
		       EDAD = SECUNDARIA.EDAD
WHEN NOT MATCHED THEN
	INSERT (CODIGO, NOMBRE, EDAD) 
	VALUES (
			SECUNDARIA.CODIGO, SECUNDARIA.NOMBRE,
			SECUNDARIA.EDAD
	);

UPDATE TABLA1 SET NOMBRE='JUANA', EDAD= 50 WHERE CODIGO=1
GO 
UPDATE TABLA1 SET NOMBRE='SONIA', EDAD= 30 WHERE CODIGO=3
GO 
DELETE FROM TABLA1 WHERE CODIGO=1
GO
DELETE FROM TABLA1 WHERE CODIGO=2
GO


DROP TABLE TABLA1
GO


CREATE TABLE TABLA1(
	CODIGO INT,
	NOMBRE VARCHAR(30),
	EDAD INT
)
GO
DROP TABLE TABLA1
GO
CREATE TABLE TABLA1(
	CODIGO INT PRIMARY KEY,
	NOMBRE VARCHAR(30),
	EDAD INT
)
GO

ALTER TABLE TABLA1
ADD CONSTRAINT UQ_TABLA1_NOMBRE
UNIQUE (NOMBRE)
GO

-- CLUSTER -- AGRUPADO
-- NO CLUSTER - NOAGRUPADO



DROP TABLE TABLA1
GO

CREATE TABLE TABLA1(
	CODIGO INT ,
	NOMBRE VARCHAR(30),
	EDAD INT
)
GO
-- AGRUPADO
CREATE CLUSTERED INDEX IDX_TABLA1_CODIGO
ON TABLA1(CODIGO)
GO

INSERT INTO TABLA1(CODIGO, NOMBRE, EDAD) VALUES(1, 'JUAN', 10)
INSERT INTO TABLA1(CODIGO, NOMBRE, EDAD) VALUES(2, 'ALEX', 15)
INSERT INTO TABLA1(CODIGO, NOMBRE, EDAD) VALUES(3, 'SONIA', 23)

SELECT * FROM TABLA1
GO

CREATE NONCLUSTERED INDEX IDX_TABLA1_NOMBRE
ON TABLA1(NOMBRE)
GO
