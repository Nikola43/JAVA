-- 2º)
SELECT COUNT(APELLIDO) 
	FROM EMPLE
	WHERE (SUBSTR(APELLIDO,1,1))='A';

-- 3º)
SELECT TO_CHAR(avg(salario),'999G999D99') "Salario Medio", 
	COUNT(comision) "Com no nulas",  
	TO_CHAR(max(salario),'999G999D99') "Salario Máximo", 
	TO_CHAR(min(salario),'999G999D99') "Salario Mínimo"
	FROM EMPLE;

-- 4º)
SELECT COUNT(tema) 
	FROM LIBRERIA 
	WHERE tema LIKE '%a%';

-- 5º)
SELECT tema 
	FROM LIBRERIA 
	WHERE TEMA LIKE '%e%'
	and EJEMPLARES = (SELECT max(EJEMPLARES) FROM LIBRERIA WHERE TEMA LIKE 	'%e%');

-- 6º)
SELECT COUNT(distinct ESTANTE) "Número estantes" FROM LIBRERIA;

-- 7º)
SELECT COUNT(distinct ESTANTE) "Distintos" FROM LIBRERIA WHERE tema LIKE '%e%';
 
-- 8º)
SELECT RPAD(RTRIM(LTRIM(TITULO,'".'),'".'), 40,'-^') RESULTADO FROM MISTEXTOS;

-- 9º)
SELECT LOWER(RTRIM(LTRIM(TITULO,'".'),'".')) FROM MISTEXTOS;
-- DE OTRA MANERA :
SELECT LOWER(TRANSLATE(TITULO,'A".','A')) FROM MISTEXTOS;

-- 10º)
SELECT AUTOR, SUBSTR(AUTOR,1,INSTR(AUTOR,',') - 1) "Apellido" FROM LIBROS;

-- 11º)
SELECT AUTOR, SUBSTR(AUTOR,INSTR(AUTOR,',') + 2) "Nombre" FROM libros;

-- 12º)
SELECT SUBSTR(AUTOR,INSTR(AUTOR,',') + 2) || ' ' ||	SUBSTR(AUTOR,1,INSTR(AUTOR,',') - 1) "Nombre y apellido"
	FROM LIBROS;

-- 13º)
SELECT TITULO, LENGTH(TITULO) "Longitud" FROM LIBROS ORDER BY LENGTH(TITULO);

-- 14º)
SELECT nombre, fechanac,
	to_char(fechanac, '"Nació el" dd "de" month "de" yyyy') "Formateado"
	FROM NACIMIENTOS;

-- 15º)
SELECT TEMA, 
	SUBSTR(RTRIM(TEMA,' '), LENGTH(RTRIM(TEMA,' ')),1) Caracter, 
	LENGTH(RTRIM(TEMA,' ')) "Nº de caracteres"
	FROM LIBRERIA order by TEMA;

-- 16º)
SELECT TRANSLATE(NOMBRE,'G ','G') ||' '||
	TO_CHAR(fechanac, '"Nació el" dd "de" month "de" yyyy') "Fecha nacimiento"  
	FROM NACIMIENTOS;

-- 17º)
SELECT TO_CHAR(TO_DATE('01072012','ddmmyyyy'), 'MONTH') FROM DUAL;

-- 18º) 
SELECT TEMA, EJEMPLARES,  
	DECODE(EJEMPLARES,7,'SEVEN',TEMA)   "CODIGO"
	FROM LIBRERIA;

-- 19º)
SELECT apellido  
	FROM EMPLE
	WHERE months_between(SYSDATE,FECHA_ALT)/12 >19;

-- 20º)
SELECT APELLIDO 
FROM EMPLE E, DEPART D
	WHERE MONTHS_BETWEEN(SYSDATE,FECHA_ALT)/12 >18
	AND D.DEPT_NO=E.DEPT_NO
	AND DNOMBRE='VENTAS';

update EMPLE
	set FECHA_ALT=add_months(FECHA_ALT,18*12);

-- 21º)
SELECT  apellido, salario, dept_no  
	FROM emple e
	WHERE salario IN 
	(SELECT max(salario) FROM emple WHERE dept_no=e.dept_no);

-- 22º)
SELECT  apellido, salario, dept_no  
	FROM emple e
	WHERE salario > 
	(SELECT AVG(SALARIO) FROM emple WHERE dept_no=e.dept_no);
