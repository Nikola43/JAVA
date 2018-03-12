TIPO A

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
1.- Dise�a el procedimiento "ModComision" que establezca la comisi�n de los empleados que trabajan en los centros de:
	- "Madrid", el 10% de su salario.
	- "Sevilla", el 15%. 
	- "Huelva", un 20%. 
	Todos empleados tendr�n un incremento de 100 euros en la comisi�n por cada a�o de antig�edad en la empresa.

C�digo:

CREATE OR REPLACE PROCEDURE ModComision
AS
	cant	NUMBER(10);
	CURSOR c_emple IS 
		SELECT salario_em, poblac_ce, fecinc_em
		FROM empleados, departamentos, centros
		WHERE dept_em = cod_de AND centro_de = cod_ce
		FOR UPDATE OF comision_em;
BEGIN
	FOR v_emp IN c_emple LOOP
		IF v_emp.poblac_ce= 'Madrid' THEN
			cant := v_emp.salario_em * 0.10;
		ELSIF  v_emp.poblac_ce= 'Sevilla' THEN
			cant := v_emp.salario_em * 0.15;
		ELSIF  v_emp.poblac_ce= 'Huelva' THEN
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
END ModComision;
/

SELECT COD_EM, SALARIO_EM, NUMHIJ_EM, COMISION_EM FROM EMPLEADOS;

Resultado:

************************************************************************
2.- Dise�a el procedimiento "ListarCentro" que acepte como par�metro el c�digo de un centro y muestre un listado con la siguiente estructura, donde la "Masa salarial" ser� la suma de los salrios de los empleados de ese departamento:

Centro    Director                         Poblacion
--------- -------------------------------- ---------
Direccion Del Junco Suarez, Malvina           Madrid
-
Cod Departamento    Director                    Masa salarial
--- --------------- --------------------------- -------------
200 Informatica     Del Junco Suarez, Malvina        23600000
300 Investigacion   Calderon Diaz, Daniel            18000000


C�digo:

CREATE OR REPLACE PROCEDURE ListarCentro
(p_centro Centros.cod_ce%TYPE)
AS
	CURSOR c_dpto (p_centro Centros.cod_ce%TYPE) IS 
		SELECT cod_de, nomb_de, nomb_em
		FROM empleados, departamentos
		WHERE director_de = cod_em AND centro_de = p_centro;
	salarios	NUMBER(10);
	CURSOR c_centro (p_centro Centros.cod_ce%TYPE) IS 
		SELECT nomb_ce, nomb_em director, poblac_ce
		FROM empleados, centros
		WHERE director_ce = cod_em AND cod_ce = p_centro;
	v_centro 	c_centro%ROWTYPE;
	no_existe_dept 	EXCEPTION;
BEGIN
	OPEN 	c_centro(p_centro);
	FETCH 	c_centro INTO v_centro;
	-- Comprobar si existe el dpto
	IF c_centro%ROWCOUNT = 0 THEN
		RAISE no_existe_dept;
	END IF;
	CLOSE 	c_centro;
	DBMS_OUTPUT.PUT_LINE('Centro    Director                         Poblacion');
	DBMS_OUTPUT.PUT_LINE('--------- -------------------------------- ---------');
	DBMS_OUTPUT.PUT_LINE(v_centro.nomb_ce||' '||v_centro.director||' '||v_centro.poblac_ce);
	DBMS_OUTPUT.PUT_LINE('-');
	DBMS_OUTPUT.PUT_LINE('Cod Departamento    Director                       Masa salarial');
	DBMS_OUTPUT.PUT_LINE('--- --------------- ------------------------------ -------------');
	FOR v_dpto IN c_dpto(p_centro) LOOP
		SELECT SUM(Salario_em) INTO salarios
		FROM EMPLEADOS WHERE dept_em = v_dpto.cod_de;
		DBMS_OUTPUT.PUT_LINE(v_dpto.cod_de||' '||RPAD(v_dpto.nomb_de,15)||' '||v_dpto.nomb_em||' '||salarios);
	END LOOP;
EXCEPTION
	WHEN no_existe_dept	THEN
		DBMS_OUTPUT.PUT_LINE('No existe '||p_centro);
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '||SQLCODE);
END ListarCentro;
/
 exec ListarCentro(10);
Resultado:

************************************************************************
3.- Dise�a el procedimiento "Listar" que haga un listado de los datos de todos los centros con la estructura del listado anterior.


C�digo:
CREATE OR REPLACE PROCEDURE Listar
AS
	CURSOR c_centro  IS 
		SELECT cod_ce
		FROM centros;
BEGIN
	FOR reg IN c_centro LOOP
		DBMS_OUTPUT.PUT_LINE('-');
		DBMS_OUTPUT.PUT_LINE('-     Centro cod: ' || reg.cod_ce);
		ListarCentro(reg.cod_ce);
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '||SQLCODE);
END Listar;
/

exec Listar;

Resultado:

************************************************************************************************************************************************
4.- Crea la funci�n "Aniversario" que se le pase como par�metro una fecha y que devuelva TRUE o FALSE si hoy fuera el aniversario algo que ocurri� en esa fecha.

C�digo:
CREATE OR REPLACE FUNCTION Aniversario
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
END Aniversario;
/


************************************************************************
5.- Dise�a el procedimiento "ListarAniversario" que genere un listado en el que se vea cada empleado con su fecha de incorporaci�n a la empresa indicando "Aniversario" a aquellos empleados  que hoy sea el aniversario de su incorporaci�n a la empresa, indicando el total de personas que lo cumplen.

	Ej.:
		Segura Viudas, Santiago	19/05/90		Aniversario	
		Rivera Calvete, Jos� M�	02/06/95
		Conan B�rbaro, Mari		12/06/99

		Total Aniversario: 1


C�digo:

CREATE OR REPLACE PROCEDURE ListarAniversario
AS
	felic	VARCHAR2(40);
	contar	NUMBER(3) := 0;
	CURSOR c_emple IS 
		SELECT nomb_em, fecinc_em
		FROM empleados;
BEGIN
	FOR reg IN c_emple LOOP 
		IF Aniversario(reg.fecinc_em) THEN
			felic := '*             Aniversario';
			contar := contar + 1;
		ELSE
			felic := NULL;
		END IF;
		DBMS_OUTPUT.PUT_LINE('-> '||reg.nomb_em||' '||reg.fecinc_em||felic);
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Total Aniversario: '||contar);
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '||SQLCODE);
END ListarAniversario;
/


Resultado:

