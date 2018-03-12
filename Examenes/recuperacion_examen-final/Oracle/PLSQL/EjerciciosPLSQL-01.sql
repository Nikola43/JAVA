-- 1. Escribir un procedimiento que reciba dos números y visualice su suma.
CREATE OR REPLACE PROCEDURE suma (n1 NUMBER, n2 NUMBER)
IS
	res NUMBER;
BEGIN
	res := n1 + n2;
	DBMS_OUTPUT.PUT_LINE('La suma de '||n1||' y '||n2||' es '||res);
END suma;
/

-- 2. Codificar un procedimiento que reciba una cadena y la visualice al revés.
CREATE OR REPLACE PROCEDURE alreves (cadena VARCHAR2)
IS
	cad_alreves VARCHAR2(32767) := '';
BEGIN
	FOR i IN REVERSE 1..LENGTH(cadena) LOOP
		cad_alreves := cad_alreves||SUBSTR(cadena, i,1);
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(cad_alreves);
END alreves;
/

-- 3. Reescribir el código de los ejercicios anteriores convirtiéndolos en funciones.
CREATE OR REPLACE FUNCTION sumaF (n1 NUMBER, n2 NUMBER)
	RETURN NUMBER
IS
	res NUMBER;
BEGIN
	res := n1 + n2;
	RETURN res;
END suma;
/

CREATE OR REPLACE FUNCTION alrevesF (cadena VARCHAR2)
	RETURN VARCHAR2
IS
	cad_alreves VARCHAR2(32767) := '';
BEGIN
	FOR i IN REVERSE 1..LENGTH(cadena) LOOP
		cad_alreves := cad_alreves||SUBSTR(cadena, i,1);
	END LOOP;
	RETURN cad_alreves;
END alreves;
/

-- 4. Escribir una función que reciba una fecha y devuelva el año, en número, correspondiente a esa fecha.

CREATE OR REPLACE FUNCTION anio	(fecha DATE)
	RETURN NUMBER
AS
	v_anio NUMBER(4);
BEGIN
	v_anio := TO_NUMBER(TO_CHAR(fecha, 'YYYY'));
	RETURN v_anio;
END anio;
/

-- 5. Escribir un bloque PL/SQL que haga uso de la función anterior.

DECLARE
 	n NUMBER(4);
BEGIN
 	n := anio(SYSDATE);
 	DBMS_OUTPUT.PUT_LINE('AÑO : '|| n);
END;
/

-- 6. Desarrollar una función que devuelva el número de años completos que hay entre dos fechas que se pasan como argumentos.
CREATE OR REPLACE FUNCTION anios_dif (
	fecha1 DATE,
	fecha2 DATE)
	RETURN NUMBER
AS
	v_anios_dif NUMBER(6);
BEGIN
	v_anios_dif := ABS(TRUNC(MONTHS_BETWEEN(fecha2,fecha1)
 / 12));
	RETURN v_anios_dif;
END anios_dif;
/

-- 7. Escribir una función que, haciendo uso de la función anterior devuelva los trienios que hay entre dos fechas. (Un trienio son tres años completos).	
CREATE OR REPLACE FUNCTION trienios (
	fecha1 DATE,
	fecha2 DATE)
	RETURN NUMBER
AS
	v_trienios NUMBER(6);
BEGIN
	v_trienios := TRUNC(anios_dif(fecha1,fecha2) / 3);
 	RETURN v_trienios;
END;
/

-- 8. 

1º Incorrecta: hay que pasar al menos el número de departamento.
2º Correcta. 
3º Incorrecta: hay que pasar también el número de departamento.
4º Correcta.
5º Incorrecta: los argumentos están en orden inverso.
Solución: crear_depart(50, 'COMPRAS');
6º Incorrecta: hay que pasar también el número.
7º Correcta.
8º Incorrecta: el orden de los argumentos es incorrecto.
	Solución: crear_depart(50, 'COMPRAS',  'VALENCIA');
9º Incorrecta: hay que pasar también el número de departamento.
10º Incorrecta: los argumentos están en orden inverso.
	Solución: crear_depart(50, NULL, 'VALENCIA');
	
-- 9. Codificar un procedimiento que reciba una lista de hasta 5 números y visualice su suma.
CREATE OR REPLACE PROCEDURE sumar_5numeros (
	Num1 NUMBER DEFAULT 0,
	Num2 NUMBER DEFAULT 0,
	Num3 NUMBER DEFAULT 0,
	Num4 NUMBER DEFAULT 0,
	Num5 NUMBER DEFAULT 0)
AS
BEGIN
	DBMS_OUTPUT.PUT_LINE(Num1 + Num2 + Num3 + Num4 + Num5);
END sumar_5numeros;
/

-- 10. Implementar un procedimiento que reciba un importe y visualice el desglose del cambio en unidades monetarias de 1, 2, 5, 10, 20, 50, 100, 200 y 500 € en orden inverso al que aparecen aquí enumeradas.
CREATE OR REPLACE PROCEDURE cambio(importe NUMBER)
AS
	cambio NATURAL := importe;
	moneda NATURAL;
	v_uni_moneda NATURAL;
BEGIN
	DBMS_OUTPUT.PUT_LINE('***** DESGLOSE DE: ' || importe );
	WHILE cambio > 0 LOOP
        IF 	cambio >= 500 THEN
			moneda := 500;
	   	ELSIF cambio >= 200 THEN
			moneda := 200;
        ELSIF cambio >= 100 THEN
			moneda := 100;
	   	ELSIF cambio >= 50 THEN
			moneda := 50;
        ELSIF cambio >= 20 THEN
			moneda := 20;
	   	ELSIF cambio >= 10 THEN
			moneda := 10;
        ELSIF cambio >= 5 THEN
			moneda := 5;
	   	ELSIF cambio >= 2 THEN
			moneda := 2;
	   	ELSE  
			moneda := 1;
		END IF;
		v_uni_moneda := TRUNC(cambio / moneda);
	   	DBMS_OUTPUT.PUT_LINE(v_uni_moneda || ' de ' || moneda || ' euros ');
 		cambio := MOD(cambio, moneda);
	END LOOP;
END cambio;
/

-- 11. Codificar un procedimiento que permita borrar un empleado cuyo código se pasará en la llamada.


CREATE OR REPLACE PROCEDURE borrar_emple(
	num_emple emple.emp_no%TYPE)
AS
	v_row ROWID;
BEGIN
	SELECT ROWID INTO v_row FROM emple 
		WHERE emp_no =  num_emple;
	DELETE FROM emple WHERE ROWID =  v_row;
	DBMS_OUTPUT.PUT_LINE('Procedimiento terminado con éxito');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No existe el código '||num_emple);
END borrar_emple;
/

-- 12. Escribir un procedimiento que modifique la localidad de un departamento. El procedimiento recibirá como parámetros el número del departamento y la localidad nueva.
CREATE OR REPLACE
PROCEDURE modificar_localidad(
	num_depart NUMBER,
	localidad VARCHAR2)
AS
	var NUMBER;
BEGIN
	SELECT dept_no INTO
		FROM depart WHERE dept_no = num_depart;
	UPDATE depart SET loc = localidad
		WHERE dept_no = num_depart;
	DBMS_OUTPUT.PUT_LINE('Procedimiento terminado con éxito');
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No existe el código '||num_depart);
END modificar_localidad;
/
-- 13. Visualizar todos los procedimientos y funciones del usuario almacenados en la base de datos y su situación (valid o invalid).

SELECT OBJECT_NAME||' -> '||OBJECT_TYPE||' -> '|| STATUS 
	FROM USER_OBJECTS 
	WHERE OBJECT_TYPE IN ('PROCEDURE','FUNCTION');

SELECT OBJECT_NAME||' -> '||OBJECT_TYPE||' -> '|| STATUS 
	FROM ALL_OBJECTS 
	WHERE OBJECT_TYPE IN ('PROCEDURE','FUNCTION');



