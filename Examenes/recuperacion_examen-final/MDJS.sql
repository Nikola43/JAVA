
Nombre: <Malvina del Junco Suarez>

************************************************************************
	INSTRUCCIONES:
	==============

-Salva este fichero con las iniciales de tu nombre y apellidos,
 en el directorio "C:\Examen\ ":
	Ejemplo:	Jos� Mar�a Rivera Calvete
			JMRC.sql

-Pon tu nombre al ejercicio y lee atentamente todas las preguntas.

-Entra en "SQL Plus" con cualquier usuario. 

-Carga el script para el examen desde el fichero "Datos.sql".

-Donde ponga "SQL>", copiar�s las sentencias SQL que has utilizado.

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en la recuperaci�n tendr�s otra oportunidad.

	PUNTUACI�N
	==========
- Pregunta 1:	3 puntos
- Pregunta 2:	2 puntos
- Pregunta 3:	2 puntos
- Pregunta 4:	3 puntos

- Se considerar� para la evaluaci�n:
	- Que funcione
	- Estilo de programaci�n 
	- Tratamiento de excepciones
	- Uso de los cursores
	- C�digo reutilizable y param�trico

************************************************************************
	Descripci�n de las tablas:
	==========================

ESPECIALIDADES
--------------
#  Cod_es		NUMBER(3)		C�digo Especialidad 
   Nombre_es	VARCHAR2(40)	Nombre de la especialidad

CENTROS
-------
# Cod_ce		NUMBER(5)		C�digo del centro
  Nombre_ce		VARCHAR2(30)	Nombre del centro

PLAZAS
------
#* Cod_pl		NUMBER(5)		C�digo del centro
#* Esp_pl		NUMBER(3)		C�digo Especialidad 
   PlazVac_pl	NUMBER(2)		N�mero de plazas vacantes
   PlazAdj_pl	NUMBER(2)		N�mero de plazas adjudicadas

PROFESORES
----------
# Cod_pr		NUMBER(4)		C�digo profesor
  Nombre_pr		VARCHAR2(35)	Nombre del profesor
* Esp_pr		NUMBER(3)		C�digo Especialidad del profesor
  AntCuerpo_pr	NUMBER(2)		Antig�edad en el cuerpo
  Horas_pr		NUMBER(3)		N� de horas de cursos
  AntCentro_pr	NUMBER(2)		Antig�edad en el �ltimo centro de destino

PETICIONES
----------
# Cod_pe		NUMBER(4)		C�digo profesor
# Orden_pe		NUMBER(3)		N� de orden de la petici�n
* Cod_ce		NUMBER(5)		C�digo del centro pedido

ADJUDICACIONES
--------------
#* Cod_pr		NUMBER(4)		C�digo profesor
#* Esp_pl		NUMBER(3)		C�digo Especialidad 
#* Cod_ce		NUMBER(5)		C�digo del centro pedido
   Orden_pe		NUMBER(3)		N� de orden de la petici�n adjudicada


Nota: 
	# PRIMARY KEY
	* FOREIGN KEY
	(O) Obligatorio
	(U) �nico

************************************************************************
1.- CREATE OR REPLACE FUNCTION Baremo(
	anyi_a Profesores.AntCuerpo_pr%TYPE,
	total_h Profesores.Horas.pr%TYPE,
	anti_centro Profesores.AntCentros_pr%TYPE) RETURN BOOLEAN
AS 
	
BEGIN
	IF
	END LOOP;
END Baremo;
/

C�digo fuente>


************************************************************************
2.- 
REATE OR REPLACE PROCEDURE Comprobar_Pet(
	p_codigo_c Plazas.Cod_pl%TYPE,
	p_codigo_e Plazas.Esp_pl%TYPE)
AS
	v_plazas	BOOLEAN;
	CURSOR c_emple IS 
	
BEGIN
	
	END LOOP;
	COMMIT;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE('Ocurri� un error: '||SQLCODE);
		ROLLBACK;
END Comprobar_Pet;
/
C�digo fuente>

************************************************************************
3.- (A�adir al final) "as� como modificar la tabla PLAZAS incrementando el campo PlazAdj_pl en una unidad".

C�digo fuente>

************************************************************************
4.- 

C�digo fuente>
