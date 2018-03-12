-- Nombre:

*************************************************************************************************
	INSTRUCCIONES:
	==============

-Salva este fichero con las iniciales de tu nombre y apellidos:
	Ejemplo:	José María Rivera Calvete
			JMRC.sql

-Pon tu nombre al ejercicio en la primera línea y lee atentamente todas las preguntas.

-Carga el script para el examen desde el fichero "DatosPLSQL.sql".

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en el final tendrás otra oportunidad.

PUNTUACIÓN
==========
- Cada pregunta vale 2 puntos


- Se considerará para la evaluación:
	- Que funcione
	- Estilo de programación
	- Legibilidad del código
	- Tratamiento de excepciones
	- Código reutilizable y paramétrico
	- Cursores adecuados

--************************************************************************************************
1.- Diseña el procedimiento 'MediasAsig' que reciba como parámetro el código de una asignatura y actualice el campo 'Notamedia_as' de la tabla 'Asignaturas' al valor medio de las notas de los alumnos que están matriculados, el campo 'Nota_ma', considerando que para el cálculo de la media se condiderarán las notas de los alumons repetidores de la siguiente manera:
	- Si está aprobado, un 5, independientemente de la nota que tenga.
	- Si está suspenso, el valor de su nota, el campo 'Nota_ma'.

Código:
CREATE OR REPLACE PROCEDURE MediasAsig(
	p_asignatura Asignaturas.Codigo_as%TYPE)
IS
	CURSOR c_Asignatura IS
	SELECT Nota_ma, Repite_ma
		FROM Matriculas
		WHERE CodAs_ma = p_asignatura;
	NotaMedia Asignaturas.Notamedia_as%TYPE := 0;
	i BINARY_INTEGER := 0;
BEGIN
	FOR reg IN c_Asignatura LOOP
		IF reg.Repite_ma = 'S' AND reg.Nota_ma >= 5 THEN
			NotaMedia := NotaMedia + 5;
		ELSE
			NotaMedia := NotaMedia + reg.Nota_ma;
		END IF;
		i := i + 1;
	END LOOP;
	UPDATE Asignaturas
		SET Notamedia_as = NotaMedia/i
		WHERE Codigo_as = p_asignatura;
EXCEPTION
	WHEN OTHERS THEN
		ROLLBACK;
END MediasAsig;
/


--************************************************************************************************
2.- Diseña la función 'CalculaMedia' que reciba como parámetro el código de un alumno y devuelva la media de las notas de las asignaturas en las que esté matriculado.

Código:
CREATE OR REPLACE FUNCTION CalculaMedia 
	(p_alumno number) RETURN NUMBER 
IS
	NotaMedia Matriculas.Nota_ma%TYPE;
BEGIN 
	SELECT AVG(Nota_ma) INTO NotaMedia
	FROM Matriculas
	WHERE CodAl_ma = p_alumno;
	-- 
	RETURN NotaMedia;
EXCEPTION 
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurrió un error: '|| SQLCODE);
		RETURN NULL;
END CalculaMedia;
/

--************************************************************************************************
3.- Diseña el procedimiento 'MediasAsig' que modifique el campo 'Notamedia_al' de la tabla 'Alumnos' al valor de la media de las notas de las asignaturas en las que esté matriculado.

Código:
CREATE OR REPLACE PROCEDURE MediasAlumno 
IS
	CURSOR c_Alumno IS
	SELECT Codigo_al
	FROM Alumnos
	FOR UPDATE OF Notamedia_al;
BEGIN 
	--COMMIT; -- Comentado para pruebas
	FOR reg IN c_Alumno LOOP
		UPDATE Alumnos
		SET Notamedia_al = CalculaMedia(reg.Codigo_al)
		WHERE CURRENT OF c_Alumno;
	END LOOP;
	--COMMIT; -- Comentado para pruebas
EXCEPTION 
	WHEN others THEN
		DBMS_OUTPUT.PUT_LINE('Ocurrió un error: '|| SQLCODE);
		ROLLBACK;
END MediasAlumno;
/


--************************************************************************************************
4.- Diseña el procedimiento 'CuentaNotas' que reciba como parámetros de entrada el código de una asignatura y el valor de una nota, y devuelva el número de alumnos que tienen esa nota de los matriculados en esa asignatura y cuantos de ellos son repetidores.
(Nota: Recuerda la opción OUT en los argumentos de un procedimiento)

Código:
CREATE OR REPLACE PROCEDURE CuentaNotas(
	p_asignatura 	IN NUMBER,
	p_nota 			IN NUMBER,
	NAlumnos 		OUT NUMBER,
	NRepetidores 	OUT NUMBER)
IS
BEGIN
	-- Cuenta el nº de alumnos con esa nota en esa asignatura
	SELECT COUNT(*) INTO NAlumnos
	FROM Matriculas
	WHERE CodAs_ma = p_asignatura
		AND Nota_ma = p_nota;
	-- Idem pero solo los repetidores
	SELECT COUNT(*) INTO NRepetidores
	FROM Matriculas
	WHERE CodAs_ma = p_asignatura
		AND Nota_ma = p_nota
		AND Repite_ma = 'S';
EXCEPTION 
	WHEN others THEN
		DBMS_OUTPUT.PUT_LINE('Ocurrió un error: '|| SQLCODE);
END CuentaNotas; 
/

-- Para probar
declare
	Asignatura	NUMBER;
	Nota		NUMBER;
	Alumnos		NUMBER;
	Repetidores	NUMBER;
begin
	Nota := 7;
	Asignatura := 2;
	CuentaNotas(Asignatura, Nota, Alumnos, Repetidores);
	DBMS_OUTPUT.PUT_LINE('Alumnos: '||Alumnos||' Repetidores: '||Repetidores);
end;
/


--************************************************************************************************
5.- Diseña el procedimiento 'ListaAsignatura' que reciba como argumento el código de una asignatura y muestre un listado de los alumnos de la misma similar al siguiente:
------------------------------------------------------
Asignatura: Java
Profesor: RUIZ DE LOPERA, MANUEL

	Nombre							Rep		Nº Asig Matriculado
	------							---		--------------------
 1	SANOGO, BAFLE MOR				N		2
 2	ÁLVAREZ CAMINO, JOAQUÍN			N		3	
 3	BAENA QUINTERO, FRANCISCO		S		3
 4	BENÍTEZ MORALES, PEDRO L.		N		3	
 5	HERRERO SAN ROMÁN, ESTEBAN		S		1
 6	JIMÉNEZ NAVARRO, DAVID			N		3
 7	LÓPEZ BARBAZÁN, MANUEL			N		3
 8	MARÍN GELO, JOSÉ M.				S		3
------------------------------------------------------

Código:
CREATE OR REPLACE PROCEDURE ListaAsignatura(
	p_asignatura	Asignaturas.Codigo_as%TYPE
	)
IS
	v_nombre	Asignaturas.Nombre_as%TYPE;
	v_profesor	VARCHAR2(35);
	CURSOR c_datos IS
		SELECT Codigo_al, Apellidos_al, Nombre_al, Repite_ma
		FROM Alumnos, Matriculas
		WHERE CodAl_ma = Codigo_al
			AND CodAs_ma = p_asignatura;
	v_nAsignaturas NUMBER;
BEGIN
	-- Para obtener el nombre de la asignatura y el del profesor
	SELECT Nombre_as, Apellidos_pr||', ' ||Nombre_pr  INTO v_nombre, v_profesor
	FROM Asignaturas, Profesores
	WHERE Codigo_pr = Profesor_as
		AND Codigo_as = p_asignatura;
	-- Muestra la información obtenida
	DBMS_OUTPUT.PUT_LINE('Asignaturas '||v_nombre);
	DBMS_OUTPUT.PUT_LINE('Profesor: '||v_profesor);
	-- Cabecera del listado
	DBMS_OUTPUT.PUT_LINE('	Nombre							Rep		Nº Asig Matriculado');
	DBMS_OUTPUT.PUT_LINE('	------							---		-------------------');
	FOR reg IN c_datos LOOP
		-- Calcula el nº de asignaturas en las que está matriculado el alumno
		SELECT COUNT(*) INTO v_nAsignaturas
		FROM Matriculas WHERE CodAl_ma = reg.Codigo_al;
		-- Imprime los datos de un alumno
		DBMS_OUTPUT.PUT_LINE('. '||reg.Codigo_al||' '||reg.Apellidos_al||', '||reg.Nombre_al||' '||reg.Repite_ma||' '||v_nAsignaturas);
	END LOOP;
EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No existe el código de la asignatura: '|| p_asignatura);
	WHEN others THEN
		DBMS_OUTPUT.PUT_LINE('Ocurrió un error: '|| SQLCODE);
END ListaAsignatura; 
/
-- Esta versión muestra el listado mejor al utilizar
-- las funciones TO_CHAR y RPAD
CREATE OR REPLACE PROCEDURE ListaAsignatura2(
	p_asignatura	Asignaturas.Codigo_as%TYPE
	)
IS
	v_nombre	Asignaturas.Nombre_as%TYPE;
	v_profesor	VARCHAR2(35);
	CURSOR c_datos IS
		SELECT Codigo_al, Apellidos_al, Nombre_al, Repite_ma
		FROM Alumnos, Matriculas
		WHERE CodAl_ma = Codigo_al
			AND CodAs_ma = p_asignatura;
	v_nAsignaturas NUMBER;
BEGIN
	-- Para obtener el nombre de la asignatura y el del profesor
	SELECT Nombre_as, Apellidos_pr||', ' ||Nombre_pr  INTO v_nombre, v_profesor
	FROM Asignaturas, Profesores
	WHERE Codigo_pr = Profesor_as
		AND Codigo_as = p_asignatura;
	-- Muestra la información obtenida
	DBMS_OUTPUT.PUT_LINE('Asignaturas '||v_nombre);
	DBMS_OUTPUT.PUT_LINE('Profesor: '||v_profesor);
	-- Cabecera del listado
	DBMS_OUTPUT.PUT_LINE('	Nombre                      Rep Nº Asig Matriculado');
	DBMS_OUTPUT.PUT_LINE('	------                      --- -------------------');
	FOR reg IN c_datos LOOP
		-- Calcula el nº de asignaturas en las que está matriculado el alumno
		SELECT COUNT(*) INTO v_nAsignaturas
		FROM Matriculas WHERE CodAl_ma = reg.Codigo_al;
		-- Imprime los datos de un alumno
		DBMS_OUTPUT.PUT_LINE('. '||TO_CHAR(reg.Codigo_al,'99')||' '||RPAD(reg.Apellidos_al||', '||reg.Nombre_al,30)||' '||reg.Repite_ma||'   '||v_nAsignaturas);
	END LOOP;
EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No existe el código de la asignatura: '|| p_asignatura);
	WHEN others THEN
		DBMS_OUTPUT.PUT_LINE('Ocurrió un error: '|| SQLCODE);
END ListaAsignatura2; 
/

-- Para probar
 EXEC ListaAsignatura2(3);

--************************************************************************************************

