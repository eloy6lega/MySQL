-- 1 --
DROP DATABASE IF EXISTS FUTBOL;
CREATE DATABASE FUTBOL;
USE FUTBOL;

CREATE TABLE EQUIPO(
    IDEQUIPO VARCHAR(2) PRIMARY KEY,
    NOMBRE VARCHAR(50),
    COPAS_REY VARCHAR(100)
);

CREATE TABLE FUTBOLISTA(
    IDFUTBOLISTA VARCHAR(2) PRIMARY KEY,
    IDEQUIPO VARCHAR(2),
    NOMBRE VARCHAR(50),
	FOREIGN KEY (IDEQUIPO) REFERENCES EQUIPO(IDEQUIPO)
);

-- 2 --
INSERT INTO EQUIPO VALUES (1,'PorcinosFC','0');
INSERT INTO EQUIPO VALUES (2,'Cartagena','0');

-- 3 --
INSERT INTO FUTBOLISTA VALUES (1,1,'Ibai Llanos');
INSERT INTO FUTBOLISTA VALUES (2,1,'Auron Play');
INSERT INTO FUTBOLISTA VALUES (3,1,'Luis Enrique');
INSERT INTO FUTBOLISTA VALUES (4,2,'Rafa Nadal');
INSERT INTO FUTBOLISTA VALUES (5,2,'Roger Federer');
INSERT INTO FUTBOLISTA VALUES (6,2,'Carlos Alcaraz');

-- 4 --
SELECT FUTBOLISTA.NOMBRE, EQUIPO.NOMBRE AS NOMBRE_EQUIPO FROM FUTBOLISTA
INNER JOIN EQUIPO 
ON FUTBOLISTA.IDEQUIPO=EQUIPO.IDEQUIPO;

-- 5 --
SET SQL_SAFE_UPDATES = 0;
UPDATE FUTBOLISTA
SET IDEQUIPO= '2'
WHERE IDFUTBOLISTA = 1;
SET SQL_SAFE_UPDATES = 1;

SELECT FUTBOLISTA.NOMBRE, EQUIPO.NOMBRE AS NOMBRE_EQUIPO FROM FUTBOLISTA
INNER JOIN EQUIPO 
ON FUTBOLISTA.IDEQUIPO=EQUIPO.IDEQUIPO;

-- 6 --
#CREADO EN LA TABLA EQUIPO

-- 7 --
SET SQL_SAFE_UPDATES = 0;
-- PRIMER EQUIPO --
UPDATE EQUIPO
SET COPAS_REY = '2004-2007-2012-2013-2022'
WHERE IDEQUIPO = 1;

-- SEGUNDO EQIUPO --
UPDATE EQUIPO
SET COPAS_REY = '2005-2008-2014-2021'
WHERE IDEQUIPO = 2;
SET SQL_SAFE_UPDATES = 1;

SELECT NOMBRE, COPAS_REY FROM EQUIPO;

-- 8 --
SET SQL_SAFE_UPDATES = 0;
DELETE FROM EQUIPO WHERE IDEQUIPO = 2;
SET SQL_SAFE_UPDATES = 1;

#Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column. Cannot use range access on index 'PRIMARY'
#due to type or collation conversion on field 'IDEQUIPO'
#Este error nos da porque no hemos desactivado el modo seguro, por lo tanto, MySQL nos protege los datos y no nos deja eliminarlo.
#Para poder eliminarlo deberíamos desactivar el modo seguro al igual que en los updates y una vez escrito el delete, activarlo otra vez.

#Si lo ejecutamos desactivando el modo seguro, pensaremos que nos dejará ejecutarlo, PERO NO. La foreign key de futbolista nos protege los datos de esta. Aquí el error:
#Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`futbol`.`futbolista`, CONSTRAINT `futbolista_ibfk_1` FOREIGN KEY (`IDEQUIPO`)
#REFERENCES `equipo` (`IDEQUIPO`))


