-- 1�) 
SELECT NOMBRE, ESPECIALIDAD, COUNT(DNI) "N�m.Profes"
	FROM CENTROS C, PROFESORES P
	WHERE C.COD_CENTRO = P.COD_CENTRO(+)
	GROUP BY NOMBRE, ESPECIALIDAD;

NOMBRE                         ESPECIALIDAD     N�m.Profes
------------------------------ ---------------- ----------
CP Los Danzantes               DIBUJO                    1
CP Los Danzantes               LENGUA                    2
CP Manuel Hidalgo              INFORM�TICA               1
IES Anto�ete                                             0
IES El Quijote                 INFORM�TICA               1
IES El Quijote                 MATEM�TICAS               2
IES Planeta Tierra             MATEM�TICAS               1


-- 2�) 
SELECT C.COD_CENTRO, NOMBRE, COUNT(DNI) "Empleados"
	FROM PERSONAL P, CENTROS C
	WHERE P.COD_CENTRO(+) = C.COD_CENTRO
	GROUP BY C.COD_CENTRO, NOMBRE;

COD_CENTRO NOMBRE                         Empleados
---------- ------------------------------ ---------
        10 IES El Quijote                         4
        15 CP Los Danzantes                       5
        22 IES Planeta Tierra                     3
        45 CP Manuel Hidalgo                      2
        50 IES Anto�ete                           0

-- 3�) 
SELECT especialidad 
	from profesores
	Group by especialidad
	Having count(*) = (select min(count(*)) 
						from profesores 
						group by especialidad);

ESPECIALIDAD
----------------
DIBUJO

-- 4�) 
SELECT FUNCION,  COUNT(*) 
	FROM PERSONAL 
	GROUP BY FUNCION;

FUNCION          COUNT(*)
--------------- ---------
ADMINISTRATIVO          4
CONSERJE                2
PROFESOR                8

-- 5�) 
SELECT NOMBRE FROM ALUM 
INTERSECT
	(SELECT NOMBRE FROM ANTIGUOS
	UNION
	SELECT NOMBRE FROM NUEVOS);

-- 6�) 
SELECT NOMBRE 
	FROM ALUM
	WHERE NOMBRE IN (SELECT NOMBRE FROM NUEVOS)
		OR NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);	
  
SELECT NOMBRE 
	FROM ALUM
	WHERE NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS 
					UNION
					SELECT NOMBRE FROM NUEVOS);


-- 7�) 
SELECT NOMBRE 
	FROM ALUM
	WHERE NOMBRE IN (SELECT NOMBRE FROM NUEVOS
					INTERSECT
					SELECT NOMBRE FROM ANTIGUOS);

-- 8�)					
SELECT NOMBRE FROM ALUM
INTERSECT
	(SELECT NOMBRE FROM NUEVOS
	INTERSECT
	SELECT NOMBRE FROM ANTIGUOS);

SELECT NOMBRE 
	FROM ALUM
	WHERE NOMBRE IN (SELECT NOMBRE FROM NUEVOS)
		AND NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);

-- 9�) 
SELECT NOMBRE FROM ALUM
MINUS
	(SELECT NOMBRE FROM ANTIGUOS
	UNION
	SELECT NOMBRE FROM NUEVOS);	
	
SELECT NOMBRE 
	FROM ALUM
	WHERE NOMBRE NOT IN (SELECT NOMBRE FROM ANTIGUOS
						UNION
						SELECT NOMBRE FROM NUEVOS);


