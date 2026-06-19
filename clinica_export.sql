DROP DATABASE IF EXISTS clinica2;
CREATE DATABASE  IF NOT EXISTS clinica2;
USE `clinica2`;



--
-- Table structure for table `poblaciones`
--


DROP TABLE IF EXISTS `poblaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `poblaciones` (
  `id_poblacion` int NOT NULL AUTO_INCREMENT,
  `nombre_poblacion` varchar(40) NOT NULL,
  PRIMARY KEY (`id_poblacion`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poblaciones`
--

LOCK TABLES `poblaciones` WRITE;
/*!40000 ALTER TABLE `poblaciones` DISABLE KEYS */;
INSERT INTO `poblaciones` VALUES (1,'Barcelona'),(2,'Hospitalet'),(3,'Cornellà');
/*!40000 ALTER TABLE `poblaciones` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `doctores`
--

DROP TABLE IF EXISTS `doctores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctores` (
  `id_doctor` int NOT NULL AUTO_INCREMENT,
  `nombre_doctor` varchar(40) NOT NULL,
  `apellido_doctor` varchar(60) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `dni` varchar(10) DEFAULT NULL,
  `id_poblacion` int NOT NULL,
  `fecha_alta` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `especialidad` enum('Traumatología','Oftalmología','Neurología') DEFAULT NULL,
  PRIMARY KEY (`id_doctor`),
  UNIQUE KEY `dni` (`dni`),
  KEY `fk_doctores_poblaciones` (`id_poblacion`),
  CONSTRAINT `fk_doctores_poblaciones` FOREIGN KEY (`id_poblacion`) REFERENCES `poblaciones` (`id_poblacion`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctores`
--

LOCK TABLES `doctores` WRITE;
/*!40000 ALTER TABLE `doctores` DISABLE KEYS */;
INSERT INTO `doctores` VALUES (1,'James','Cameron','1980-12-25',NULL,2,'2026-06-19 15:10:16','2026-06-19 15:10:16','Oftalmología');
/*!40000 ALTER TABLE `doctores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(40) NOT NULL,
  `apellido_usuario` varchar(60) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `dni` varchar(10) DEFAULT NULL,
  `id_poblacion` int NOT NULL,
  `fecha_alta` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `tel_movil` varchar(9) DEFAULT NULL,
  `tel_fijo` varchar(9) DEFAULT NULL,
  `codigo_usuario` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `dni` (`dni`),
  KEY `fk_usuarios_poblaciones` (`id_poblacion`),
  CONSTRAINT `fk_usuarios_poblaciones` FOREIGN KEY (`id_poblacion`) REFERENCES `poblaciones` (`id_poblacion`)
);
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Peter','Parker','2000-01-01','12345678A',1,'2026-06-19 15:10:15','2026-06-19 16:13:56','123456789',NULL,'LSJR-4747'),(2,'Clark','Kent','1990-01-01','12345678B',1,'2026-06-19 15:10:15','2026-06-19 16:13:56',NULL,NULL,'GIAA-1435'),(3,'Son','Goku','2001-01-01','12345678D',1,'2026-06-19 15:10:15','2026-06-19 16:13:56','123456789',NULL,'PPIV-4080'),(4,'Loise','Lane','1995-06-18','12345678F',2,'2026-06-19 15:10:15','2026-06-19 16:13:56',NULL,NULL,'HTDH-2033'),(5,'John','Lennon','1998-06-18','12345678E',2,'2026-06-19 15:10:15','2026-06-19 16:13:56',NULL,NULL,'RTWE-2069'),(10,'John','Smith','2001-01-01','12345678G',2,'2025-06-18 16:29:53','2026-06-19 16:13:56',NULL,'987654321','QSSN-5851'),(11,'Tryon','Lannister','2001-01-01','12345678H',1,'2026-06-19 15:10:15','2026-06-19 16:13:56',NULL,'987654321','RMLS-5042');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;





--
-- Table structure for table `consultas`
--

DROP TABLE IF EXISTS `consultas`;

CREATE TABLE `consultas` (
  `id_consulta` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_doctor` int NOT NULL,
  `fecha_concertada` datetime NOT NULL,
  `fecha_peticion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `tratamiento` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_consulta`),
  KEY `fk_consultas_usuarios` (`id_usuario`),
  KEY `fk_consultas_doctores` (`id_doctor`),
  CONSTRAINT `fk_consultas_doctores` FOREIGN KEY (`id_doctor`) REFERENCES `doctores` (`id_doctor`),
  CONSTRAINT `fk_consultas_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
);

--
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
INSERT INTO `consultas` VALUES (1,1,1,'2026-06-19 00:00:00','2026-06-19 15:10:16',30.00),(2,2,1,'2026-06-22 00:00:00','2026-06-19 15:10:16',12.00),(3,2,1,'2026-07-22 00:00:00','2026-06-19 15:10:16',0.00),(4,3,1,'2026-06-25 00:00:00','2026-06-19 15:10:16',50.00);
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;
