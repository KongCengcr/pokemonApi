-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-12-2022 a las 23:11:30
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pokemon_api`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `countEachTypePokemon` ()   BEGIN 
SELECT types.name AS `type`, COUNT(pokemon_types.type_id) AS `count` FROM pokemon_types JOIN types ON pokemon_types.type_id = types.id GROUP BY pokemon_types.type_id; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `countPokemonBeginningByTypes` (IN `type` CHAR(20))   BEGIN 
SELECT types.name AS `type`, COUNT(pokemon_types.type_id) AS `count` 
                FROM pokemon_types
                    JOIN types ON pokemon_types.type_id = types.id 
                        WHERE types.name LIKE CONCAT(type,'%') 
                        GROUP BY pokemon_types.type_id; 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePokemon` (IN `pokemonId` INT)   BEGIN
DELETE FROM pokemon WHERE id LIKE pokemonId;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `breakpoint` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`version`, `migration_name`, `start_time`, `end_time`, `breakpoint`) VALUES
(20221213034949, 'CreateTypesTableMigration', '2022-12-21 02:49:25', '2022-12-21 02:49:26', 0),
(20221214013858, 'CreatePokemonTableMigration', '2022-12-21 02:49:26', '2022-12-21 02:49:26', 0),
(20221215011836, 'CreatePokemonTypesTableMigration', '2022-12-21 02:49:26', '2022-12-21 02:49:27', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pokemon`
--

CREATE TABLE `pokemon` (
  `id` int(11) NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_experience` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `sprite_front_default` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sprite_front_shiny` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sprite_female_default` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sprite_female_shiny` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pokemon`
--

INSERT INTO `pokemon` (`id`, `name`, `base_experience`, `height`, `is_default`, `order`, `weight`, `sprite_front_default`, `sprite_front_shiny`, `sprite_female_default`, `sprite_female_shiny`) VALUES
(1, 'bulbasaur', 64, 7, 1, 1, 69, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png', '', ''),
(2, 'ivysaur', 142, 10, 1, 2, 130, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/2.png', '', ''),
(3, 'venusaur', 263, 20, 1, 3, 1000, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/3.png', '', ''),
(4, 'charmander', 62, 6, 1, 5, 85, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/4.png', '', ''),
(5, 'charmeleon', 142, 11, 1, 6, 190, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/5.png', '', ''),
(6, 'charizard', 267, 17, 1, 7, 905, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/6.png', '', ''),
(7, 'squirtle', 63, 5, 1, 10, 90, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/7.png', '', ''),
(8, 'wartortle', 142, 10, 1, 11, 225, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/8.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/8.png', '', ''),
(9, 'blastoise', 265, 16, 1, 12, 855, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/9.png', '', ''),
(10, 'caterpie', 39, 3, 1, 14, 29, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/10.png', '', ''),
(11, 'metapod', 72, 7, 1, 15, 99, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/11.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/11.png', '', ''),
(12, 'butterfree', 198, 11, 1, 16, 320, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/12.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/12.png', '', ''),
(13, 'weedle', 39, 3, 1, 17, 32, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/13.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/13.png', '', ''),
(14, 'kakuna', 72, 6, 1, 18, 100, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/14.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/14.png', '', ''),
(15, 'beedrill', 178, 10, 1, 19, 295, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/15.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/15.png', '', ''),
(16, 'pidgey', 50, 3, 1, 21, 18, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/16.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/16.png', '', ''),
(17, 'pidgeotto', 122, 11, 1, 22, 300, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/17.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/17.png', '', ''),
(18, 'pidgeot', 216, 15, 1, 23, 395, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/18.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/18.png', '', ''),
(19, 'rattata', 51, 3, 1, 25, 35, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/19.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/19.png', '', ''),
(20, 'raticate', 145, 7, 1, 27, 185, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/20.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/20.png', '', ''),
(21, 'spearow', 52, 3, 1, 30, 20, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/21.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/21.png', '', ''),
(22, 'fearow', 155, 12, 1, 31, 380, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/22.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/22.png', '', ''),
(23, 'ekans', 58, 20, 1, 32, 69, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/23.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/23.png', '', ''),
(24, 'arbok', 157, 35, 1, 33, 650, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/24.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/24.png', '', ''),
(25, 'pikachu', 112, 4, 1, 35, 60, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png', '', ''),
(26, 'raichu', 243, 8, 1, 51, 300, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/26.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/26.png', '', ''),
(27, 'sandshrew', 60, 6, 1, 53, 120, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/27.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/27.png', '', ''),
(28, 'sandslash', 158, 10, 1, 55, 295, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/28.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/28.png', '', ''),
(29, 'nidoran-f', 55, 4, 1, 57, 70, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/29.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/29.png', '', ''),
(30, 'nidorina', 128, 8, 1, 58, 200, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/30.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/30.png', '', ''),
(31, 'nidoqueen', 253, 13, 1, 59, 600, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/31.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/31.png', '', ''),
(32, 'nidoran-m', 55, 5, 1, 60, 90, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/32.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/32.png', '', ''),
(33, 'nidorino', 128, 9, 1, 61, 195, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/33.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/33.png', '', ''),
(34, 'nidoking', 253, 14, 1, 62, 620, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/34.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/34.png', '', ''),
(35, 'clefairy', 113, 6, 1, 64, 75, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/35.png', '', ''),
(36, 'clefable', 242, 13, 1, 65, 400, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/36.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/36.png', '', ''),
(37, 'vulpix', 60, 6, 1, 66, 99, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/37.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/37.png', '', ''),
(38, 'ninetales', 177, 11, 1, 68, 199, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/38.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/38.png', '', ''),
(39, 'jigglypuff', 95, 5, 1, 71, 55, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/39.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/39.png', '', ''),
(40, 'wigglytuff', 218, 10, 1, 72, 120, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/40.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/40.png', '', ''),
(41, 'zubat', 49, 8, 1, 73, 75, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/41.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/41.png', '', ''),
(42, 'golbat', 159, 16, 1, 74, 550, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/42.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/42.png', '', ''),
(43, 'oddish', 64, 5, 1, 76, 54, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/43.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/43.png', '', ''),
(44, 'gloom', 138, 8, 1, 77, 86, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/44.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/44.png', '', ''),
(45, 'vileplume', 245, 12, 1, 78, 186, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/45.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/45.png', '', ''),
(46, 'paras', 57, 3, 1, 80, 54, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/46.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/46.png', '', ''),
(47, 'parasect', 142, 10, 1, 81, 295, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/47.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/47.png', '', ''),
(48, 'venonat', 61, 10, 1, 82, 300, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/48.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/48.png', '', ''),
(49, 'venomoth', 158, 15, 1, 83, 125, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/49.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/49.png', '', ''),
(50, 'diglett', 53, 2, 1, 84, 8, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/50.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/50.png', '', ''),
(51, 'dugtrio', 149, 7, 1, 86, 333, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/51.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/51.png', '', ''),
(52, 'meowth', 58, 4, 1, 88, 42, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/52.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/52.png', '', ''),
(53, 'persian', 154, 10, 1, 91, 320, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/53.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/53.png', '', ''),
(54, 'psyduck', 64, 8, 1, 93, 196, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/54.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/54.png', '', ''),
(55, 'golduck', 175, 17, 1, 94, 766, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/55.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/55.png', '', ''),
(56, 'mankey', 61, 5, 1, 95, 280, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/56.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/56.png', '', ''),
(57, 'primeape', 159, 10, 1, 96, 320, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/57.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/57.png', '', ''),
(58, 'growlithe', 70, 7, 1, 97, 190, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/58.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/58.png', '', ''),
(59, 'arcanine', 194, 19, 1, 98, 1550, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/59.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/59.png', '', ''),
(60, 'poliwag', 60, 6, 1, 99, 124, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/60.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/60.png', '', ''),
(61, 'poliwhirl', 135, 10, 1, 100, 200, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/61.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/61.png', '', ''),
(62, 'poliwrath', 255, 13, 1, 101, 540, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/62.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/62.png', '', ''),
(63, 'abra', 62, 9, 1, 103, 195, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/63.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/63.png', '', ''),
(64, 'kadabra', 140, 13, 1, 104, 565, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/64.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/64.png', '', ''),
(65, 'alakazam', 250, 15, 1, 105, 480, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/65.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/65.png', '', ''),
(66, 'machop', 61, 8, 1, 107, 195, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/66.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/66.png', '', ''),
(67, 'machoke', 142, 15, 1, 108, 705, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/67.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/67.png', '', ''),
(68, 'machamp', 253, 16, 1, 109, 1300, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/68.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/68.png', '', ''),
(69, 'bellsprout', 60, 7, 1, 110, 40, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/69.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/69.png', '', ''),
(70, 'weepinbell', 137, 10, 1, 111, 64, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/70.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/70.png', '', ''),
(71, 'victreebel', 221, 17, 1, 112, 155, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/71.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/71.png', '', ''),
(72, 'tentacool', 67, 9, 1, 113, 455, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/72.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/72.png', '', ''),
(73, 'tentacruel', 180, 16, 1, 114, 550, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/73.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/73.png', '', ''),
(74, 'geodude', 60, 4, 1, 115, 200, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/74.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/74.png', '', ''),
(75, 'graveler', 137, 10, 1, 117, 1050, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/75.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/75.png', '', ''),
(76, 'golem', 223, 14, 1, 119, 3000, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/76.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/76.png', '', ''),
(77, 'ponyta', 82, 10, 1, 121, 300, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/77.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/77.png', '', ''),
(78, 'rapidash', 175, 17, 1, 123, 950, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/78.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/78.png', '', ''),
(79, 'slowpoke', 63, 12, 1, 125, 360, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/79.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/79.png', '', ''),
(80, 'slowbro', 172, 16, 1, 127, 785, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/80.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/80.png', '', ''),
(81, 'magnemite', 65, 3, 1, 132, 60, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/81.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/81.png', '', ''),
(82, 'magneton', 163, 10, 1, 133, 600, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/82.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/82.png', '', ''),
(83, 'farfetchd', 132, 8, 1, 135, 150, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/83.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/83.png', '', ''),
(84, 'doduo', 62, 14, 1, 137, 392, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/84.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/84.png', '', ''),
(85, 'dodrio', 165, 18, 1, 138, 852, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/85.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/85.png', '', ''),
(86, 'seel', 65, 11, 1, 139, 900, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/86.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/86.png', '', ''),
(87, 'dewgong', 166, 17, 1, 140, 1200, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/87.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/87.png', '', ''),
(88, 'grimer', 65, 9, 1, 141, 300, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/88.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/88.png', '', ''),
(89, 'muk', 175, 12, 1, 143, 300, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/89.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/89.png', '', ''),
(90, 'shellder', 61, 3, 1, 145, 40, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/90.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/90.png', '', ''),
(91, 'cloyster', 184, 15, 1, 146, 1325, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/91.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/91.png', '', ''),
(92, 'gastly', 62, 13, 1, 147, 1, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/92.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/92.png', '', ''),
(93, 'haunter', 142, 16, 1, 148, 1, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/93.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/93.png', '', ''),
(94, 'gengar', 250, 15, 1, 149, 405, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/94.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/94.png', '', ''),
(95, 'onix', 77, 88, 1, 151, 2100, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/95.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/95.png', '', ''),
(96, 'drowzee', 66, 10, 1, 154, 324, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/96.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/96.png', '', ''),
(97, 'hypno', 169, 16, 1, 155, 756, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/97.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/97.png', '', ''),
(98, 'krabby', 65, 4, 1, 156, 65, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/98.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/98.png', '', ''),
(99, 'kingler', 166, 13, 1, 157, 600, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/99.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/99.png', '', ''),
(100, 'voltorb', 66, 5, 1, 158, 104, 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/100.png', 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/100.png', '', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pokemon_types`
--

CREATE TABLE `pokemon_types` (
  `id` int(11) NOT NULL,
  `type_id` int(11) DEFAULT NULL,
  `pokemon_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pokemon_types`
--

INSERT INTO `pokemon_types` (`id`, `type_id`, `pokemon_id`) VALUES
(1, 12, 1),
(2, 4, 1),
(3, 12, 2),
(4, 4, 2),
(5, 12, 3),
(6, 4, 3),
(7, 10, 4),
(8, 10, 5),
(9, 10, 6),
(10, 3, 6),
(11, 11, 7),
(12, 11, 8),
(13, 11, 9),
(14, 7, 10),
(15, 7, 11),
(16, 7, 12),
(17, 3, 12),
(18, 7, 13),
(19, 4, 13),
(20, 7, 14),
(21, 4, 14),
(22, 7, 15),
(23, 4, 15),
(24, 1, 16),
(25, 3, 16),
(26, 1, 17),
(27, 3, 17),
(28, 1, 18),
(29, 3, 18),
(30, 1, 19),
(31, 1, 20),
(32, 1, 21),
(33, 3, 21),
(34, 1, 22),
(35, 3, 22),
(36, 4, 23),
(37, 4, 24),
(38, 13, 25),
(39, 13, 26),
(40, 5, 27),
(41, 5, 28),
(42, 4, 29),
(43, 4, 30),
(44, 4, 31),
(45, 5, 31),
(46, 4, 32),
(47, 4, 33),
(48, 4, 34),
(49, 5, 34),
(50, 18, 35),
(51, 18, 36),
(52, 10, 37),
(53, 10, 38),
(54, 1, 39),
(55, 18, 39),
(56, 1, 40),
(57, 18, 40),
(58, 4, 41),
(59, 3, 41),
(60, 4, 42),
(61, 3, 42),
(62, 12, 43),
(63, 4, 43),
(64, 12, 44),
(65, 4, 44),
(66, 12, 45),
(67, 4, 45),
(68, 7, 46),
(69, 12, 46),
(70, 7, 47),
(71, 12, 47),
(72, 7, 48),
(73, 4, 48),
(74, 7, 49),
(75, 4, 49),
(76, 5, 50),
(77, 5, 51),
(78, 1, 52),
(79, 1, 53),
(80, 11, 54),
(81, 11, 55),
(82, 2, 56),
(83, 2, 57),
(84, 10, 58),
(85, 10, 59),
(86, 11, 60),
(87, 11, 61),
(88, 11, 62),
(89, 2, 62),
(90, 14, 63),
(91, 14, 64),
(92, 14, 65),
(93, 2, 66),
(94, 2, 67),
(95, 2, 68),
(96, 12, 69),
(97, 4, 69),
(98, 12, 70),
(99, 4, 70),
(100, 12, 71),
(101, 4, 71),
(102, 11, 72),
(103, 4, 72),
(104, 11, 73),
(105, 4, 73),
(106, 6, 74),
(107, 5, 74),
(108, 6, 75),
(109, 5, 75),
(110, 6, 76),
(111, 5, 76),
(112, 10, 77),
(113, 10, 78),
(114, 11, 79),
(115, 14, 79),
(116, 11, 80),
(117, 14, 80),
(118, 13, 81),
(119, 9, 81),
(120, 13, 82),
(121, 9, 82),
(122, 1, 83),
(123, 3, 83),
(124, 1, 84),
(125, 3, 84),
(126, 1, 85),
(127, 3, 85),
(128, 11, 86),
(129, 11, 87),
(130, 15, 87),
(131, 4, 88),
(132, 4, 89),
(133, 11, 90),
(134, 11, 91),
(135, 15, 91),
(136, 8, 92),
(137, 4, 92),
(138, 8, 93),
(139, 4, 93),
(140, 8, 94),
(141, 4, 94),
(142, 6, 95),
(143, 5, 95),
(144, 14, 96),
(145, 14, 97),
(146, 11, 98),
(147, 11, 99),
(148, 13, 100);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `types`
--

CREATE TABLE `types` (
  `id` int(11) NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `types`
--

INSERT INTO `types` (`id`, `name`) VALUES
(1, 'normal'),
(2, 'fighting'),
(3, 'flying'),
(4, 'poison'),
(5, 'ground'),
(6, 'rock'),
(7, 'bug'),
(8, 'ghost'),
(9, 'steel'),
(10, 'fire'),
(11, 'water'),
(12, 'grass'),
(13, 'electric'),
(14, 'psychic'),
(15, 'ice'),
(16, 'dragon'),
(17, 'dark'),
(18, 'fairy'),
(19, 'unknown'),
(20, 'shadow');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`version`);

--
-- Indices de la tabla `pokemon`
--
ALTER TABLE `pokemon`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `pokemon_types`
--
ALTER TABLE `pokemon_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`type_id`),
  ADD KEY `pokemon_id` (`pokemon_id`);

--
-- Indices de la tabla `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `pokemon`
--
ALTER TABLE `pokemon`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT de la tabla `pokemon_types`
--
ALTER TABLE `pokemon_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT de la tabla `types`
--
ALTER TABLE `types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pokemon_types`
--
ALTER TABLE `pokemon_types`
  ADD CONSTRAINT `pokemon_types_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pokemon_types_ibfk_2` FOREIGN KEY (`pokemon_id`) REFERENCES `pokemon` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
