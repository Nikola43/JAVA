TIPO B

Nombre: <Pon aquí tu nombre>

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

1.- Crea la función "Cumple" que se le pase como parámetro una fecha y que devuelva TRUE o FALSE si hoy
 fuera el cumpleaños de alguien nacido en esa fecha.

Código:
create or replace FUNCTION Cumple(fecha DATE)
	RETURN BOOLEAN
AS
BEGIN
	IF TO_CHAR(SYSDATE,'MM') = TO_CHAR(fecha,'MM') AND 
		TO_CHAR(SYSDATE,'DD') = TO_CHAR(fecha,'DD') THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END Cumple;
/

DECLARE
  FECHA DATE;
  v_Return BOOLEAN;
BEGIN
  FECHA := NULL;

  v_Return := CUMPLE(
    FECHA => FECHA
  );
  /* Legacy output: 
IF (v_Return) THEN 
    DBMS_OUTPUT.PUT_LINE('v_Return = ' || 'TRUE');
  ELSE
    DBMS_OUTPUT.PUT_LINE('v_Return = ' || 'FALSE');
  END IF;
*/ 
  --:v_Return := v_Return;
--rollback; 
END;
/


************************************************************************
2.- Diseña el procedimiento "Felicitar" que genere un listado en el que se vea cada empleado 
con sus hijos (si los tiene) indicando "Felicidades" a aquellos (empleados o hijos) que
cumplan aos, indicando el total de personas que cumplen años.

	Ej.:
		Segura Viudas, Santiago	12/12/90		Felicidades	
		Rivera Calvete, José Mª	02/06/65
			Rivera López, Jorge	24/04/00
			Rivera López, Victoria	13/08/01
		Conan Bárbaro, Mari	12/06/60
			Lopera Conan, Alfonso	12/12/85	Felicidades

		Total cumpleaños: 2


Código:

CREATE OR REPLACE PROCEDURE Felicitar
AS
	v_fecha	DATE;
	v_nombre empleados.nomb_em%TYPE;
	v_felic	VARCHAR2(40);
	v_contar	NUMBER(3) := 0;
	CURSOR c_emple IS 
		SELECT nomb_em, fecnac_em, cod_em, numhij_em
		FROM empleados;
	CURSOR c_hijo (padre empleados.cod_em%TYPE) IS 
		SELECT nomb_hi, fecnac_hi
		FROM hijos
		WHERE padre_hi = padre;
BEGIN
	FOR reg IN c_emple LOOP
		nombre
	
	
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurrió un error: '||SQLCODE);
END Felicitar;
/


Resultado:

************************************************************************

3.- Diseña el procedimiento "ModComision" que establezca la comisión de los empleados que trabajan en los centros:
	- "Fabrica", el 10% de su salario.
	- "Oficinas", el 15%. 
	- "Direccion", un 20%. 
	Los empleados con hijos tendrán un incremento de 1.000 euros en la comisión por cada hijo.


Código:

CREATE OR REPLACE PROCEDURE ModComision
AS
	--inicializar variable a 0
	v_contar  NUMBER(10):=0;
	CURSOR c_emple IS 
	SELECT SALARIO_EM SALARIO, NUMHIJ_EM HIJOS, NOMB_CE CENTRO
	FROM EMPLEADOS E,DEPARTAMENTOS D, CENTROS C
	WHERE E.DEPT_EM = D.COD_DE AND D.CENTRO_DE = C.COD_CE
	FOR UPDATE OF COMISION_EM;
	
	
BEGIN
	FOR reg IN c_emple LOOP
		IF reg.NOMB_CE = 'Fabrica' THEN
			v_contar := reg.SALARIO_EM * 0.10;
		ELSIF reg.NOMB_CE = 'Oficinas' THEN
			v_contar := reg.SALARIO_EM * 0.15;
		ELSIF reg.NOMB_CE = 'Direccion' THEN
			v_contar := reg.SALARIO_EM * 0.20;	
		END IF;
		v_contar := v_contar + reg.NUMHIJ_EM * 1000;
		UPDATE EMPLEADOS 
			SET COMISION_EM = v_contar
			WHERE CURRENT OF c_emple;
	END LOOP;
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurrió un error: '||SQLCODE);
		ROLLBACK;
END ModComision;
/

SELECT COD_EM, SALARIO_EM, NUMHIJ_EM, COMISION_EM FROM EMPLEADOS;

Resultado:

************************************************************************
4.- Diseña el procedimiento "ListarDpto" que acepte como parámetro el código de un departamento y muestre un listado con 
la siguiente estructura, donde "Total" será la suma del salario más la comisión:

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

CREATE OR REPLACE PROCEDURE ListarDpto(p_codDepart DEPARTAMENTOS.COD_DE%TYPE)

AS
	v_total NUMBER(10)
	
	CURSOR c_emple (p_depart EMPLEADOS,DEPT_EM%TYPE) IS 
	SELECT NOMB_EM "EMPLEADO", SALARIO_EM "SALARIO", COMISION_EM "COMISION"
	FROM EMPLEADOS
	WHERE DEPT_EM = p_depart;	
	
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
		DBMS_OUTPUT.PUT_LINE('Ocurrió un error: '||SQLCODE);
END ListarDpto;
/

Resultado:

************************************************************************

5.- Diseña el procedimiento "ListarTodo" que haga un listado de los datos de todos los departamentos con la estructura del 
listado anterior.


Código:
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
		DBMS_OUTPUT.PUT_LINE('Ocurrió un error: '||SQLCODE);
END ListarTodo;
/

exec ListarTodo;

Resultado:

************************************************************************
1A.- Dise�a el procedimiento "ModComision" que establezca la comisi�n de los empleados que trabajan en los centros de:
	- "Madrid", el 10% de su salario.
	- "Sevilla", el 15%. 
	- "Huelva", un 20%. 
	Todos empleados tendr�n un incremento de 100 euros en la comisi�n por cada a�o de antig�edad en la empresa.

C�digo:

CREATE OR REPLACE PROCEDURE ModComision1
AS
	cant	NUMBER(10);
	CURSOR c_emple IS 
		SELECT salario_em, fecinc_em, POBLAC_CE
		FROM empleados, departamentos, centros
		WHERE dept_em = cod_de AND centro_de = cod_ce
		FOR UPDATE OF comision_em;
BEGIN
	FOR v_emp IN c_emple LOOP
		IF v_emp.POBLAC_CE= 'Madrid' THEN
			cant := v_emp.salario_em * 0.10;
		ELSIF  v_emp.POBLAC_CE= 'Sevilla' THEN
			cant := v_emp.salario_em * 0.15;
		ELSIF  v_emp.POBLAC_CE= 'Huelva' THEN
			cant := v_emp.salario_em * 0.20;
		END IF;
		cant := cant + trunc(months_between(sysdate,v_emp.fecinc_em)/12) * 100;
		UPDATE empleados SET comision_em = cant
			WHERE CURRENT OF c_emple;
	END LOOP;
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '||SQLCODE);
		ROLLBACK;
END ModComision1;
/

*******************************************************************
2.- Dise�a el procedimiento "ListarCentro" que acepte como par�metro el c�digo de un centro y muestre un listado con la
 siguiente estructura, donde la "Masa salarial" ser� la suma de los salrios de los empleados de ese departamento:

Centro    Director                         Poblacion
--------- -------------------------------- ---------
Direccion Del Junco Suarez, Malvina           Madrid
-
Cod Departamento    Director                    Masa salarial
--- --------------- --------------------------- -------------
200 Informatica     Del Junco Suarez, Malvina        23600000
300 Investigacion   Calderon Diaz, Daniel            18000000


CREATE OR REPLACE PROCEDURE ListarDpto
(p_codCentro Centros.cod_ce%TYPE)
AS

	tot	NUMBER(10);
	CURSOR c_DPTO (p_centro Centros.cod_ce%TYPE)IS 
		SELECT nomb_em, CENTRO_DE, salario_em
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
