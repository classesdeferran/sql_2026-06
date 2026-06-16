# Base de datos de una tienda

# crear la base de datos
CREATE DATABASE IF NOT EXISTS tienda;

# indicar a mysql que vamos a usar la bd tienda
USE tienda;

# creación de la tabla productos
CREATE TABLE productos(
id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre_producto VARCHAR(30) NOT NULL,
nombre_proveedor VARCHAR(30) NOT NULL,
tel_proveedor VARCHAR(9),
email_proveedor VARCHAR(40),
ciudad_proveedor VARCHAR(20),
precio_compra DECIMAL(8, 2),
precio_venta DECIMAL(8, 2),
referencia_producto VARCHAR(8)
);

# introducción de registros = productos
-- INSERT INTO productos(nombre_producto) VALUES("Micra"); -- esto es un error porque el nombre_proveedor es obligatorio
INSERT INTO productos(nombre_producto, nombre_proveedor, tel_proveedor, 
email_proveedor, ciudad_proveedor, precio_compra, precio_venta, referencia_producto) VALUES
("Micra", "AUTOS SA", "123456789", "info@autossa.com", "Lleida", 4000, 6000, "M1"),
("Raval", "AUTOS SA", "123456789", "info@autossa.com", "Lleida", 6000, 8000, "R1");

SELECT * FROM productos;
SELECT DISTINCT nombre_proveedor, tel_proveedor, email_proveedor, ciudad_proveedor FROM productos;

# Subdividir la tabla productos en:
CREATE TABLE proveedores(
	id_proveedor INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_proveedor VARCHAR(30) NOT NULL,
	tel_proveedor VARCHAR(9),
	email_proveedor VARCHAR(40),
    id_ciudad INT
);

CREATE TABLE ciudades(
	id_ciudad INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    nombre_ciudad VARCHAR(30)
);

# introducir el nombre de la ciudad
INSERT INTO ciudades(nombre_ciudad) VALUES("Lleida");
SELECT * FROM ciudades;

# modificar la tabla proveedores para añadir el nombre de la ciudad
ALTER TABLE proveedores
ADD COLUMN nombre_ciudad VARCHAR(30);

SELECT * FROM proveedores;

INSERT INTO proveedores(nombre_proveedor, tel_proveedor, email_proveedor, nombre_ciudad)
SELECT DISTINCT nombre_proveedor, tel_proveedor, email_proveedor, ciudad_proveedor FROM productos;

SELECT c.id_ciudad
FROM ciudades c
JOIN proveedores p
ON c.nombre_ciudad = p.nombre_ciudad;

SELECT * FROM proveedores;

UPDATE proveedores p
JOIN ciudades c
ON c.nombre_ciudad = p.nombre_ciudad
SET p.id_ciudad = c.id_ciudad;

ALTER TABLE proveedores
DROP COLUMN nombre_ciudad;

SELECT p.nombre_proveedor, c.nombre_ciudad
FROM proveedores p
JOIN ciudades c
ON p.id_ciudad = c.id_ciudad;

SELECT * FROM productos;

ALTER TABLE productos
ADD COLUMN id_proveedor INT;

UPDATE productos pr
JOIN proveedores p
ON pr.nombre_proveedor = p.nombre_proveedor

SET pr.id_proveedor = p.id_proveedor;
ALTER TABLE productos
DROP COLUMN nombre_proveedor, DROP COLUMN tel_proveedor, DROP COLUMN email_proveedor, DROP COLUMN ciudad_proveedor;

INSERT INTO ciudades(nombre_ciudad) VALUES("Vic"), ("Chicago"), ("Paris");

INSERT INTO proveedores(nombre_proveedor, tel_proveedor, email_proveedor, id_ciudad) VALUES
("Michael Corleone", "1234", "michael@corleone.com", (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = "Chicago"));

INSERT INTO productos(nombre_producto, precio_compra, precio_venta, referencia_producto, id_proveedor) VALUES
("Testa Rossa", 50000, 90000, "T1", (SELECT id_proveedor FROM proveedores WHERE nombre_proveedor LIKE "M%")),
("Corsa", 5000, 9000, "C1", (SELECT id_proveedor FROM proveedores WHERE nombre_proveedor LIKE "M%"));

CREATE TABLE clientes(
id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre_cliente VARCHAR(30),
apellido_cliente VARCHAR(30),
empresa VARCHAR(30),
id_ciudad int
);

INSERT INTO clientes(nombre_cliente, apellido_cliente, empresa, id_ciudad) VALUES
("Bill", "Gates", null, (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = "Chicago" )),
(null, null, "Apple", (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = "Lleida" )),
("Steve", "Ballmer", null, (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = "Chicago" )),
("Salvador", "Illa", null, (SELECT id_ciudad FROM ciudades WHERE nombre_ciudad = "Vic" ));

CREATE TABLE ventas(
id_venta INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_producto INT NOT NULL,
id_cliente INT NOT NULL,
cantidad INT NOT NULL
);

INSERT INTO ventas(id_producto, id_cliente, cantidad) VALUES
(3, 1, 1), (3, 3, 3), (4, 4, 1);




