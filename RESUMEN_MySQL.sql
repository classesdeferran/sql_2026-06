/*
Comentario
multilinea
*/
# Comentario de una linea
-- Otro comentario de una línea

/*
S tructured
Q uery
L anguage
SQL = Lenguaje de Consultas Estructurado

SQL es un sistema de bases de datos relacionales = RDBMS
SQL se implementa como motor de diversas formas:
MySQL, SQLite, MariaDB, Oracle DataBase, SQL Server (Microsoft)

filas = registros 
columnas = campos (siempre tienen un tipo de dato)

Entre corchetes se indica lo que es optativo

En MySQL cada línea debe terminar con punto y coma (;)
*/

/* 
Eliminación de la base de datos (BD)
DROP DATABASE [IF EXISTS] nombre_base_datos;

Creacion de la BD
CREATE DATABASE [IF NOT EXISTS] nombre_base_datos;

Qué BD hay en el sistema
SHOW DATABASES;

Indicar cuál BD vamos a usar
USE nombre_base_datos; 

Creación de una tabla
CREATE TABLE nombre_tabla (
	id tipo_de_dato [restricciones = constraints],
    ...,
    Indicar más restricciones
);
*/
DROP DATABASE IF EXISTS clinica;
CREATE DATABASE IF NOT EXISTS clinica;
USE clinica;

CREATE TABLE poblaciones (
	id_poblacion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_poblacion VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS poblaciones (
	id_poblacion INT NOT NULL AUTO_INCREMENT,
    nombre_poblacion VARCHAR(40) NOT NULL,
    PRIMARY KEY(id_poblacion)
);

CREATE TABLE usuarios (
	id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario varchar(40) NOT NULL,
    apellido_usuario varchar(60) NOT NULL,
    fecha_nacimiento date not null,
    dni varchar(10),
    id_poblacion INT NOT NULL,
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (dni)
);

/*
Eliminación de tablas:
DROP TABLE nombre_tabla;
Borrado de datos:
DELETE FROM nombre_tabla; -- Esto borra TODOS los datos (mantiene la posición de AUTO_INCREMENT)
DELETE FROM nombre_tabla WHERE condicion; -- Esto borra los datos que cumplan la condición
TRUNCATE TABLE nombre_tabla; -- Esto borra TODOS los datos (reinicia la posición de AUTO_INCREMENT) 
*/
/*
MODIFICACIÓN DE UNA TABLA
-- Cambiar el nombre de la tabla
ALTER TABLE nombre_tabla_inicial
RENAME TO nombre_tabla_nuevo;
*/
ALTER TABLE poblaciones
RENAME TO ciudades;
ALTER TABLE ciudades
RENAME TO poblaciones;

-- añadir una columna
ALTER TABLE poblaciones
ADD COLUMN provincia VARCHAR(20);

-- cambiar el nombre a una columna
ALTER TABLE poblaciones
RENAME COLUMN provincia TO distrito;

-- borrado de columna
ALTER TABLE poblaciones
DROP COLUMN distrito;

/*
TIPOS DE DATOS
-- Numéricos: INT, FLOAT, DECIMAL(digitos_totales, cantidad de decimales)
-- Texto: VARCHAR(cantidad máxima de caracteres), CHAR(cantidad fija de caracteres), TEXT
-- Fecha: 
--	DATE -> año-mes-dia
--	TIME -> hora-minutos-segundos o un intervalo de tiempo
--	DATETIME -> año-mes-dia hora-minutos-segundos
-- 	TIMESTAMP -> año-mes-dia hora-minutos-segundos en formato UTC
--	YEAR --> año
*/

/*
RESTRICCIONES = CONSTRAINTS
NOT NULL
UNIQUE
AUTO_INCREMENT
PRIMARY KEY
CHECK
UNSIGNED
*/

CREATE TABLE doctores (
	id_doctor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_doctor varchar(40) NOT NULL,
    apellido_doctor varchar(60) NOT NULL,
    fecha_nacimiento date not null,
    dni varchar(10),
    id_poblacion INT NOT NULL,
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    especialidad ENUM('Traumatología', 'Oftalmología'),
    UNIQUE (dni)
);

-- Ejemplo de creación de tabla con vinculaciones a otras
CREATE TABLE consultas (
	id_consulta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_doctor INT NOT NULL,
    fecha_concertada DATETIME NOT NULL,
    fecha_peticion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_consultas_usuarios 
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
	CONSTRAINT fk_consultas_doctores 
    FOREIGN KEY (id_doctor) REFERENCES doctores(id_doctor)
);
-- Crear las vinculaciones después de crear las tablas
ALTER TABLE usuarios
ADD CONSTRAINT fk_usuarios_poblaciones
FOREIGN KEY (id_poblacion)
REFERENCES poblaciones(id_poblacion);

ALTER TABLE doctores
ADD CONSTRAINT fk_doctores_poblaciones
FOREIGN KEY (id_poblacion)
REFERENCES poblaciones(id_poblacion);

ALTER TABLE doctores
MODIFY COLUMN especialidad ENUM('Traumatología', 'Oftalmología', 'Neurología');

ALTER TABLE consultas
ADD COLUMN tratamiento varchar(100);

/*
C reate => INSERT
R ead => SELECT
U pdate 
D elete
*/

# INSERT INTO nombre_tabla VALUES ()
INSERT INTO poblaciones VALUES(1, "Barcelona"); -- lo hace el sistema
INSERT INTO poblaciones(nombre_poblacion) VALUES ("Hospitalet"),('Cornellà');

# INSERT INTO usuarios_2 SELECT * FROM usuarios;

INSERT INTO usuarios(nombre_usuario, apellido_usuario, fecha_nacimiento, dni, id_poblacion) VALUES
("Peter", "Parker", "2000-01-01", "12345678A", 1);
INSERT INTO usuarios(nombre_usuario, apellido_usuario, fecha_nacimiento, dni, id_poblacion) VALUES
("Clark", "Kent", "1990-01-01", "12345678B", 1);
INSERT INTO usuarios(nombre_usuario, apellido_usuario, fecha_nacimiento, dni, id_poblacion) VALUES
("Son", "Goku", "2001-01-01", "12345678D", 1),
("Loise", "Lane", "1995-06-18", "12345678F", 2),
("John", "Lennon", "1998-06-18", "12345678E", 2);
INSERT INTO usuarios VALUES
(10,"John", "Smith","2001-01-01", "12345678G", 1, "2025-06-18 18:29:53", "2025-06-18 18:29:53");

# UPDATE => modificar el valor de datos
UPDATE usuarios
SET id_poblacion = 2
WHERE nombre_usuario = "John" AND apellido_usuario="Smith";

INSERT INTO usuarios(nombre_usuario, apellido_usuario, fecha_nacimiento, dni, id_poblacion) VALUES
("Tryon", "Lannister", "2001-01-01", "12345678H", 
(SELECT id_poblacion FROM poblaciones WHERE nombre_poblacion = "Barcelona"));

/* 
SELECT
FROM
NATURAL JOIN, [INNER] JOIN, LEFT JOIN, RIGHT JOIN, FULL [OUTER] JOIN + ON campos comunes
WHERE
GROUP BY 
HAVING
ORDER BY
LIMIT
*/

# MODIFICADORES WHERE

SELECT u.nombre_usuario, u.apellido_usuario
FROM usuarios u
NATURAL JOIN poblaciones p
WHERE p.nombre_poblacion = "Barcelona" OR p.nombre_poblacion = "Hospitalet";

SELECT u.nombre_usuario, u.apellido_usuario
FROM usuarios u
NATURAL JOIN poblaciones p
WHERE p.nombre_poblacion IN ("Barcelona", "Cornellà");

SELECT u.nombre_usuario, u.apellido_usuario
FROM usuarios u
NATURAL JOIN poblaciones p
WHERE p.nombre_poblacion NOT IN ("Barcelona", "Cornellà");

SELECT u.nombre_usuario, u.apellido_usuario
FROM usuarios u
WHERE u.nombre_usuario LIKE "J%";

SELECT u.nombre_usuario, u.apellido_usuario
FROM usuarios u
WHERE u.apellido_usuario LIKE "_e%";

SELECT u.nombre_usuario, u.apellido_usuario, u.fecha_nacimiento
FROM usuarios u
WHERE u.fecha_nacimiento BETWEEN '1995-01-01' AND '1999-12-31';

SELECT u.nombre_usuario, u.apellido_usuario, u.fecha_nacimiento
FROM usuarios u
WHERE u.nombre_usuario BETWEEN 'C' AND 'M';

# Queremos saber qué usuarios son de la misma ciudad
SELECT A.apellido_usuario as usuario_1, B.apellido_usuario as usuario2
FROM usuarios A, usuarios B
WHERE A.id_poblacion = B.id_poblacion AND A.apellido_usuario <> B.apellido_usuario
ORDER BY A.id_poblacion
;

/*
FUNCIONES del sistema
-- Lista de funciones: https://www.w3schools.com/mysql/mysql_ref_functions.asp

-- Funciones de agregación: MAX(), MIN(), AVG(), COUNT(), SUM()
-- Funciones lógicas: IFNULL(), IF(), COALESCE()
-- Funciones de texto: CONCAT, CONCAT_WS(), LOWER(), UPPER(), REPLACE()
-- Funciones de fecha
*/

# ¿Cuántos usuarios son de Barcelona?
SELECT count(*) as "usuarios de Barcelona"
FROM usuarios u
NATURAL JOIN poblaciones p
WHERE p.nombre_poblacion = "Barcelona";

SET @max_id = (SELECT MAX(id_poblacion) FROM usuarios u);
SELECT @max_id;

INSERT INTO doctores(nombre_doctor, apellido_doctor, fecha_nacimiento, id_poblacion, especialidad) VALUES
("James", "Cameron", "1980-12-25", 2, "Oftalmología");

-- TRUNCATE TABLE consultas;

ALTER TABLE consultas
MODIFY COLUMN tratamiento DECIMAL (5,2);

INSERT INTO consultas(id_usuario, id_doctor, fecha_concertada, tratamiento) VALUES
(1,1, "2026-06-19", 30), 
(2,1,"2026-06-22", 12 ), 
(2,1,"2026-07-22", 0 ), 
(3,1,"2026-06-25", 50 );

# Queremos saber cuál es el promedio de coste del tratamiento por usuario
SELECT id_usuario, AVG(tratamiento) 
FROM consultas
GROUP BY id_usuario;
 

# Queremos saber qué usuarios tienen el coste promedio por encima de la media de todos los tratamientos
SELECT id_usuario, AVG(tratamiento) as promedio_personal
FROM consultas
GROUP BY id_usuario
HAVING promedio_personal >(SELECT AVG(tratamiento) FROM consultas);

/* No funciona
SELECT id_usuario, AVG(tratamiento) as promedio_personal
FROM consultas
WHERE tratamiento >(SELECT AVG(tratamiento) 
FROM consultas)
GROUP BY id_usuario;
*/

# ¿Cuál/es usuarios (nombre y apellido) han realizado más consultas?
SELECT concat(u.nombre_usuario, " ", u.apellido_usuario) as usuario, COUNT(c.id_usuario) as consultas
FROM usuarios u
NATURAL JOIN consultas c
GROUP BY c.id_usuario
ORDER BY consultas DESC
LIMIT 1;

# ¿Cuál/es usuarios (nombre y apellido) han realizado menos consultas?
# Solución mala, no incluye necesariamente todos los registros
SELECT concat(u.nombre_usuario, " ", u.apellido_usuario) as usuario, COUNT(c.id_usuario) as consultas
FROM usuarios u
NATURAL JOIN consultas c
GROUP BY c.id_usuario
ORDER BY consultas ASC
LIMIT 1;

SELECT 
    CONCAT(u.nombre_usuario,
            ' ',
            u.apellido_usuario) AS usuario,
    COUNT(c.id_usuario) AS consultas
FROM
    usuarios u
        NATURAL JOIN
    consultas c
GROUP BY c.id_usuario
HAVING consultas = (SELECT 
        COUNT(c.id_usuario) AS consultas
    FROM
        usuarios u
            NATURAL JOIN
        consultas c
    GROUP BY c.id_usuario
    ORDER BY consultas DESC
    LIMIT 1);

SELECT CONCAT(u.nombre_usuario,
            ' ',
            u.apellido_usuario) AS usuario,
            COUNT(c.id_usuario) as consultas_usuarios
FROM usuarios u
NATURAL JOIN consultas c
GROUP BY c.id_usuario
HAVING consultas_usuarios > 1
ORDER BY consultas_usuarios ASC
LIMIT 1;












































/* REVISAR
USE clinica;
EXPLAIN SELECT id_usuario, AVG(tratamiento) as promedio_personal
FROM consultas
GROUP BY id_usuario
HAVING promedio_personal >(SELECT AVG(tratamiento) FROM consultas);

EXPLAIN ANALYZE SELECT id_usuario, AVG(tratamiento) as promedio_personal
FROM consultas
GROUP BY id_usuario
HAVING promedio_personal >(SELECT AVG(tratamiento) FROM consultas);

*/

/* ================================================
	FUNCIONES DEL SISTEMA
*/
/* IFNULL(campo a evaluar, que mostrar si la respuesta es NULL) */

# Qué usuarios sí han programado ninguna consulta todavía
SELECT DISTINCT concat(u.nombre_usuario,
            ' ',
            u.apellido_usuario) AS usuario            
FROM usuarios u
NATURAL JOIN consultas c;

# Qué usuarios no han programado ninguna consulta todavía
SELECT concat(u.nombre_usuario,
            ' ',
            u.apellido_usuario) AS usuario,
            IFNULL(c.id_consulta, 0) as consultas_programadas
FROM usuarios u
LEFT JOIN consultas c USING(id_usuario)
WHERE c.id_consulta IS NULL;

/* COALESCE(col_1, col_2, ...) */
ALTER TABLE usuarios
ADD COLUMN tel_movil VARCHAR(9),
ADD COLUMN tel_fijo VARCHAR(9);

UPDATE usuarios
SET tel_movil = "123456789"
WHERE id_usuario = 1;

UPDATE usuarios
SET tel_movil = "123456789"
WHERE id_usuario = 3;

UPDATE usuarios
SET tel_fijo = "987654321"
WHERE id_usuario = 11;

UPDATE usuarios
SET tel_fijo = "987654321"
WHERE id_usuario = 10;

SELECT concat(u.nombre_usuario,
            ' ',
            u.apellido_usuario) AS usuario,
            COALESCE(tel_movil, tel_fijo, "No tenemos datos de contacto") as contacto
FROM usuarios u;

/*  IF(condicion, is_verdadero, si_falso) */

# Podemos ofrecer un descuento a los usuarios que han nacido antes del año 2000
# Queremos que aparezca si tienen o no opción a ese descuento

SELECT concat(u.nombre_usuario,
            ' ',
            u.apellido_usuario) AS usuario,
			IF(u.fecha_nacimiento < "2000-01-01", "Sí", "No") as opcion_descuento
FROM usuarios u;

/* DATEDIFF(fecha_1, fecha_2) -> devuelve la diferencia en días */
# Queremos saber cuántos días han pasado desde que se pide una consulta hasta que se realiza
SELECT id_consulta, DATEDIFF(fecha_concertada, fecha_peticion) as dias
FROM consultas
WHERE DATEDIFF(fecha_concertada, fecha_peticion) > 5;

/* CURDATE() */
SELECT CURDATE();
/* NOW() */
SELECT NOW();

# Cuántos días faltan para las consultas pendientes
SELECT id_consulta, DATEDIFF(fecha_concertada, CURDATE()) as dias_que_faltan
FROM consultas
WHERE DATEDIFF(fecha_concertada, CURDATE()) > 0;

/* Esto provoca un error
SELECT id_consulta, 
IF(DATEDIFF(fecha_concertada, CURDATE()) > 0, DATEDIFF(fecha_concertada, CURDATE()), "consulta ya realizada") as dias_que_faltan
FROM consultas
WHERE dias_que_faltan > 1;
*/

/* RAND() -> genera números aleatorios entre 0 y 1 (pero el 1 no está incluido) */
SELECT RAND();

# números aleatorios entre 1 y 10
SELECT FLOOR(RAND() * 10) + 1;

/* SUBSTRING */
SELECT substring("AEIOU", 2, 1);

ALTER TABLE usuarios
ADD COLUMN codigo_usuario VARCHAR(9);

# Hay que actualizar los códigos de usuario con valores aleatorios
# según este patrón: 4 letras - 4 números. Por ejemplo: ABCD-1234
















