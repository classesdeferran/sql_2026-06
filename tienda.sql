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


