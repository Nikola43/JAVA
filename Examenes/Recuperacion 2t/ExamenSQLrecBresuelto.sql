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

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en el final tendrás otra oportunidad.

	PUNTUACIÓN
	==========
- Preguntas 1-16:	10/16 puntos cada una

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
1.- Crea la tabla EQUIPOS sin restricciones con los siguientes campo:
# COD_EQ		CHAR(4)			Código del Equipo
  NOMB_EQ		VARCHAR2(40)	Nombre del Empleado (U)
  CIUDAD_EQ		VARCHAR2(20)	Ciudad del equipo
  FECHA_EQ		DATE			Fecha de fundación del equipo

Nota: 
	# PRIMARY KEY
	(U) Único
SQL>
CREATE TABLE EQUIPOS(
	COD_EQ		CHAR(4),
	NOMB_EQ		VARCHAR2(40),
	CIUDAD_EQ	VARCHAR2(20),
	FECHA_EQ	DATE	
);
RESULTADO:

************************************************************************
2.- Crea la tabla PARTIDOS sin restricciones con los siguientes campo:
#*LOCAL_PA		CHAR(4)			Código del Equipo Local
#*VISITANTE_PA	CHAR(4)			Código del Equipo Visitante
  PUNTOSLOC_PA	NUMBER(3)		Puntos del Equipo Local
  PUNTOSVIS_PA	NUMBER(3)		Puntos del Equipo Visitante
  FECHA_PA		DATE			Fecha del partido

Nota: 
	# PRIMARY KEY
	* FOREIGN KEY
SQL>
CREATE TABLE PARTIDOS(
	LOCAL_PA		CHAR(4),
	VISITANTE_PA	CHAR(4),
	PUNTOSLOC_PA	NUMBER(3),
	PUNTOSVIS_PA	NUMBER(3),
	FECHA_PA		DATE
);
RESULTADO:

************************************************************************
3.- Añade las restricciones de PRIMARY KEY a las dos tablas.

SQL>
ALTER TABLE EQUIPOS ADD CONSTRAINT PK_EQUIPOS PRIMARY KEY (COD_EQ);
ALTER TABLE PARTIDOS ADD CONSTRAINT PK_PARTIDOS PRIMARY KEY (LOCAL_PA, VISITANTE_PA);
RESULTADO:

************************************************************************
4.- Añade las restricciones de FOREIGN KEY a la tabla PARTIDOS.

SQL>
ALTER TABLE PARTIDOS ADD CONSTRAINT FK_PARTIDOSL FOREIGN KEY (LOCAL_PA) REFERENCES EQUIPOS;
ALTER TABLE PARTIDOS ADD CONSTRAINT FK_PARTIDOSV FOREIGN KEY (VISITANTE_PA) REFERENCES EQUIPOS;
RESULTADO:

************************************************************************
5.- Añade las restricciones a los campos PUNTOSLOC_PA y PUNTOSVIS_PA para que no puedan ser negativos.

SQL>
ALTER TABLE PARTIDOS ADD CONSTRAINT CH_PARTIDOSV CHECK(PUNTOSLOC_PA >= 0 AND PUNTOSVIS_PA >= 0);
RESULTADO:

************************************************************************
6.- Añade las restricciones a los campos COD_EQ que debe ser mayúscula y NOMB_EQ, que no se puede repetir.

SQL>
ALTER TABLE EQUIPOS ADD CONSTRAINT CH_CIUDAD CHECK (CIUDAD_EQ = UPPER(CIUDAD_EQ));
ALTER TABLE EQUIPOS ADD CONSTRAINT CH_NOMB_EQ UNIQUE(NOMB_EQ);
RESULTADO:

************************************************************************
7.- Listar para cada empleado, su código, su dni y el dni del empleado que es director de su centro.


SQL>
SELECT E.COD_EM, E.DNI_EM, D.DNI_EM
FROM DEPARTAMENTOS, EMPLEADOS E, EMPLEADOS D, CENTROS
WHERE E.DEPT_EM = COD_DE
	AND CENTRO_DE = COD_CE
	AND D.COD_EM = DIRECTOR_CE;
RESULTADO:
COD_EM DNI_EM    DNI_EM
------ --------- ---------
     5 55645991T 55645991T
     7 54652636D 71106202D
     6 71106202D 71106202D
     9 56646516D 71106202D
     2 51506642K 76138301V
     8 55980648H 71106202D
     3 64555339D 55645991T
    10 37839343D 71106202D
     1 76138301V 76138301V
     4 67918627L 55645991T
    15 63453550T 55645991T
    17 90676183D 71106202D
    16 22563618D 71106202D
    19 48443585D 71106202D
    12 47141695K 76138301V
    18 76723706H 71106202D
    13 22599031D 55645991T
    20 76186874D 71106202D
    11 76647678V 76138301V
    14 92369400L 55645991T
    25 54523162T 55645991T
    27 34287936D 71106202D
    26 54015399D 71106202D
    29 85750368D 71106202D
    22 46167848K 76138301V
    28 53036510H 71106202D
    23 65408034D 55645991T
    30 27892539D 71106202D
    21 59126147V 76138301V
    24 52426286L 55645991T
    35 27962126T 55645991T
    31 22481393D 71106202D
    32 56373194D 71106202D
    33 36090320D 71106202D
    34 93739487K 76138301V
************************************************************************
8.- Listar por cada departamento, el nombre, la suma de los salarios, para aquellos departamentos que tengan empleados sin hijos.

SQL>
SELECT NOMB_DE, SUM(SALARIO_EM) SUM_SALARIOS
FROM DEPARTAMENTOS, EMPLEADOS
WHERE DEPT_EM = COD_DE
	AND COD_DE IN (SELECT DEPT_EM
					FROM EMPLEADOS
					WHERE NUMHIJ_EM = 0)
GROUP BY NOMB_DE;
RESULTADO:
NOMB_DE                                  SUM_SALARIOS
---------------------------------------- ------------
Ingenieria de sistemas                       14600000
Investigacion y Dise±o                       18000000
Administracion Zona Sur                      24800000
Jefatura Fabrica Zona Sur                    20000000
Ventas Zona Sur                              25200000
Direccion General                            23600000
Produccion Zona Sur                          12400000

7 filas seleccionadas.
************************************************************************
9.- Listar el nombre y el número de extensiones telefónicas que tiene el departamento con menos extensiones telefónicas.

SQL>
SELECT NOMB_DE, COUNT(EXTTEL_EM) NUM_EXTEL
FROM EMPLEADOS, DEPARTAMENTOS
WHERE DEPT_EM = COD_DE
GROUP BY NOMB_DE
HAVING COUNT(EXTTEL_EM) = (SELECT MIN(COUNT(EXTTEL_EM))
							FROM EMPLEADOS
							GROUP BY DEPT_EM);
RESULTADO:
NOMB_DE                                   NUM_EXTEL
---------------------------------------- ----------
Direccion General                                 3
************************************************************************
10.- Mostrar para cada empleado nacido en un año par, el nombre, edad actual, la letra de su DNI y el nombre del departamento donde trabajan. 

SQL>
SELECT NOMB_EM, TRUNC(MONTHS_BETWEEN(SYSDATE,FECNAC_EM)/12) EDAD, SUBSTR(DNI_EM,9,1) LETRA, NOMB_DE
FROM DEPARTAMENTOS, EMPLEADOS
WHERE DEPT_EM = COD_DE
	AND MOD(TO_CHAR(FECNAC_EM,'YYYY'),2) = 0;
RESULTADO:
NOMB_EM                                        EDAD LETR NOMB_DE
---------------------------------------- ---------- ---- --------------------------
Arias Grillo, Jairo                              30 T    Administracion Zona Sur
Cabrera Alava, Kilian                            20 D    Produccion Zona Sur
Calderon Diaz, Daniel                            21 K    Investigacion y Dise±o
Jimenez Campos, Alejandro                        29 H    Produccion Zona Sur
Menacho Cabo, Pedro Jose                         24 T    Administracion Zona Sur
Mendizabal Romero, Luis                          20 D    Produccion Zona Sur
Pineda Santos, Jose Manuel                       20 H    Produccion Zona Sur
Pozo Martin, Ismael                              18 D    Produccion Zona Sur
Punta Perez, Gonzalo                             22 V    Direccion General
Reina Ramirez, Joaquin Javier                    24 L    Ventas Zona Sur
Rivas Barba, Miguel                              23 T    Administracion Zona Sur
************************************************************************
11.- Listar para cada empleado el código, nombre, salario, nombre del centro donde trabaja y localidad en la que se encuentra, de aquellos empleados que ganan menos que la media de los salarios de su departamento.

SQL>
SELECT COD_EM, NOMB_EM, SALARIO_EM, NOMB_CE, POBLAC_CE
FROM DEPARTAMENTOS, EMPLEADOS E1, CENTROS
WHERE DEPT_EM = COD_DE
	AND CENTRO_DE = COD_CE
	AND SALARIO_EM < (SELECT AVG(SALARIO_EM)
						FROM EMPLEADOS E2
						WHERE E1.DEPT_EM = E2.DEPT_EM);
RESULTADO:
COD_EM NOMB_EM                                  SALARIO_EM NOMB_CE                        POBLAC_CE
------ ---------------------------------------- ---------- ------------------------------ ---------
    31 Rolo Vera, Luis Miguel                      1600000 Fabrica Zona Sur               Sevilla
    30 Pozo Martin, Ismael                         1300000 Fabrica Zona Sur               Sevilla
    28 Pineda Santos, Jose Manuel                  1600000 Fabrica Zona Sur               Sevilla
    27 Mendizabal Romero, Luis                     1100000 Fabrica Zona Sur               Sevilla
    20 Leon Vazquez, Rafael                        1300000 Fabrica Zona Sur               Sevilla
    18 Jimenez Campos, Alejandro                   1600000 Fabrica Zona Sur               Sevilla
    17 Garcia Vazquez, Jose Manuel                 1600000 Fabrica Zona Sur               Sevilla
    10 Conde Alvarez, Jose Antonio                 1300000 Fabrica Zona Sur               Sevilla
     8 Calvo Jimenez, Alberto                      1600000 Fabrica Zona Sur               Sevilla
     7 Arnaldos Valle, Javier                      1600000 Fabrica Zona Sur               Sevilla
    24 Reina Ramirez, Joaquin Javier               3200000 Oficinas Zona Sur              Sevilla
    14 Matito Lozano, Carmen                       3200000 Oficinas Zona Sur              Sevilla
     4 Fernandez Benito, Javier                    3200000 Oficinas Zona Sur              Sevilla
    11 Marquez Funes, Marcos                       7200000 Direccion General              Murcia
     1 Del Junco Suarez, Malvina                   7200000 Direccion General              Murcia
************************************************************************
12.- Insertar un departamento con código 900 y nombre 'Mantenimiento', que dependerá del departamento con menos empleados. El resto de datos serán los del departamento del que depende.

SQL>
INSERT INTO DEPARTAMENTOS
	SELECT 900, DIRECTOR_DE, COD_DE, CENTRO_DE, 'Mantenimiento', PRESUP_DE, TIPODIR_DE
	FROM DEPARTAMENTOS
	WHERE COD_DE = (SELECT DEPT_EM
					FROM EMPLEADOS
					GROUP BY DEPT_EM
					HAVING COUNT(*) = (SELECT MIN(COUNT(*))
										FROM EMPLEADOS
										GROUP BY DEPT_EM));
RESULTADO:

************************************************************************
13.- Modificar el director del departamento 900 al empleado con menor salario.

SQL>
UPDATE DEPARTAMENTOS
SET DIRECTOR_DE = (SELECT COD_EM	
					FROM EMPLEADOS	
					WHERE SALARIO_EM = (SELECT MIN(SALARIO_EM)
										FROM EMPLEADOS))
WHERE COD_DE = 900;										
RESULTADO:

************************************************************************
14.- Cambia al departamento 900 a los empleados que tengan extensión telefónica.

SQL>
UPDATE EMPLEADOS
SET DEPT_EM = 900
WHERE COD_EM IN (SELECT COD_EM	
					FROM EMPLEADOS	
					WHERE EXTTEL_EM IS NOT NULL);
RESULTADO:

************************************************************************
15.- Inserta un nuevo empleado en el departamento 900 de nombre "Esteban Murillo, Bartolome", fecha de nacimiento "01/01/1617" y el resto de datos, los del empleado que lleva menos tiempo en la empresa.

SQL>
INSERT INTO EMPLEADOS
	SELECT 100, 900, EXTTEL_EM, FECINC_EM, '01/01/1617', '12345678Z', 'Esteban Murillo, Bartolome', NUMHIJ_EM, SALARIO_EM
	FROM EMPLEADOS
	WHERE FECINC_EM = (SELECT MIN(FECINC_EM)
						FROM EMPLEADOS);
RESULTADO:

************************************************************************
16.- Modifica el presupuesto del departamento 900 al doble de la suma de los salarios de sus empleados.

SQL>
UPDATE DEPARTAMENTOS
SET PRESUP_DE = 2 * (SELECT SUM(SALARIO_EM)	
								FROM EMPLEADOS	
								WHERE DEPT_EM = 900)
WHERE COD_DE = 900;
RESULTADO:

