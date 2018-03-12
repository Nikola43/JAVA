----------------------------------------------------------------
-- 1. Desarrollar un procedimiento que visualice el apellido y la fecha de alta de todos los empleados ordenados por apellido.
Solución:
CREATE OR REPLACE PROCEDURE ver_emple1
AS
	CURSOR c_emple IS 
		SELECT APELLIDO, FECHA_ALT
		FROM EMPLE
		ORDER BY APELLIDO;
	v_apellido VARCHAR2(10);
	v_fecha DATE;
BEGIN
	OPEN c_emple;
	FETCH c_emple into v_apellido, v_fecha;
	WHILE c_emple%FOUND LOOP
		DBMS_OUTPUT.PUT_LINE( v_apellido||' * '||v_fecha);
		FETCH c_emple into v_apellido,v_fecha; 
	END LOOP;
	CLOSE c_emple;
END ver_emple1;
/

CREATE OR REPLACE PROCEDURE ver_emple2
AS
	CURSOR c_emple IS 
		SELECT APELLIDO, FECHA_ALT
		FROM EMPLE
		ORDER BY APELLIDO;
BEGIN
	FOR registro IN c_emple LOOP
		DBMS_OUTPUT.PUT_LINE( registro.APELLIDO||' * '||registro.FECHA_ALT);
	END LOOP;
END ver_emple2;
/

----------------------------------------------------------------
-- 2. Codificar un procedimiento que muestre el nombre de cada departamento y el número de empleados que tiene.
Solución:
CREATE OR REPLACE PROCEDURE ver_emple_depart
AS
	CURSOR c_emple IS 
		SELECT dnombre, COUNT(emp_no) num_emple
		FROM emple e, depart d
		WHERE d.dept_no = e.dept_no(+) -- Por si el dpto no tiene empleados, que aparezca
		GROUP BY dnombre;
BEGIN
	FOR reg IN c_emple LOOP
		DBMS_OUTPUT.PUT_LINE(reg.dnombre||' * '||reg.num_emple);
	END LOOP;
END ver_emple_depart;


----------------------------------------------------------------
-- 3. Escribir un procedimiento que reciba una cadena y visualice el apellido y el número de empleado de todos los empleados cuyo apellido contenga la cadena especificada. Al finalizar visualizar el número de empleados mostrados.
Solución:
CREATE OR REPLACE PROCEDURE ver_emple_apell(cadena VARCHAR2)
AS
	busqueda VARCHAR2(10);
	CURSOR c_emple IS 
		SELECT apellido, emp_no 
		FROM emple
		WHERE apellido LIKE busqueda;
	vr_emple c_emple%ROWTYPE;
BEGIN
	busqueda :='%'||cadena||'%';
	OPEN c_emple;
	FETCH c_emple INTO vr_emple;
	WHILE (c_emple%FOUND) LOOP
		DBMS_OUTPUT.PUT_LINE(vr_emple.emp_no||' * '||vr_emple.apellido);
		FETCH c_emple INTO vr_emple; 
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('NUMERO DE EMPLEADOS: '|| c_emple%ROWCOUNT);
	CLOSE c_emple;
END ver_emple_apell;
/

CREATE OR REPLACE PROCEDURE ver_emple_apell2(cadena VARCHAR2)
AS
	total	BINARY_INTEGER;
	CURSOR c_emp (cad VARCHAR2) IS 
		SELECT apellido, emp_no 
		FROM emple
		WHERE apellido LIKE cad;
BEGIN
	FOR reg IN c_emp('%'||cadena||'%') LOOP
		DBMS_OUTPUT.PUT_LINE(reg.emp_no||' * '||reg.apellido);
		total := c_emp%ROWCOUNT;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('NUMERO DE EMPLEADOS: '|| total);
END ver_emple_apell2;
/

----------------------------------------------------------------
-- 4. Escribir un programa que visualice el apellido y el salario de los cinco empleados que tienen el salario más alto.
Solución:
CREATE OR REPLACE PROCEDURE emp_5maxsal
AS
	CURSOR c_emp IS
		SELECT apellido, salario FROM emple
		ORDER BY salario DESC;
	vr_emp c_emp%ROWTYPE;
	i NUMBER;
BEGIN
	i:=1;
	OPEN c_emp;
	FETCH c_emp INTO vr_emp;
	WHILE c_emp%FOUND AND i<=5 LOOP	
		DBMS_OUTPUT.PUT_LINE(vr_emp.apellido ||' * '|| vr_emp.salario);	    
		FETCH c_emp INTO vr_emp;
		i:=i+1;
	END LOOP;
	CLOSE c_emp;
END emp_5maxsal;
/

CREATE OR REPLACE PROCEDURE emp_5maxsal2
AS
	CURSOR c_emp IS
		SELECT apellido, salario FROM emple
		ORDER BY salario DESC;
BEGIN
	FOR reg IN c_emp LOOP
		DBMS_OUTPUT.PUT_LINE(reg.apellido ||' * '|| reg.salario);	    
		EXIT WHEN c_emp%ROWCOUNT=5;
	END LOOP;
END emp_5maxsal2;
/

CREATE OR REPLACE PROCEDURE emp_5maxsal3
AS
	CURSOR c_emp IS
		SELECT apellido, salario FROM emple
		WHERE ROWNUM <= 5
		ORDER BY salario DESC;
	BEGIN
	FOR reg IN c_emp LOOP
		DBMS_OUTPUT.PUT_LINE(reg.apellido ||' * '|| reg.salario);	    
	END LOOP;
END emp_5maxsal3;
/

----------------------------------------------------------------
-- 5. Codificar un programa que visualice los dos empleados que ganan menos de cada oficio.
Solución:
CREATE OR REPLACE PROCEDURE emp_2minsal
AS
	CURSOR c_emp IS
		SELECT apellido, oficio, salario 
		FROM emple
		ORDER BY oficio, salario;
	vr_emp c_emp%ROWTYPE;
	oficio_ant EMPLE.OFICIO%TYPE;
	i NUMBER;
BEGIN
	OPEN c_emp;
	oficio_ant:='*';
	FETCH c_emp INTO vr_emp;
	WHILE c_emp%FOUND LOOP	
		IF oficio_ant <> vr_emp.oficio THEN
			oficio_ant := vr_emp.oficio;
			i := 1;
		END IF;
		IF i <= 2 THEN
			DBMS_OUTPUT.PUT_LINE(vr_emp.oficio||' * '||vr_emp.apellido||' * '||vr_emp.salario);	    
		END IF;
		FETCH c_emp INTO vr_emp;
		i:=i+1;
	END LOOP;
	CLOSE c_emp;
END emp_2minsal;
/

CREATE OR REPLACE PROCEDURE emp_2minsal2
AS
	CURSOR c_emp IS
		SELECT apellido, oficio, salario 
		FROM emple
		ORDER BY oficio, salario;
	oficio_ant EMPLE.OFICIO%TYPE;
	i NUMBER;
BEGIN
	oficio_ant:='*';
	FOR reg IN c_emp LOOP
		IF oficio_ant <> reg.oficio THEN
			oficio_ant := reg.oficio;
			i := 1;
		END IF;
		IF i <= 2 THEN
			DBMS_OUTPUT.PUT_LINE(reg.oficio||' * '||reg.apellido||' * '||reg.salario);	    
		END IF;
		i:=i+1;
	END LOOP;
END emp_2minsal2;
/

CREATE OR REPLACE PROCEDURE emp_2minsal3
AS
	CURSOR c_emp1 IS
		SELECT distinct oficio
		FROM emple;
	CURSOR c_emp2(p_oficio emple.oficio%TYPE) IS
		SELECT apellido, oficio, salario 
		FROM emple
		WHERE oficio = p_oficio
		ORDER BY salario;
	i NUMBER;
BEGIN
	FOR reg1 IN c_emp1 LOOP
		i := 1;
		FOR reg2 IN c_emp2(reg1.oficio) LOOP
			IF i <= 2 THEN
				DBMS_OUTPUT.PUT_LINE(reg2.oficio||' * '||reg2.apellido||' * '||reg2.salario);	    
			END IF;
			i:=i+1;
		END LOOP;
	END LOOP;
END emp_2minsal3;
/

----------------------------------------------------------------
-- 6. Escribir un programa que muestre los siguientes datos:
-- Para cada empleado: apellido y salario.
-- Para cada departamento: Número de empleados y suma de los salarios del departamento.
-- Al final del listado: Número total de empleados y suma de todos los salarios.
Solución:
CREATE OR REPLACE PROCEDURE listar_emple
AS
	CURSOR c1 IS
		SELECT apellido, salario, dept_no 
		FROM emple
		ORDER BY dept_no, apellido;
	vr_emp 		c1%ROWTYPE;
	dep_ant 	EMPLE.DEPT_NO%TYPE;
	cont_emple	NUMBER(4) DEFAULT 0;
	sum_sal 	NUMBER(9) DEFAULT 0;
	tot_emple	NUMBER(4) DEFAULT 0;
	tot_sal		NUMBER(10) DEFAULT 0;
BEGIN
	OPEN c1;
	FETCH c1 INTO vr_emp;
	IF c1%FOUND THEN
		dep_ant := vr_emp.dept_no;
	END IF;
	WHILE c1%FOUND LOOP
			/* Comprobación nuevo departamento y resumen */
		IF dep_ant <> vr_emp.dept_no THEN	
			DBMS_OUTPUT.PUT_LINE('*** DEPTO: ' || dep_ant ||' NUM EMPLEADOS: '|| cont_emple ||' SUM. SALARIOS:  '||TO_CHAR(sum_sal,'9G999G999'));
			dep_ant := vr_emp.dept_no;
			tot_emple := tot_emple + cont_emple;
			tot_sal:= tot_sal + sum_sal;
			cont_emple:=0;
			sum_sal:=0; 
		END IF;
		/* Líneas de detalle */
		DBMS_OUTPUT.PUT_LINE(RPAD(vr_emp.apellido,10)|| ' * '||LPAD(TO_CHAR(vr_emp.salario,'9G999G999'),12));
		/* Incrementar y acumular */
		cont_emple := cont_emple + 1;
		sum_sal:=sum_sal + vr_emp.salario; 
		FETCH c1 INTO vr_emp;
	END LOOP;
	CLOSE c1;

	IF cont_emple > 0 THEN
	/* Escribir datos del último departamento */
		DBMS_OUTPUT.PUT_LINE('*** DEPTO: ' || dep_ant ||' NUM EMPLEADOS: '|| cont_emple ||' SUM. SALARIOS:  '||TO_CHAR(sum_sal,'9G999G999'));
 		tot_emple := tot_emple + cont_emple;
		tot_sal:= tot_sal + sum_sal;
		/* Escribir totales informe */
        DBMS_OUTPUT.PUT_LINE(' ****** NUMERO TOTAL EMPLEADOS: '||tot_emple||' TOTAL SALARIOS: '|| TO_CHAR(tot_sal,'9G999G999'));
	END IF;
END listar_emple;
/

CREATE OR REPLACE PROCEDURE listar_emple2
AS
	CURSOR c1 
	IS
		SELECT d.dept_no dpto, dnombre, COUNT(*) n_emple, SUM(salario) s_sal
		FROM depart d, emple e
		WHERE d.dept_no = e.dept_no
		GROUP BY d.dept_no, dnombre;
	CURSOR c2 (p_dpto emple.dept_no%TYPE)
	IS
		SELECT apellido, salario
		FROM emple
		WHERE dept_no = p_dpto
		ORDER BY dept_no, apellido;
	tot_emple	NUMBER(4) DEFAULT 0;
	tot_sal		NUMBER(10) DEFAULT 0;
BEGIN
	FOR reg1 IN c1 LOOP
		FOR reg2 IN c2(reg1.dpto) LOOP
			DBMS_OUTPUT.PUT_LINE(RPAD(reg2.apellido,10)|| ' * '||LPAD(TO_CHAR(reg2.salario,'9G999G999'),12));
		END LOOP;
		DBMS_OUTPUT.PUT_LINE('*** DEPTO: ' || reg1.dnombre ||' EMPLEADOS: '||reg1.n_emple ||' SUMA SALARIOS:  '||reg1.s_sal);
		tot_emple := tot_emple + reg1.n_emple;
		tot_sal := tot_sal + reg1.s_sal;
	END LOOP;
    DBMS_OUTPUT.PUT_LINE(' ****** NUMERO TOTAL EMPLEADOS: '||tot_emple||' TOTAL SALARIOS: '|| tot_sal);
END listar_emple2;
/

CREATE OR REPLACE PROCEDURE listar_emple3
AS
	CURSOR c1 
	IS
		SELECT d.dept_no dpto, dnombre, COUNT(*) n_emple, SUM(salario) s_sal
		FROM depart d, emple e
		WHERE d.dept_no = e.dept_no
		GROUP BY d.dept_no, dnombre;
	CURSOR c2 (p_dpto emple.dept_no%TYPE)
	IS
		SELECT apellido, salario
		FROM emple
		WHERE dept_no = p_dpto
		ORDER BY dept_no, apellido;
	tot_emple	NUMBER(4) DEFAULT 0;
	tot_sal		NUMBER(10) DEFAULT 0;
BEGIN
	FOR reg1 IN c1 LOOP
		FOR reg2 IN c2(reg1.dpto) LOOP
			DBMS_OUTPUT.PUT_LINE(RPAD(reg2.apellido,10)|| ' * '||LPAD(TO_CHAR(reg2.salario,'9G999G999'),12));
		END LOOP;
		DBMS_OUTPUT.PUT_LINE('*** DEPTO: ' || reg1.dnombre ||' EMPLEADOS: '||reg1.n_emple ||' SUMA SALARIOS:  '||reg1.s_sal);
	END LOOP;
	SELECT COUNT(*), SUM(SALARIO) 
		INTO tot_emple, tot_sal
		FROM EMPLE;
    DBMS_OUTPUT.PUT_LINE(' ****** NUMERO TOTAL EMPLEADOS: '||tot_emple||' TOTAL SALARIOS: '|| tot_sal);
END listar_emple3;
/


----------------------------------------------------------------
-- 7. Desarrollar un procedimiento que permita insertar nuevos departamentos según las siguientes especificaciones:
-- Se pasará al procedimiento el nombre del departamento y la localidad.
-- El procedimiento insertará la fila nueva asignando como número de departamento la decena siguiente al número mayor de la tabla.
-- Se incluirá gestión de posibles errores.
Solución:
CREATE OR REPLACE PROCEDURE insertar_depart(
	nombre_dep VARCHAR2,
	loc VARCHAR2)
AS
	CURSOR c_dep 
	IS 
		SELECT dnombre 
		FROM depart 
		WHERE dnombre = nombre_dep; 
	v_cod 		DEPART.DNOMBRE%TYPE DEFAULT NULL;
	v_ulti_num 	DEPART.DEPT_NO%TYPE;
	nombre_duplicado EXCEPTION;
BEGIN
	/* Comprobación de que el departamento no está duplicado */
	OPEN c_dep;
	FETCH c_dep INTO v_cod; 
	CLOSE c_dep;
	IF v_cod IS NOT NULL THEN
	    RAISE nombre_duplicado;
	END IF;
	/* Captura del último número y cálculo del siguiente */
     SELECT MAX(dept_no) INTO v_ulti_num FROM depart;
     /* Inserción de la nueva fila */
	INSERT INTO depart VALUES ((TRUNC(v_ulti_num, -1)+10), nombre_dep, loc);
EXCEPTION
	WHEN nombre_duplicado THEN	
		RAISE_APPLICATION_ERROR(-20010, 'Err. departamento duplicado');
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20005, 'Err. Operación cancelada');
END insertar_depart;	
/

----------------------------------------------------------------
-- 8. Escribir un procedimiento que reciba todos los datos de un nuevo empleado procese la transacción de alta, gestionando posibles errores:
-- No existe el departamento.
-- No existe el empleado jefe.
-- Si ya existía el empleado.
Solución:
CREATE OR REPLACE PROCEDURE alta_emp(
 	p_num emple.emp_no%TYPE,
	p_ape emple.apellido%TYPE,
	p_ofi emple.oficio%TYPE,
	p_jef emple.dir%TYPE,
	p_fec emple.fecha_alt%TYPE,
	p_sal emple.salario%TYPE,
	p_com emple.comision%TYPE DEFAULT NULL,
	p_dep emple.dept_no%TYPE)
AS
	v_jef EMPLE.DIR%TYPE DEFAULT NULL;
	v_dep DEPART.DEPT_NO%TYPE DEFAULT NULL;
BEGIN
	/* Comprobación de que existe el departamento */
	SELECT dept_no INTO v_dep 
		FROM depart WHERE dept_no = p_dep;
	/* Comprobación de que existe el jefe del empleado */
	SELECT emp_no INTO v_jef  
		FROM emple WHERE emp_no = p_jef;

	/* Inserción de la fila */	
	INSERT INTO EMPLE VALUES 
	(p_num, p_ape, p_ofi, p_jef, p_fec, p_sal, p_com, p_dep);

EXCEPTION
	WHEN NO_DATA_FOUND THEN
		IF v_dep IS NULL THEN
			RAISE_APPLICATION_ERROR(-20005,'Err. Departamento inexistente');
		ELSIF v_jef IS NULL THEN
			RAISE_APPLICATION_ERROR(-20005,'Err. No existe el jefe');
		ELSE 
			RAISE_APPLICATION_ERROR(-20005,'Err. Datos no encontrados(*)');
		END IF;
WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Err.numero de empleado duplicado');
		RAISE;
END alta_emp;


----------------------------------------------------------------
-- 9. Codificar un procedimiento reciba como parámetros un numero de departamento, un importe y un porcentaje; y suba el salario a todos los empleados del departamento indicado en la llamada. La subida será el porcentaje o el importe indicado en la llamada (el que sea más beneficioso para el empleado en cada caso empleado).
Solución:
CREATE OR REPLACE PROCEDURE subida_sal1(
	num_depar	emple.dept_no%TYPE,
	importe		NUMBER,
	porcentaje	NUMBER)
AS
	CURSOR c_sal IS 
		SELECT salario
		FROM emple  
		WHERE dept_no = num_depar
		FOR UPDATE OF salario;
	v_imp_pct	NUMBER(10);
BEGIN
	COMMIT;
	FOR reg IN c_sal LOOP
		/* Guardar en v_imp_pct el importe mayor */
		v_imp_pct := GREATEST((reg.salario/100)*porcentaje,importe);	   
		/* Actualizar */
		UPDATE EMPLE 
			SET SALARIO=SALARIO + v_imp_pct
			WHERE CURRENT OF c_sal;
	END LOOP;
	COMMIT;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Err. ninguna fila actualizada');
		ROLLBACK;
	WHEN OTHERS THEN
		ROLLBACK;
  
END subida_sal1;


----------------------------------------------------------------
-- 10. Escribir un procedimiento que suba el sueldo de todos los empleados que ganen menos que el salario medio de su oficio. La subida será de el 50% de la diferencia entre el salario del empleado y la media de su oficio. Se deberá asegurar que la transacción no se quede a medias, y se gestionarán los posibles errores.
Solución:

CREATE OR REPLACE PROCEDURE subida_50pct
AS
	CURSOR c_ofi_sal IS
		SELECT oficio, AVG(salario) salario 
		FROM emple
		GROUP BY oficio
		ORDER BY oficio;
	CURSOR c_emp_sal IS
		SELECT oficio, salario FROM emple E1
		WHERE salario < (SELECT AVG(salario) 
						FROM emple E2
						WHERE E2.oficio = E1.oficio)
		ORDER BY oficio, salario 
		FOR UPDATE OF salario;
	
vr_ofi_sal c_ofi_sal%ROWTYPE;
vr_emp_sal c_emp_sal%ROWTYPE;	
v_incremento emple.salario%TYPE;
	
BEGIN
	COMMIT;
	OPEN c_emp_sal;
	FETCH c_emp_sal INTO vr_emp_sal;
	OPEN c_ofi_sal;
	FETCH c_ofi_sal INTO vr_ofi_sal;
	WHILE c_ofi_sal%FOUND AND c_emp_sal%FOUND LOOP	
		/* calcular incremento */
		v_incremento :=  (vr_ofi_sal.salario - vr_emp_sal.salario) / 2;
		/* actualizar */		
		UPDATE emple SET salario = salario + v_incremento
			WHERE CURRENT OF c_emp_sal;		
		/* siguiente empleado */		
		FETCH c_emp_sal INTO vr_emp_sal;
		/* comprobar si es otro oficio */
		IF c_ofi_sal%FOUND and vr_ofi_sal.oficio <> vr_emp_sal.oficio THEN
			FETCH c_ofi_sal INTO vr_ofi_sal;
		END IF;
	END LOOP; 
	CLOSE c_emp_sal;
	CLOSE c_ofi_sal;
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
	  	ROLLBACK WORK;
		RAISE;
END subida_50pct;


CREATE OR REPLACE PROCEDURE subida_50pct2
AS
	CURSOR c_ofi_sal IS
		SELECT oficio, AVG(salario) salario 
		FROM emple
		GROUP BY oficio;
	CURSOR c_emp_sal(p_oficio emple.oficio%TYPE) IS
		SELECT oficio, salario FROM emple
		WHERE salario < (SELECT AVG(salario) 
						FROM emple E2
						WHERE oficio = p_oficio)
				AND oficio = p_oficio
		ORDER BY oficio, salario 
		FOR UPDATE OF salario;
	
	v_incremento emple.salario%TYPE;
BEGIN
	COMMIT;
	FOR reg1 IN c_ofi_sal LOOP
		FOR reg2 IN c_emp_sal(reg1.oficio) LOOP
			/* calcular incremento */
			v_incremento :=  (vr_ofi_sal.salario - vr_emp_sal.salario) / 2;
			/* actualizar */		
			UPDATE emple SET salario = salario + v_incremento
				WHERE CURRENT OF c_emp_sal;	
		END LOOP; 
	END LOOP; 
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
	  	ROLLBACK WORK;
		RAISE;
END subida_50pct2;
