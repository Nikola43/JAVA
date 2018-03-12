TIPO B

Nombre: <Pon aqu� tu nombre>

************************************************************************
	INSTRUCCIONES:
	==============

-Salva este fichero con las iniciales de tu nombre y apellidos,
 en el directorio "C:\ALUMNOS\ ":
	Ejemplo:	Jos� Mar�a Rivera Calvete
			JMRC.sql

-Pon tu nombre al ejercicio y lee atentamente todas las preguntas.

-Entra en "SQL Plus" con:
	usuario: 	HR
	contrase�a:	HR

-Carga el script para el examen desde el fichero "Empresa.sql".

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en la recuperaci�n tendr�s otra oportunidad.

	PUNTUACI�N
	==========
- Cada pregunta: 	 2 puntos

- Se considerar� para la evaluaci�n:
	- Que funcione
	- Estilo de programaci�n 
	- Tratamiento de excepciones
	- C�digo reutilizable y param�trico

************************************************************************

	Descripci�n de las tablas:
	==========================

CENTROS
-------
# COD_CE		NUMBER(2)		C�digo del Centro
* DIRECTOR_CE	NUMBER(6)		Director del Centro
  NOMB_CE		VARCHAR2(30)	Nombre del Centro (O)
  DIRECC_CE		VARCHAR2(50)	Direcci�n del Centro (O)
  POBLAC_CE		VARCHAR2(15)	Poblaci�n del Centro (O)

DEPARTAMENTOS
-------------
# COD_DE		NUMBER(3)		C�digo del Departamento
* DIRECTOR_DE	NUMBER(6)		Director del Departamento
* DEPTJEFE_DE	NUMBER(3)		Departamento del que depende
* CENTRO_DE		NUMBER(2)		Centro trabajo (O)
  NOMB_DE		VARCHAR2(40)	Nombre del Departamento (O)
  PRESUP_DE		NUMBER(11)		Presupuesto del Departamento (O)
  TIPODIR_DE	CHAR(1)			Tipo de Director del Departamento (O)

EMPLEADOS
---------
# COD_EM		NUMBER(6)		C�digo del Empleado
* DEPT_EM		NUMBER(3)		Departamento del Empleado (O)
  EXTTEL_EM		CHAR(9)			Extensi�n telef�nica
  FECINC_EM		DATE			Fecha de incorporaci�n del Empleado (O)
  FECNAC_EM		DATE			Fecha de nacimiento del Empleado (O)
  DNI_EM		VARCHAR2(9)		DNI del Empleado (U)
  NOMB_EM		VARCHAR2(40)	Nombre del Empleado (O)
  NUMHIJ_EM		NUMBER(2)		N�mero de hijos del Empleado (O)
  SALARIO_EM	NUMBER(9)		Salario Anual del Empleado (O)
  COMISION_EM	NUMBER(9)		Comisi�n del Empleado

HIJOS
-----
#*PADRE_HI		NUMBER(6)		C�digo del Empleado
# NUMHIJ_HI		NUMBER(2)		N�mero del hijo del Empleado
  FECNAC_HI		DATE			Fecha de nacimiento del Hijo (O)
  NOMB_HI		VARCHAR2(40)	Nombre del Hijo (O)



Nota: 
	# PRIMARY KEY
	* FOREIGN KEY
	(O) Obligatorio
	(U) �nico

************************************************************************

1.- Crea la funci�n "Cumple" que se le pase como par�metro una fecha y que devuelva TRUE o FALSE si hoy fuera el cumplea�os de alguien nacido en esa fecha.

C�digo:
CREATE OR REPLACE FUNCTION Cumple2
( fecha IN DATE) RETURN BOOLEAN
AS 
	felicita BOOLEAN; --Variable de retorno
BEGIN
	IF TO_CHAR(SYSDATE,'MM') = TO_CHAR(fecha,'MM') AND 
		TO_CHAR(SYSDATE,'DD') = TO_CHAR(fecha,'DD') THEN
		felicita := TRUE;
	ELSE
		felicita := FALSE;
	END IF;
	RETURN felicita;
END Cumple2;
/


************************************************************************


2.- Dise�a el procedimiento "Felicitar" que genere un listado en el que se vea cada empleado con sus hijos 
(si los tiene) indicando "Felicidades" a aquellos (empleados o hijos) que cumplan a�os, indicando el total de 
personas que cumplen a�os.

	Ej.:
		Segura Viudas, Santiago	12/12/90		Felicidades	
		Rivera Calvete, Jos� M�	02/06/65
			Rivera L�pez, Jorge	24/04/00
			Rivera L�pez, Victoria	13/08/01
		Conan B�rbaro, Mari	12/06/60
			Lopera Conan, Alfonso	12/12/85	Felicidades

		Total cumplea�os: 2


C�digo:

CREATE OR REPLACE PROCEDURE Felicitar
AS

	fecha	DATE;
	nombre	empleados.nomb_em%TYPE;
	felic	VARCHAR2(40);
	contar	NUMBER(3) := 0;
	CURSOR c_emple IS 
		SELECT nomb_em, fecnac_em, cod_em, numhij_em
		FROM empleados;
	CURSOR c_hijo (padre empleados.cod_em%TYPE) IS 
		SELECT NOMB_HI, fecnac_hi
		FROM hijos
		WHERE padre_hi = padre;
BEGIN
	FOR v_emple IN c_emple LOOP 
		nombre := v_emple.nomb_em;
		fecha  := v_emple.fecnac_em;
		IF cumple(fecha) THEN
			felic := '*             Felicidades';
			contar := contar + 1;
		ELSE
			felic := NULL;
		END IF;
		DBMS_OUTPUT.PUT_LINE('-> '||nombre||' '||fecha||felic);
		IF v_emple.numhij_em > 0 THEN
		  FOR v_hijo IN c_hijo(v_emple.cod_em) LOOP
			nombre := v_hijo.nomb_hi;
			fecha  := v_hijo.fecnac_hi;
			IF cumple(fecha) THEN
				felic := '*             Felicidades';
				contar := contar + 1;
			ELSE
				felic := NULL;
			END IF;
			DBMS_OUTPUT.PUT_LINE('-h    -> '||nombre||' '||fecha||felic);
		  END LOOP;
		END IF;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Total cumplea�os: '||contar);
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '||SQLCODE);
END Felicitar;
/


Resultado:

************************************************************************

3.- Dise�a el procedimiento "ModComision" que establezca la comisi�n de los empleados que trabajan en los centros:
	- "Fabrica", el 10% de su salario.
	- "Oficinas", el 15%. 
	- "Direccion", un 20%. 
	Los empleados con hijos tendr�n un incremento de 1.000 euros en la comisi�n por cada hijo.


C�digo:

CREATE OR REPLACE PROCEDURE ModComision
AS
	cant	NUMBER(10);
	CURSOR c_emple IS 
		SELECT salario_em, numhij_em, nomb_ce
		FROM empleados, departamentos, centros
		WHERE dept_em = cod_de AND centro_de = cod_ce
		FOR UPDATE OF comision_em;
BEGIN
	FOR v_emp IN c_emple LOOP
		IF v_emp.nomb_ce= 'Fabrica' THEN
			cant := v_emp.salario_em * 0.10;
		ELSIF  v_emp.nomb_ce= 'Oficinas' THEN
			cant := v_emp.salario_em * 0.15;
		ELSIF  v_emp.nomb_ce= 'Direccion' THEN
			cant := v_emp.salario_em * 0.20;
		END IF;
		cant := cant + v_emp.numhij_em * 1000;
		UPDATE empleados SET comision_em = cant
			WHERE CURRENT OF c_emple;
	END LOOP;
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '||SQLCODE);
		ROLLBACK;
END ModComision;
/

SELECT COD_EM, SALARIO_EM, NUMHIJ_EM, COMISION_EM FROM EMPLEADOS;

Resultado:

************************************************************************
4.- Dise�a el procedimiento "ListarDpto" que acepte como par�metro el c�digo de un departamento y muestre un listado con la siguiente 
estructura, donde "Total" ser� la suma del salario m�s la comisi�n:

Departamento Director                    Centro  Presupuesto
------------ --------------------------- ------- -----------
Jefatura 	 Avila Ferrete, Raquel Maria Fabrica     6200000

Empleado                            Salario Comision Total
----------------------------------- ------- -------- -------
Avila Ferrete, Raquel Maria         5000000	    6500 5006500
Gata Masero, Carlos                 5000000     1500 5001500
Montane Rodriguez, Francisco Javier 5000000     3300 5003300
Rufo Rodriguez, Alejandro           5000000     7000 5007000


C�digo:

CREATE OR REPLACE PROCEDURE ListarDpto
(p_depart departamentos.cod_de%TYPE)
AS

	tot	NUMBER(10);
	CURSOR c_emple (p_dep empleados.dept_em%TYPE)IS 
		SELECT nomb_em, comision_em, salario_em
		FROM empleados
		WHERE dept_em = p_dep;
	CURSOR c_dept (p_dep departamentos.cod_de%TYPE)IS 
		SELECT nomb_de, nomb_em director, presup_de, nomb_ce
		FROM departamentos, empleados, centros
		WHERE cod_de = p_dep AND centro_de = cod_ce AND director_de = cod_em;
	v_de 	c_dept%ROWTYPE;
	no_existe_dept 	EXCEPTION;
BEGIN
	OPEN 	c_dept(p_depart);
	FETCH 	c_dept INTO v_de;
	-- Comprobar si existe el dpto
	IF c_dept%ROWCOUNT = 0 THEN
		RAISE no_existe_dept;
	END IF;
	CLOSE 	c_dept;
	DBMS_OUTPUT.PUT_LINE('Departamento Director                    Centro  Presupuesto');
	DBMS_OUTPUT.PUT_LINE('------------ --------------------------- ------- -----------');
	DBMS_OUTPUT.PUT_LINE(v_de.nomb_de||' '||v_de.director||' '||v_de.nomb_ce||' '||v_de.presup_de);
	DBMS_OUTPUT.PUT_LINE('-');
	DBMS_OUTPUT.PUT_LINE('Empleado                            Salario Comision Total');
	DBMS_OUTPUT.PUT_LINE('----------------------------------- ------- -------- -------');
	FOR v_emp IN c_emple(p_depart) LOOP
		tot := v_emp.salario_em+NVL(v_emp.comision_em,0);
		DBMS_OUTPUT.PUT_LINE(v_emp.nomb_em||' '||v_emp.salario_em||' '||NVL(v_emp.comision_em,0)||' '||tot);
	END LOOP;
EXCEPTION
	WHEN no_existe_dept	THEN
		DBMS_OUTPUT.PUT_LINE('No existe '||p_depart);
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '||SQLCODE);
END ListarDpto;
/

Resultado:

************************************************************************

5.- Dise�a el procedimiento "ListarTodo" que haga un listado de los datos de todos los departamentos con la estructura del listado anterior.


C�digo:
CREATE OR REPLACE PROCEDURE ListarTodo
AS
	CURSOR c_dept  IS 
		SELECT cod_de
		FROM departamentos;
		
BEGIN
	FOR v_dep IN c_dept LOOP
		DBMS_OUTPUT.PUT_LINE('-');
		DBMS_OUTPUT.PUT_LINE('-     Departamento cod: ' || v_dep.cod_de);
		--ListarDpto(v_dep.cod_de);
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '||SQLCODE);
END ListarTodo;
/

exec ListarTodo;

Resultado:

************************************************************************