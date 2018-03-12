-- Nombre:

*************************************************************************************************
	INSTRUCCIONES:
	==============

-Salva este fichero con las iniciales de tu nombre y apellidos:
	Ejemplo:	Jos� Mar�a Rivera Calvete
			JMRC.sql

-Pon tu nombre al ejercicio en la primera l�nea y lee atentamente todas las preguntas.

-Carga el script para el examen desde el fichero "DatosPLSQL.sql".

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en el final tendr�s otra oportunidad.

PUNTUACI�N
==========
- Cada pregunta vale 2 puntos


- Se considerar� para la evaluaci�n:
	- Que funcione
	- Estilo de programaci�n
	- Legibilidad del c�digo
	- Tratamiento de excepciones
	- C�digo reutilizable y param�trico
	- Cursores adecuados

--************************************************************************************************
1.- Dise�a el procedimiento 'MediasAsig' que reciba como par�metro el c�digo de una asignatura y actualice el campo 'Notamedia_as' de la tabla 'Asignaturas' al valor medio de las notas de los alumnos que est�n matriculados, el campo 'Nota_ma', considerando que para el c�lculo de la media se condiderar�n las notas de los alumons repetidores de la siguiente manera:
	- Si est� aprobado, un 5, independientemente de la nota que tenga.
	- Si est� suspenso, el valor de su nota, el campo 'Nota_ma'.

C�digo:
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
2.- Dise�a la funci�n 'CalculaMedia' que reciba como par�metro el c�digo de un alumno y devuelva la media de las notas de las asignaturas en las que est� matriculado.

C�digo:
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
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '|| SQLCODE);
		RETURN NULL;
END CalculaMedia;
/

--************************************************************************************************
3.- Dise�a el procedimiento 'MediasAsig' que modifique el campo 'Notamedia_al' de la tabla 'Alumnos' al valor de la media de las notas de las asignaturas en las que est� matriculado.

C�digo:
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
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '|| SQLCODE);
		ROLLBACK;
END MediasAlumno;
/


--************************************************************************************************
4.- Dise�a el procedimiento 'CuentaNotas' que reciba como par�metros de entrada el c�digo de una asignatura y el valor de una nota, y devuelva el n�mero de alumnos que tienen esa nota de los matriculados en esa asignatura y cuantos de ellos son repetidores.
(Nota: Recuerda la opci�n OUT en los argumentos de un procedimiento)

C�digo:
CREATE OR REPLACE PROCEDURE CuentaNotas(
	p_asignatura 	IN NUMBER,
	p_nota 			IN NUMBER,
	NAlumnos 		OUT NUMBER,
	NRepetidores 	OUT NUMBER)
IS
BEGIN
	-- Cuenta el n� de alumnos con esa nota en esa asignatura
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
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '|| SQLCODE);
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
5.- Dise�a el procedimiento 'ListaAsignatura' que reciba como argumento el c�digo de una asignatura y muestre un listado de los alumnos de la misma similar al siguiente:
------------------------------------------------------
Asignatura: Java
Profesor: RUIZ DE LOPERA, MANUEL

	Nombre							Rep		N� Asig Matriculado
	------							---		--------------------
 1	SANOGO, BAFLE MOR				N		2
 2	�LVAREZ CAMINO, JOAQU�N			N		3	
 3	BAENA QUINTERO, FRANCISCO		S		3
 4	BEN�TEZ MORALES, PEDRO L.		N		3	
 5	HERRERO SAN ROM�N, ESTEBAN		S		1
 6	JIM�NEZ NAVARRO, DAVID			N		3
 7	L�PEZ BARBAZ�N, MANUEL			N		3
 8	MAR�N GELO, JOS� M.				S		3
------------------------------------------------------

C�digo:
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
	-- Muestra la informaci�n obtenida
	DBMS_OUTPUT.PUT_LINE('Asignaturas '||v_nombre);
	DBMS_OUTPUT.PUT_LINE('Profesor: '||v_profesor);
	-- Cabecera del listado
	DBMS_OUTPUT.PUT_LINE('	Nombre							Rep		N� Asig Matriculado');
	DBMS_OUTPUT.PUT_LINE('	------							---		-------------------');
	FOR reg IN c_datos LOOP
		-- Calcula el n� de asignaturas en las que est� matriculado el alumno
		SELECT COUNT(*) INTO v_nAsignaturas
		FROM Matriculas WHERE CodAl_ma = reg.Codigo_al;
		-- Imprime los datos de un alumno
		DBMS_OUTPUT.PUT_LINE('. '||reg.Codigo_al||' '||reg.Apellidos_al||', '||reg.Nombre_al||' '||reg.Repite_ma||' '||v_nAsignaturas);
	END LOOP;
EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No existe el c�digo de la asignatura: '|| p_asignatura);
	WHEN others THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '|| SQLCODE);
END ListaAsignatura; 
/
-- Esta versi�n muestra el listado mejor al utilizar
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
	-- Muestra la informaci�n obtenida
	DBMS_OUTPUT.PUT_LINE('Asignaturas '||v_nombre);
	DBMS_OUTPUT.PUT_LINE('Profesor: '||v_profesor);
	-- Cabecera del listado
	DBMS_OUTPUT.PUT_LINE('	Nombre                      Rep N� Asig Matriculado');
	DBMS_OUTPUT.PUT_LINE('	------                      --- -------------------');
	FOR reg IN c_datos LOOP
		-- Calcula el n� de asignaturas en las que est� matriculado el alumno
		SELECT COUNT(*) INTO v_nAsignaturas
		FROM Matriculas WHERE CodAl_ma = reg.Codigo_al;
		-- Imprime los datos de un alumno
		DBMS_OUTPUT.PUT_LINE('. '||TO_CHAR(reg.Codigo_al,'99')||' '||RPAD(reg.Apellidos_al||', '||reg.Nombre_al,30)||' '||reg.Repite_ma||'   '||v_nAsignaturas);
	END LOOP;
EXCEPTION 
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('No existe el c�digo de la asignatura: '|| p_asignatura);
	WHEN others THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '|| SQLCODE);
END ListaAsignatura2; 
/

-- Para probar
 EXEC ListaAsignatura2(3);

--************************************************************************************************

