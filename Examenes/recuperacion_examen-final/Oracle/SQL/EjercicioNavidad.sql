	INSTRUCCIONES:
	==============

-Salva este fichero con las iniciales de tu nombre y apellidos,
 en el directorio "C:\ALUMNOS\ ":
	Ejemplo:	José María Rivera Calvete
			JMRC.txt

-Pon tu nombre al ejercicio y lee atentamente todas las preguntas.

-Donde ponga "SQL>", copiarás las sentencias SQL que has utilizado.

-SÓLO donde ponga "RESULTADOS:" copiarás el resultado que SQL*Plus te devuelve.

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en la recuperación tendrás otra oportunidad.

	PUNTUACIÓN
	==========
- Preguntas 1-5: 	3 puntos
- Preguntas 6-8: 	1 punto
- Preguntas 9-11: 	2 puntos
- Preguntas 12-13: 	1 punto
- Preguntas 14-16: 	2 puntos
- Preguntas 17-20: 	1 punto

************************************************************************

Nombre: José Rodriguez Aguayo (CORREGIDO)

************************************************************************
	Descripción de las tablas:
	==========================

HABILIDADES
-----------
# COD_HA	CHAR(5)		Código Habilidad
  DESC_HA	VARCHAR2(30)	Descripción de Habilidad (O) (U)

CENTROS
-------
# COD_CE	CHAR(4)		Código del Centro
* DIRECTOR_CE	NUMBER(6)	Director del Centro
  NOMB_CE	VARCHAR2(30)	Nombre del Centro (O)
  DIRECC_CE	VARCHAR2(50)	Dirección del Centro (O)
  POBLAC_CE	VARCHAR2(15)	Población del Centro (O)

DEPARTAMENTOS
-------------
# COD_DE	CHAR(5)		Código del Departamento
* DIRECTOR_DE	NUMBER(6)	Director del Departamento
* DEPTJEFE_DE	CHAR(5)		Departamento del que depende
* CENTRO_DE	CHAR(4)		Centro trabajo (O)
  NOMB_DE	VARCHAR2(40)	Nombre del Departamento (O)
  PRESUP_DE	NUMBER(11)	Presupuesto del Departamento (O)
  TIPODIR_DE	CHAR(1)		Tipo de Director del Departamento (O)

EMPLEADOS
---------
# COD_EM	NUMBER(6)	Código del Empleado
* DEPT_EM	CHAR(5)		Departamento del Empleado (O)
  EXTTEL_EM	CHAR(9)		Extensión telefónica
  FECINC_EM	DATE		Fecha de incorporación del Empleado (O)
  FECNAC_EM	DATE		Fecha de nacimiento del Empleado (O)
  DNI_EM	VARCHAR2(9)	DNI del Empleado (U)
  NOMB_EM	VARCHAR2(40)	Nombre del Empleado (O)
  NUMHIJ_EM	NUMBER(2)	Número de hijos del Empleado (O)
  SALARIO_EM	NUMBER(9)	Salario Anual del Empleado (O)

HIJOS
-----
#*PADRE_HI	NUMBER(6)	Código del Empleado
# NUMHIJ_HI	NUMBER(2)	Número del hijo del Empleado
  FECNAC_HI	DATE		Fecha de nacimiento del Hijo (O)
  NOMB_HI	VARCHAR2(40)	Nombre del Hijo (O)

HABIEMPL
-----------
#*CODHA_HE	CHAR(5)		Código de la Habilidad
#*CODEM_HE	NUMBER(6)	Código del Empleado


Nota: 
	# PRIMARY KEY
	* FOREIGN KEY
	(O) Obligatorio
	(U) Único

************************************************************************
1.- Crea las tablas anteriores indicando las claves primarias y las restricciones (O) y (U).

SQL>CREACION DE TABLAS

CREATE TABLE HABILIDADES (
	COD_HA	CHAR(5)
		CONSTRAINT PK_HABI PRIMARY KEY,		
	DESC_HA	VARCHAR2(30)
		NOT NULL
		UNIQUE
);


CREATE TABLE EMPLEADOS (
	COD_EM		NUMBER(6)
		CONSTRAINT PK_EMP PRIMARY KEY,
	DEPT_EM		CHAR(5)	,
  	EXTTEL_EM	CHAR(9),
  	FECINC_EM	DATE
		NOT NULL,	
  	FECNAC_EM	DATE
		NOT NULL, 		
  	DNI_EM		VARCHAR2(9)	
		UNIQUE,
  	NOMB_EM		VARCHAR2(40)	
		NOT NULL,
  	NUMHIJ_EM	NUMBER(2)	
		NOT NULL,
  	SALARIO_EM	NUMBER(9)
		NOT NULL
);


CREATE TABLE CENTROS (
	COD_CE	        CHAR(4)
		CONSTRAINT PK_CEN PRIMARY KEY,
 	DIRECTOR_CE	NUMBER(6),
  	NOMB_CE	        VARCHAR2(30)
		NOT NULL,
  	DIRECC_CE	VARCHAR2(50)	
		NOT NULL,
  	POBLAC_CE	VARCHAR2(15)
		NOT NULL,
);


CREATE TABLE DEPARTAMENTOS (
	COD_DE	        CHAR(5)	
		CONSTRAINT PK_DEP PRIMARY KEY,
 	DIRECTOR_DE	NUMBER(6),
 	DEPTJEFE_DE	CHAR(5),
 	CENTRO_DE	CHAR(4)
		NOT NULL,
  	NOMB_DE	        VARCHAR2(40)
		NOT NULL,
  	PRESUP_DE	NUMBER(11)	
		NOT NULL,
  	TIPODIR_DE	CHAR(1)
		NOT NULL,
);


CREATE TABLE HIJOS (
	PADRE_HI	NUMBER(6),
	NUMHIJ_HI	NUMBER(2),
	FECNAC_HI	DATE
		NOT NULL,
  	NOMB_HI		VARCHAR2(40)
		NOT NULL,
	CONSTRAINT PK_HIJOS PRIMARY KEY(PADRE_HI, NUMHIJ_HI),
);


CREATE TABLE HABIEMPL (
	CODHA_HE	CHAR(5),
	CODEM_HE	NUMBER(6),
	CONSTRAINT PK_HABIEM PRIMARY KEY (CODHA_HE, CODEM_HE),
);

************************************************************************
2.- Ejecuta las órdenes del fichero "Datos.txt" con el comando START.

SQL>START C:\ALUMNOS\EXAMEN\DATOS.TXT

************************************************************************
3.- Añade las restricciones de clave ajena a las tablas que las tengan.

SQL> ALTER TABLE EMPLEADOS ADD CONSTRAINT FK_DEPART FOREIGN KEY (DEPT_EM ) REFERENCES DEPARTAMENTOS ON DELETE CASCADE;

     ALTER TABLE CENTROS ADD CONSTRAINT FK_DIR FOREIGN KEY (DIRECTOR_CE) REFERENCES EMPLEADOS ON DELETE CASCADE;

     ALTER TABLE DEPARTAMENTOS ADD CONSTRAINT FK_DIRER FOREIGN KEY (DIRECTOR_DE) REFERENCES EMPLEADOS ON DELETE CASCADE;
     ALTER TABLE DEPARTAMENTOS ADD CONSTRAINT FK_DEPT FOREIGN KEY (DEPTJEFE_DE) REFERENCES DEPARTAMENTOS ON DELETE CASCADE;
     ALTER TABLE DEPARTAMENTOS ADD CONSTRAINT FK_CENTRO FOREIGN KEY (CENTRO_DE) REFERENCES CENTROS ON DELETE CASCADE;

     ALTER TABLE HIJOS ADD CONSTRAINT FK_PADRE FOREIGN KEY (PADRE_HI) REFERENCES EMPLEADOS ON DELETE CASCADE;

     ALTER TABLE HABIEMPL ADD CONSTRAINT FK_HABI FOREIGN KEY (CODEM_HE) REFERENCES EMPLEADOS;

************************************************************************
4.- Añade las siguientes restricciones:
	- Todos los campos numéricos son positivos.
	NO- Todos los nombres y descripciones deben estar en mayúsculas.
	NO- Todos los empleados eran mayores de edad cuando se incorporaron.
	- El Tipo de Director es 'F' o 'P'.
 Si no pudieras añadir alguna de las restricciones anteriores modifica los valores de las columnas correspondientes para añadirlas.

SQL>   (CORREGIDO)
*
ALTER TABLE CENTROS ADD CONSTRAINT CH_DIREC_CE CHECK (DIRECTOR_CE >= 0);
ALTER TABLE DEPARTAMENTOS ADD CONSTRAINT CH_DIREC_DE CHECK (DIRECTOR_DE >= 0);
ALTER TABLE DEPARTAMENTOS ADD CONSTRAINT CH_PRE CHECK (PRESUP_DE >= 0);
ALTER TABLE EMPLEADOS ADD CONSTRAINT CH_COD_EM CHECK(COD_EM >= 0);
ALTER TABLE EMPLEADOS ADD CONSTRAINT CH_NUMHIJOS CHECK(NUMHIJ_EM >= 0);
ALTER TABLE EMPLEADOS ADD CONSTRAINT CH_SAL CHECK(SALARIO_EM >= 0);
ALTER TABLE HIJOS ADD CONSTRAINT CH_PADREHI CHECK(PADRE_HI >= 0);
ALTER TABLE HIJOS ADD CONSTRAINT CH_NUMHI CHECK(NUMHIJ_HI >= 0);
ALTER TABLE HABIEMPL ADD CONSTRAINT CH_CODEM CHECK (CODEM_HE >= 0);

*
ALTER TABLE DEPARTAMENTOS ADD CONSTRAINT CH_TI_DI CHECK(TIPODIR_DE IN ('F', 'P'));


************************************************************************
5.- Añade la columna NIVEL_HE NUMBER(2), a la tabla HABIEMPL con las siguientes restricciones:
	- Es obligatorio.
	- Por defecto vale 5.
	- Valores válidos entre 1 y 10.

SQL> ALTER TABLE HABIEMPL ADD NIVEL_HE  NUMBER(2) 
					DEFAULT 5 
					CHECK(NIVEL_HE BETWEEN 1 AND 10);

************************************************************************
6.- Listar el código y nombre de los empleados cuyo código sea distinto de 1, 4, 6, 8 ó 10.

SQL>
SELECT COD_EM, NOMB_EM FROM EMPLEADOS WHERE
COD_EM NOT IN (1,4,6,8,10);

RESULTADO:
   COD_EM NOMB_EM
--------- ----------------------------------------
        5 Alada Veraz, Juana
        7 Forzado López, Juan
        9 Mando Correa, Rosa
        2 Manrique Bacterio, Luisa
        3 Monforte Cid, Roldán

************************************************************************
7.- Listar el nombre de los empleados que no tienen extensión telefónica.

SQL>
SELECT NOMB_EM FROM EMPLEADOS  
WHERE EXTTEL_EM IS NULL;

RESULTADO:
NOMB_EM
----------------------------------------
Forzado López, Juan
Macullas Alto, Eloisa
Pérez Muñoz, Alfonso
************************************************************************
8.- Listado del código, nombre y presupuesto de los departamentos ordenado por criterio descendente de presupuesto anual.

SQL>
SELECT COD_DE, NOMB_DE, PRESUP_DE 
	FROM DEPARTAMENTOS 
	ORDER BY PRESUP_DE DESC;

RESULTADO:
COD_D NOMB_DE                                  PRESUP_DE
----- ---------------------------------------- ---------
PROZS Producción Zona Sur                      108000000
DIRGE Dirección General                         26000000
INYDI Investigación y Diseño                    25000000
ADMZS Administración Zona Sur                   14000000
VENZS Ventas Zona Sur                           13500000
JEFZS Jefatura Fábrica Zona Sur                  6200000

6 filas seleccionadas.

************************************************************************
9.- Listar el nombre del empleado y el nombre y fecha de nacimiento de su hijo/a para aquellos empleados con un único hijo. Ordenar por fecha de nacimiento de los hijos.

SQL>
SELECT NOMB_EM, NOMB_HI, FECNAC_HI 
	FROM EMPLEADOS E, HIJOS H 
	WHERE H.PADRE_HI= E.COD_EM 
	AND NUMHIJ_HI = 1 
	ORDER BY FECNAC_HI;

RESULTADO:
NOMB_EM                                  NOMB_HI                                  FECNAC_HI
---------------------------------------- ---------------------------------------- ----------
Alada Veraz, Juana                       Pastora Alada, Mateo                     06/03/1982
Mando Correa, Rosa                       León Mando, Elvira                       28/02/1988
Ruiz de Lopera, Manuel                   Ruiz Denil, Son                          07/06/1989
Monforte Cid, Roldán                     Monforte Lemos, Jesús                    12/09/1990
Macullas Alto, Eloisa                    Fuerte Mascullas, Anacleto               14/03/1994
************************************************************************
10.- Listar el nombre de los departamentos y del departamento del que dependen (sólo para los departamentos dependientes).

SQL>		(CORREGIDO)
SELECT A.NOMB_DE "Departamento", B.NOMB_DE "Dpto Jefe" 
	FROM DEPARTAMENTOS A, DEPARTAMENTOS B
	WHERE A.DEPTJEFE_DE = B.COD_DE;

RESULTADO:
Departamento                   Dpto Jefe
------------------------------ ------------------------------
Investigación y Diseño         Dirección General
Producción Zona Sur            Jefatura Fábrica Zona Sur
Ventas Zona Sur                Administración Zona Sur


************************************************************************
11.- Listar el NIF, nombre del empleado y el nombre del dpto. al que se encuentra asignado ordenado por dpto. y dentro de cada dpto por el nombre de empleado.

SQL>
SELECT DNI_EM, NOMB_EM, NOMB_DE 
	FROM EMPLEADOS A, DEPARTAMENTOS D
	WHERE A.DEPT_EM= D.COD_DE 
	ORDER BY NOMB_DE, NOMB_EM;

RESULTADO:
DNI_EM    NOMB_EM                                  NOMB_DE
--------- ---------------------------------------- ----------------------------------------
38223822T Alada Veraz, Juana                       Administración Zona Sur
21452145V Ruiz de Lopera, Manuel                   Dirección General
21232123K Manrique Bacterio, Luisa                 Investigación y Diseño
26452645D Gozque Altanero, Carlos                  Jefatura Fábrica Zona Sur
47124712D Forzado López, Juan                      Producción Zona Sur
32133213H Macullas Alto, Eloisa                    Producción Zona Sur
11311131D Mando Correa, Rosa                       Producción Zona Sur
32933293D Pérez Muñoz, Alfonso                     Producción Zona Sur
23822382D Monforte Cid, Roldán                     Ventas Zona Sur
38293829L Topaz Illán, Carlos                      Ventas Zona Sur

10 filas seleccionadas.

************************************************************************
12.- Listar el salario mínimo, máximo y medio para cada dpto. indicando el código de dpto. al que pertenece el dato.

SQL>
SELECT MIN(SALARIO_EM) "SALARIO MIN", 
		MAX(SALARIO_EM) "MAX SALARIO", 
		AVG(SALARIO_EM) "MEDIA SALARIO", 
		DEPT_EM 
	FROM EMPLEADOS 
	GROUP BY DEPT_EM;

RESULTADO:
SALARIO MIN MAX SALARIO MEDIA SALARIO DEPT_
----------- ----------- ------------- -----
    6200000     6200000       6200000 ADMZS
    7200000     7200000       7200000 DIRGE
    4500000     4500000       4500000 INYDI
    5000000     5000000       5000000 JEFZS
    1300000     3100000       1900000 PROZS
    3200000     5200000       4200000 VENZS

6 filas seleccionadas.
************************************************************************
13.- Listar el salario promedio de los empleados.

SQL>
SELECT  AVG(SALARIO_EM) "MEDIA DE LOS SALARIOS" 
	FROM EMPLEADOS;

RESULTADO:
MEDIA DE LOS SALARIOS
---------------------
              3890000
************************************************************************
14.- Listar el nombre de los hijos del empleado que se apellida 'Correa'.

SQL>
SELECT NOMB_HI, NOMB_EM 
	FROM EMPLEADOS E, HIJOS H 
	WHERE H.PADRE_HI = E.COD_EM 
	AND NOMB_EM LIKE '%Correa%';

RESULTADO:
NOMB_HI                                  NOMB_EM
---------------------------------------- ----------------------------------------
León Mando, Elvira                       Mando Correa, Rosa
León Mando, Plácido                      Mando Correa, Rosa
************************************************************************
15.- Listar el nombre de los departamentos en los que la suma de los sueldos es igual o mayor al 25% del presupuesto.

SQL>
SELECT NOMB_DE 
	FROM DEPARTAMENTOS D, EMPLEADOS E
	WHERE E.DEPT_EM = D.COD_DE 
	GROUP BY COD_DE, PRESUP_DE, NOMB_DE
	HAVING SUM(E.SALARIO_EM)>= (PRESUP_DE * 25) /100;

RESULTADO:
NOMB_DE
----------------------------------------
Administración Zona Sur
Dirección General
Jefatura Fábrica Zona Sur
Ventas Zona Sur
************************************************************************
16.- Listar los departamentos que tengan algún empleado que gane más de 500.000 ptas al mes. (Recuerda que el salario es anual).

SQL>
SELECT NOMB_DE 
	FROM EMPLEADOS E, DEPARTAMENTOS D 
	WHERE (SALARIO_EM /12)> 500000 
		AND E.DEPT_EM= D.COD_DE;

RESULTADO:
NOMB_DE
----------------------------------------
Administración Zona Sur
Dirección General
************************************************************************
17.- Crear la tabla TEMP(CODEMP, NOMDEPT, NOMEMP, SALEMP) cuyas columnas tienen el mismo tipo y tamaño las similares existentes en la BD. Insertar en dicha tabla el código de empleado, nombre de dpto, nombre de empleado y salario de los empleados de los centros de MURCIA.

SQL>
CREATE TABLE TEMP (CODEMP, NOMDEPT, NOMEMP, SALEMP) AS 
	SELECT COD_EM, NOMB_DE, NOMB_EM, SALARIO_EM 
		FROM EMPLEADOS E, DEPARTAMENTOS D, CENTROS C
		WHERE E.DEPT_EM= D.COD_DE 
		AND D.CENTRO_DE = C.COD_CE 
		AND C.POBLAC_CE LIKE 'Murcia';

RESULTADO:
Tabla creada.
************************************************************************
18.- Incrementar en un 10% los salarios de los empleados que ganen menos de 5.000.000 de ptas.

SQL>
UPDATE TEMP
	SET SALEMP = SALEMP * 1.1
	WHERE SALEMP < 5000000;
RESULTADO:
6 filas actualizadas.
************************************************************************
19.- Deshacer la operación anterior.

SQL>
ROLLBACK;
RESULTADO:
Rollback terminado.
************************************************************************
20.- Borrar la tabla TEMP y todas las anteriores.

SQL>
DROP TABLE TEMP CASCADE CONSTRAINT;
DROP TABLE HABILIDADES CASCADE CONSTRAINT;
DROP TABLE CENTROS CASCADE CONSTRAINT;
DROP TABLE DEPARTAMENTOS CASCADE CONSTRAINT;
DROP TABLE EMPLEADOS CASCADE CONSTRAINT;
DROP TABLE HIJOS CASCADE CONSTRAINT;
DROP TABLE HABIEMPL CASCADE CONSTRAINT;
RESULTADO:
Tabla borrada.
************************************************************************
