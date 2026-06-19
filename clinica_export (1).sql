CREATE DATABASE  IF NOT EXISTS `clinica3` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `clinica3`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: clinica2
-- ------------------------------------------------------
-- Server version	8.4.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `consultas`
--

DROP TABLE IF EXISTS `consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
INSERT INTO `consultas` VALUES (1,1,1,'2026-06-19 00:00:00','2026-06-19 13:10:16',30.00),(2,2,1,'2026-06-22 00:00:00','2026-06-19 13:10:16',12.00),(3,2,1,'2026-07-22 00:00:00','2026-06-19 13:10:16',0.00),(4,3,1,'2026-06-25 00:00:00','2026-06-19 13:10:16',50.00);
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctores`
--

LOCK TABLES `doctores` WRITE;
/*!40000 ALTER TABLE `doctores` DISABLE KEYS */;
INSERT INTO `doctores` VALUES (1,'James','Cameron','1980-12-25',NULL,2,'2026-06-19 13:10:16','2026-06-19 13:10:16','Oftalmología');
/*!40000 ALTER TABLE `doctores` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Peter','Parker','2000-01-01','12345678A',1,'2026-06-19 13:10:15','2026-06-19 14:13:56','123456789',NULL,'LSJR-4747'),(2,'Clark','Kent','1990-01-01','12345678B',1,'2026-06-19 13:10:15','2026-06-19 14:13:56',NULL,NULL,'GIAA-1435'),(3,'Son','Goku','2001-01-01','12345678D',1,'2026-06-19 13:10:15','2026-06-19 14:13:56','123456789',NULL,'PPIV-4080'),(4,'Loise','Lane','1995-06-18','12345678F',2,'2026-06-19 13:10:15','2026-06-19 14:13:56',NULL,NULL,'HTDH-2033'),(5,'John','Lennon','1998-06-18','12345678E',2,'2026-06-19 13:10:15','2026-06-19 14:13:56',NULL,NULL,'RTWE-2069'),(10,'John','Smith','2001-01-01','12345678G',2,'2025-06-18 14:29:53','2026-06-19 14:13:56',NULL,'987654321','QSSN-5851'),(11,'Tryon','Lannister','2001-01-01','12345678H',1,'2026-06-19 13:10:15','2026-06-19 14:13:56',NULL,'987654321','RMLS-5042');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `usuarios_consultas_doctores`
--

DROP TABLE IF EXISTS `usuarios_consultas_doctores`;
/*!50001 DROP VIEW IF EXISTS `usuarios_consultas_doctores`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `usuarios_consultas_doctores` AS SELECT 
 1 AS `nombre_usuario`,
 1 AS `apellido_usuario`,
 1 AS `fecha_nacimiento`,
 1 AS `dni`,
 1 AS `nombre_poblacion`,
 1 AS `contacto`,
 1 AS `fecha_concertada`,
 1 AS `doctor`,
 1 AS `especialidad`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `usuarios_consultas_doctores`
--

/*!50001 DROP VIEW IF EXISTS `usuarios_consultas_doctores`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `usuarios_consultas_doctores` AS select `u`.`nombre_usuario` AS `nombre_usuario`,`u`.`apellido_usuario` AS `apellido_usuario`,`u`.`fecha_nacimiento` AS `fecha_nacimiento`,`u`.`dni` AS `dni`,`p`.`nombre_poblacion` AS `nombre_poblacion`,coalesce(`u`.`tel_movil`,`u`.`tel_fijo`,'No tenemos datos de contacto') AS `contacto`,`c`.`fecha_concertada` AS `fecha_concertada`,concat(`d`.`nombre_doctor`,' ',`d`.`apellido_doctor`) AS `doctor`,`d`.`especialidad` AS `especialidad` from (((`poblaciones` `p` join `usuarios` `u` on((`p`.`id_poblacion` = `u`.`id_poblacion`))) join `consultas` `c` on((`u`.`id_usuario` = `c`.`id_usuario`))) join `doctores` `d` on((`c`.`id_doctor` = `d`.`id_doctor`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-19 19:44:57
