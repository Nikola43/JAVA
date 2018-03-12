
Nombre: <Malvina del Junco Suarez>
	
/************************************************************************/
	INSTRUCCIONES:
	==============

-Salva este fichero con las iniciales de tu nombre y apellidos,
 en el directorio "C:\Examen\ ":
	Ejemplo:	José María Rivera Calvete
			JMRC.sql

-Pon tu nombre al ejercicio y lee atentamente todas las preguntas.

-Entra en "SQL Plus" con cualquier usuario. 

-Carga el script para el examen desde el fichero "Empresa.sql".

-Donde ponga "SQL>", copiarás las sentencias SQL que has utilizado.

-Donde ponga "RESULTADOS:" copiarás el resultado que SQL*Plus te devuelve.

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en la recuperación tendrás otra oportunidad.

	PUNTUACIÓN
	==========
- Preguntas:	0,625 puntos cada una


/************************************************************************/
	Descripción de las tablas:
	==========================

CENTROS
-------
# Cod_ce	NUMBER(2)			Número identificativo del centro
  Nombre_ce	VARCHAR2(30)		Nombre del centro
  Dir_ce	VARCHAR2(35)		Dirección del centro

DEPARTAMENTOS
-------------
# Cod_de		NUMBER(3)		Número identificativo del departamento
* Centro_de		NUMBER(2)		Número del centro de trabajo donde está el departamento
* Director_de	NUMBER(4)		Número del empleado que es director del departamento
  TipoDir_de	CHAR(1)			Tipo de director: 'P', en propiedad y 'F', en funciones
  Presuesto_de	NUMBER(6)		Presupuesto anual del departamento
* Dptojefe_de	NUMBER(3)		Número del departamento del que depende
  Nombre_de		VARCHAR2(30)	Nombre del departamento

EMPLEADOS
---------
# Cod_em		NUMBER(4)		Número identificativo del empleado
* Dpto_em		NUMBER(3)		Número del departamento al que está asignado el empleado
  ExtTel_em		NUMBER(3)		Extensión telefónica del empleado
  FechaNac_em	DATE			Fecha de nacimiento
  FechaIng_em	DATE			Fecha de ingreso en la empresa
  Salario_em	NUMBER(5)		Salario mensual en euros
  Comision_em	NUMBER(5)		Comisión mensual en euros
  Numhijos_em	NUMBER(2)		Número de hijos
  Apellidos_em	VARCHAR2(30)	Apellidos del empleado
  Nombre_em		VARCHAR2(15)	Nombre del empleado

Nota: 
	# PRIMARY KEY
	* FOREIGN KEY


	
/************************************************************************/
1.- Hallar el número de empleados de toda la empresa.
/*SELECT COUNT(*) FROM EMPLEADOS;*/
SQL>SELECT COUNT(Cod_em) AS "NUMERO DE EMPLEADOS" FROM EMPLEADOS;
	

RESULTADO:
NUMERO DE EMPLEADOS
-------------------
                 34
/************************************************************************/
2.- Hallar la masa salarial (salarios+comisiones) de la empresa.
/*SELECT SUM(SALARIO_EM + NVL(COMISION_EM,0)) MASA_SALARIAL FROM EMPLEADOS;
RESULTADO:
MASA_SALARIAL
-------------
        46670*/
SQL> SELECT SUM(Salario_em + Comision_em) FROM  EMPLEADO

RESULTADO:
SUM(SALARIO_EM+COMISION_EM)
--------------------------
                     19100

/************************************************************************/
3.- Obtener un listado que incluya el nombre de cada uno de los departamentos junto al nombre y apellidos de su director.
/*SELECT Nombre_de, Nombre_em, Apellidos_em 
	FROM EMPLEADOS, DEPARTAMENTOS
	WHERE Director_de = Cod_em;

RESULTADO:
NOMBRE_DE                      NOMBRE_EM       APELLIDOS_EM
------------------------------ --------------- ------------------------------
PERSONAL                       DANIEL          DOMINGUEZ PACHECO
ORGANIZACION                   DANIEL          DOMINGUEZ PACHECO
SECTOR INDUSTRIAL              PABLO           GANDUL ROMERO
DIRECC. COMERCIAL              PABLO           GANDUL ROMERO
DIRECCION GENERAL              MANUEL          RUIZ DE LOPERA
SECTOR SERVICIOS               ISAAC           MARIN SALAS
FINANZAS                       ANTONIO         RODRIGUEZ MORALES
PROCESO DE DATOS               RAQUEL          RUIZ FERNANDEZ

8 filas seleccionadas.*/
SQL>SELECT A.Nombre_de as "NOMBRE DEPARTAMENTO ", B.Nombre_em AS "NOMBRE DIR", B.Apellidos_em AS "APELLIDOS DIR" 
FROM DEPARTAMENTOS A, EMPLEADOS B where A.Director_de = B.Cod_em

RESULTADO:
NOMBRE DEPARTAMENTO            NOMBRE DIR      APELLIDOS DIR
------------------------------ --------------- -------------------------
PERSONAL                       DANIEL          DOMINGUEZ PACHECO
ORGANIZACION                   DANIEL          DOMINGUEZ PACHECO
SECTOR INDUSTRIAL              PABLO           GANDUL ROMERO
DIRECC. COMERCIAL              PABLO           GANDUL ROMERO
DIRECCION GENERAL              MANUEL          RUIZ DE LOPERA
SECTOR SERVICIOS               ISAAC           MARIN SALAS
FINANZAS                       ANTONIO         RODRIGUEZ MORALES
PROCESO DE DATOS               RAQUEL          RUIZ FERNANDEZ
/************************************************************************/
4.- Obtener, por orden alfabético, los nombres y apellidos de los empleados cuyo salario es igual o superior al mayor de los salarios de los empleados del departamento 122.
/*SQL>
SELECT Nombre_em, Apellidos_em
	FROM EMPLEADOS
	WHERE SALARIO_EM >= (SELECT MAX(SALARIO_EM) FROM EMPLEADOS WHERE Dpto_em = 122)
	ORDER BY 2, 1;
	
RESULTADO:
NOMBRE_EM       APELLIDOS_EM
--------------- ------------------------------
PABLO           GANDUL ROMERO
JOSE ANTONIO    MORENO GOMEZ
JOSE MARIA      RIVERA CALVETE
MANUEL          RUIZ DE LOPERA
RAQUEL          RUIZ FERNANDEZ/*/
SQL>SELECT Nombre_em,Apellidos_em From EMPLEADOS WHERE Salario_em >= (SELECT MAX(Salario_em) FROM EMPLEADOS WHERE Dpto_em = 122);

RESULTADO:

NOMBRE_EM       APELLIDOS_EM
--------------- -----------------------
JOSE MARIA      RIVERA CALVETE
PABLO           GANDUL ROMERO
JOSE ANTONIO    MORENO GOMEZ
MANUEL          RUIZ DE LOPERA
RAQUEL          RUIZ FERNANDEZ

SQL>
/************************************************************************/
5.- Obtener, por orden alfabético, los nombres, apellidos y las comisiones de los empleados del departamento 110.
/*SQL>
SELECT Nombre_em, Apellidos_em, Comision_em
	FROM EMPLEADOS
	WHERE Dpto_em = 110
	ORDER BY 2, 1;
RESULTADO:
NOMBRE_EM       APELLIDOS_EM                   COMISION_EM
--------------- ------------------------------ -----------
ROMULO          CAMPOS SORIA
PABLO           GANDUL ROMERO                           50
SERGIO          TORO RAMIREZ
*/
SQL>SELECT Nombre_em AS NOMBRE, Apellidos_em AS APELLIDOS, Comision_em as COMISIONES FROM EMPLEADOS WHERE Dpto_em = 110 ORDER BY Nombre_em, Apellidos_em;

RESULTADO:

RESULTADO:
NOMBRE          APELLIDOS                      COMISIONES
--------------- ------------------------------ ----------
PABLO           GANDUL ROMERO                          50
ROMULO          CAMPOS SORIA
SERGIO          TORO RAMIREZ

/************************************************************************/
6.- Datos de los empleados que cobran el salario máximo de su departamento.	
/*SQL>
SELECT Nombre_em, Apellidos_em, Salario_em
	FROM EMPLEADOS E
	WHERE Salario_em = (SELECT MAX(Salario_em) FROM Empleados WHERE Dpto_em = E.Dpto_em);
	
RESULTADO:
NOMBRE_EM       APELLIDOS_EM                   SALARIO_EM
--------------- ------------------------------ ----------
JOSE MARIA      RIVERA CALVETE                       2310
JAVIER          FERNANDEZ MONTES                     1310
PABLO           GANDUL ROMERO                        1480
MANUEL          RUIZ DE LOPERA                       1720
ISAAC           MARIN SALAS                          1380
JOSE            RODRIGUEZ AGUAYO                     1270
ANTONIO         RODRIGUEZ MORALES                    1420
RAQUEL          RUIZ FERNANDEZ                       1450
*/
SQL> SELECT Nombre_em AS NOMBRE, Apellidos_em AS APELLIDOS FROM EMPLEADOS WHERE Salario_em IN (SELECT MAX(Salario_em) FROM EMPLEADOS GROUP BY Dpto_em);

RESULTADO::

NOMBRE          APELLIDOS
--------------- -------------------------
JOSE MARIA      RIVERA CALVETE
JAVIER          FERNANDEZ MONTES
PABLO           GANDUL ROMERO
JESUS           MANCHEÐO CAMACHO
JOSE ANTONIO    MORENO GOMEZ
MANUEL          RUIZ DE LOPERA
ISAAC           MARIN SALAS
ENRIQUE         PANIAGUA VELA
JOSE            RODRIGUEZ AGUAYO
ANTONIO         RODRIGUEZ MORALES
RAQUEL          RUIZ FERNANDEZ
/************************************************************************/
7.- Calcular aquellos empleados que llevan más de 35 años en la empresa. Muestre todos los datos de cada uno de ellos.(MAL)
/*SQL>
SELECT *
	FROM empleados
	WHERE months_between(SYSDATE, FechaIng_em)/12 > 35;


SELECT Cod_em, Nombre_em, Apellidos_em, trunc(months_between(SYSDATE, FechaIng_em)/12) antig
	FROM empleados
	WHERE months_between(SYSDATE, FechaIng_em)/12 > 35;
	RESULTADO:
    COD_EM NOMBRE_EM       APELLIDOS_EM                        ANTIG
---------- --------------- ------------------------------ ----------
       110 JOSE MARIA      RIVERA CALVETE                         51
       150 DANIEL          DOMINGUEZ PACHECO                      53
       180 PABLO           GANDUL ROMERO                          45
       190 SONIA           GARCIA PEREZ                           39
       210 JESUS           MANCHEÐO CAMACHO                       42
       240 JULIO           MAQUEDA GARCIA                         35
       270 ISAAC           MARIN SALAS                            35

7 filas seleccionadas.
*/

SQL>SELECT * FROM EMPLEADOS WHERE trunc((SYSDATE - to_date(FechaNac_em,'DD/MM/RRRR')) / 365.25)  > 35;
Select *
From empleados
Where fecha_ingreso < (curdate() – 35);

RESULTADO:
    COD_EM    DPTO_EM  EXTTEL_EM FECHANAC FECHAING SALARIO_EM COMISION_EM NUMHIJ
OS_EM APELLIDOS_EM
---------- ---------- ---------- -------- -------- ---------- ----------- ------
----- ------------------------------
NOMBRE_EM
---------------
       120        112        840 09/06/50 01/10/83       1350         110
    1 ALONSO SORIANO
ANTONIO

       130        112        810 09/11/60 01/02/84       1290         110
    2 CANO GALVEZ
JOSE MANUEL

       160        111        740 09/07/54 11/11/83       1310         110
    2 FERNANDEZ MONTES
JAVIER

       210        100        200 28/09/55 22/01/74       1380
    2 MANCHEÐO CAMACHO
JESUS

       240        111        760 26/02/57 24/02/81       1280         100
    3 MAQUEDA GARCIA
JULIO

       250        100        250 27/10/61 01/03/82       1450
    0 MORENO GOMEZ
JOSE ANTONIO

       260        100        220 03/12/58 12/07/83       1720
    6 RUIZ DE LOPERA
MANUEL

       270        112        800 21/05/60 10/09/81       1380          80
    3 MARIN SALAS
ISAAC

       280        130        410 11/01/63 08/10/86       1290
    5 OCAÐA TINEO
CONCEPCION

       285        122        620 25/10/64 15/02/83       1380
    0 PANIAGUA VELA
ENRIQUE

       290        120        910 30/11/62 14/02/83       1270
    3 RODRIGUEZ AGUAYO
JOSE

       310        130        480 21/11/61 15/01/86       1420
    0 RODRIGUEZ MORALES
ANTONIO

    COD_EM    DPTO_EM  EXTTEL_EM FECHANAC FECHAING SALARIO_EM COMISION_EM NUMHIJ
OS_EM APELLIDOS_EM
---------- ---------- ---------- -------- -------- ---------- ----------- ------
----- ------------------------------
NOMBRE_EM
---------------

       320        122        620 25/12/72 05/02/93       1405
    2 ROMERO CAMPILLEJO
ROSA MARIA

       330        112        850 19/08/63 01/03/87       1280          90
    0 ROMERO FERNANDEZ
MARIA PIEDAD

       350        122        610 13/04/64 10/09/99       1450
    1 RUIZ FERNANDEZ
RAQUEL

       360        111        750 29/10/73 10/10/83       1250         100
    2 SALGADO PEREZ
JOSE

       480        111        760 04/04/80 28/02/01       1210         100
    1 PINO BUSTOS
DIANA

       490        112        880 06/06/79 01/01/03       1180         100
    0 TORRES VELA
EUGENIA

       500        111        750 08/10/80 01/01/02       1200         100
    0 VAZQUEZ LOPEZ
VICTORIA

/************************************************************************/
8.- Hallar, por orden de número de empleado, el nombre, apellidos y el salario total (salario más comisión) de los empleados cuyo salario total supera los 1300 euros mensuales.
/*SQL>
SELECT nombre_em, salario_em+nvl(comision_em,0) salario_total 
	FROM empleados 
	WHERE salario_em+nvl(comision_em,0) >1300 
	ORDER BY cod_em;

RESULTADO:

NOMBRE_EM       SALARIO_TOTAL
--------------- -------------
JOSE MARIA               2310
ANTONIO                  1460
JOSE MANUEL              1400
DANIEL                   1440
JAVIER                   1420
PABLO                    1530
JESUS                    1380
JULIO                    1380
JOSE ANTONIO             1450
MANUEL                   1720
ISAAC                    1460
ENRIQUE                  1380
ANTONIO                  1420
ROSA MARIA               1405
MARIA PIEDAD             1370
RAQUEL                   1450
JOSE                     1350
CLAUDIA                  1400
LIVIA                    1310
CARMEN                   1310
DIANA                    1310
*/

SQL>
SELECT nombre_em, salario_em+nvl(comision_em,0) salario_total 
	FROM empleados 
	WHERE salario_em+nvl(comision_em,0) >1300 
	ORDER BY cod_em;

RESULTADO:

NOMBRE_EM       SALARIO_TOTAL
--------------- -------------
JOSE MARIA               2310
ANTONIO                  1460
JOSE MANUEL              1400
DANIEL                   1440
JAVIER                   1420
PABLO                    1530
JESUS                    1380
JULIO                    1380
JOSE ANTONIO             1450
MANUEL                   1720
ISAAC                    1460
ENRIQUE                  1380
ANTONIO                  1420
ROSA MARIA               1405
MARIA PIEDAD             1370
RAQUEL                   1450
JOSE                     1350
CLAUDIA                  1400
LIVIA                    1310
CARMEN                   1310
DIANA                    1310

SQL>8:
SELECT Nombre_em AS NOMBRE, Apellidos_em AS APELLIDOS, SUM(Salario_em + Comision_em) as "SALARIO TOTAL" FROM EMPLEADOS WHERE SUM(Salario_em + Comision_em) > 1300 order by Cod_em;

RESULTADO:

/************************************************************************/
9.- Mostrar para cada empleado el número de meses que lleva el empleado en la empresa junto con su nombre.
/*QL>
SELECT trunc(months_between(SYSDATE, FechaIng_em))  meses, nombre_em
 FROM empleados;

RESULTADO:
     MESES NOMBRE_EM
---------- ---------------
       622 JOSE MARIA
       398 ANTONIO
       394 JOSE MANUEL
       646 DANIEL
       397 JAVIER
       548 PABLO
       478 SONIA
       514 JESUS
       429 JULIO
       417 JOSE ANTONIO
       401 MANUEL
       423 ISAAC
       362 CONCEPCION
       405 ENRIQUE
       406 JOSE
       370 ANTONIO
       286 ROSA MARIA
       357 MARIA PIEDAD
       207 RAQUEL
       398 JOSE
       178 EDUARDO
       167 SERGIO
       182 SERGIO
       169 LUCRECIA
       158 AZUCENA
       156 CLAUDIA
       156 VALERIA
       189 LIVIA
       189 CARMEN
       189 DIANA
       167 EUGENIA
       179 VICTORIA
       181 ROMULO
       166 SANCHO
	   */
SQL>SELECT Apellidos_em, Nombre_em, TRUNC(MONTHS_BETWEEN (sysdate, FechaIng_em), 0)AS N_de_meses_trabajados FROM EMPLEADOS;

RESULTADO:
APELLIDOS_EM                   NOMBRE_EM       N_DE_MESES_TRABAJADOS
------------------------------ --------------- ---------------------
RIVERA CALVETE                 JOSE MARIA                        622
ALONSO SORIANO                 ANTONIO                           398
CANO GALVEZ                    JOSE MANUEL                       394
DOMINGUEZ PACHECO              DANIEL                            646
FERNANDEZ MONTES               JAVIER                            397
GANDUL ROMERO                  PABLO                             548
GARCIA PEREZ                   SONIA                             478
MANCHEÐO CAMACHO               JESUS                             514
MAQUEDA GARCIA                 JULIO                             429
MORENO GOMEZ                   JOSE ANTONIO                      417
RUIZ DE LOPERA                 MANUEL                            401
MARIN SALAS                    ISAAC                             423
OCAÐA TINEO                    CONCEPCION                        362
PANIAGUA VELA                  ENRIQUE                           405
RODRIGUEZ AGUAYO               JOSE                              406
RODRIGUEZ MORALES              ANTONIO                           370
ROMERO CAMPILLEJO              ROSA MARIA                        286
ROMERO FERNANDEZ               MARIA PIEDAD                      357
RUIZ FERNANDEZ                 RAQUEL                            207
SALGADO PEREZ                  JOSE                              398
SERRANO LUQUE                  EDUARDO                           178
SORIANO GONZALEZ               SERGIO                            167
TORO RAMIREZ                   SERGIO                            182
SALAS LARA                     LUCRECIA                          169
MUÐOZ GONZALEZ                 AZUCENA                           158
FIERRO GARCIA                  CLAUDIA                           156
MORA PEREZ                     VALERIA                           156
DURAN DELGADO                  LIVIA                             189
PEREZ RAMOS                    CARMEN                            189
PINO BUSTOS                    DIANA                             189
TORRES VELA                    EUGENIA                           167
VAZQUEZ LOPEZ                  VICTORIA                          179
CAMPOS SORIA                   ROMULO                            181
SANTOS BONILLA                 SANCHO                            166


/************************************************************************/
10.- Mostrar un listado donde aparezca el código de los departamentos y su nombre conjuntamente con el código de los centros en donde están situados y el nombre de estos centros.
SQL>
/*SELECT cod_de, nombre_de, centro_de, nombre_ce
 FROM departamentos, centros
 WHERE centro_de=cod_ce;
RESULTADO:
    COD_DE NOMBRE_DE                       CENTRO_DE NOMBRE_CE
---------- ------------------------------ ---------- ---------------
       100 DIRECCION GENERAL                      10 SEDE CENTRAL
       110 DIRECC. COMERCIAL                      20 SEDE ORIENTAL
       111 SECTOR INDUSTRIAL                      30 PRODUCCION
       112 SECTOR SERVICIOS                       20 SEDE ORIENTAL
       120 ORGANIZACION                           10 SEDE CENTRAL
       121 PERSONAL                               30 PRODUCCION
       122 PROCESO DE DATOS                       30 PRODUCCION
       130 FINANZAS                               10 SEDE CENTRAL

8 filas seleccionadas.
*/
SQL>SELECT A.Cod_de, A.Nombre_de, B.Centro_de, B.Nombre_em FROM DEPARTAMENTOS WHERE A.Centro_de = B.Cod_ce;

RESULTADO:

/************************************************************************/
11.- Hallar, en una consulta, los siguientes datos para cada departamento junto con su código:
	a) Número de empleados.
	b) Salario medio, máximo y mínimo
	c) Media de las comisiones.

Poner un alias a las columnas que usen funciones de grupo o agregación.
/*SQL>
SELECT dpto_em,
		count(cod_em)  nemp,
		avg(salario_em) salmed,
		max(salario_em) salmax,
		min(salario_em) salmin,
		avg(nvl(comision_em,0)) commed
	FROM empleados
	GROUP BY dpto_em;
RESULTADO:
   DPTO_EM       NEMP     SALMED     SALMAX     SALMIN     COMMED
---------- ---------- ---------- ---------- ---------- ----------
       100          3 1516,66667       1720       1380          0
       121          4       1560       2310       1190          0
       120          1       1270       1270       1270          0
       112          7 1267,14286       1380       1180 84,2857143
       110          3 1298,33333       1480       1200 16,6666667
       130          3       1370       1420       1290          0
       111          8   1218,125       1310       1100      91,25
       122          5       1324       1450       1175          0

8 filas seleccionadas.	*/
SQL>
 A)
SELECT COUNT(Cod_em) AS NUMERO_EMPLEADOS FROM EMPLEADOS GROUP BY Dpto_em;
 B)
SELECT MAX(Salario_em) AS SALARIO_MAXIMO, MIN(Salario_em) AS SALARIO_MINIMO, AVG(Salario_em) AS SALARIO_MEDIO FROM EMPLEADOS GROUP BY Dpto_em;
C):
SELECT AVG(Comision_em) AS MEDIA_COMISIONES FROM EMPLEADOS GROUP BY Dpto_em;

RESULTADO:
NUMERO_EMPLEADOS
----------------
               3
               4
               1
               7
               3
               3
               8
               5

SALARIO_MAXIMO SALARIO_MINIMO SALARIO_MEDIO
------------- -------------- -------------
         1720           1380    1516,66667
         2310           1190          1560
         1270           1270          1270
         1380           1180    1267,14286
         1480           1200    1298,33333
         1420           1290          1370
         1310           1100      1218,125
         1450           1175          1324

MEDIA_COMISIONES
----------------



      98,3333333
              50

      104,285714

/************************************************************************/
12.-  Calcular cuantos números de teléfono distintos usa cada departamento, mostrando el código y el nombre de cada departamento.
/*SQL>
SELECT dpto_em, count(DISTINCT exttel_em) num_distintos, Nombre_de
	FROM empleados, departamentos
	WHERE cod_de = dpto_em
	GROUP BY dpto_em, nombre_de;

RESULTADO:
   DPTO_EM NUM_DISTINTOS NOMBRE_DE
---------- ------------- -------------------
       100             3 DIRECCION GENERAL
       110             3 DIRECC. COMERCIAL
       111             4 SECTOR INDUSTRIAL
       112             5 SECTOR SERVICIOS
       120             1 ORGANIZACION
       121             3 PERSONAL
       122             4 PROCESO DE DATOS
       130             3 FINANZAS
/****************************************
SQL>
*/
RESULTADO:

/************************************************************************/
13.- Mostrar los departamentos (número y nombre) con sus centros (número y nombre) y la edad media de sus empleados de aquellos departamentos que tienen una edad media en sus empleados mayor a 35 años.
/*SQL>
SELECT cod_de, nombre_de, cod_ce, nombre_ce, avg(months_between(SYSDATE,fechanac_em )/12) edad_media
	FROM empleados, departamentos, centros
	WHERE dpto_em=cod_de
		AND cod_ce=centro_de
	GROUP BY cod_de, nombre_de, cod_ce, nombre_ce
	HAVING avg(months_between(SYSDATE,fechanac_em )/12)>35;
RESULTADO:
   COD_DE NOMBRE_DE                          COD_CE NOMBRE_CE                      EDAD_MEDIA
--------- ------------------------------ ---------- ------------------------------ ----------
      100 DIRECCION GENERAL                      10 SEDE CENTRAL                   58,1267553
      110 DIRECC. COMERCIAL                      20 SEDE ORIENTAL                  46,1975439
      120 ORGANIZACION                           10 SEDE CENTRAL                   54,0425259
      121 PERSONAL                               30 PRODUCCION                     61,8785475
      112 SECTOR SERVICIOS                       20 SEDE ORIENTAL                  48,4123416
      111 SECTOR INDUSTRIAL                      30 PRODUCCION                      42,214569
      122 PROCESO DE DATOS                       30 PRODUCCION                     43,2673541
      130 FINANZAS                               10 SEDE CENTRAL                   48,0470062
	  */
SQL>LECT A.Cod_de AS "NUMERO DEPARTAMENTO", A.Nombre_de as "NOMBRE DEPARTAMENTO ", B.Cod_ce AS "NUMERO CENTRO", B.Nombre_ce AS "NOMBRE CENTRO", TRUNC(AVG(SYSDATE - to_date(C.FechaNac_em,'DD/MM/RRRR')) / 365.25)) AS EDAD_MEDIA FROM DEPARTAMENTOS A, CENTROS B, EMPLEADOS C where B.Cod_ce = A.Centro_de AND A.Cod_de = C.Dpto_em AND EDAD_MEDIA >35


RESULTADO:

/************************************************************************/
14.- Para cada grupo de empleados que cobran el mismo salario y tienen el mismo número de hijos, diga cuantos empleados forman el grupo y en cuantos departamentos están trabajando.
/*SQL>
SELECT salario_em, numhijos_em, count(cod_em) nempl, count(DISTINCT dpto_em) depdist
 FROM empleados
 GROUP BY salario_em, numhijos_em;
RESULTADO:

 SALARIO_EM NUMHIJOS_EM      NEMPL    DEPDIST
---------- ----------- ---------- ----------
      1100           0          1          1
      1200           0          1          1
      1200           1          1          1
      1300           4          1          1
      1400           0          1          1
      1175           0          1          1
      1180           0          2          1
      1185           0          1          1
      1190           1          1          1
      1210           0          2          2
      1210           1          2          2
      1215           1          1          1
      1250           2          1          1
      1270           3          1          1
      1280           0          1          1
      1280           3          1          1
      1290           2          1          1
      1290           5          1          1
      1310           2          1          1
      1310           3          1          1
      1350           1          1          1
      1380           0          1          1
      1380           2          1          1
      1380           3          1          1
      1405           2          1          1
      1420           0          1          1
      1440           0          1          1
      1450           0          1          1
      1450           1          1          1
      1480           2          1          1
      1720           6          1          1
*/
SQL>

RESULTADO:

/************************************************************************/
15.- Para cada extensión telefónica, hallar cuántos empleados la usan y el salario medio de éstos.
/*SQL> 
SELECT exttel_em, count(cod_em) nempl, avg(salario_em) salario_medio
	FROM empleados
	GROUP BY exttel_em;
RESULTADO:
 EXTTEL_EM      NEMPL SALARIO_MEDIO
---------- ---------- -------------
       810          1          1290
       650          1          1210
       740          1          1310
       620          2        1392,5
       880          3          1190
       450          1          1400
       340          1          1440
       250          1          1450
       220          1          1720
       410          1          1290
       610          1          1450
       500          1          1215
       360          1          1190
       350          2          1805
       840          1          1350
       750          2          1225
       550          1          1200
       508          1          1480
       200          1          1380
       850          1          1280
       760          3    1233,33333
       910          1          1270
       800          1          1380
       480          1          1420
       780          2        1142,5
       660          1          1175
*/
SQL.SELECT COUNT(Cod_em), AVG(Salario_em) FROM EMPLEADOS GROUP BY (ExtTel_em);

RESULTADO:
COUNT(COD_EM) AVG(SALARIO_EM)
------------- ---------------
            1            1290
            1            1210
            1            1310
            2          1392,5
            3            1190
            1            1400
            1            1440
            1            1450
            1            1720
            1            1290
            1            1450
            1            1215
            1            1190
            2            1805
            1            1350
            2            1225
            1            1200
            1            1480
            1            1380
            1            1280
            3      1233,33333
            1            1270
            1            1380
            1            1420
            2          1142,5
            1            1175


/************************************************************************/
16.- Hallar el salario medio por departamento para aquellos departamentos cuyo salario máximo es inferior al salario medio de todos los empleados.

/*SQL> SELECT dpto_em, avg(salario_em) salmed
	FROM empleados
	GROUP BY dpto_em
	HAVING max(salario_em) < (SELECT avg(salario_em) FROM empleados );
RESULTADO:
   DPTO_EM     SALMED
---------- ----------
       120       1270
       111   1218,125
	   */
	   
SQL>SELECT AVG(Salario_em) AS SALARIO_MEDIO FROM EMPLEADOS GROUP BY (SELECT Dpto_em FROM EMPLEADOS WHERE MAX(Salario_em) < AVG(Salario_em));

RESULTADO:

