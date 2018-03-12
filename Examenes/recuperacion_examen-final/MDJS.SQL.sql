
Nombre: <Malvina del Junco Suarez>

************************************************************************
	INSTRUCCIONES:
	==============

-Salva este fichero con las iniciales de tu nombre y apellidos,
 en el directorio "C:\Examen\ ":
	Ejemplo:	José María Rivera Calvete
			JMRC.sql

-Pon tu nombre al ejercicio y lee atentamente todas las preguntas.

-Entra en "SQL Plus" con cualquier usuario. 

-Carga el script para el examen desde el fichero "Datos.sql".

-Donde ponga "SQL>", copiarás las sentencias SQL que has utilizado.

-RECUERDA: guardar, cada cierto tiempo, el contenido de este fichero. Es lo que voy a evaluar, si lo pierdes, lo siento, en la recuperación tendrás otra oportunidad.

	PUNTUACIÓN
	==========
- Pregunta 1:	3 puntos
- Pregunta 2:	2 puntos
- Pregunta 3:	2 puntos
- Pregunta 4:	3 puntos

- Se considerará para la evaluación:
	- Que funcione
	- Estilo de programación 
	- Tratamiento de excepciones
	- Uso de los cursores
	- Código reutilizable y paramétrico

************************************************************************
	Descripción de las tablas:
	==========================

ESPECIALIDADES
--------------
#  Cod_es		NUMBER(3)		Código Especialidad 
   Nombre_es	VARCHAR2(40)	Nombre de la especialidad

CENTROS
-------
# Cod_ce		NUMBER(5)		Código del centro
  Nombre_ce		VARCHAR2(30)	Nombre del centro

PLAZAS
------
#* Cod_pl		NUMBER(5)		Código del centro
#* Esp_pl		NUMBER(3)		Código Especialidad 
   PlazVac_pl	NUMBER(2)		Número de plazas vacantes
   PlazAdj_pl	NUMBER(2)		Número de plazas adjudicadas

PROFESORES
----------
# Cod_pr		NUMBER(4)		Código profesor
  Nombre_pr		VARCHAR2(35)	Nombre del profesor
* Esp_pr		NUMBER(3)		Código Especialidad del profesor
  AntCuerpo_pr	NUMBER(2)		Antigüedad en el cuerpo
  Horas_pr		NUMBER(3)		Nº de horas de cursos
  AntCentro_pr	NUMBER(2)		Antigüedad en el último centro de destino

PETICIONES
----------
# Cod_pe		NUMBER(4)		Código profesor
# Orden_pe		NUMBER(3)		Nº de orden de la petición
* Cod_ce		NUMBER(5)		Código del centro pedido

ADJUDICACIONES
--------------
#* Cod_pr		NUMBER(4)		Código profesor
#* Esp_pl		NUMBER(3)		Código Especialidad 
#* Cod_ce		NUMBER(5)		Código del centro pedido
   Orden_pe		NUMBER(3)		Nº de orden de la petición adjudicada


Nota: 
	# PRIMARY KEY
	* FOREIGN KEY
	(O) Obligatorio
	(U) Único

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

Código fuente>


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
		DBMS_OUTPUT.PUT_LINE('Ocurrió un error: '||SQLCODE);
		ROLLBACK;
END Comprobar_Pet;
/
Código fuente>

************************************************************************
3.- (Añadir al final) "así como modificar la tabla PLAZAS incrementando el campo PlazAdj_pl en una unidad".

Código fuente>

************************************************************************
4.- 

Código fuente>
