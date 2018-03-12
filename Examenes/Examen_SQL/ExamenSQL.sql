                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
Nombre: <Pon aqu� tu nombre>

/************************************************************************/
	INSTRUCCIONES:
	==============

-Salva este fichero con las iniciales de tu nombre y apellidos,
 en el directorio "C:\Examen\ ":
	Ejemplo:	Jos� Mar�a Rivera Calvete
			JMRC.sql

-Pon tu nombre al ejercicio y lee atentamente todas las preguntas.

-Entra en "SQL Plus" con cualquier usuario. 

-Carga el script para el examen desde el fichero "Empresa.sql".

-Donde ponga "SQL>", copiar�s las sentencias SQL que has utilizado.

-Donde ponga "RESULTADOS:" copiar�s el resultado que SQL*Plus te devuelve.

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en la recuperaci�n tendr�s otra oportunidad.

	PUNTUACI�N
	==========
- Preguntas:	0,625 puntos cada una


/************************************************************************/
	Descripci�n de las tablas:
	==========================

CENTROS
-------
# Cod_ce	NUMBER(2)			N�mero identificativo del centro
  Nombre_ce	VARCHAR2(30)		Nombre del centro
  Dir_ce	VARCHAR2(35)		Direcci�n del centro

DEPARTAMENTOS
-------------
# Cod_de		NUMBER(3)		N�mero identificativo del departamento
* Centro_de		NUMBER(2)		N�mero del centro de trabajo donde est� el departamento
* Director_de	NUMBER(4)		N�mero del empleado que es director del departamento
  TipoDir_de	CHAR(1)			Tipo de director: 'P', en propiedad y 'F', en funciones
  Presuesto_de	NUMBER(6)		Presupuesto anual del departamento
* Dptojefe_de	NUMBER(3)		N�mero del departamento del que depende
  Nombre_de		VARCHAR2(30)	Nombre del departamento

EMPLEADOS
---------
# Cod_em		NUMBER(4)		N�mero identificativo del empleado
* Dpto_em		NUMBER(3)		N�mero del departamento al que est� asignado el empleado
  ExtTel_em		NUMBER(3)		Extensi�n telef�nica del empleado
  FechaNac_em	DATE			Fecha de nacimiento
  FechaIng_em	DATE			Fecha de ingreso en la empresa
  Salario_em	NUMBER(5)		Salario mensual en euros
  Comision_em	NUMBER(5)		Comisi�n mensual en euros
  Numhijos_em	NUMBER(2)		N�mero de hijos
  Apellidos_em	VARCHAR2(30)	Apellidos del empleado
  Nombre_em		VARCHAR2(15)	Nombre del empleado

Nota: 
	# PRIMARY KEY
	* FOREIGN KEY


	
/************************************************************************/
1.- Hallar el n�mero de empleados de toda la empresa.

SQL>SELECT COUNT(*) FROM EMPLEADOS;

RESULTADO:

/************************************************************************/
2.- Hallar la masa salarial (salarios+comisiones) de la empresa.

SQL>SELECT SUM(SALARIO_EM + NVL(COMISION_EM)) MASA_SALARIAL FROM EMPLEADOS;

RESULTADO:

/************************************************************************/
3.- Obtener un listado que incluya el nombre de cada uno de los departamentos junto al nombre y apellidos de su director.

SQL>SELECT DEP.NOMBRE_DE,EMP.NOMBRE_EM, EMP.APELLIDOS_EM
  FROM EMPLEADOS EMP,DEPARTAMENTOS DEP
 WHERE DEP.DIRECTOR_DE = EMP.COD_EM;

RESULTADO:

/************************************************************************/
4.- Obtener, por orden alfab�tico, los nombres y apellidos de los empleados cuyo salario es igual o superior al mayor de los salarios de los empleados del departamento 122.

SQL>SELECT EMP.APELLIDOS_EM, EMP.NOMBRE_EM
  FROM EMPLEADOS EMP 
WHERE EMP.SALARIO_EM>=(SELECT MAX(EMP.SALARIO_EM)
                        FROM EMPLEADOS EMP 
                      WHERE EMP.DPTO_EM=122)
ORDER BY EMP.APELLIDOS_EM,EMP.NOMBRE_EM;

RESULTADO:

/************************************************************************/
5.- Obtener, por orden alfab�tico, los nombres, apellidos y las comisiones de los empleados del departamento 110.

SQL>SELECT EMP.NOMBRE_EM, EMP.APELLIDOS_EM,EMP.COMISION_EM
  FROM EMPLEADOS EMP
WHERE EMP.DPTO_EM=110
ORDER BY EMP.APELLIDOS_EM,EMP.NOMBRE_EM;

RESULTADO:

/************************************************************************/
6.- Datos de los empleados que cobran el salario m�ximo de su departamento.	

SQL>SELECT EMP.NOMBRE_EM,EMP.APELLIDOS_EM,EMP.SALARIO_EM
FROM EMPLEADOS EMP 
WHERE EMP.SALARIO_EM =(SELECT MAX(SALARIO_EM) 
						FROM EMPLEADOS 
						WHERE DPTO_EM = EMP.DPTO_EM);

RESULTADO:

/************************************************************************/
7.- Calcular aquellos empleados que llevan m�s de 35 a�os en la empresa. Muestre todos los datos de cada uno de ellos.

SQL>
SELECT * FROM EMPLEADOS
WHERE MONTHS_BETWEEN(SYSDATE,FECHAING_EM)/12>35;

SELECT COD_EM,NOMBRE_EM,APELLIDOS_EM ,TRUNC(MONTHS_BETWEEN(SYSDATE, FECHAING_EM)/12)
  FROM EMPLEADOS 
WHERE MONTHS_BETWEEN(SYSDATE,FECHAING_EM)/12>35;

RESULTADO:

/************************************************************************/
8.- Hallar, por orden de n�mero de empleado, el nombre, apellidos y el salario total (salario m�s comisi�n) de los empleados cuyo salario total supera los 1300 euros mensuales.

SQL>SELECT NOMBRE_EM,SALARIO_EM + NVL(COMISION_EM,0)SALARIO_TOTAL
FROM EMPLEADOS WHERE SALARIO_EM >1300
ORDER BY COD_EM;

RESULTADO:

/************************************************************************/
9.- Mostrar para cada empleado el n�mero de meses que lleva el empleado en la empresa junto con su nombre.

SQL>SELECT EMP.NOMBRE_EM,TRUNC(MONTHS_BETWEEN(SYSDATE, FECHAING_EM))MESES FROM EMPLEADOS EMP;

RESULTADO:

/************************************************************************/
10.- Mostrar un listado donde aparezca el c�digo de los departamentos y su nombre conjuntamente con el c�digo de los centros en donde est�n situados y el nombre de estos centros.

SQL>SELECT COD_DE, NOMBRE_DE, COD_CE, NOMBRE_CE FROM DEPARTAMENTOS,CENTROS WHERE CENTROS.COD_CE=DEPARTAMENTOS.CENTRO_DE;
RESULTADO:

/************************************************************************/
11.- Hallar, en una consulta, los siguientes datos para cada departamento junto con su c�digo:
	a) N�mero de empleados.
	b) Salario medio, m�ximo y m�nimo
	c) Media de las comisiones.

Poner un alias a las columnas que usen funciones de grupo o agregaci�n.

SQL>SELECT DPTO_EM,
  COUNT(COD_EM)NUM_EMPLE,
  AVG(SALARIO_EM)MEDIA_SA,
  MIN(SALARIO_EM)SALARIO_M,
  MAX(SALARIO_EM)SAL_MAX,
  AVG(NVL(COMISION_EM,0))MEDIA_COMI 
FROM EMPLEADOS
GROUP BY DPTO_EM ;

RESULTADO:

/************************************************************************/
12.-  Calcular cuantos n�meros de tel�fono distintos usa cada departamento, mostrando el c�digo y el nombre de cada departamento.

SQL>SELECT COUNT(DISTINCT EXTTEL_EM)NUM_DISTINTOS, COD_DE, NOMBRE_DE 
  FROM DEPARTAMENTOS DEP,EMPLEADOS EMP 
WHERE DEP.COD_DE=EMP.DPTO_EM
GROUP BY COD_DE, NOMBRE_DE;

RESULTADO:

/************************************************************************/
13.- Mostrar los departamentos (n�mero y nombre) con sus centros (n�mero y nombre) y la edad media de sus empleados de aquellos departamentos que tienen una edad media en sus empleados mayor a 35 a�os.

SQL>SELECT DEP.COD_DE,DEP.NOMBRE_DE, CEN.COD_CE,CEN.NOMBRE_CE,AVG(MONTHS_BETWEEN(SYSDATE,EMP.FECHANAC_EM)/12) EDAD_MEDIA 
  FROM DEPARTAMENTOS DEP,CENTROS CEN, EMPLEADOS EMP
  WHERE DPTO_EM=COD_DE
		AND COD_CE=CENTRO_DE
  GROUP BY DEP.COD_DE,DEP.NOMBRE_DE, CEN.COD_CE,CEN.NOMBRE_CE
  HAVING AVG(MONTHS_BETWEEN(SYSDATE,EMP.FECHANAC_EM)/12)>35;


RESULTADO:

/************************************************************************/
14.- Para cada grupo de empleados que cobran el mismo salario y tienen el mismo n�mero de hijos, 
     diga cuantos empleados forman el grupo y en cuantos departamentos est�n trabajando.

SQL>SELECT EMP.SALARIO_EM, EMP.NUMHIJOS_EM, COUNT(EMP.COD_EM)EMPLEADOS_FORMAN, COUNT(DISTINCT DPTO_EM)DEPAR_TRABAJN
  FROM EMPLEADOS EMP 
GROUP BY  EMP.SALARIO_EM, EMP.NUMHIJOS_EM; 


RESULTADO:

/************************************************************************/
15.- Para cada extensi�n telef�nica, hallar cu�ntos empleados la usan y el salario medio de �stos.

SQL>SELECT EMP.EXTTEL_EM,COUNT(EMP.COD_EM)NUMEMPLE, AVG(EMP.SALARIO_EM)SALARIO_MEDIO FROM EMPLEADOS EMP 
GROUP BY EMP.EXTTEL_EM;

RESULTADO:

/************************************************************************/
16.- Hallar el salario medio por departamento para aquellos departamentos cuyo salario m�ximo es inferior al salario medio de todos los empleados.

SQL>SELECT dpto_em, ROUND(avg(salario_em)) salmed
	FROM empleados
	GROUP BY dpto_em
  HAVING max(salario_em) < (SELECT avg(salario_em) FROM empleados );

RESULTADO:

