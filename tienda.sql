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


# Formas de borrar datos
# de lo más pequeño a lo más grande
# DELETE FROM nombre_tabla -- borra los registros pero mantiene los índices anteriores
# DELETE FROM nombre_tabla WHERE condicion
# TRUNCATE TABLE nombre_tabla -- borra los registros y los índices anteriores

# DROP TABLE nombre_tabla -- Elimina la tabla
# DROP DATABASE nombre_base_datos -- Elimina la base de datos entera

USE tienda;
TRUNCATE TABLE ciudades;
TRUNCATE TABLE clientes;
TRUNCATE TABLE ventas;
TRUNCATE TABLE proveedores;
TRUNCATE TABLE productos;


INSERT INTO `ciudades` VALUES (1,'Lleida'),(2,'Vic'),(3,'Chicago'),(4,'Paris'),(5,'Madrid'),(6,'París'),(7,'Berlín'),(8,'Roma'),(9,'Londres'),(10,'Lisboa'),(11,'Ámsterdam'),(12,'Bruselas'),(13,'Viena'),(14,'Praga'),(15,'Atenas'),(16,'Dublín'),(17,'Copenhague'),(18,'Estocolmo'),(19,'Oslo'),(20,'Helsinki'),(21,'Varsovia'),(22,'Budapest'),(23,'Bucarest'),(24,'Sofía'),(25,'Zúrich'),(26,'Ginebra'),(27,'Milán'),(28,'Venecia'),(29,'Florencia'),(30,'Nápoles'),(31,'Barcelona'),(32,'Sevilla'),(33,'Valencia'),(34,'Bilbao'),(35,'Oporto'),(36,'Múnich'),(37,'Fráncfort'),(38,'Hamburgo'),(39,'Colonia'),(40,'Lyon'),(41,'Marsella'),(42,'Toulouse'),(43,'Niza'),(44,'Amberes'),(45,'Brujas'),(46,'Róterdam'),(47,'Utrecht'),(48,'Salzburgo'),(49,'Innsbruck'),(50,'Cracovia'),(51,'Gdansk'),(52,'Bratislava'),(53,'Liubliana'),(54,'Zagreb'),(55,'Split'),(56,'Sarajevo'),(57,'Belgrado'),(58,'Skopie'),(59,'Tirana'),(60,'Tallin'),(61,'Riga'),(62,'Vilna'),(63,'Reikiavik'),(64,'La Valeta'),(65,'Nicosia'),(66,'Luxemburgo'),(67,'Edimburgo'),(68,'Glasgow'),(69,'Mánchester'),(70,'Liverpool'),(71,'Birmingham'),(72,'Belfast'),(73,'Cardiff'),(74,'Fráncfort'),(75,'Stuttgart'),(76,'Düsseldorf'),(77,'Bremen'),(78,'Leipzig'),(79,'Dresde'),(80,'Burdeos'),(81,'Estrasburgo'),(82,'Lille'),(83,'Nantes'),(84,'Turín'),(85,'Génova'),(86,'Bolonia'),(87,'Palermo'),(88,'Verona'),(89,'Zaragoza'),(90,'Málaga'),(91,'Murcia'),(92,'Palma de Mallorca'),(93,'Las Palmas'),(94,'Coímbra'),(95,'Braga'),(96,'Funchal'),(97,'Eindhoven'),(98,'Gante'),(99,'Lieja'),(100,'Basilea'),(101,'Berna'),(102,'Lugano'),(103,'Gotemburgo'),(104,'Malmö'),(105,'Nueva York'),(106,'Los Angeles'),(107,'Andorra la Vella');

INSERT INTO `clientes` VALUES (1,'Bill','Gates',NULL,3),(2,NULL,NULL,'Apple',1),(3,'Steve','Ballmer',NULL,3),(4,'Salvador','Illa',NULL,2),(5,'Brad','Pitt',NULL,46),(6,'Angelina','Jolie',NULL,52),(7,'Leonardo','DiCaprio',NULL,22),(8,'Scarlett','Johansson',NULL,53),(9,'Tom','Cruise',NULL,99),(10,'Meryl','Streep',NULL,37),(11,'Robert','Downey',NULL,86),(12,'Natalie','Portman',NULL,17),(13,'Johnny','Depp',NULL,30),(14,'Penélope','Cruz',NULL,95),(15,'Antonio','Banderas',NULL,88),(16,'Javier','Bardem',NULL,52),(17,'Will','Smith',NULL,95),(18,'Jennifer','Lawrence',NULL,19),(19,'Morgan','Freeman',NULL,8),(20,'Emma','Watson',NULL,85),(21,'Keanu','Reeves',NULL,1),(22,'Margot','Robbie',NULL,47),(23,'Denzel','Washington',NULL,33),(24,'Charlize','Theron',NULL,22),(25,'Hugh','Jackman',NULL,12),(26,'Nicole','Kidman',NULL,92),(27,'Matt','Damon',NULL,25),(28,'Anne','Hathaway',NULL,48),(29,'Christian','Bale',NULL,63),(30,'Vito','Corleone',NULL,71),(31,'Madonna',NULL,NULL,66),(32,'Freddie','Mercury',NULL,15),(33,'Beyoncé',NULL,NULL,77),(34,'Taylor','Swift',NULL,41),(35,'Martin','Scorsese',NULL,72),(36,'Lady','Gaga',NULL,39),(37,'Peter','Parker',NULL,77),(38,'Adele',NULL,NULL,69),(39,'Rihanna',NULL,NULL,11),(40,'Toni','Albà',NULL,50),(41,'Steven','Spielberg',NULL,17),(42,'Rosalía',NULL,NULL,34),(43,'Pep','Plaza',NULL,20),(44,'Ricky','Martin',NULL,97),(45,'Alejandro','Sanz',NULL,22),(46,'Gustavo','Dudamel',NULL,22),(47,'Elton','John',NULL,41),(48,'Paul','McCartney',NULL,37),(49,'Mick','Jagger',NULL,65),(50,'Bruce','Springsteen',NULL,12),(51,'David','Bowie',NULL,63),(52,'Billie','Eilish',NULL,80),(53,'James','Cameron',NULL,11),(54,'Justin','Bieber',NULL,13),(55,'Juliette','Binoche',NULL,32),(56,'Clint','Eastwood',NULL,22),(57,'Jordi','Savall',NULL,13),(58,'Christopher','Nolan',NULL,100),(59,'Evgeny','Kissin',NULL,58),(60,'Francesc','Novell',NULL,89),(61,'John','Lennon',NULL,70),(62,'Laura','Pausini',NULL,84),(63,'Andrea','Bocelli',NULL,9),(64,'Luciano','Pavarotti',NULL,94),(65,NULL,NULL,'NovaTech Solutions',22),(66,NULL,NULL,'Apex Global Logistics',16),(67,NULL,NULL,'CyberDyne Systems',14),(68,NULL,NULL,'InnovaCorp Group',22),(69,NULL,NULL,'Quantum FinTech',15),(70,NULL,NULL,'Vortex Media',11),(71,NULL,NULL,'Starlight Industries',8),(72,NULL,NULL,'BlueHorizon Ventures',8),(73,NULL,NULL,'Alpha Omega Consulting',17),(74,NULL,NULL,'PrimeHealth Pharma',7),(75,NULL,NULL,'EcoEnergy Dynamics',36),(76,NULL,NULL,'Stratosphere Aerospace',6),(77,NULL,NULL,'Nexus Software Solutions',21),(78,NULL,NULL,'Matrix Realty Group',40),(79,NULL,NULL,'Zentrix Food Industries',33),(80,NULL,NULL,'Titanium Security',46),(81,NULL,NULL,'OmniCorp International',29),(82,NULL,NULL,'Solaria Green Power',6),(83,NULL,NULL,'Pinnacle Capital',43),(84,NULL,NULL,'Delta Telecom',47),(85,NULL,NULL,'Meridian Biotech',4),(86,NULL,NULL,'Orion Automobile',28),(87,NULL,NULL,'Infinity Retail',31),(88,NULL,NULL,'TerraForm Agriculture',17),(89,NULL,NULL,'Summit E-Commerce',42),(90,NULL,NULL,'IronClad Construction',8),(91,NULL,NULL,'Genesis AI Innovations',16),(92,NULL,NULL,'Horizon Heavy Machinery',5),(93,NULL,NULL,'Vanguard Asset Management',28),(94,NULL,NULL,'Polaris Cloud Services',21),(95,NULL,NULL,'Eclipse Entertainment',22),(96,NULL,NULL,'Synergy Workspace',47),(97,NULL,NULL,'Aura Fashion House',20),(98,NULL,NULL,'Catalyst Chemical Group',7),(99,NULL,NULL,'Zephyr Aviation',25),(100,NULL,NULL,'Phoenix Recycling',3),(101,NULL,NULL,'Aethelgard Gaming',39),(102,NULL,NULL,'Luminary Marketing',35),(103,NULL,NULL,'Aethelgard Legal Partners',7),(104,NULL,NULL,'Hyperion Smart Home',31);

INSERT INTO `productos` VALUES (1,'Micra',4000.00,6000.00,'M1',1),(2,'Raval',6000.00,8000.00,'R1',1),(3,'Testa Rossa',50000.00,90000.00,'T1',2),(4,'Corsa',5000.00,9000.00,'C1',2),(5,'Seat Ibiza',14000.00,19600.00,'SI12',17),(6,'Renault Clio',15500.00,21700.00,'RC24',16),(7,'Volkswagen Golf',22000.00,30800.00,'VG90',5),(8,'Toyota Corolla',21000.00,29400.00,'TC45',20),(9,'Ford Fiesta',13500.00,18900.00,'FF07',1),(10,'Peugeot 208',16000.00,22400.00,'P208',5),(11,'Hyundai i30',18500.00,25900.00,'HI33',4),(12,'Kia Stonic',17000.00,23800.00,'KS18',1),(13,'Dacia Sandero',11000.00,15400.00,'DS55',16),(14,'Fiat 500',12500.00,17500.00,'F500',15),(15,'Opel Corsa',15000.00,21000.00,'OC61',7),(16,'Citroën C3',14800.00,20720.00,'CC39',7),(17,'BMW Serie 3',35000.00,49000.00,'BS31',16),(18,'Audi A4',37000.00,51800.00,'AA42',19),(19,'Mercedes Clase A',31000.00,43400.00,'MA15',7),(20,'Mazda 3',23000.00,32200.00,'M309',15),(21,'Nissan Qashqai',25000.00,35000.00,'NQ88',13),(22,'Honda Civic',24500.00,34300.00,'HC71',20),(23,'Skoda Octavia',22500.00,31500.00,'SO14',2),(24,'Volvo XC40',33000.00,46200.00,'VX40',9),(25,'Honda SH125i',3800.00,53200.00,'HS12',17),(26,'Yamaha TMAX',12000.00,16800.00,'YT84',20),(27,'Kawasaki Z900',8500.00,11900.00,'KZ90',8),(28,'BMW R1250GS',18000.00,25200.00,'BR12',19),(29,'KTM Duke 390',5500.00,7700.00,'KD39',10),(30,'Vespa Primavera',4200.00,5880.00,'VP22',13),(31,'Kymco Agility',2200.00,3080.00,'KA01',14),(32,'Suzuki SV650',6800.00,9520.00,'SS65',11),(33,'Ducati Monster',11500.00,16100.00,'DM77',12),(34,'Triumph Bonneville',10500.00,14700.00,'TB50',7),(35,'Honda Africa Twin',13800.00,19320.00,'HA11',20),(36,'Yamaha MT-07',7200.00,10080.00,'YM07',19),(37,'Piaggio Liberty',2600.00,3640.00,'PL44',14),(38,'Harley Iron 883',11000.00,15400.00,'HI88',11),(39,'Benelli TRK 502',6200.00,8680.00,'BT52',15),(40,'Renault Kangoo',19000.00,26600.00,'RK10',18),(41,'Citroën Berlingo',19500.00,27300.00,'CB20',8),(42,'Peugeot Partner',19200.00,26880.00,'PP30',4),(43,'Ford Transit Custom',28000.00,39200.00,'FT40',13),(44,'Volkswagen Transporter',32000.00,44800.00,'VT50',16),(45,'Mercedes Sprinter',38000.00,53200.00,'MS60',1),(46,'Fiat Ducato',26500.00,37100.00,'FD70',16),(47,'Opel Vivaro',24000.00,33600.00,'OV80',17),(48,'Toyota Proace',23500.00,32900.00,'TP90',16),(49,'Nissan Interstar',27000.00,37800.00,'NI05',7),(50,'Iveco Daily',31000.00,43400.00,'ID13',6),(51,'MAN TGE',34000.00,47600.00,'MT44',9),(52,'Maxus Deliver 9',25500.00,35700.00,'MD99',7),(53,'Ford Tourneo',21500.00,30100.00,'FT11',8),(54,'Renault Trafic',26000.00,36400.00,'RT66',18);

INSERT INTO `proveedores` VALUES (1,'AUTOS SA','123456789','info@autossa.com',1),(2,'Michael Corleone','1234','michael@corleone.com',3),(3,'AutoPremium Concesionarios','600111222','contacto@autopremium.com',13),(4,'Vehículos Ocasión Express','611222333','info@ocasionexpress.com',6),(5,'MundoRueda Automoción','622333444','ventas@mundorueda.es',12),(6,'Concesionario TodoAuto','633444555','atencion@todoauto.com',2),(7,'Ruta 66 Autos','644555666','info@ruta66autos.com',13),(8,'Motores del Sur','655666777','contacto@motoresdelsur.es',16),(9,'EcoCar Inteligente','666777888','comercial@ecocar.com',3),(10,'Líder Autos Multimarca','677888999','ventas@liderautos.com',7),(11,'Kilómetro Cero Automóviles','688999000','info@km0autos.es',3),(12,'Click & Drive España','699000111','soporte@clickdrive.com',16),(13,'Autos Directos del Norte','600222333','norte@autosdirectos.com',11),(14,'Iberia Motor Group','611333444','info@iberiamotor.es',8),(15,'Tu Coche Ideal','622444555','encuentra@tucocheideal.com',3),(16,'Outlet del Automóvil','633555666','ventas@outletautomovil.es',13),(17,'Garantía Motor','644666777','postventa@garantiamotor.com',13),(18,'Autos Urbanos','655777888','contacto@autosurbanos.com',7),(19,'FamiliaCar Concesionarios','666888999','info@familiacar.es',14),(20,'Suv & Crossover World','677999000','ventas@suvworld.com',11),(21,'Car Center Continental','688000222','info@carcenter.es',12),(22,'Autos Low Cost Online','699111333','web@autoslowcost.com',5),(23,'Próximo Coche','600333444','hola@proximocoche.com',11),(24,'Universo del Seminuevo','611444555','comercial@seminuevos.es',18),(25,'MotorSport Para Todos','622555666','info@motorsportpt.com',17),(26,'Vanguardia Automotriz','633666777','ventas@vanguardiaauto.com',9),(27,'Ocasión Garantizada Autos','644777888','info@ocasiongarantizada.es',14),(28,'Conduce Fácil Concesiones','655888999','atencion@conducefacil.com',1),(29,'Autos Elite Selección','666999111','elite@eliteseleccion.com',5),(30,'Soluciones Sobre Ruedas','677000333','info@sobreruedas.es',19),(31,'AutoSalón Metropolitano','688111444','contacto@autometropoli.com',19),(32,'Mi Primer Coche S.L.','699222555','ventas@miprimercoche.es',19),(33,'Planeta Automóvil','600444555','info@planetaautomovil.com',16),(34,'Autos de Confianza','611555666','gerencia@autosconfianza.com',2),(35,'RapiCar Compraventa','622666777','compras@rapicar.es',2),(36,'Smart Mobility Concesiones','633777888','info@smartmobility.com',3),(37,'Autos del Mediterráneo','644888999','ventas@autosmediterraneo.es',11),(38,'Central de Vehículos','655999222','info@centralvehiculos.com',3),(39,'EuroAutos Selección','666000444','comercial@euroautos.es',2),(40,'CityCar Automoción','677111555','info@citycarauto.com',20),(41,'Autos Futura','688222666','contacto@autosfutura.es',14),(42,'Punto de Venta Automotriz','699333777','ventas@puntoventaauto.com',10),(43,'Coches y Más Coches','600555666','hola@cochesymas.com',8),(44,'AutoStock Disponible','611666777','stock@autostock.es',10),(45,'Click Automóviles','622777888','digital@clickautomoviles.com',6),(46,'Motores de Ocasión Global','633888999','info@motoresocasion.com',18),(47,'Concesionario Primera Línea','644999333','ventas@primeralinea.es',11),(48,'Autos Total Confort','655000555','info@autostotalconfort.com',3),(49,'Descuento Automóvil','666111666','ofertas@descuentoauto.es',18),(50,'MoviCar Soluciones','677222777','contacto@movicar.com',4),(51,'Ruta Abierta Automoción','688333888','info@rutaabierta.es',5),(52,'Vía Libre Vehículos','699444999','comercial@vialibre.com',10);

INSERT INTO `ventas` VALUES (1,3,1,1),(2,3,3,3),(3,4,4,1),(4,12,45,1),(5,55,12,2),(6,34,78,4),(7,12,23,2),(8,89,45,1),(9,3,67,2),(10,67,12,3),(11,92,34,1),(12,45,56,5),(13,34,12,4),(14,12,78,3),(15,73,45,3),(16,22,19,2),(17,55,61,1),(18,8,23,4),(19,41,7,2),(20,67,56,1),(21,89,12,5),(22,99,34,2),(23,15,78,4),(24,3,45,4),(25,22,23,4),(26,50,19,5),(27,92,67,4),(28,14,2,4),(29,81,15,3),(30,36,40,3),(31,58,72,1),(32,25,11,4),(33,70,63,2),(34,5,50,1),(35,94,28,1),(36,48,33,5),(37,62,5,5),(38,19,77,1),(39,85,21,3),(40,31,69,4),(41,53,42,4),(42,77,14,4),(43,64,59,2),(44,12,45,3),(45,55,12,2),(46,34,78,3),(47,99,23,4),(48,89,45,3),(49,3,67,2),(50,67,12,2),(51,92,34,4),(52,45,56,2),(53,34,12,2),(54,70,78,3),(55,73,45,5),(56,22,19,1),(57,55,61,5),(58,8,23,1),(59,41,7,3),(60,67,56,1),(61,89,12,5),(62,99,34,2),(63,15,78,2),(64,50,40,5),(65,94,72,5),(66,48,11,1),(67,62,63,2),(68,19,50,1),(69,85,28,4),(70,31,33,2),(71,53,5,3),(72,77,77,4),(73,64,21,3),(74,1,10,1),(75,2,20,3),(76,3,30,1),(77,4,40,4),(78,5,50,5),(79,6,60,5),(80,7,70,5),(81,8,80,1),(82,9,10,2),(83,10,20,2),(84,11,30,1),(85,12,40,2),(86,13,50,2),(87,14,60,1),(88,15,70,1),(89,16,80,4),(90,17,10,3),(91,18,20,5),(92,19,30,3),(93,20,40,5),(94,21,6,2),(95,22,16,1),(96,23,26,1),(97,24,36,5),(98,25,46,5),(99,26,56,1),(100,27,66,5),(101,28,76,3),(102,29,6,4),(103,30,16,4),(104,31,26,3),(105,32,36,2),(106,33,46,4),(107,34,56,2),(108,35,66,5),(109,36,76,3),(110,37,6,5),(111,38,16,2),(112,39,26,1),(113,40,36,1),(114,41,3,5),(115,42,13,5),(116,43,23,3),(117,44,33,3),(118,45,43,2),(119,46,53,2),(120,47,63,2),(121,48,73,3),(122,49,3,2),(123,50,13,2),(124,51,23,5),(125,52,33,2),(126,53,43,5),(127,54,53,5),(128,55,63,2),(129,56,73,2),(130,57,3,2),(131,58,13,4),(132,59,23,2),(133,60,33,4),(134,61,8,5),(135,62,18,1),(136,63,28,3),(137,64,38,4),(138,65,48,1),(139,66,58,2),(140,67,68,1),(141,68,78,5),(142,69,8,2),(143,70,18,4),(144,71,28,5),(145,72,38,1),(146,73,48,1),(147,74,58,2),(148,75,68,4),(149,76,78,1),(150,77,8,3),(151,78,18,1),(152,79,28,3),(153,80,38,3),(154,81,1,5),(155,82,11,3),(156,83,21,2),(157,84,31,5),(158,85,41,4),(159,86,51,5),(160,87,61,4),(161,88,71,1),(162,89,1,1),(163,90,11,1),(164,91,21,2),(165,92,31,5),(166,93,41,3),(167,94,51,2),(168,95,61,1),(169,96,71,2),(170,97,1,5),(171,98,11,3),(172,99,21,2),(173,100,31,2),(174,12,31,5),(175,25,45,4),(176,34,12,5),(177,55,78,3),(178,67,23,4),(179,89,45,3),(180,92,67,5),(181,3,12,4),(182,8,34,1),(183,15,56,3),(184,19,78,4),(185,22,45,3),(186,31,19,2),(187,36,61,5),(188,45,23,4),(189,48,7,5),(190,50,56,3),(191,53,12,3),(192,58,34,5),(193,62,78,4),(194,64,45,3),(195,70,23,4),(196,73,19,4),(197,77,61,4),(198,81,23,1),(199,85,7,5),(200,94,56,3),(201,99,12,3),(202,5,34,5),(203,14,78,2);

-- Añadir los vínculos entre las tablas
ALTER TABLE clientes
ADD CONSTRAINT fk_clientes_ciudades 
FOREIGN KEY (id_ciudad) REFERENCES ciudades(id_ciudad) 
ON DELETE RESTRICT
ON UPDATE CASCADE
; -- CASCADE - SET NULL - RESTRICT = NO ACTION




# ¿Qué clientes han comprado productos de proveedores de Lleida?
SELECT cl.nombre_cliente, cl.empresa
FROM clientes cl
JOIN ventas v
ON cl.id_cliente = v.id_cliente
JOIN productos pd
ON pd.id_producto = v.id_producto
JOIN proveedores pv
ON pd.id_proveedor = pv.id_proveedor
JOIN ciudades c
ON c.id_ciudad = pv.id_ciudad
WHERE c.nombre_ciudad = "Lleida";

# ¿Qué clientes tiene un nombre que empieza por S?
SELECT CONCAT( nombre_cliente, " ", apellido_cliente) as "el cliente es"
FROM clientes
WHERE nombre_cliente LIKE "S%";

SELECT CONCAT_WS(" ", nombre_cliente, apellido_cliente, "y su id es", id_cliente) as "el cliente es"
FROM clientes
WHERE nombre_cliente LIKE "S%";

# ¿Cuántas ventas hemos hecho?
SELECT COUNT(*) as "ventas realizadas"
FROM ventas;

# ¿Cuántos coches hemos vendido?
SELECT SUM(cantidad)
FROM ventas;

# ¿Cuánto dinero hemos ganado hasta ahora?
SELECT SUM(v.cantidad * (p.precio_venta - precio_compra)) as beneficio
FROM ventas v
JOIN productos p
ON v.id_producto = p.id_producto;

# Precio y nombre del coche más caro
SELECT precio_venta as pv, nombre_producto
FROM productos
where precio_venta = (SELECT MAX(precio_venta) FROM productos);

# El Corsa lo compramos a 4000
UPDATE productos 
SET precio_compra = 4000
WHERE nombre_producto = "Corsa";

# Precio y nombre del coche más barato
SELECT precio_compra, nombre_producto
FROM productos
where precio_compra = (SELECT MIN(precio_compra) FROM productos);

# ¿Qué cliente/s ha realizado más pedidos?
SELECT cl.nombre_cliente, cl.apellido_cliente, cl.empresa, COUNT(*) as ventas
FROM clientes cl
JOIN ventas v ON cl.id_cliente = v.id_cliente
GROUP BY v.id_cliente
ORDER BY ventas DESC
LIMIT 5;

# ¿Qué cliente/s han comprado más productos?
SELECT TRIM(concat_ws(' ',IFNULL(cl.nombre_cliente, ''), IFNULL(cl.apellido_cliente, ''), IFNULL(cl.empresa, ''))) as cliente , SUM(v.cantidad) as cantidades
FROM clientes cl
JOIN ventas v ON cl.id_cliente = v.id_cliente
GROUP BY v.id_cliente
ORDER BY cantidades DESC;

# ¿Quién es nuestro mejor cliente?
SELECT cl.nombre_cliente, cl.apellido_cliente, cl.empresa, SUM(v.cantidad * (p.precio_venta - p.precio_compra)) as beneficio
FROM clientes cl
INNER JOIN ventas v ON cl.id_cliente = v.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto
GROUP BY v.id_cliente
ORDER BY beneficio DESC;

# ¿Quienes son nuestro peores clientes?
SELECT TRIM(concat_ws(' ',IFNULL(cl.nombre_cliente, ''), IFNULL(cl.apellido_cliente, ''), IFNULL(cl.empresa, ''))) as cliente, v.id_cliente
FROM clientes cl
LEFT JOIN ventas v ON cl.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL
ORDER BY cliente ASC;

# ¿Cuántos clientes tenemos registrados?
SELECT COUNT(*) as clientes
FROM clientes;

# ¿Cuántos de nuestros clientes son empresas y cuántos personas?


# Funciones de agregación son: SUM, COUNT, MAX, MIN, AVG
# Coste promedio de los productos
SELECT AVG(precio_compra) as avg, ROUND(AVG(precio_compra), 2) as round, CEIL(AVG(precio_compra)) as ceil, FLOOR(AVG(precio_compra)) as floor
FROM productos;

# ¿Qué clientes han realizado algún pedido (sin repeticiones)?

# ¿Qué ciudades tienen un nombre compuesto? (Como Hospitalet de Llobregat)

# ¿Cuántas ciudades empiezan por "B"?

# ¿Cuántas ciudades contienen la letra "e"?

# ¿Qué beneficio hemos obtenido de los proveedores de Praga?

# ¿Cuántos vehículos hemos vendido de los proveedores de Viena?

# ¿Con qué proveedor/es ganamos más dinero?

# ¿De qué producto hemos realizado más ventas?

# ¿De qué ciudades no tenemos productos?

# Productos con precio de venta por encima del promedio

# Clientes que han hecho más de 10 compras

# ¿De qué ciudad tenemos más clientes?

# Productos cuyo nombre no incluya la letra 'i'