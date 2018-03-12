-- 2�)
SELECT COUNT(APELLIDO) 
	FROM EMPLE
	WHERE (SUBSTR(APELLIDO,1,1))='A';

-- 3�)
SELECT TO_CHAR(avg(salario),'999G999D99') "Salario Medio", 
	COUNT(comision) "Com no nulas",  
	TO_CHAR(max(salario),'999G999D99') "Salario M�ximo", 
	TO_CHAR(min(salario),'999G999D99') "Salario M�nimo"
	FROM EMPLE;

-- 4�)
SELECT COUNT(tema) 
	FROM LIBRERIA 
	WHERE tema LIKE '%a%';

-- 5�)
SELECT tema 
	FROM LIBRERIA 
	WHERE TEMA LIKE '%e%'
	and EJEMPLARES = (SELECT max(EJEMPLARES) FROM LIBRERIA WHERE TEMA LIKE 	'%e%');

-- 6�)
SELECT COUNT(distinct ESTANTE) "N�mero estantes" FROM LIBRERIA;

-- 7�)
SELECT COUNT(distinct ESTANTE) "Distintos" FROM LIBRERIA WHERE tema LIKE '%e%';
 
-- 8�)
SELECT RPAD(RTRIM(LTRIM(TITULO,'".'),'".'), 40,'-^') RESULTADO FROM MISTEXTOS;

-- 9�)
SELECT LOWER(RTRIM(LTRIM(TITULO,'".'),'".')) FROM MISTEXTOS;
-- DE OTRA MANERA :
SELECT LOWER(TRANSLATE(TITULO,'A".','A')) FROM MISTEXTOS;

-- 10�)
SELECT AUTOR, SUBSTR(AUTOR,1,INSTR(AUTOR,',') - 1) "Apellido" FROM LIBROS;

-- 11�)
SELECT AUTOR, SUBSTR(AUTOR,INSTR(AUTOR,',') + 2) "Nombre" FROM libros;

-- 12�)
SELECT SUBSTR(AUTOR,INSTR(AUTOR,',') + 2) || ' ' ||	SUBSTR(AUTOR,1,INSTR(AUTOR,',') - 1) "Nombre y apellido"
	FROM LIBROS;

-- 13�)
SELECT TITULO, LENGTH(TITULO) "Longitud" FROM LIBROS ORDER BY LENGTH(TITULO);

-- 14�)
SELECT nombre, fechanac,
	to_char(fechanac, '"Naci� el" dd "de" month "de" yyyy') "Formateado"
	FROM NACIMIENTOS;

-- 15�)
SELECT TEMA, 
	SUBSTR(RTRIM(TEMA,' '), LENGTH(RTRIM(TEMA,' ')),1) Caracter, 
	LENGTH(RTRIM(TEMA,' ')) "N� de caracteres"
	FROM LIBRERIA order by TEMA;

-- 16�)
SELECT TRANSLATE(NOMBRE,'G ','G') ||' '||
	TO_CHAR(fechanac, '"Naci� el" dd "de" month "de" yyyy') "Fecha nacimiento"  
	FROM NACIMIENTOS;

-- 17�)
SELECT TO_CHAR(TO_DATE('01072012','ddmmyyyy'), 'MONTH') FROM DUAL;

-- 18�) 
SELECT TEMA, EJEMPLARES,  
	DECODE(EJEMPLARES,7,'SEVEN',TEMA)   "CODIGO"
	FROM LIBRERIA;

-- 19�)
SELECT apellido  
	FROM EMPLE
	WHERE months_between(SYSDATE,FECHA_ALT)/12 >19;

-- 20�)
SELECT APELLIDO 
FROM EMPLE E, DEPART D
	WHERE MONTHS_BETWEEN(SYSDATE,FECHA_ALT)/12 >18
	AND D.DEPT_NO=E.DEPT_NO
	AND DNOMBRE='VENTAS';

update EMPLE
	set FECHA_ALT=add_months(FECHA_ALT,18*12);

-- 21�)
SELECT  apellido, salario, dept_no  
	FROM emple e
	WHERE salario IN 
	(SELECT max(salario) FROM emple WHERE dept_no=e.dept_no);

-- 22�)
SELECT  apellido, salario, dept_no  
	FROM emple e
	WHERE salario > 
	(SELECT AVG(SALARIO) FROM emple WHERE dept_no=e.dept_no);
