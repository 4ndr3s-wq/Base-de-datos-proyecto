-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-09-2020 a las 18:26:04
-- Versión del servidor: 10.4.11-MariaDB
-- Versión de PHP: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actu_producto`
--

CREATE TABLE `actu_producto` (
  `id_producto` int(11) DEFAULT NULL,
  `nom_producto` varchar(30) NOT NULL,
  `id_clasificacion` int(11) DEFAULT NULL,
  `marca` varchar(30) NOT NULL,
  `peso` varchar(30) NOT NULL,
  `precio` int(11) NOT NULL,
  `fecha_caducacion` date NOT NULL,
  `fecha_mod` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clasificacion`
--

CREATE TABLE `clasificacion` (
  `id_clasificacion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `clasificacion`
--

INSERT INTO `clasificacion` (`id_clasificacion`) VALUES
(301),
(302),
(303),
(304);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id_factura` int(11) NOT NULL,
  `nit` int(11) DEFAULT NULL,
  `precio_total` int(11) NOT NULL,
  `cant_producto` int(11) NOT NULL,
  `fecha_venta` date DEFAULT NULL,
  `numero_factura` int(11) NOT NULL,
  `iva` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id_factura`, `nit`, `precio_total`, `cant_producto`, `fecha_venta`, `numero_factura`, `iva`) VALUES
(567, 567, 34000, 0, '2020-08-14', 78, 45678),
(898, 79878, 34000, 234, '2020-08-13', 78, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `total_inventario` int(11) NOT NULL,
  `ventas_realizadas` int(11) NOT NULL,
  `productos_vendidos` varchar(45) NOT NULL,
  `productos_comprados` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id`, `id_producto`, `total_inventario`, `ventas_realizadas`, `productos_vendidos`, `productos_comprados`) VALUES
(5, 234, 787, 767, 'kaka', '7878');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `nom_producto` varchar(30) NOT NULL,
  `id_clasificacion` int(11) DEFAULT NULL,
  `marca` varchar(30) NOT NULL,
  `peso` varchar(30) NOT NULL,
  `precio` int(11) NOT NULL,
  `fecha_caducacion` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `nom_producto`, `id_clasificacion`, `marca`, `peso`, `precio`, `fecha_caducacion`) VALUES
(0, 'Big Ben', 304, 'Colombina', '23g', 34000, '2020-08-27'),
(234, 'Big Ben', 304, 'bimbo', '23g', 34000, '2020-08-13');

--
-- Disparadores `producto`
--
DELIMITER $$
CREATE TRIGGER `Prod_AD` AFTER DELETE ON `producto` FOR EACH ROW insert into Prod_eliminado  (id_producto,nom_producto,
 id_clasificacion,marca, peso,precio,fecha_caducacion)
values (old.id_producto, old.nom_producto, old.id_clasificacion,
 old.peso, old.precio, old.fecha_caducacion, 'Productos eliminados')
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Prod_AU` AFTER UPDATE ON `producto` FOR EACH ROW insert into actu_producto  (id_producto,nom_producto, id_clasificacion,marca, peso,precio,fecha_caducacion, nom_empresa, fecha_mod)
values (old.id_producto, old.nom_producto, old.id_clasificacion,old.marca, old.peso, 
old.precio, old.fecha_caducacion, sysdate())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Producto_AI` AFTER INSERT ON `producto` FOR EACH ROW insert into reg_producto 
(nom_producto, 
id_clasificacion,
 marca, 
 peso, 
 precio, 
 fecha_caducacion) 
values 
(new.nom_producto, new.id_clasificacion,
new.marca, new. peso, new.precio, new.fecha_caducacion)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_proveedor`
--

CREATE TABLE `producto_proveedor` (
  `id_proveedor` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prod_eliminado`
--

CREATE TABLE `prod_eliminado` (
  `id_producto` int(11) DEFAULT NULL,
  `nom_producto` varchar(30) DEFAULT NULL,
  `id_clasificacion` int(11) DEFAULT NULL,
  `marca` varchar(30) DEFAULT NULL,
  `peso` varchar(30) DEFAULT NULL,
  `precio` int(11) DEFAULT NULL,
  `fecha_caducacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `nom_empresa` varchar(20) NOT NULL,
  `catalogo` varchar(30) NOT NULL,
  `precio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `nombre`, `telefono`, `direccion`, `nom_empresa`, `catalogo`, `precio`) VALUES
(1001, 'yoiber', '3044508092', 'calle 65a sur numero 16c-34', 'mok', 'lechera', 34000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reg_producto`
--

CREATE TABLE `reg_producto` (
  `Act_productos` int(10) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `nom_producto` varchar(30) DEFAULT NULL,
  `id_clasificacion` int(11) DEFAULT NULL,
  `marca` varchar(30) DEFAULT NULL,
  `peso` varchar(30) DEFAULT NULL,
  `precio` int(11) DEFAULT NULL,
  `fecha_caducacion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nom_usuario` varchar(20) NOT NULL,
  `apellido_usuario` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `telefono_1` varchar(20) NOT NULL,
  `telefono_2` varchar(20) NOT NULL,
  `contraseña` varchar(40) NOT NULL,
  `nivel` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nom_usuario`, `apellido_usuario`, `email`, `direccion`, `telefono_1`, `telefono_2`, `contraseña`, `nivel`) VALUES
(29383, 'uor', 'beitasr', 'yoiber', 'bogo', '2424', '565564', 'yuyuy', 1),
(124323, 'Carla', 'oviedo', 'carla@gmail.com', 'nada', '2234244', '3546453', 'carla', 1),
(657890, 'Viviana', 'salgado', 'yoiberrenteria2017@gmail.com', '3145165661', '3145165661', '057840', '99999', 2),
(12345673, 'yoiber', 'beitar', 'yoiber@gmail.com', 'bogota', '323443', '345545', 'yoiber', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `venta`
--

CREATE TABLE `venta` (
  `id_venta` int(11) NOT NULL,
  `id_factura` int(11) DEFAULT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `fecha_venta` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `venta`
--

INSERT INTO `venta` (`id_venta`, `id_factura`, `id_producto`, `fecha_venta`) VALUES
(838, 567, 234, '2020-06-09');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clasificacion`
--
ALTER TABLE `clasificacion`
  ADD PRIMARY KEY (`id_clasificacion`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id_factura`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `id_clasificacion` (`id_clasificacion`);

--
-- Indices de la tabla `producto_proveedor`
--
ALTER TABLE `producto_proveedor`
  ADD KEY `id_proveedor` (`id_proveedor`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `reg_producto`
--
ALTER TABLE `reg_producto`
  ADD PRIMARY KEY (`Act_productos`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `contraseña` (`contraseña`);

--
-- Indices de la tabla `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`id_venta`),
  ADD KEY `id_producto` (`id_producto`),
  ADD KEY `id_factura` (`id_factura`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `reg_producto`
--
ALTER TABLE `reg_producto`
  MODIFY `Act_productos` int(10) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`id_clasificacion`) REFERENCES `clasificacion` (`id_clasificacion`);

--
-- Filtros para la tabla `producto_proveedor`
--
ALTER TABLE `producto_proveedor`
  ADD CONSTRAINT `producto_proveedor_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`),
  ADD CONSTRAINT `producto_proveedor_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`) ON DELETE CASCADE,
  ADD CONSTRAINT `venta_ibfk_3` FOREIGN KEY (`id_factura`) REFERENCES `factura` (`id_factura`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
