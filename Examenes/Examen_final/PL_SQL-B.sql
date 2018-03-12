TIPO B

Nombre: <Malvina Del Junco Suarez>

************************************************************************
	INSTRUCCIONES:
	==============

-Salva este fichero con las iniciales de tu nombre y apellidos,
 en el directorio "C:\ALUMNOS\ ":
	Ejemplo:	José María Rivera Calvete
			JMRC.sql

-Pon tu nombre al ejercicio y lee atentamente todas las preguntas.

-Entra en "SQL Plus" con:
	usuario: 	HR
	contraseña:	HR

-Carga el script para el examen desde el fichero "Empresa.sql".

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en la recuperación tendrás otra oportunidad.

	PUNTUACIÓN
	==========
- Cada pregunta: 	 2 puntos

- Se considerará para la evaluación:
	- Que funcione
	- Estilo de programación 
	- Tratamiento de excepciones
	- Código reutilizable y paramétrico

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
  COMISION_EM	NUMBER(9)		Comisión del Empleado

HIJOS
-----
#*PADRE_HI		NUMBER(6)		Código del Empleado
# NUMHIJ_HI		NUMBER(2)		Número del hijo del Empleado
  FECNAC_HI		DATE			Fecha de nacimiento del Hijo (O)
  NOMB_HI		VARCHAR2(40)	Nombre del Hijo (O)



Nota: 
	# PRIMARY KEY
	* FOREIGN KEY
	(O) Obligatorio
	(U) Único

************************************************************************
1.- Crea la función "Cumple" que se le pase como parámetro una fecha y que devuelva TRUE o FALSE si hoy fuera el cumpleaños de alguien nacido en esa fecha.

Código:

CREATE OR REPLACE FUNCTION Cumple 
	(fecha DATE) RETURN BOOLEAN 
IS
BEGIN
	IF TO_CHAR(fecha,'dd/mm') = TO_CHAR(SYSDATE,'dd/mm') THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
END IF;
EXCEPTION
	WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE('No existe ningun empleado con esa fecha');
	RETURN FALSE;
END Cumple;
/

DECLARE
 	
BEGIN
 	
 	DBMS_OUTPUT.PUT_LINE('AÑO : '|| );
END;
/
Funcion creada.
************************************************************************
2.- Diseña el procedimiento "Felicitar" que genere un listado en el que se vea cada empleado con sus hijos (si los tiene) indicando "Felicidades" a aquellos (empleados o hijos) que cumplan años, indicando el total de personas que cumplen años.

	Ej.:
		Segura Viudas, Santiago	19/05/90		Felicidades	
		Rivera Calvete, José Mª	02/06/65
			Rivera López, Jorge	24/04/00
			Rivera López, Victoria	13/08/01
		Conan Bárbaro, Mari	12/06/60
			Lopera Conan, Alfonso	19/05/10	Felicidades

		Total cumpleaños: 2


Código:
CREATE OR REPLACE PROCEDURE Felicitar
IS	
	CURSOR c_Cumple IS
	SELECT NOMB_EM,NOMB_HI,FECNAC_EM,FECNAC_HI FROM EMPLEADOS,HIJOS
	WHERE COD_EM = PADRE_HI(+);
	v_cont NUMBER;

BEGIN
	FOR reg IN c_Cumple LOOP
	IF Cumple(reg.FECNAC_EM) THEN
		DBMS_OUTPUT.PUT_LINE(reg.NOMB_EM||' * '||reg.FECNAC_EM||' * '||'Felicidades');
		v_cont := v_cont + 1;
	ELSE
		DBMS_OUTPUT.PUT_LINE(reg.NOMB_EM||' * '||reg.FECNAC_EM);
END IF;
	IF Cumple(reg.FECNAC_HI) THEN
		DBMS_OUTPUT.PUT_LINE(reg.NOMB_HI||' * '||reg.FECNAC_HI||' * '||'Felicidades');
		v_cont := v_cont + 1;
ELSE
	DBMS_OUTPUT.PUT_LINE(reg.NOMB_HI||' * '||reg.FECNAC_HI);
END IF;
END LOOP;
	DBMS_OUTPUT.PUT_LINE('Total cumpleaños : '||v_cont);
END Felicitar;
/
Procedimiento creado
EXEC Felicitar;

Resultado:
Calvo Jimenez, Alberto              * 31/10/1995
Calvo Rey, Ana * 14/03/2015
Cabrera Alava, Kilian               * 10/12/1996
Cabrera Santos, Elvira * 19/05/2016 * Felicidades
Cabrera Alava, Kilian               * 10/12/1996
Cabrera Santos, Kilian * 28/07/2016
Camacho Lindsey, Daniel             * 06/12/1995
Camacho Rey, Jesus * 19/05/2015 * Felicidades
Arias Grillo, Jairo                 * 15/11/1986
Arias Calvo, Mateo * 06/03/2014
Del Junco Suarez, Malvina           * 26/08/1987
Ruiz Del Junco, Juan * 12/12/2005
Montane Rodriguez, Francisco Javier * 24/01/1979
*
Gallego Carvajal, Juan              * 22/04/1993
*
Punta Perez, Gonzalo                * 25/12/1994
*
Conde Alvarez, Jose Antonio         * 19/05/1987 * Felicidades
*
Jimenez Campos, Alejandro           * 18/01/1988
*
Pozo Martin, Ismael                 * 06/08/1998
*
Fernandez Benito, Javier            * 12/02/1979
*
Pineda Santos, Jose Manuel          * 19/09/1996
*
Pires Barranco, Amador Claudio      * 07/04/1995
*
Menacho Cabo, Pedro Jose            * 16/12/1992
*
Calderon Diaz, Daniel               * 11/01/1996
*
Reina Ramirez, Joaquin Javier       * 19/05/1992 * Felicidades
*
Rolo Vera, Luis Miguel              * 13/09/1993
*
Gomez Alba, Gonzalo                 * 04/11/1997
*
Gil Campos, David                   * 29/06/1997
*
Rufo Rodriguez, Alejandro           * 31/03/1995
*
Garcia Vazquez, Jose Manuel         * 10/02/1997
*
Arnaldos Valle, Javier              * 05/08/1995
*
Matito Lozano, Carmen               * 09/01/1989
*
Gata Masero, Carlos                 * 19/05/1997 * Felicidades
*
Jimenez Garcia, Jose Manuel         * 01/01/1997
*
Toscano Fernandez, Juan             * 29/12/1997
*
Perez Alvarez, Javier               * 30/03/1991
*
Leon Vazquez, Rafael                * 19/05/1989 * Felicidades
*
Marquez Funes, Marcos               * 27/09/1997
*
Avila Ferrete, Raquel Maria         * 12/04/1997
*
Montes Rodriguez, Victor            * 06/03/1993
*
Valverde Gallego, Enrique           * 23/07/1997
*
Rivas Barba, Miguel                 * 29/03/1994
*
Mendizabal Romero, Luis             * 04/12/1996
*
Total cumpleaños :

************************************************************************
3.- Diseña el procedimiento "ModComision" que establezca la comisión de los empleados que trabajan en los centros:
	- "Fabrica", el 10% de su salario.
	- "Oficinas", el 15%. 
	- "Direccion", un 20%. 
	Los empleados con hijos tendrán un incremento de 1.000 euros en la comisión por cada hijo.


Código:

Resultado:

************************************************************************
4.- Diseña el procedimiento "ListarDpto" que acepte como parámetro el código de un departamento y muestre un listado con la siguiente estructura, donde "Total" será la suma del salario más la comisión:

Departamento Director                    Centro  Presupuesto
------------ --------------------------- ------- -----------
Jefatura 	 Avila Ferrete, Raquel Maria Fabrica     6200000

Empleado                            Salario Comision Total
----------------------------------- ------- -------- -------
Avila Ferrete, Raquel Maria         5000000	    6500 5006500
Gata Masero, Carlos                 5000000     1500 5001500
Montane Rodriguez, Francisco Javier 5000000     3300 5003300
Rufo Rodriguez, Alejandro           5000000     7000 5007000


Código:


************************************************************************
5.- Diseña el procedimiento "ListarTodo" que haga un listado de los datos de todos los departamentos con la estructura del listado anterior.


Código:
CREATE OR REPLACE PROCEDURE ListarTodo
IS
	CURSOR c_dep IS
	SELECT NOMB_DE,DIRECTOR_DE,NOMB_CE,PRESUP_DE 
	FROM DEPARTAMENTOS,CENTROS 
	WHERE CENTRO_DE = COD_CE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Nombre	Director   Centro   Presupuesto');
	DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------------');
	FOR reg IN c_dep LOOP
		DBMS_OUTPUT.PUT_LINE(reg.NOMB_DE||' '||reg.DIRECTOR_DE||' '||reg.NOMB_CE||' '||reg.PRESUP_DE);
END LOOP;
END ListarTodo;
/ 


Resultado:
Nombre          Director        Centro   Presupuesto
----------------------------------------------
Administracion          5               Oficinas                14000000




************************************************************************