-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-06-2026 a las 19:28:29
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `clinica2`
--
DROP DATABASE IF EXISTS clinica2;
CREATE DATABASE IF NOT EXISTS `clinica2`;
USE `clinica2`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultas`
--

DROP TABLE IF EXISTS `consultas`;
CREATE TABLE IF NOT EXISTS `consultas` (
  `id_consulta` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_doctor` int(11) NOT NULL,
  `fecha_concertada` datetime NOT NULL,
  `fecha_peticion` timestamp NULL DEFAULT current_timestamp(),
  `tratamiento` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id_consulta`),
  KEY `fk_consultas_usuarios` (`id_usuario`),
  KEY `fk_consultas_doctores` (`id_doctor`)
) ;

--
-- Volcado de datos para la tabla `consultas`
--

INSERT INTO `consultas` (`id_consulta`, `id_usuario`, `id_doctor`, `fecha_concertada`, `fecha_peticion`, `tratamiento`) VALUES
(1, 1, 1, '2026-06-19 00:00:00', '2026-06-19 13:10:16', 30.00),
(2, 2, 1, '2026-06-22 00:00:00', '2026-06-19 13:10:16', 12.00),
(3, 2, 1, '2026-07-22 00:00:00', '2026-06-19 13:10:16', 0.00),
(4, 3, 1, '2026-06-25 00:00:00', '2026-06-19 13:10:16', 50.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctores`
--

DROP TABLE IF EXISTS `doctores`;
CREATE TABLE IF NOT EXISTS `doctores` (
  `id_doctor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_doctor` varchar(40) NOT NULL,
  `apellido_doctor` varchar(60) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `dni` varchar(10) DEFAULT NULL,
  `id_poblacion` int(11) NOT NULL,
  `fecha_alta` timestamp NULL DEFAULT current_timestamp(),
  `fecha_modificacion` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `especialidad` enum('Traumatología','Oftalmología','Neurología') DEFAULT NULL,
  PRIMARY KEY (`id_doctor`),
  UNIQUE KEY `dni` (`dni`),
  KEY `fk_doctores_poblaciones` (`id_poblacion`)
) ;

--
-- Volcado de datos para la tabla `doctores`
--

INSERT INTO `doctores` (`id_doctor`, `nombre_doctor`, `apellido_doctor`, `fecha_nacimiento`, `dni`, `id_poblacion`, `fecha_alta`, `fecha_modificacion`, `especialidad`) VALUES
(1, 'James', 'Cameron', '1980-12-25', NULL, 2, '2026-06-19 13:10:16', '2026-06-19 13:10:16', 'Oftalmología');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `poblaciones`
--

DROP TABLE IF EXISTS `poblaciones`;
CREATE TABLE IF NOT EXISTS `poblaciones` (
  `id_poblacion` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_poblacion` varchar(40) NOT NULL,
  PRIMARY KEY (`id_poblacion`)
);

--
-- Volcado de datos para la tabla `poblaciones`
--

INSERT INTO `poblaciones` (`id_poblacion`, `nombre_poblacion`) VALUES
(1, 'Barcelona'),
(2, 'Hospitalet'),
(3, 'Cornellà');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(40) NOT NULL,
  `apellido_usuario` varchar(60) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `dni` varchar(10) DEFAULT NULL,
  `id_poblacion` int(11) NOT NULL,
  `fecha_alta` timestamp NULL DEFAULT current_timestamp(),
  `fecha_modificacion` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `tel_movil` varchar(9) DEFAULT NULL,
  `tel_fijo` varchar(9) DEFAULT NULL,
  `codigo_usuario` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `dni` (`dni`),
  KEY `fk_usuarios_poblaciones` (`id_poblacion`)
);

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre_usuario`, `apellido_usuario`, `fecha_nacimiento`, `dni`, `id_poblacion`, `fecha_alta`, `fecha_modificacion`, `tel_movil`, `tel_fijo`, `codigo_usuario`) VALUES
(1, 'Peter', 'Parker', '2000-01-01', '12345678A', 1, '2026-06-19 13:10:15', '2026-06-19 14:13:56', '123456789', NULL, 'LSJR-4747'),
(2, 'Clark', 'Kent', '1990-01-01', '12345678B', 1, '2026-06-19 13:10:15', '2026-06-19 14:13:56', NULL, NULL, 'GIAA-1435'),
(3, 'Son', 'Goku', '2001-01-01', '12345678D', 1, '2026-06-19 13:10:15', '2026-06-19 14:13:56', '123456789', NULL, 'PPIV-4080'),
(4, 'Loise', 'Lane', '1995-06-18', '12345678F', 2, '2026-06-19 13:10:15', '2026-06-19 14:13:56', NULL, NULL, 'HTDH-2033'),
(5, 'John', 'Lennon', '1998-06-18', '12345678E', 2, '2026-06-19 13:10:15', '2026-06-19 14:13:56', NULL, NULL, 'RTWE-2069'),
(10, 'John', 'Smith', '2001-01-01', '12345678G', 2, '2025-06-18 14:29:53', '2026-06-19 14:13:56', NULL, '987654321', 'QSSN-5851'),
(11, 'Tryon', 'Lannister', '2001-01-01', '12345678H', 1, '2026-06-19 13:10:15', '2026-06-19 14:13:56', NULL, '987654321', 'RMLS-5042');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `consultas`
--
ALTER TABLE `consultas`
  ADD CONSTRAINT `fk_consultas_doctores` FOREIGN KEY (`id_doctor`) REFERENCES `doctores` (`id_doctor`),
  ADD CONSTRAINT `fk_consultas_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`);

--
-- Filtros para la tabla `doctores`
--
ALTER TABLE `doctores`
  ADD CONSTRAINT `fk_doctores_poblaciones` FOREIGN KEY (`id_poblacion`) REFERENCES `poblaciones` (`id_poblacion`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuarios_poblaciones` FOREIGN KEY (`id_poblacion`) REFERENCES `poblaciones` (`id_poblacion`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
