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
IS
	CURSOR c_emple IS 
		SELECT E.NOMB_EM,E.NUMHIJ_EM, E.COD_EM, E.FECNAC_EM 
		FROM EMPLEADOS E;
	CURSOR c_hijos (padre EMPLEADOS.COD_EM %TYPE)IS
		SELECT H.FECNAC_HI, H.NOMB_HI 
		FROM HIJOS H
		WHERE PADRE_HI=padre; 
	
	v_nombre EMPLEADOS.NOMB_EM%TYPE;
	v_fecha DATE;
	v_cont  NUMBER :=0;
	v_felicidades NUMBER;
	
BEGIN
	FOR p_reg IN c_emple LOOP
		v_nombre:=p_reg.NOMB_EM;
		v_fecha:=p_reg.FECNAC_EM;
		IF Cumple2(v_fecha) THEN
			v_felicidades:= '                  FELICIDADES';
			v_cont:= v_cont+1;
		ELSE
			v_felicidades:=NULL;
		END IF;
		DBMS_OUTPUT.PUT_LINE('-> '||v_nombre||' '||v_fecha||v_felicidades);
		IF p_reg.NUMHIJ_EM > 0 THEN
			FOR h_reg IN c_hijos(p_reg.COD_EM) LOOP
				v_nombre:=h_reg.NOMB_HI;
				v_fecha:=h_reg.FECNAC_HI;
				IF Cumple2(v_fecha) THEN
						v_felicidades:= '                  FELICIDADES';
						v_cont:= v_cont+1;
				ELSE
				v_felicidades:=NULL;
				END IF;
				DBMS_OUTPUT.PUT_LINE('-> '||v_nombre||' '||v_fecha||v_felicidades);
			END LOOP;	
		END IF;		
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Total cumplea�os: '||v_cont);
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
 IS
    v_cant NUMBER;
    CURSOR c_emp IS
      SELECT E.SALARIO_EM, E.NUMHIJ_EM, C.NOMB_CE 
      FROM EMPLEADOS E, DEPARTAMENTOS D, CENTROS C
      WHERE C.COD_CE = D.CENTRO_DE AND D.COD_DE=E.DEPT_EM
      FOR UPDATE OF COMISION_EM;
BEGIN
	FOR reg IN c_emp LOOP
      IF reg.NOMB_CE = 'Fabrica'THEN				
        v_cant:= reg.SALARIO_EM * 0.10;		
      ELSIF  reg.NOMB_CE = 'Oficinas'THEN	
        v_cant:= reg.SALARIO_EM * 0.15;
      ELSIF  reg.NOMB_CE = 'Direccion'THEN	
        v_cant:= reg.SALARIO_EM * 0.20;
      END IF;
        v_cant:=v_cant + reg.NUMHIJ_EM * 1.000;
        UPDATE EMPLEADOS SET COMISION_EM = v_cant
        WHERE CURRENT OF c_emp;		
	END LOOP;
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN 
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '||SQLCODE);
		ROLLBACK;
END ModComision;
/

Resultado:

************************************************************************
4.- Dise�a el procedimiento "ListarDpto" que acepte como par�metro el c�digo de un departamento y muestre un listado con
 la siguiente estructura, donde "Total" ser� la suma del salario m�s la comisi�n:

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
(p_cod_depto DEPARTAMENTOS.COD_DE%TYPE)
IS
	v_total NUMBER;
	CURSOR c_emple IS
		SELECT 
	
	
	
BEGIN
	FOR p_reg IN c_emple LOOP
		v_nombre:=p_reg.NOMB_EM;
		v_fecha:=p_reg.FECNAC_EM;
		IF Cumple2(v_fecha) THEN
			v_felicidades:= '                  FELICIDADES';
			v_cont:= v_cont+1;
		ELSE
			v_felicidades:=NULL;
		END IF;
		DBMS_OUTPUT.PUT_LINE('-> '||v_nombre||' '||v_fecha||v_felicidades);
		IF p_reg.NUMHIJ_EM > 0 THEN
			FOR h_reg IN c_hijos(p_reg.COD_EM) LOOP
				v_nombre:=h_reg.NOMB_HI;
				v_fecha:=h_reg.FECNAC_HI;
				IF Cumple2(v_fecha) THEN
						v_felicidades:= '                  FELICIDADES';
						v_cont:= v_cont+1;
				ELSE
				v_felicidades:=NULL;
				END IF;
				DBMS_OUTPUT.PUT_LINE('-> '||v_nombre||' '||v_fecha||v_felicidades);
			END LOOP;	
		END IF;		
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Total cumplea�os: '||v_cont);
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '||SQLCODE);
END ListarDpto;
/
Resultado:

************************************************************************

5.- Dise�a el procedimiento "ListarTodo" que haga un listado de los datos de todos los departamentos con la estructura del listado anterior.


C�digo:


Resultado:

************************************************************************