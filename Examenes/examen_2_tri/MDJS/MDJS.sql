TIPO B

Nombre: <Malvina Del Junco Suarez>

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

SQL>INSERT INTO DEPARTAMENTOS 
SELECT 900,DIRECTOR_DE, DEPTJEFE_DE, CENTRO_DE, 'Ingieneria de sistemas'
FROM 
WHERE

RESULTADO:

************************************************************************
2.- Modificar el director del departamento 900 al empleado más joven.

SQL>UPDATE 
RESULTADO:

************************************************************************
3.- Listar el DNI y el complemento por antigüedad de los empleados sin hijos. 
NOTA: El complemento por antigüedad será el 3% del salario por cada año.

SQL> SELECT DNI_EM, 0,03*(SALARIO_EM)
	FROM EMPLEADOS 
	WHERE NUMHIJ_EM = 0;

RESULTADO:

DNI_EM             0 03*(SALARIO_EM)
--------- ---------- ---------------
54652636D          0         4800000
71106202D          0        15000000
51506642K          0        13500000
37839343D          0         3900000
67918627L          0         9600000
63453550T          0        18600000
90676183D          0         4800000
22563618D          0        15000000
48443585D          0         9300000
47141695K          0        13500000
76723706H          0         4800000
22599031D          0        15600000
76186874D          0         3900000
76647678V          0        21600000
92369400L          0         9600000
54523162T          0        18600000
34287936D          0         4800000
54015399D          0        15000000
85750368D          0         9300000
46167848K          0        13500000
53036510H          0         4800000
65408034D          0        15600000
27892539D          0         3900000
59126147V          0        21600000
52426286L          0         9600000
27962126T          0        18600000
22481393D          0         4800000
56373194D          0        15000000
36090320D          0         9300000
93739487K          0        13500000

30 filas seleccionadas.
************************************************************************
4.- Listar el nº de empleados que tiene asignado cada departamento.

SQL>SELECT COUNT(DISTINCT COD_EM),DEPT_EM 
	FROM EMPLEADOS 
	GROUP BY DEPT_EM;

RESULTADO:

COUNT(DISTINCTCOD_EM)    DEPT_EM
--------------------- ----------
                    4        100
                    3        200
                    4        300
                    4        400
                   14        500
                    6        600

6 filas seleccionadas.

************************************************************************
5.- Listar el nombre del departamento y su masa salarial, de aquellos departamentos cuya masa salarial esté por encima de las masas salariales de los departamentos.
NOTA: La masa salarial de un departamento es la suma de los salarios de sus empleados.

SQL>SELECT NOMB_DE,PRESUP_DE 
	FROM DEPARTAMENTOS 
	WHERE PRESUP_DE > (SELECT AVG(PRESUP_DE) FROM DEPARTAMENTOS);

RESULTADO:
NOMB_DE                                   PRESUP_DE
---------------------------------------- ----------
Produccion Zona Sur                       108000000
************************************************************************
6.- Listar el nombre, salario anual, fecha de nacimiento y fecha de ingreso de los empleados que ganan más de 4 millones de pesetas y que nacieron en marzo.

SQL>SELECT NOMB_EM, SALARIO_EM, FECNAC_EM, FECINC_EM FROM EMPLEADOS WHERE SALARIO_EM > 4000000 AND TO_CHAR(FECNAC_EM,'mm') = 03;

RESULTADO:

NOMB_EM                                  SALARIO_EM FECNAC_EM  FECINC_EM
---------------------------------------- ---------- ---------- ----------
Perez Alvarez, Javier                       4500000 30/03/1991 17/08/2014
Rivas Barba, Miguel                         6200000 29/03/1994 17/09/2014
Rufo Rodriguez, Alejandro                   5000000 31/03/1995 17/07/2014

************************************************************************
7.- Listar los nombres de los empleados cuyo salario supone más del 40% del presupuesto del departamento.

SQL>SELECT NOMB_EM 
	FROM EMPLEADOS E,DEPARTAMENTOS D
	WHERE E.DEPT_EM = D.COD_DE
	GROUP BY COD_DE, PRESUP_DE, NOMB_EM
	HAVING SUM(SALARIO_EM)>(PRESUP_DE * 40) /100;
RESULTADO:

NOMB_EM
-------------------------------------
Rufo Rodriguez, Alejandro
Montane Rodriguez, Francisco Javier
Rivas Barba, Miguel
Avila Ferrete, Raquel Maria
Arias Grillo, Jairo
Menacho Cabo, Pedro Jose
Gallego Carvajal, Juan
Gata Masero, Carlos

8 filas seleccionadas.

************************************************************************
8.- Crear una vista denominada DIRECTORES que incluya el código, nombre del director, nombre de dpto, salario y población donde trabaja de aquellos empleados que son directores de departamentos. Llamar a las columnas COD, NOM, DEP, PTS, y POB respectivamente.

SQL>CREATE VIEW DIRECTORES 
			AS SELECT COD_EM,NOMB_EM,NOMB_DE,SALARIO_EM,POBLAC_CE
			FROM EMPLEADOS,DEPARTAMENTOS,CENTROS 
			WHERE COD_EM=(SELECT DIRECTOR_DE 
							FROM DEPARTAMENTOS);
RESULTADO:

Vista creada.

************************************************************************
9.- Modifica la columna SALARIO_EM de la tabla EMPLEADOS para que tenga dos decimales.

SQL>ALTER TABLE EMPLEADOS 
	MODIFY job TRUNC(SALARIO_EM,2);

RESULTADO:

************************************************************************
10.- Cambia a EUROS los salarios de los empleados. NOTA: un euro = 166,386 ptas.

SQL>

RESULTADO:

************************************************************************
11.- Modifica todos los datos del campo NOMBRE_EM de la tabla EMPLEADOS poniendo su contenido en mayúsculas.

SQL>

RESULTADO:

************************************************************************
12.- Añade una restricción sobre el campo NOMBRE_EM de la tabla EMPLEADOS para que su contenido siempre sea en mayúsculas.

SQL>ALTER TABLE EMPLEADOS ADD CHECK (NOMB_EM=UPPER(NOMB_EM));

RESULTADO:

************************************************************************
13.- Cambia al departamento 900 a los empleados que tuvieran 20 años cuando los contrataron.

SQL>

RESULTADO:

************************************************************************
14.- Modifica la extensión telefónica a los empleados del departamento de 'Ismael' por la extensión telefónica que tiene 'Kilian'.

SQL>

RESULTADO:

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
