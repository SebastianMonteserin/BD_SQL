/*
                      TP BASE DE DATOS - SENTENCIAS SQL

	
 
A – Básicas 
1. Indicar cuáles son los títulos y autores de los libros cuyo tipo sea ‘no’ y sus precios originales superen los $21. */
SELECT LI.TITULO, LI.AUTOR
	FROM LIBRO LI
	WHERE LI.TIPO = 'no' AND LI.PRECIO_ORI > 21


/*
2. ¿Cuáles son los números, precios originales y ediciones de los libros cuyo tipo sea ‘no’ o que sus precios originales superen $21 y las ediciones sean posteriores a 1985? */
SELECT LI.NRO_LIBRO, LI.PRECIO_ORI, LI.EDICION
FROM LIBRO LI 
WHERE LI.TIPO = 'no' OR (LI.PRECIO_ORI > 21 AND LI.EDICION > 1985)

/*
3. Obtener la lista autores y ediciones de los libros cuyos nombres de autores comiencen con la letra L */
SELECT LI.AUTOR, LI.EDICION
FROM LIBRO LI
WHERE LI.AUTOR LIKE 'L%'


/*
4. Obtener la lista de autores y ediciones de los libros cuyos nombres de autores no comiencen con la letra G. */
SELECT LI.AUTOR, LI.EDICION
FROM LIBRO LI
WHERE LI.AUTOR NOT LIKE 'G%'

/*
5. Obtener la lista de autores, precios originales y ediciones de los libros cuyos autores tengan la hilera "RR" en algún lugar del nombre */
SELECT LI.AUTOR, LI.PRECIO_ORI, LI.EDICION
FROM LIBRO LI
WHERE LI.AUTOR  LIKE '%RR%'

/*
6. Obtener la lista de títulos y ediciones de aquellos libros cuyos precios originales no estén comprendidos entre $12 y $25. */
SELECT LI.TITULO, LI.EDICION
FROM LIBRO LI
WHERE LI.PRECIO_ORI  > 25 OR LI.PRECIO_ORI < 12

/*
7. Obtener todos los tipos y ediciones DISTINTAS(en tipo y Edición) de los libros, ordenado por Edición y año de edición ascendente. */
SELECT DISTINCT  LI.TIPO, LI.EDICION 
FROM LIBRO LI
ORDER BY LI.EDICION

/*
8. Listar los números, ediciones, tipos, precios originales, precios actuales y diferencias de precios para todos los libros clasificado por tipo y por dicha diferencia en forma ascendente, en ese orden. */
SELECT DISTINCT  LI.NRO_LIBRO,  LI.EDICION, LI.TIPO, LI.PRECIO_ORI, LI.PRECIO_ACT, (LI.PRECIO_ACT - LI.PRECIO_ORI ) AS DIF_PRECIO
FROM LIBRO LI
ORDER BY LI.TIPO, DIF_PRECIO
/*
9. Listar los números, ediciones, tipos, precios originales, precios actuales y diferencias de precios para todos los libros de estudio. */
SELECT LI.NRO_LIBRO, LI.EDICION, LI.TIPO, LI.PRECIO_ORI, LI.PRECIO_ACT, (LI.PRECIO_ACT - LI.PRECIO_ORI ) AS DIF_PRECIO
FROM LIBRO LI
WHERE LI.TIPO = 'es'
/*
10. ¿Cuáles son los números, precios originales y ediciones de los libros cuyas ediciones son posteriores a 1985 y además o bien el tipo es ‘no’ o el precio original supera $21? */
SELECT LI.NRO_LIBRO, LI.PRECIO_ORI, LI.EDICION
FROM LIBRO LI
WHERE (LI.EDICION > 1985) AND ( LI.TIPO = 'no' or LI.PRECIO_ORI > 21)

/*
11. ¿Cuáles son los títulos y nombres de los autores de los libros cuyo tipo sea ‘no’ o aquellos cuyos precios de origen superan $21? */
SELECT LI.TITULO, LI.AUTOR
FROM LIBRO LI
WHERE LI.TIPO = 'no' or LI.PRECIO_ORI > 21

/*
12. Obtener la lista de títulos y precios originales de los libros que se editaron en 1948, 1978 y 1985 */
SELECT LI.TITULO, LI.PRECIO_ORI
FROM LIBRO LI
WHERE LI.EDICION IN (1948, 1978, 1985)

/*
13. Obtener los títulos y ediciones de los libros cuyos precios originales estén dentro del rango de $12 a $25 inclusive */
SELECT LI.TITULO, LI.EDICION
FROM LIBRO LI
WHERE LI.PRECIO_ORI BETWEEN 12 AND 25

/*
14. Obtener la lista de títulos, precios originales y ediciones de aquellos libros cuyos títulos tengan las letras "R" y "S" en algún lugar y en ese orden. */
SELECT LI.TITULO, LI.PRECIO_ORI, LI.EDICION
FROM LIBRO LI
WHERE LI.TITULO LIKE '%R%S%'

/*
15. Obtener la lista de títulos, precios originales y ediciones de aquellos libros que tengan la letra "A" en la segunda posición del título. */
SELECT LI.TITULO, LI.PRECIO_ORI, LI.EDICION
FROM LIBRO LI
WHERE LI.TITULO LIKE '_A%'

/*
16. Ordenar en secuencia ascendente por año de edición los títulos de los libros cuyo tipo sea ‘no’. Listar también la edición. */

SELECT LI.TITULO, LI.EDICION
FROM LIBRO LI
WHERE LI.TIPO = 'no'
ORDER BY LI.EDICION
/*
17. Listar los números, ediciones y tipos de libros cuyos precios originales superen los $20. Clasificar por edición en forma descendente y por número de libro ascendente en ese orden. */

SELECT LI.NRO_LIBRO, LI.EDICION, LI.TIPO
FROM LIBRO LI
WHERE LI.PRECIO_ORI > 20
ORDER BY LI.EDICION DESC, LI.NRO_LIBRO



/*
18. Listar los números, ediciones, tipos, precios originales, precios actuales y diferencias de precios para todos los libros cuyas diferencias de precio sean superiores a $10. */
SELECT LI.NRO_LIBRO, LI.EDICION, LI.TIPO, LI.PRECIO_ORI, LI.PRECIO_ACT, (LI.PRECIO_ACT - LI.PRECIO_ORI) AS DIF_PRECIO
FROM LIBRO LI
WHERE (LI.PRECIO_ACT - LI.PRECIO_ORI) > 10




/*
19. Listar los números, ediciones, tipos, precios originales, precios actuales y diferencias de precios para todos los libros cuyas diferencias de precio sean superiores a $10, clasificado por dicha diferencia en forma descendente. */
SELECT LI.NRO_LIBRO, LI.EDICION, LI.TIPO, LI.PRECIO_ORI, LI.PRECIO_ACT, (LI.PRECIO_ACT - LI.PRECIO_ORI) AS DIF_PRECIO
FROM LIBRO LI
WHERE (LI.PRECIO_ACT - LI.PRECIO_ORI) > 10
ORDER BY DIF_PRECIO DESC
/*
B - Funciones de Agregación, Having 
1. Obtener la suma y el promedio de los precios originales y el mínimo y el máximo de los precios actuales para todos los libros cuyo año de edición sea mayor a 1970 */
SELECT SUM(LI.PRECIO_ORI) AS SUMA, AVG(LI.PRECIO_ORI) AS PROMEDIO, MIN(LI.PRECIO_ACT) MINIMO, MAX(LI.PRECIO_ACT) MAXIMO
FROM LIBRO LI
WHERE LI.EDICION > 1970
/*
2. Obtener de la suma total de la suma de los precios originales más los actuales, el promedio de dicha suma y el mínimo y el máximo de las diferencias de precios para todos los libros cuyo año de edición sea superior a 1970.  */
SELECT   SUM(LI.PRECIO_ORI + LI.PRECIO_ACT) AS SUMA, AVG(LI.PRECIO_ORI + LI.PRECIO_ACT) PROMEDIO_SUMAS,  MIN(LI.PRECIO_ACT - LI.PRECIO_ORI) MINIMO, MAX (LI.PRECIO_ACT -LI.PRECIO_ORI) MAXIMO
FROM LIBRO LI
WHERE LI.EDICION > 1970
/*
3. Listar la cantidad de libros, los distintos tipos de libros, el mínimo y el máximo del precio original, pero sólo para aquellos libros cuyo precio original supere los $45. */
SELECT COUNT(LI.NRO_LIBRO) AS CANT_LIBROS , COUNT(DISTINCT TIPO) AS CANT_TIPO, MIN(PRECIO_ORI) AS [MIN], MAX(PRECIO_ORI) AS [MAX]
FROM LIBRO LI 
WHERE LI.PRECIO_ORI > 45
/*

4. Listar los tipos de libros, totales de precios originales, promedios de precios actuales, resumidos por tipo de libro y para los libros cuyas ediciones no sean de 1946, pero sólo para aquellos tipos de libros cuya sumatoria de precios originales supere $40. */
SELECT  LI.TIPO  , SUM(LI.PRECIO_ORI) SUMA_ORIGIN, AVG(LI.PRECIO_ACT) PROM_ACTUAL 
FROM LIBRO LI 
WHERE LI.EDICION <> 1946
GROUP BY TIPO
HAVING SUM(LI.PRECIO_ORI) > 40

/*
5. Listar los tipos de libros y promedios de precios originales agrupados por tipos, para aquellos tipos que tengan el promedio de sus precios originales por arriba del promedio de precios originales de todos los libros. */
SELECT  LI.TIPO , AVG(LI.PRECIO_ORI) PROM_ORI
FROM LIBRO LI 
GROUP BY TIPO
HAVING  AVG(LI.PRECIO_ORI) >ALL 
    (SELECT AVG(LI.PRECIO_ORI) 
	 FROM LIBRO LI)

/*
6. Listar los tipos de libros, totales de precios originales y promedios de precios actuales, de aquellos libros que fueron editados entre 1946 y 1975, resumidos por tipo de libro. */
SELECT  LI.TIPO , SUM(LI.PRECIO_ORI) TOTAL_ORIG, AVG(LI.PRECIO_ACT) PROMEDIO
FROM LIBRO LI 
WHERE LI.EDICION BETWEEN 1946 AND 1975
GROUP BY TIPO

/*
7. Listar los tipos de libros, totales de precios originales y promedios de precios actuales, de aquellos libros que no fueron editados en 1946, resumidos por tipo de libro clasificado por promedio de precios actuales de menor a mayor. */
SELECT  LI.TIPO , SUM(LI.PRECIO_ORI) TOTAL_ORIG, AVG(LI.PRECIO_ACT) PROMEDIO
FROM LIBRO LI 
WHERE LI.EDICION != 1946 
GROUP BY TIPO
ORDER BY AVG(LI.PRECIO_ACT) ASC



/*
8. Listar los tipos de libros, totales de precios originales y promedios de precios actuales, de aquellos libros que fueron editados entre 1946 y 1975, resumidos por tipo de libro. */
SELECT  LI.TIPO , SUM(LI.PRECIO_ORI) TOTAL_ORIG, AVG(LI.PRECIO_ACT) PROMEDIO
FROM LIBRO LI 
WHERE LI.EDICION BETWEEN 1946 AND 1975
GROUP BY TIPO


/*
9. Listar el salario máximo agrupado por el tipo de trabajo. */
SELECT  MAX(LE.SALARIO)
FROM LECTOR LE 
GROUP BY LE.TRABAJO


/*
10. Listar el salario promedio agrupado por tipo de trabajo de los lectores que viven en capital. */
SELECT  AVG(LE.SALARIO) PROMEDIO, LE.DIRECCION
FROM LECTOR LE 
WHERE DIRECCION LIKE '%Cap%' OR  DIRECCION LIKE '%PALE%'  OR  DIRECCION LIKE '%B.CHINO%'
GROUP BY LE.TRABAJO,LE.DIRECCION
 

/*
C - Uso de Operadores Especiales (ALL, ANY) , SubQuerys 
1. Obtener los cinco primeros caracteres de los nombres de todos los lectores de libros */
SELECT  SUBSTRING(LE.NOMBRE, 1,5) AS NOMBRE
FROM LECTOR LE 


/*
2. Listar los nombres y la dirección de los lectores que tienen libros a préstamo (usar subconsultas) */
SELECT  LE.NOMBRE AS NOMBRE, LE.DIRECCION AS DIRECCION
FROM LECTOR LE, PRESTAMO PRE
WHERE (LE.NRO_LECTOR = PRE.NRO_LECTOR) AND PRE.F_DEVOL IS NULL

/*
3. Listar el número, título y precio actual del libro que tenga el máximo precio original. */
SELECT  LI.NRO_LIBRO , LI.TITULO ,  LI.PRECIO_ACT 
FROM LIBRO LI
WHERE LI.PRECIO_ORI = ALL 
    (SELECT MAX(LI.PRECIO_ORI)
     FROM LIBRO LI)


/*
4. Listar el número, título y precio original de aquellos libros cuyos precios originales sean más alto s que el promedio de precios actuales de todos los libros. */
SELECT  LI.NRO_LIBRO , LI.TITULO ,  LI.PRECIO_ORI
FROM LIBRO LI
WHERE LI.PRECIO_ORI > ALL 
    (SELECT AVG(LI.PRECIO_ACT)
     FROM LIBRO LI)
/*
5. Listar los números, títulos y precios originales de aquellos libros cuyos precios originales sean mayores que todos y cada uno de los precios originales de las novelas. */
SELECT  LI.NRO_LIBRO , LI.TITULO ,  LI.PRECIO_ORI
FROM LIBRO LI
WHERE LI.PRECIO_ORI > ALL 
    (SELECT LI.PRECIO_ORI
     FROM LIBRO LI
	 WHERE LI.TIPO = 'no')

/*
6. Listar los números, títulos y precios originales de aquellos libros cuyos precios originales sean mayores que alguno cualquiera de los precios originales de las novelas. */
SELECT  LI.NRO_LIBRO , LI.TITULO ,  LI.PRECIO_ORI
FROM LIBRO LI
WHERE LI.PRECIO_ORI > ANY 
    (SELECT LI.PRECIO_ORI
     FROM LIBRO LI
	 WHERE LI.TIPO = 'no')



/*
D - Consultas en varias tablas – uso de join (inner join – left join – right join) 
1. Listar el Titulo, fecha de Préstamo y la fecha de Devolución de los Libros prestados */
SELECT  LI.TITULO,  P.F_PREST, P.F_DEVOL
FROM LIBRO LI INNER JOIN
PRESTAMO P ON
LI.NRO_LIBRO = P.NRO_LIBRO
	
/*
2. Listar el Nro de Libro, Titulo, fecha de Préstamo y la fecha de Devolución de los Libros prestados */
SELECT  LI.NRO_LIBRO, LI.TITULO, P.F_PREST, P.F_DEVOL
FROM LIBRO LI INNER JOIN
PRESTAMO P ON
LI.NRO_LIBRO = P.NRO_LIBRO
/*
3. Listar el número de lector, su nombre y la cantidad de préstamos realizados a ese lector. */
SELECT   LE.NRO_LECTOR, LE.NOMBRE, COUNT(P.NRO_LECTOR) PRESTAMOS
FROM LECTOR LE INNER JOIN
PRESTAMO P ON
LE.NRO_LECTOR = P.NRO_LECTOR
GROUP BY LE.NRO_LECTOR, LE.NOMBRE

/*
4. Listar el número de libro, el título, el número de copia, y la cantidad de préstamos realizados para cada copia de cada libro. */
SELECT   LI.NRO_LIBRO, LI.TITULO, P.NRO_COPIA, COUNT(P.NRO_COPIA) PRESTAMOS_COPIA
FROM LIBRO LI INNER JOIN
PRESTAMO P ON
P.NRO_LIBRO = LI.NRO_LIBRO
GROUP BY LI.NRO_LIBRO, LI.TITULO, P.NRO_COPIA


/*
5. Listar el número de libro, el título, y la cantidad de préstamos realizados para ese libro a partir del año 2012 */
SELECT   LI.NRO_LIBRO, LI.TITULO,  COUNT(P.NRO_LIBRO) PRESTAMOS
FROM LIBRO LI INNER JOIN
PRESTAMO P ON
 LI.NRO_LIBRO = P.NRO_LIBRO 
WHERE P.F_PREST >  '2012-01-01 00:00:00:000'
GROUP BY LI.NRO_LIBRO, LI.TITULO

/*
6. Listar el número de libro, el título, el número de copia, y la cantidad de préstamos realizados para cada copia de cada libro, pero sólo para aquellas copias que se hayan prestado más de 1 vez. */
SELECT   LI.NRO_LIBRO, LI.TITULO, P.NRO_COPIA,  COUNT(P.NRO_COPIA) PRESTAMOS_COPIA
FROM LIBRO LI INNER JOIN
PRESTAMO P ON
 LI.NRO_LIBRO = P.NRO_LIBRO 
 GROUP BY LI.NRO_LIBRO, LI.TITULO, P.NRO_COPIA
 HAVING COUNT(P.NRO_LIBRO) > 1


/*
7. Listar el Nro de Libro, Titulo, nro de Copia y Fecha de Préstamo, de todas las Copias, hayan sido prestadas o no */
SELECT  LI.NRO_LIBRO, LI.TITULO, P.NRO_COPIA, P.F_PREST
FROM LIBRO LI LEFT JOIN
PRESTAMO P  ON
LI.NRO_LIBRO = P.NRO_LIBRO 
GROUP BY P.NRO_COPIA,  LI.NRO_LIBRO, LI.TITULO, P.F_PREST


 /*
8. Listar Nro de Lector, Nombre, nro de Libro, Titulo, Descripción del Tipo de Libro , fecha de préstamo que aquellos Prestamos que hayan sido devueltos y el tipo de Libro sea Novela o Cuentos */
SELECT  LE.NRO_LECTOR, LE.NOMBRE, LI.NRO_LIBRO, LI.TITULO, TI.DESCTIPO, P.F_PREST
FROM PRESTAMO P INNER JOIN
LIBRO LI  ON
P.NRO_LIBRO = LI.NRO_LIBRO 
INNER JOIN TIPOLIBRO TI ON
LI.TIPO = TI.TIPO
INNER JOIN LECTOR LE ON
LE.NRO_LECTOR = P.NRO_LECTOR
WHERE P.F_DEVOL!= NULL AND TI.TIPO IN ('no','cu')





 /*
9. Obtener la lista de los títulos de los libros prestados y los nombres de los lectores que los tienen en préstamo */
SELECT  LI.TITULO, LE.NOMBRE
FROM PRESTAMO P INNER JOIN
LIBRO LI ON
P.NRO_LIBRO = LI.NRO_LIBRO
INNER JOIN LECTOR LE ON
LE.NRO_LECTOR = P.NRO_LECTOR
WHERE P.F_DEVOL IS NULL


 /*
10. Listar el Nro de Lector, Nombre y fecha de Préstamo de aquellos Lectores que hayan realizado un préstamo y no lo hayan devuelto */
 SELECT P.NRO_LECTOR, LE.NOMBRE, P.F_PREST
 FROM PRESTAMO P INNER JOIN
 LECTOR LE ON
 P.NRO_LECTOR = LE.NRO_LECTOR
 WHERE P.F_DEVOL IS NULL
 /*
11. Listar Nro de Lector, Nombre, nro de Libro, Titulo, fecha de préstamo que aquellos Prestamos que hayan sido devueltos */
 SELECT P.NRO_LECTOR, LE.NOMBRE, P.NRO_LIBRO, LI.TITULO, P.F_PREST
 FROM PRESTAMO P INNER JOIN
 LECTOR LE ON
 P.NRO_LECTOR = LE.NRO_LECTOR
 INNER JOIN LIBRO LI ON
 LI.NRO_LIBRO = P.NRO_LIBRO
 WHERE P.F_DEVOL IS NOT NULL 
 

 /*
12. Listar Nro de Lector, Nombre, nro de Libro, Titulo, fecha de préstamo que aquellos Prestamos que hayan sido devueltos y el tipo de Libro sea Novela o Cuentos */
SELECT LE.NRO_LECTOR, LE.NOMBRE, LI.NRO_LIBRO, LI.TITULO, P.F_PREST
FROM  LECTOR LE INNER JOIN
 PRESTAMO P ON
P.NRO_LECTOR = LE.NRO_LECTOR
INNER JOIN LIBRO LI ON
P.NRO_LIBRO = LI.NRO_LIBRO
WHERE  P.F_DEVOL IS NOT NULL AND LI.TIPO IN ('no','cu')

 /*
13. Listar el Nro de Lector, Nombre y fecha de Préstamo de Todos los Lectores, hayan tenido Prestamos o no */
SELECT LE.NRO_LECTOR, LE.NOMBRE, P.F_PREST
FROM LECTOR LE LEFT JOIN
PRESTAMO P ON
LE.NRO_LECTOR = P.NRO_LECTOR


/*
E – Insert – Update - Delete 
1. Agregar un nuevo LIBRO y sus respectivos valores a la tabla COPIAS. */


INSERT INTO COPIAS
VALUES (123456, 2, NULL)

/*
2. Modificar el precio Actual del Libro LAS MIL Y UNA NOCHES a 35.35 */

UPDATE LIBRO
SET PRECIO_ACT = 35.35
WHERE TITULO = 'LAS MIL Y UNA NOCHES'


/*
3. Eliminar los lectores cuyo salario sea menor $ 1000. ¿Cuántos lectores se han eliminado? */
DELETE FROM LECTOR
WHERE SALARIO < 1000

/*SE ELIMINARON 4 LECTORES*/


/*
F – PLUS 
1. Realizar una sentencia SQL que involucre TODOS los campos de TODAS las tablas 

¿Es esto posible?
*/
SELECT * FROM LIBRO
FULL JOIN PRESTAMO ON LIBRO.NRO_LIBRO = PRESTAMO.NRO_LIBRO
FULL JOIN COPIAS ON COPIAS.NRO_COPIA = PRESTAMO.NRO_COPIA
FULL JOIN LECTOR ON LECTOR.NRO_LECTOR = PRESTAMO.NRO_LECTOR
FULL JOIN TIPOLIBRO ON TIPOLIBRO.TIPO = LIBRO.TIPO
