/************************************************************************/
1.- Hallar el n�mero de empleados de toda la empresa.

SQL>
SELECT COUNT(*) FROM EMPLEADOS;

RESULTADO:
  COUNT(*)
----------
        34
/************************************************************************/
2.- Hallar la masa salarial (salarios+comisiones) de la empresa.

SQL>
SELECT SUM(SALARIO_EM + NVL(COMISION_EM,0)) MASA_SALARIAL FROM EMPLEADOS;

RESULTADO:
MASA_SALARIAL
-------------
        46670
/************************************************************************/
3.- Obtener un listado que incluya el nombre de cada uno de los departamentos junto al nombre de su director.

SQL>
SELECT Nombre_de, Nombre_em, Apellidos_em 
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

8 filas seleccionadas.
/************************************************************************/
4.- Obtener, por orden alfab�tico, los nombres de los empleados cuyo salario es igual o superior al mayor de los salarios de los empleados del departamento 122.

SQL>
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
RAQUEL          RUIZ FERNANDEZ

/************************************************************************/
5.- Obtener, por orden alfab�tico, los nombres y las comisiones de los empleados del departamento 110.

SQL>
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

/************************************************************************/
6.- Datos de los empleados que cobran el salario m�ximo de su departamento.	

SQL>
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

/**************************************************************************************************************/
7.- Calcular aquellos empleados que llevan m�s de 35 a�os en la empresa. Muestre todos los datos de cada uno de ellos.

SQL>
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
       210 JESUS           MANCHE�O CAMACHO                       42
       240 JULIO           MAQUEDA GARCIA                         35
       270 ISAAC           MARIN SALAS                            35

7 filas seleccionadas.
/**************************************************************************************************************/
8.- Hallar, por orden de n�mero de empleado, el nombre y el salario total (salario m�s comisi�n) de los empleados cuyo salario total supera los 1300 euros mensuales.

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

/**************************************************************************************************************/
9.- Mostrar para cada empleado el n�mero de meses que lleva el empleado en la empresa junto con su nombre.

SQL>
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

/**************************************************************************************************************/
10.- Mostrar un listado donde aparezca el c�digo de los departamentos y su nombre conjuntamente con el c�digo de los centros en donde est�n situados y el nombre de estos centros.

SQL>
SELECT cod_de, nombre_de, centro_de, nombre_ce
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
/**************************************************************************************************************/
11.- Hallar, en una consulta, los siguientes datos para cada departamento:
	a) N�mero de empleados.
	b) Salario medio, m�ximo y m�nimo
	c) Media de las comisiones.

Poner un alias a las columnas que usen funciones de grupo o agregaci�n.

SQL>
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

8 filas seleccionadas.	
/**************************************************************************************************************/
12.-  Calcular cuantos n�meros de tel�fono distintos usa cada departamento, mostrando el c�digo y el nombre de cada departamento.

SQL>
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
/**************************************************************************************************************/
13.- Mostrar los departamentos (n�mero y nombre) con sus centros (n�mero y nombre) y la edad media de sus empleados de aquellos departamentos que tienen una edad media en sus empleados mayor a 35 a�os.

SQL>
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
/**************************************************************************************************************/
14.- Para cada grupo de empleados que cobran el mismo salario y tienen el mismo n�mero de hijos, diga cuantos empleados forman el grupo y en cuantos departamentos est�n trabajando.

SQL>
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

31 filas seleccionadas.
/**************************************************************************************************************/
15.- Para cada extensi�n telef�nica, hallar cu�ntos empleados la usan y el salario medio de �stos.

SQL> 
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

26 filas seleccionadas.
/**************************************************************************************************************/
16.- Hallar el salario medio por departamento para aquellos departamentos cuyo salario m�ximo es inferior al salario medio de todos los empleados.

SQL>
SELECT dpto_em, avg(salario_em) salmed
	FROM empleados
	GROUP BY dpto_em
	HAVING max(salario_em) < (SELECT avg(salario_em) FROM empleados );
RESULTADO:
   DPTO_EM     SALMED
---------- ----------
       120       1270
       111   1218,125

/**************************************************************************************************************/
