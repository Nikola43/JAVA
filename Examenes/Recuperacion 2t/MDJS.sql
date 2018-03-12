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
	
DROP TABLE EQUIPOS CASCADE CONSTRAINTS;	
SQL>CREATE TABLE EQUIPOS (
	COD_EQ CHAR (4)PRIMARY KEY,
	NOMBRE_EQ VARCHAR(40) UNIQUE,
	CIUDAD_EQ VARCHAR (20),
	FECHA DATE );

RESULTADO:Tabla creada
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
	
DROP TABLE PARTIDOS CASCADE CONSTRAINTS;	
SQL>CREATE TABLE PARTIDOS(
  LOCAL_PA		CHAR(4),
  VISITANTE_PA CHAR(4),
  PUNTOSLOC_PA	NUMBER(3),
  PUNTOSVIS_PA	NUMBER(3),
  FECHA_PA		DATE
);

RESULTADO:

Tabla creada.

************************************************************************
3.- Añade las restricciones de PRIMARY KEY a las dos tablas.

SQL>ALTER TABLE EQUIPOS ADD CONSTRAINT PK_EQUIPOS PRIMARY KEY (COD_EQ);

	ALTER TABLE PARTIDOS ADD CONSTRAINT PK_PARTIDOS PRIMARY KEY (LOCAL_PA, VISITANTE_PA);
RESULTADO:

Tabla modificada.
************************************************************************
4.- Añade las restricciones de FOREIGN KEY a la tabla PARTIDOS.

SQL>ALTER TABLE PARTIDOS ADD CONSTRAINT FK_EQUIPO_LOCAL FOREIGN KEY (LOCAL_PA ) REFERENCES EQUIPOS (COD_EQ) ON DELETE CASCADE;

	ALTER TABLE PARTIDOS ADD CONSTRAINT FK_EQUIPO_VISITANTE FOREIGN KEY (VISITANTE_PA ) REFERENCES EQUIPOS (COD_EQ) ON DELETE CASCADE;

RESULTADO:

Tabla modificada.
************************************************************************
5.- Añade las restricciones a los campos PUNTOSLOC_PA y PUNTOSVIS_PA para que no puedan ser negativos.

SQL>ALTER TABLE PARTIDOS ADD CONSTRAINT CK_PUNTOS_NO_NEGATIVOS CHECK (PUNTOSLOC_PA>0 AND PUNTOSVIS_PA >=0);

RESULTADO:
Tabla modificada.

************************************************************************
6.- Añade las restricciones a los campos COD_EQ que debe ser mayúscula y NOMB_EQ, que no se puede repetir.

SQL>ALTER TABLE EQUIPOS ADD CONSTRAINT CK_COD_EQ_MAY CHECK (COD_EQ = UPPER(COD_EQ));

	ALTER TABLE EQUIPOS ADD CONSTRAINT U_NOMBRE_EQ UNIQUE (NOMB_EQ);

RESULTADO:

************************************************************************
7.- Listar para cada empleado, su código, su dni y el dni del empleado que es director de su centro.

SQL>SELECT COD_EM, DNI_EM ,DIRECTOR_DE
FROM EMPLEADOS EMP, DEPARTAMENTOS DEP
WHERE EMP.DEPT_EM= DEP.COD_DE AND DIRECTOR_CE = DNI_EM;

SELECT EMP.COD_EM "CODIGO", EMP.DNI_EM "DNI EMPLEADO", (SELECT DNI_EM FROM EMPLEADOS WHERE COD_EM= CEN.DIRECTOR_CE)"DNI DIRECTOR CENTRO" 
FROM EMPLEADOS EMP, CENTROS CEN, DEPARTAMENTOS DEP 
WHERE CEN.COD_CE = DEP.CENTRO_DE
 AND DEP.COD_DE = EMP.DEPT_EM;
 
RESULTADO:

 SELECT DNI_EM FROM EMPLEADOS WHERE COD_EM= DIRECTOR_CE; 
    CODIGO DNI EMPLE DNI DIREC
---------- --------- ---------
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

SQL>SELECT NOMB_DE "NOMBRE", SUM(EMP.SALARIO_EM) "SUMA DE SALARIOS" 
 FROM EMPLEADOS EMP, DEPARTAMENTOS DEP 
WHERE EMP.DEPT_EM = DEP.COD_DE 
  AND EMP.NUMHIJ_EM = 0
 GROUP BY NOMB_DE;

RESULTADO:

NOMBRE                                   SUMA DE SALARIOS
---------------------------------------- ----------------
Investigacion y Dise±o                           18000000
Jefatura Fabrica Zona Sur                        20000000
Administracion Zona Sur                          18600000
Ventas Zona Sur                                  20000000
Direccion General                                14400000
Produccion Zona Sur                              22800000

6 filas seleccionadas.
************************************************************************
9.- Listar el nombre y el número de extensiones telefónicas que tiene el departamento con menos extensiones telefónicas.

SQL>SELECT DEP.NOMB_DE "NOMBRE DEPARTAMENTO", COUNT(NVL(EMP.EXTTEL_EM, 0)) "NUMERO EXTENSIONES TELEFONICAS"
 FROM EMPLEADOS EMP, DEPARTAMENTOS DEP 
WHERE EMP.DEPT_EM = DEP.COD_DE
GROUP BY DEP.NOMB_DE
HAVING COUNT(NVL(EMP.EXTTEL_EM, 0)) = (SELECT MIN(COUNT(NVL(EXTTEL_EM, 0))) 
                                        FROM EMPLEADOS
                                       GROUP BY DEPT_EM);

RESULTADO:

NOMBRE DEPARTAMENTO                      NUMERO EXTENSIONES TELEFONICAS
---------------------------------------- ------------------------------
Direccion General                                                     3
************************************************************************
10.- Mostrar para cada empleado nacido en un año par, el nombre, edad actual, la letra de su DNI y el nombre del departamento donde trabajan. 

SQL>SELECT EMP.NOMB_EM "NOMBRE", TRUNC(MONTHS_BETWEEN(SYSDATE,EMP.FECNAC_EM)/12) "EDAD", SUBSTR(EMP.DNI_EM, 9,1) "LETRA DNI", DEP.NOMB_DE "NOMBRE DEPARTAMENTO"
 FROM EMPLEADOS EMP, DEPARTAMENTOS DEP
WHERE EMP.DEPT_EM = DEP.COD_DE;

RESULTADO:
SELECT NOMB_EM, TRUNC(MONTHS_BETWEEN(SYSDATE,FECNAC_EM)/12) EDAD, SUBSTR(DNI_EM,9,1) LETRA, NOMB_DE
FROM DEPARTAMENTOS, EMPLEADOS
WHERE DEPT_EM = COD_DE
	AND MOD(TO_CHAR(FECNAC_EM,'YYYY'),2) = 0;
NOMBRE                                         EDAD LETR NOMBRE DEPARTAMENTO
---------------------------------------- ---------- ---- ---------------------------
Arias Grillo, Jairo                              30 T    Administracion Zona Sur
Arnaldos Valle, Javier                           21 D    Produccion Zona Sur
Avila Ferrete, Raquel Maria                      20 D    Jefatura Fabrica Zona Sur
Cabrera Alava, Kilian                            20 D    Produccion Zona Sur
Calderon Diaz, Daniel                            21 K    Investigacion y Dise±o
Calvo Jimenez, Alberto                           21 H    Produccion Zona Sur
Camacho Lindsey, Daniel                          21 D    Ventas Zona Sur
Conde Alvarez, Jose Antonio                      29 D    Produccion Zona Sur
Del Junco Suarez, Malvina                        29 V    Direccion General
Fernandez Benito, Javier                         38 L    Ventas Zona Sur
Gallego Carvajal, Juan                           23 T    Administracion Zona Sur
Garcia Vazquez, Jose Manuel                      20 D    Produccion Zona Sur
Gata Masero, Carlos                              19 D    Jefatura Fabrica Zona Sur
Gil Campos, David                                19 D    Produccion Zona Sur
Gomez Alba, Gonzalo                              19 K    Investigacion y Dise±o
Jimenez Campos, Alejandro                        29 H    Produccion Zona Sur
Jimenez Garcia, Jose Manuel                      20 D    Ventas Zona Sur
Leon Vazquez, Rafael                             27 D    Produccion Zona Sur
Marquez Funes, Marcos                            19 V    Direccion General
Matito Lozano, Carmen                            28 L    Ventas Zona Sur
Menacho Cabo, Pedro Jose                         24 T    Administracion Zona Sur
Mendizabal Romero, Luis                          20 D    Produccion Zona Sur
Montane Rodriguez, Francisco Javier              38 D    Jefatura Fabrica Zona Sur
Montes Rodriguez, Victor                         24 D    Produccion Zona Sur
Perez Alvarez, Javier                            26 K    Investigacion y Dise±o
Pineda Santos, Jose Manuel                       20 H    Produccion Zona Sur
Pires Barranco, Amador Claudio                   22 D    Ventas Zona Sur
Pozo Martin, Ismael                              18 D    Produccion Zona Sur
Punta Perez, Gonzalo                             22 V    Direccion General
Reina Ramirez, Joaquin Javier                    24 L    Ventas Zona Sur
Rivas Barba, Miguel                              23 T    Administracion Zona Sur
Rolo Vera, Luis Miguel                           23 D    Produccion Zona Sur
Rufo Rodriguez, Alejandro                        22 D    Jefatura Fabrica Zona Sur
Toscano Fernandez, Juan                          19 D    Produccion Zona Sur
Valverde Gallego, Enrique                        19 K    Investigacion y Dise±o

************************************************************************
11.- Listar para cada empleado el código, nombre, salario, nombre del centro donde trabaja y localidad en la que se encuentra, de aquellos empleados que ganan menos que la media de los salarios de su departamento.

SQL>SELECT EMP.DEPT_EM, EMP.COD_EM, EMP.NOMB_EM, EMP.SALARIO_EM, CEN.NOMB_CE, CEN.POBLAC_CE
FROM EMPLEADOS EMP, CENTROS CEN, DEPARTAMENTOS DEP 
WHERE CEN.COD_CE = DEP.CENTRO_DE
 AND DEP.COD_DE = EMP.DEPT_EM
 GROUP BY EMP.DEPT_EM, EMP.COD_EM, EMP.NOMB_EM, EMP.SALARIO_EM, CEN.NOMB_CE, CEN.POBLAC_CE
 HAVING EMP.SALARIO_EM < (SELECT AVG(SALARIO_EM)  
                           FROM EMPLEADOS
                           WHERE DEPT_EM = EMP.DEPT_EM
                       GROUP BY DEPT_EM);

RESULTADO:

   DEPT_EM     COD_EM NOMB_EM                                  SALARIO_EM NOMB_CE                     POBLAC_CE
---------- ---------- ---------------------------------------- ---------- ------------------------------ --------------
       500         10 Conde Alvarez, Jose Antonio                 1300000 Fabrica Zona Sur            Sevilla
       600          4 Fernandez Benito, Javier                    3200000 Oficinas Zona Sur           Sevilla
       500         28 Pineda Santos, Jose Manuel                  1600000 Fabrica Zona Sur            Sevilla
       500         31 Rolo Vera, Luis Miguel                      1600000 Fabrica Zona Sur            Sevilla
       500         20 Leon Vazquez, Rafael                        1300000 Fabrica Zona Sur            Sevilla
       500         27 Mendizabal Romero, Luis                     1600000 Fabrica Zona Sur            Sevilla
       500          7 Arnaldos Valle, Javier                      1600000 Fabrica Zona Sur            Sevilla
       500         18 Jimenez Campos, Alejandro                   1600000 Fabrica Zona Sur            Sevilla
       600         24 Reina Ramirez, Joaquin Javier               3200000 Oficinas Zona Sur           Sevilla
       600         14 Matito Lozano, Carmen                       3200000 Oficinas Zona Sur           Sevilla
       500         30 Pozo Martin, Ismael                         1300000 Fabrica Zona Sur            Sevilla
       500          8 Calvo Jimenez, Alberto                      1600000 Fabrica Zona Sur            Sevilla
       500         17 Garcia Vazquez, Jose Manuel                 1600000 Fabrica Zona Sur            Sevilla

	   
13 filas seleccionadas.
************************************************************************
12.- Insertar un departamento con código 900 y nombre 'Mantenimiento', que dependerá del departamento con menos empleados. El resto de datos serán los del departamento del que depende.

SQL>INSERT INTO DEPARTAMENTOS
SELECT 900, DEP.DIRECTOR_DE, DEP.DEPTJEFE_DE, DEP.CENTRO_DE, 'Mantenimiento', DEP.PRESUP_DE, DEP.TIPODIR_DE
FROM EMPLEADOS EMP, DEPARTAMENTOS DEP
WHERE COD_DE=DEPT_EM
GROUP BY DEP.COD_DE, DEP.DIRECTOR_DE, DEP.DEPTJEFE_DE, DEP.CENTRO_DE, DEP.NOMB_DE, DEP.PRESUP_DE, DEP.TIPODIR_DE
HAVING COUNT(EMP.COD_EM)= (SELECT MIN(COUNT(EMP.COD_EM)) 
                                  FROM EMPLEADOS EMP, DEPARTAMENTOS DEP
                                 WHERE EMP.DEPT_EM = DEP.COD_DE
                                 GROUP BY EMP.DEPT_EM);

RESULTADO:

1 fila creada.

    COD_DE DIRECTOR_DE DEPTJEFE_DE  CENTRO_DE NOMB_DE
---------- ----------- ----------- ---------- ---------------------------------
       100           5                     30 Administracion Zona Sur
       200           1                     10 Direccion General
       300           2         200         10 Investigacion y Dise±o
       400           6                     20 Jefatura Fabrica Zona Sur
       500           9         400         20 Produccion Zona Sur
       600           3         100         30 Ventas Zona Sur
       900           1                     10 Mantenimiento

************************************************************************
13.- Modificar el director del departamento 900 al empleado con menor salario.

SQL>UPDATE DEPARTAMENTOS
SET DIRECTOR_DE = (SELECT COD_EM
FROM EMPLEADOS
WHERE SALARIO_EM = (SELECT MIN(SALARIO_EM)
FROM EMPLEADOS))
WHERE COD_DE=900;

RESULTADO:

************************************************************************
14.- Cambia al departamento 900 a los empleados que tengan extensión telefónica.

SQL>UPDATE EMPLEADOS 
  SET DEPT_EM = 900 
WHERE EXTTEL_EM IS NOT NULL;

RESULTADO:
25 filas actualizadas.
************************************************************************
15.- Inserta un nuevo empleado en el departamento 900 de nombre "Esteban Murillo, Bartolome", fecha de nacimiento "01/01/1617" y el resto de datos, los del empleado que lleva menos tiempo en la empresa.

SQL>
************************************************************************
16.- Modifica el presupuesto del departamento 900 al doble de la suma de los salarios de sus empleados.

SQL>UPDATE DEPARTAMENTOS
	SET PRESUP_DE = PRESUP* 2
	WHERE

RESULTADO:

