-- 1�) 

SELECT DEPT_NO, AVG(SALARIO) "Sal medio"
	FROM EMPLE
	GROUP BY DEPT_NO
	HAVING AVG(SALARIO) >= (SELECT  AVG(SALARIO) FROM EMPLE);

  DEPT_NO    Sal medio
--------- ------------                      
       10    379166,67
       20       282750

-- 2�) 
select count(*)
	from emple
	where dept_no = (select dept_no from depart where dnombre='VENTAS')
	and oficio = 'VENDEDOR'
	group by oficio;

 COUNT(*)
---------
        4

-- 3�) 
select oficio, sum(salario)
	from emple
	where dept_no = (select dept_no from depart where dnombre = 'VENTAS')
	group by oficio;

OFICIO     SUM(SALARIO)
-------- --------------                       
DIRECTOR         370500
EMPLEADO         123500
VENDEDOR         728000
 
-- 4�) 
select apellido, salario
	from emple
	where (salario,dept_no) in
	(select avg(salario), dept_no from emple group by dept_no);

ninguna fila seleccionada

-- 5�) 
select dept_no, COUNT(*) "N�emple"
	FROM EMPLE
	WHERE OFICIO LIKE 'EMPLEADO'
	GROUP BY DEPT_NO;

  DEPT_NO   N�emple
--------- ---------                   
       10         1
       20         2
       30         1

-- 6�) 
SELECT DEPT_NO, COUNT(*) "N�emple"
	FROM EMPLE
	WHERE OFICIO LIKE 'EMPLEADO'
	GROUP BY DEPT_NO
	HAVING COUNT(*) = (SELECT MAX(COUNT(*)) 
						FROM EMPLE 
						WHERE OFICIO LIKE 'EMPLEADO' 
						GROUP BY DEPT_NO);

  DEPT_NO   N�emple
--------- ---------                   
       20         2

-- 7�) 
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
       20 INVESTIGACI�N

--- 8�) 
SELECT DEPT_NO, COUNT(*) 
	FROM EMPLE 
	GROUP BY DEPT_NO, OFICIO  
	HAVING COUNT(*) > 2;

DEPT_NO  COUNT(*)
------- ---------                  
     30         4

-- 9�) 
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

-- 10�) 
SELECT estante, sum(ejemplares) 
	FROM LIBRERIA
	HAVING  SUM(ejemplares) = (SELECT MAX(SUM(ejemplares))  
								FROM LIBRERIA  
								GROUP BY  estante)
	GROUP BY estante;

E SUM(EJEMPLARES)
- ---------------
A              36

-- 11�) 
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

-- 12�)
SELECT ESTANTE, COUNT(*) "N� temas" 
	FROM LIBRERIA 
	GROUP BY ESTANTE;

E  N� temas
- ---------
A         3
B         2
C         3
D         2
E         1

-- 13�)
SELECT ESTANTE, COUNT(*) "N� temas"  
	FROM LIBRERIA
	GROUP BY ESTANTE
	HAVING COUNT(*) = 3;

E  N� temas
- ---------
A         3
C         3
























TABLAS ALUM, ANTIGUOS, NUEVOS

11�) 
SQL> SELECT NOMBRE FROM ALUM INTERSECT
  2  (SELECT NOMBRE FROM ANTIGUOS
  3  UNION
  4  SELECT NOMBRE FROM NUEVOS);

12�) 

SQL> SELECT NOMBRE FROM ALUM
  2  WHERE NOMBRE IN
  3  (SELECT NOMBRE FROM NUEVOS)
  4  OR
  5  NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);	SQL> SELECT NOMBRE FROM ALUM
  2  WHERE NOMBRE IN
  3  (SELECT NOMBRE FROM ANTIGUOS 
  4  UNION
  5  SELECT NOMBRE FROM NUEVOS);


13�) 

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

14�) 
SQL> SELECT NOMBRE FROM ALUM
  2  WHERE NOMBRE IN (SELECT NOMBRE FROM NUEVOS)
  4  AND   NOMBRE IN (SELECT NOMBRE FROM ANTIGUOS);

15�) 

SQL>  SELECT NOMBRE FROM ALUM
  2  MINUS
  3   (SELECT NOMBRE FROM ANTIGUOS
  4   UNION
5	SELECT NOMBRE FROM NUEVOS);	SQL> SELECT NOMBRE FROM ALUM
  2  WHERE NOMBRE NOT IN
  3  (SELECT NOMBRE FROM ANTIGUOS
  4  UNION
  5  SELECT NOMBRE FROM NUEVOS);


17�) 
SQL>  SELECT NOMBRE, ESPECIALIDAD, COUNT(DNI) "N�m.Profes"
  2   FROM CENTROS C, PROFESORES P
  3   WHERE C.COD_CENTRO=P.COD_CENTRO(+)
  4  GROUP BY NOMBRE, ESPECIALIDAD;

NOMBRE                         ESPECIALIDAD     N�m.Profes
------------------------------ ---------------- ----------
CP Los Danzantes               DIBUJO                    1
CP Los Danzantes               LENGUA                    2
CP Manuel Hidalgo              INFORM�TICA               1
IES Anto�ete                                             0
IES El Quijote                 INFORM�TICA               1
IES El Quijote                 MATEM�TICAS               2
IES Planeta Tierra             MATEM�TICAS               1

7 filas seleccionadas.

18�) 
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
        50 IES Anto�ete                           0

19�) 
SQL> Select especialidad from profesores
  2  Group by especialidad
  3  Having count(*) = (select min(count(*)) from profesores group by especialidad);

ESPECIALIDAD
----------------
DIBUJO

20�) 
SQL> SELECT FUNCION,  COUNT(*) FROM PERSONAL GROUP BY FUNCION;

FUNCION          COUNT(*)
--------------- ---------
ADMINISTRATIVO          4
CONSERJE                2
PROFESOR                8

TABLA LIBRERIA:



