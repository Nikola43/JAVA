TIPO B

Nombre: <Pon aquí tu nombre>

************************************************************************
	INSTRUCCIONES:
	==============

-Salva este fichero con las iniciales de tu nombre y apellidos,
 en el directorio "C:\Examen\ ":
	Ejemplo:	José María Rivera Calvete
			JMRC.txt

-Pon tu nombre al ejercicio y lee atentamente todas las preguntas.

-Entra en "SQL Plus" con cualquier usuario. 

-Carga el script para el examen desde el fichero "Empresa.sql".

-Donde ponga "SQL>", copiarás las sentencias SQL que has utilizado.

-Donde ponga "RESULTADOS:" copiarás el resultado que SQL*Plus te devuelve.

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en la recuperación tendrás otra oportunidad.

	PUNTUACIÓN
	==========
- Preguntas 1-14:	0,50 puntos cada una
- Pregunta 15:		3 puntos

************************************************************************
	Descripción de las tablas:
	==========================

CENTROS
-------
# COD_CE		NUMBER(2)		Código del Centro
* DIRECTOR_CE	NUMBER(6)		Director del Centro
  NOMB_CE		VARCHAR2(30)	Nombre del Centro (O)
  DIRECC_CE		VARCHAR2(50)	Dirección del Centro (O)
  POBLAC_CE		VARCHAR2(15)	Población del Centro (O)

DEPARTAMENTOS
-------------
# COD_DE		NUMBER(3)		Código del Departamento
* DIRECTOR_DE	NUMBER(6)		Director del Departamento
* DEPTJEFE_DE	NUMBER(3)		Departamento del que depende
* CENTRO_DE		NUMBER(2)		Centro trabajo (O)
  NOMB_DE		VARCHAR2(40)	Nombre del Departamento (O)
  PRESUP_DE		NUMBER(11)		Presupuesto del Departamento (O)
  TIPODIR_DE	CHAR(1)			Tipo de Director del Departamento (O)

EMPLEADOS
---------
# COD_EM		NUMBER(6)		Código del Empleado
* DEPT_EM		NUMBER(3)		Departamento del Empleado (O)
  EXTTEL_EM		CHAR(9)			Extensión telefónica
  FECINC_EM		DATE			Fecha de incorporación del Empleado (O)
  FECNAC_EM		DATE			Fecha de nacimiento del Empleado (O)
  DNI_EM		VARCHAR2(9)		DNI del Empleado (U)
  NOMB_EM		VARCHAR2(40)	Nombre del Empleado (O)
  NUMHIJ_EM		NUMBER(2)		Número de hijos del Empleado (O)
  SALARIO_EM	NUMBER(9)		Salario Anual del Empleado (O)

HIJOS
-----
#*PADRE_HI	NUMBER(6)		Código del Empleado
# NUMHIJ_HI	NUMBER(2)		Número del hijo del Empleado
  FECNAC_HI	DATE			Fecha de nacimiento del Hijo (O)
  NOMB_HI	VARCHAR2(40)	Nombre del Hijo (O)

Nota: 
	# PRIMARY KEY
	* FOREIGN KEY
	(O) Obligatorio
	(U) Único

************************************************************************
1.- Insertar un departamento con código 900 y nombre 'Ingenieria de sistemas', cuyo presupuesto será igual al triple de la masa salarial del departamento con menor masa salarial, dicho departamento será del que dependerá éste. El resto de datos serán los del departamento del que depende.

SQL>
INSERT INTO DEPARTAMENTOS
	SELECT 900, DIRECTOR_DE, COD_DE, CENTRO_DE, 'Ingenieria de sistemas', 3*SUM(SALARIO_EM), TIPODIR_DE
	FROM EMPLEADOS, DEPARTAMENTOS
	WHERE COD_DE=DEPT_EM
	GROUP BY NOMB_DE, DIRECTOR_DE, COD_DE, CENTRO_DE, TIPODIR_DE
	HAVING SUM(SALARIO_EM)= (SELECT MIN(SUM(SALARIO_EM))
							FROM EMPLEADOS
							GROUP BY DEPT_EM);

RESULTADO:
 900 DIRECTOR_DE     COD_DE  CENTRO_DE 'INGENIERIADESISTEMAS' 3*SUM(SALARIO_EM) T
---- ----------- ---------- ---------- ---------------------- ----------------- -
 900           2        300         10 Ingenieria de sistemas          54000000 P
************************************************************************
2.- Modificar el director del departamento 900 al empleado más joven.

SQL>
UPDATE DEPARTAMENTOS
	SET DIRECTOR_DE = (SELECT COD_EM
						FROM EMPLEADOS
						WHERE FECNAC_EM = (SELECT MAX(FECNAC_EM)
										FROM EMPLEADOS))
	WHERE COD_DE=900;
RESULTADO:

************************************************************************
3.- Listar el DNI y el complemento por antigüedad de los empleados sin hijos. 
NOTA: El complemento por antigüedad será el 3% del salario por cada año.

SQL>
SELECT DNI_EM, SALARIO_EM*0.03*TRUNC(MONTHS_BETWEEN(SYSDATE,FECINC_EM)/12) COMPANTIGUEDAD, TRUNC(MONTHS_BETWEEN(SYSDATE,FECINC_EM)/12) ANO
	FROM EMPLEADOS
	WHERE NUMHIJ_EM = 0;
RESULTADO:
DNI_EM    COMPANTIGUEDAD
--------- --------------
54652636D              0
71106202D         150000
51506642K              0
37839343D              0
67918627L          96000
63453550T         186000
90676183D              0
22563618D         150000
48443585D         186000
47141695K              0
76723706H          48000
22599031D              0
76186874D              0
76647678V         432000
92369400L              0
54523162T         186000
34287936D              0
54015399D         300000
85750368D              0
46167848K         270000
53036510H          96000
65408034D              0
27892539D              0
59126147V         432000
52426286L         192000
27962126T         372000
22481393D          48000
56373194D         300000
36090320D         186000
93739487K         135000

30 filas seleccionadas.
************************************************************************
4.- Listar el nº de empleados que tiene asignado cada departamento.

SQL>
SELECT NOMB_DE, COUNT(*)
	FROM EMPLEADOS, DEPARTAMENTOS
	WHERE COD_DE=DEPT_EM
	GROUP BY NOMB_DE;
RESULTADO:
NOMB_DE                                    COUNT(*)
---------------------------------------- ----------
Investigacion y Dise±o                            4
Administracion Zona Sur                           4
Jefatura Fabrica Zona Sur                         4
Ventas Zona Sur                                   6
Direccion General                                 3
Produccion Zona Sur                              14

6 filas seleccionadas.
************************************************************************
5.- Listar el nombre del departamento y su masa salarial, de aquellos departamentos cuya masa salarial esté por encima de la MEDIA de las masas salariales de los departamentos.
NOTA: La masa salarial de un departamento es la suma de los salarios de sus empleados.

SQL>
SELECT NOMB_DE, SUM(SALARIO_EM) MSALARIAL
	FROM EMPLEADOS, DEPARTAMENTOS
	WHERE COD_DE=DEPT_EM
	GROUP BY NOMB_DE
	HAVING SUM(SALARIO_EM)>(SELECT AVG(SUM(SALARIO_EM))
							FROM EMPLEADOS
							GROUP BY DEPT_EM);
RESULTADO:
NOMB_DE                                   MSALARIAL
---------------------------------------- ----------
Administracion Zona Sur                    24800000
Ventas Zona Sur                            25200000
Produccion Zona Sur                        27500000

************************************************************************
6.- Listar el nombre, salario anual, fecha de nacimiento y fecha de ingreso de los empleados que ganan más de 4 millones de pesetas y que nacieron en marzo.

SQL>
SELECT NOMB_EM,SALARIO_EM,FECNAC_EM,FECINC_EM
	FROM EMPLEADOS
	WHERE SALARIO_EM > 4000000
	AND TO_CHAR(FECNAC_EM,'MM') = 3;
RESULTADO:
NOMB_EM                                  SALARIO_EM FECNAC_EM  FECINC_EM
---------------------------------------- ---------- ---------- ----------
Perez Alvarez, Javier                       4500000 30/03/1991 17/08/2014
Rivas Barba, Miguel                         6200000 29/03/1994 17/09/2014
Rufo Rodriguez, Alejandro                   5000000 31/03/1995 17/07/2014
************************************************************************
7.- Listar los nombres de los empleados cuyo salario supone más del 40% del presupuesto del departamento.

SQL>
SELECT NOMB_EM
	FROM DEPARTAMENTOS, EMPLEADOS
	WHERE COD_DE=DEPT_EM
	AND SALARIO_EM > PRESUP_DE*0.4;
RESULTADO:
NOMB_EM
------------------------------------
Arias Grillo, Jairo
Avila Ferrete, Raquel Maria
Gallego Carvajal, Juan
Gata Masero, Carlos
Menacho Cabo, Pedro Jose
Montane Rodriguez, Francisco Javier
Rivas Barba, Miguel
Rufo Rodriguez, Alejandro
************************************************************************
8.- Crear una vista denominada DIRECTORES que incluya el código, nombre del director, nombre de dpto, salario y población donde trabaja de aquellos empleados que son directores de departamentos. Llamar a las columnas COD, NOM, DEP, PTS, y POB respectivamente.

SQL>
CREATE OR REPLACE VIEW DIRECTORES (COD, NOM, DEP, PTS, POB)
AS
SELECT COD_EM, NOMB_EM, NOMB_DE, SALARIO_EM, POBLAC_CE
	FROM EMPLEADOS, DEPARTAMENTOS, CENTROS
	WHERE COD_EM = DIRECTOR_DE
		AND CENTRO_DE = COD_CE;

************************************************************************
9.- Modifica la columna SALARIO_EM de la tabla EMPLEADOS para que tenga dos decimales.

SQL>

ALTER TABLE EMPLEADOS MODIFY SALARIO_EM NUMBER(11,2);

************************************************************************
10.- Cambia a EUROS los salarios de los empleados. NOTA: un euro = 166,386 ptas.

SQL>

UPDATE EMPLEADOS
	SET SALARIO_EM = SALARIO_EM/166.386;
	
************************************************************************
11.- Modifica todos los datos del campo NOMB_EM de la tabla EMPLEADOS poniendo su contenido en mayúsculas.

SQL>
UPDATE EMPLEADOS
	SET NOMB_EM = UPPER(NOMB_EM);

************************************************************************
12.- Añade una restricción sobre el campo NOMB_EM de la tabla EMPLEADOS para que su contenido siempre sea en mayúsculas.

SQL>
ALTER TABLE EMPLEADOS ADD CONSTRAINT MAY_EM CHECK(NOMB_EM = UPPER(NOMB_EM));:

************************************************************************
13.- Cambia al departamento 900 a los empleados que tuvieran 20 años cuando los contrataron.

SQL>

SELECT * FROM EMPLEADOS    
WHERE TRUNC(MONTHS_BETWEEN(FECINC_EM,FECNAC_EM)/12)=20;

UPDATE EMPLEADOS
	SET DEPT_EM = 900
	WHERE TRUNC(MONTHS_BETWEEN(FECINC_EM,FECNAC_EM)/12)=20;
RESULTADO:

************************************************************************
14.- Modifica la extensión telefónica a los empleados del departamento de 'Ismael' por la extensión telefónica que tiene 'Kilian'.

SQL>
UPDATE EMPLEADOS
	SET EXTTEL_EM = (SELECT EXTTEL_EM
							FROM EMPLEADOS
							WHERE NOMB_EM LIKE '%Kilian%')
	WHERE DEPT_EM = (SELECT DEPT_EM
						FROM EMPLEADOS
						WHERE NOMB_EM LIKE '%Ismael%');

************************************************************************
15.- Carga el fichero "Datos107.sql", y a partir de la tabla APROBADOS con la siguiente estructura, y utilizando las sentencias que creas convenientes:

	ID		NUMBER(3)		Identificador del opositor
	Nombre	VARCHAR2(60)	(DNI) Apellidos, Nombre del opositor
	Fecha	DATE			Fecha de nacimiento
	Nota	NUMBER(6)		Nota de la prueba

Obtener la tabla OPOSITORES: 
  #	DNI		CHAR(8)			DNI del opositor
	Apel	VARCHAR2(40)	Apellidos del opositor
	Nombre	VARCHAR2(20)	Nombre del opositor
	Fecha	DATE			Fecha de nacimiento
	Nota	NUMBER			Nota de la prueba

Ejemplo de datos de la tabla APROBADOS:
     ID NOMBRE                                                       FECHA           NOTA
------- ------------------------------------------------------------ ---------- ---------
     85 (44261136) MARTINEZ VARO , PEDRO JOSE                        19/03/1974     58833
     86 (25102011) RUIZ RUBIO , RAFAEL                               21/04/1968     58800

DNI      APEL                                     NOMBRE          FECHA           NOTA
-------- ---------------------------------------- --------------- ---------- ---------
44261136 MARTINEZ VARO                            PEDRO JOSE      19/03/1974    5,8833
25102011 RUIZ RUBIO                               RAFAEL          21/04/1968    5,8800

SUGERENCIAS:
Opción a) Crea la tabla a partir de una sentencia SELECT utilizando las funciones adecuadas. Después, modifica la estructura de la tabla utilizando sentencias "ALTER TABLE OPOSITORES MODIFY ...".

Opción b) Crea la tabla y, posteriormente, inserta los datos a partir de una sentencia SELECT utilizando las funciones adecuadas.

SQL>

RESULTADO:
SUGERENCIAS:
-- Opción a) Crea la tabla a partir de una sentencia SELECT utilizando las funciones adecuadas. Después, modifica la estructura de la tabla utilizando sentencias "ALTER TABLE OPOSITORES MODIFY ...".
SQL>
DROP TABLE opositores;
CREATE TABLE opositores(
   	DNI PRIMARY KEY,
	Apel,
	Nombre,
	Fecha,
	Nota
	)
	AS
	SELECT 
	SUBSTR(nombre,2,8) DNI,
	SUBSTR(SUBSTR(SUBSTR(nombre,12),0,INSTR(SUBSTR(nombre,12),',')-2),0,40) Apel,
	SUBSTR(SUBSTR(SUBSTR(nombre,12),INSTR(SUBSTR(nombre,12),',')+2),0,20) Nombre,
	Fecha,
	(Nota/10000) Nota
	FROM aprobados;

ALTER TABLE opositores MODIFY apel VARCHAR2(40);
ALTER TABLE opositores MODIFY nombre VARCHAR2(20);
ALTER TABLE opositores MODIFY dni CHAR(8);

-- Opción b) Crea la tabla y, posteriormente, inserta los datos a partir de una sentencia SELECT utilizando las funciones adecuadas.
SQL>
DROP TABLE opositores;
CREATE TABLE opositores(
   	DNI		CHAR(8)	PRIMARY KEY,
	Apel	VARCHAR2(40),
	Nombre	VARCHAR2(20),
	Fecha	DATE,
	Nota	NUMBER
	);

INSERT INTO opositores
	SELECT 
	SUBSTR(nombre,2,8) DNI,
	SUBSTR(SUBSTR(SUBSTR(nombre,12),0,INSTR(SUBSTR(nombre,12),',')-2),0,40) Apel,
	SUBSTR(SUBSTR(SUBSTR(nombre,12),INSTR(SUBSTR(nombre,12),',')+2),0,20) Nombre,
	Fecha,
	(Nota/10000) Nota
	FROM aprobados;
