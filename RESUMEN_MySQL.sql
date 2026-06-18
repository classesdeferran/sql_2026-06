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
DROP COLUMN provincia;

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




