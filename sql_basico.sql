-- Esto es un comentario
# Esto es otro comentario
/*
Comentario
Multilinea
*/

-- Mostrar todas las bases de datos del sistema
SHOW databases;

-- Crear una base de datos
CREATE DATABASE IF NOT EXISTS primeraBD;

-- Borrar la base de datos
# DROP DATABASE IF EXISTS primeraBD;

-- Indicar cual BD quiero utilizar
USE primeraBD;

-- Borrar una tabla
DROP TABLE IF EXISTS test;

-- Creación de una tabla
CREATE TABLE IF NOT EXISTS test (
	id_test INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_producto VARCHAR(25) NOT NULL,
    coste_producto DECIMAL(8,2) NULL,
    precio_venta DECIMAL(8,2) NULL
);

SELECT * 
FROM test;

-- FROM test SELECT *;

-- INSERT -> inserta datos = introduce datos
INSERT INTO test(nombre_producto, coste_producto, precio_venta) 
VALUES ("Iphone 17", 800, 1400);
INSERT INTO test(nombre_producto, coste_producto) 
VALUES ("Samsung S45", 600);

-- UPDATE --> modificar valores
UPDATE test 
SET precio_venta = 1250
WHERE nombre_producto = "Samsung S45";

/*
C = Create = Crear (Insert)
R = Read = Leer (Select)
U = Update = Modificación
D = Delete = Borrar
*/

-- DELETE
DELETE FROM test
WHERE id_test = 3;

INSERT INTO test(nombre_producto, coste_producto, precio_venta) 
VALUES 
("Xiaomi 18", 400, 800),
("Motorola", 400, 785.45), 
("Macbook", 2000, 3500);

ALTER TABLE test
ADD COLUMN nombre_proveedor VARCHAR(20) NULL;

ALTER TABLE test
ADD COLUMN marca_producto VARCHAR(20) NULL;

SELECT * 
FROM test;

UPDATE test
SET marca_producto = "Apple"
WHERE coste_producto >= 800;

UPDATE test
SET marca_producto = "Samsung"
WHERE nombre_producto LIKE "%Samsung%";

UPDATE test
SET marca_producto = "Xiaomi"
WHERE nombre_producto LIKE "%Xiaomi%";

UPDATE test
SET marca_producto = "Motorola"
WHERE nombre_producto LIKE "%Motorola%";

-- Los productos de marca Apple los vende la empresa Jobs SA y los demás Gates SL
UPDATE test
set nombre_proveedor = "Gates SL";

UPDATE test
set nombre_proveedor = "Jobs SA"
WHERE marca_producto = "Apple";

UPDATE test
set nombre_proveedor = null;

UPDATE test
set nombre_proveedor = "Gates SL"
WHERE marca_producto != "Apple";


CREATE TABLE proveedores (
	id_proveedor INT AUTO_INCREMENT NOT NULL PRIMARY KEY,-- clave primaria
    nombre_proveedor VARCHAR(20) NOT NULL,
    tel_fijo VARCHAR(9) NOT NULL,
    id_poblacion INT NOT NULL -- clave foránea o foreign key
);

ALTER TABLE proveedores
MODIFY COLUMN id_poblacion INT NULL; 

INSERT INTO proveedores(nombre_proveedor, tel_fijo) VALUES
("Jobs SA", "123456789"),("Gates SL", "234567891"),("Pepezon", "345678912");

CREATE TABLE poblaciones (
id_poblacion INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
nombre_poblacion VARCHAR(40)
);

INSERT INTO poblaciones(nombre_poblacion) VALUES
("Barcelona"), ("Bilbao"), ('Santa Coloma');

SELECT * FROM poblaciones;
SELECT * FROM proveedores;



