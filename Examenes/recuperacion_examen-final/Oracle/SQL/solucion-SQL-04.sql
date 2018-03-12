-- 1º) 
SELECT NOMBRE, ESPECIALIDAD, COUNT(DNI) "Núm.Profes"
	FROM CENTROS C, PROFESORES P
	WHERE C.COD_CENTRO = P.COD_CENTRO(+)
	GROUP BY NOMBRE, ESPECIALIDAD;

NOMBRE                         ESPECIALIDAD     Núm.Profes
------------------------------ ---------------- ----------
CP Los Danzantes               DIBUJO                    1
CP Los Danzantes               LENGUA                    2
CP Manuel Hidalgo              INFORMÁTICA               1
IES Antoñete                                             0
IES El Quijote                 INFORMÁTICA               1
IES El Quijote                 MATEMÁTICAS               2
IES Planeta Tierra             MATEMÁTICAS               1


-- 2º) 
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
        50 IES Antoñete                           0

-- 3º) 
SELECT especialidad 
	from profesores
	Group by especialidad
	Having count(*) = (select min(count(*)) 
						from profesores 
						group by especialidad);

ESPECIALIDAD
----------------
DIBUJO

-- 4º) 
SELECT FUNCION,  COUNT(*) 
	FROM PERSONAL 
	GROUP BY FUNCION;

FUNCION          COUNT(*)
--------------- ---------
ADMINISTRATIVO          4
CONSERJE                2
PROFESOR                8

-- 5º) 
SELECT NOMBRE FROM ALUM 
INTERSECT
	(SELECT NOMBRE FROM ANTIGUOS
	UNION
	SELECT NOMBRE FROM NUEVOS);

-- 6º) 
SELECT NOMBRE 
	FROM ALUM
	WHERE NOMBRE IN (SELECT NOMBRE FROM NUEVOS)
		OR NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);	
  
SELECT NOMBRE 
	FROM ALUM
	WHERE NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS 
					UNION
					SELECT NOMBRE FROM NUEVOS);


-- 7º) 
SELECT NOMBRE 
	FROM ALUM
	WHERE NOMBRE IN (SELECT NOMBRE FROM NUEVOS
					INTERSECT
					SELECT NOMBRE FROM ANTIGUOS);

-- 8º)					
SELECT NOMBRE FROM ALUM
INTERSECT
	(SELECT NOMBRE FROM NUEVOS
	INTERSECT
	SELECT NOMBRE FROM ANTIGUOS);

SELECT NOMBRE 
	FROM ALUM
	WHERE NOMBRE IN (SELECT NOMBRE FROM NUEVOS)
		AND NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);

-- 9º) 
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


