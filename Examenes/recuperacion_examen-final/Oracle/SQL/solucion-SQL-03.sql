-- 1º) 

SELECT DEPT_NO, AVG(SALARIO) "Sal medio"
	FROM EMPLE
	GROUP BY DEPT_NO
	HAVING AVG(SALARIO) >= (SELECT  AVG(SALARIO) FROM EMPLE);

  DEPT_NO    Sal medio
--------- ------------                      
       10    379166,67
       20       282750

-- 2º) 
select count(*)
	from emple
	where dept_no = (select dept_no from depart where dnombre='VENTAS')
	and oficio = 'VENDEDOR'
	group by oficio;

 COUNT(*)
---------
        4

-- 3º) 
select oficio, sum(salario)
	from emple
	where dept_no = (select dept_no from depart where dnombre = 'VENTAS')
	group by oficio;

OFICIO     SUM(SALARIO)
-------- --------------                       
DIRECTOR         370500
EMPLEADO         123500
VENDEDOR         728000
 
-- 4º) 
select apellido, salario
	from emple
	where (salario,dept_no) in
	(select avg(salario), dept_no from emple group by dept_no);

ninguna fila seleccionada

-- 5º) 
select dept_no, COUNT(*) "Nºemple"
	FROM EMPLE
	WHERE OFICIO LIKE 'EMPLEADO'
	GROUP BY DEPT_NO;

  DEPT_NO   Nºemple
--------- ---------                   
       10         1
       20         2
       30         1

-- 6º) 
SELECT DEPT_NO, COUNT(*) "Nºemple"
	FROM EMPLE
	WHERE OFICIO LIKE 'EMPLEADO'
	GROUP BY DEPT_NO
	HAVING COUNT(*) = (SELECT MAX(COUNT(*)) 
						FROM EMPLE 
						WHERE OFICIO LIKE 'EMPLEADO' 
						GROUP BY DEPT_NO);

  DEPT_NO   Nºemple
--------- ---------                   
       20         2

-- 7º) 
SELECT DEPT_NO, DNOMBRE  
	FROM DEPART
	WHERE DEPT_NO = (select dept_no  
						FROM EMPLE 
						WHERE OFICIO LIKE 'EMPLEADO'
						GROUP BY DEPT_NO
						having COUNT(*) = (SELECT MAX(COUNT(*)) 
											FROM EMPLE 
											WHERE OFICIO LIKE 'EMPLEADO' 
											GROUP BY DEPT_NO));
											
  DEPT_NO DNOMBRE
--------- -------------                        
       20 INVESTIGACIÓN

--- 8º) 
SELECT DEPT_NO, COUNT(*) 
	FROM EMPLE 
	GROUP BY DEPT_NO, OFICIO  
	HAVING COUNT(*) > 2;

DEPT_NO  COUNT(*)
------- ---------                  
     30         4

-- 9º) 
SELECT estante, sum(ejemplares)
	FROM  libreria 
	GROUP BY estante;

E SUM(EJEMPLARES)
- ---------------
A              36
B              28
C              33
D              16
E               6

-- 10º) 
SELECT estante, sum(ejemplares) 
	FROM LIBRERIA
	HAVING  SUM(ejemplares) = (SELECT MAX(SUM(ejemplares))  
								FROM LIBRERIA  
								GROUP BY  estante)
	GROUP BY estante;

E SUM(EJEMPLARES)
- ---------------
A              36

-- 11º) 
SELECT ESTANTE 
	FROM LIBRERIA 
	GROUP BY ESTANTE
	ORDER BY ESTANTE DESC;

E
-
E
D
C
B
A

-- 12º)
SELECT ESTANTE, COUNT(*) "Nº temas" 
	FROM LIBRERIA 
	GROUP BY ESTANTE;

E  Nº temas
- ---------
A         3
B         2
C         3
D         2
E         1

-- 13º)
SELECT ESTANTE, COUNT(*) "Nº temas"  
	FROM LIBRERIA
	GROUP BY ESTANTE
	HAVING COUNT(*) = 3;

E  Nº temas
- ---------
A         3
C         3
























TABLAS ALUM, ANTIGUOS, NUEVOS

11º) 
SQL> SELECT NOMBRE FROM ALUM INTERSECT
  2  (SELECT NOMBRE FROM ANTIGUOS
  3  UNION
  4  SELECT NOMBRE FROM NUEVOS);

12º) 

SQL> SELECT NOMBRE FROM ALUM
  2  WHERE NOMBRE IN
  3  (SELECT NOMBRE FROM NUEVOS)
  4  OR
  5  NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);	SQL> SELECT NOMBRE FROM ALUM
  2  WHERE NOMBRE IN
  3  (SELECT NOMBRE FROM ANTIGUOS 
  4  UNION
  5  SELECT NOMBRE FROM NUEVOS);


13º) 

SQL> SELECT NOMBRE FROM ALUM
  2  WHERE NOMBRE IN
  3  (SELECT NOMBRE FROM NUEVOS
  4  INTERSECT
  5  SELECT NOMBRE FROM ANTIGUOS);
	SQL> SELECT NOMBRE FROM ALUM
  2      INTERSECT
  3      (SELECT NOMBRE FROM NUEVOS
  4      INTERSECT
  5      SELECT NOMBRE FROM ANTIGUOS);

14º) 
SQL> SELECT NOMBRE FROM ALUM
  2  WHERE NOMBRE IN (SELECT NOMBRE FROM NUEVOS)
  4  AND   NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);

15º) 

SQL>  SELECT NOMBRE FROM ALUM
  2  MINUS
  3   (SELECT NOMBRE FROM ANTIGUOS
  4   UNION
5	SELECT NOMBRE FROM NUEVOS);	SQL> SELECT NOMBRE FROM ALUM
  2  WHERE NOMBRE NOT IN
  3  (SELECT NOMBRE FROM ANTIGUOS
  4  UNION
  5  SELECT NOMBRE FROM NUEVOS);


17º) 
SQL>  SELECT NOMBRE, ESPECIALIDAD, COUNT(DNI) "Núm.Profes"
  2   FROM CENTROS C, PROFESORES P
  3   WHERE C.COD_CENTRO=P.COD_CENTRO(+)
  4  GROUP BY NOMBRE, ESPECIALIDAD;

NOMBRE                         ESPECIALIDAD     Núm.Profes
------------------------------ ---------------- ----------
CP Los Danzantes               DIBUJO                    1
CP Los Danzantes               LENGUA                    2
CP Manuel Hidalgo              INFORMÁTICA               1
IES Antoñete                                             0
IES El Quijote                 INFORMÁTICA               1
IES El Quijote                 MATEMÁTICAS               2
IES Planeta Tierra             MATEMÁTICAS               1

7 filas seleccionadas.

18º) 
SQL> SELECT C.COD_CENTRO, NOMBRE, COUNT(DNI) "Empleados"
  2   FROM PERSONAL P, CENTROS C
  3   WHERE P.COD_CENTRO(+)=C.COD_CENTRO
  4   GROUP BY C.COD_CENTRO, NOMBRE;

COD_CENTRO NOMBRE                         Empleados
---------- ------------------------------ ---------
        10 IES El Quijote                         4
        15 CP Los Danzantes                       5
        22 IES Planeta Tierra                     3
        45 CP Manuel Hidalgo                      2
        50 IES Antoñete                           0

19º) 
SQL> Select especialidad from profesores
  2  Group by especialidad
  3  Having count(*) = (select min(count(*)) from profesores group by especialidad);

ESPECIALIDAD
----------------
DIBUJO

20º) 
SQL> SELECT FUNCION,  COUNT(*) FROM PERSONAL GROUP BY FUNCION;

FUNCION          COUNT(*)
--------------- ---------
ADMINISTRATIVO          4
CONSERJE                2
PROFESOR                8

TABLA LIBRERIA:



