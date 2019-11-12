-- --------------------------------------------------------
-- Värd:                         127.0.0.1
-- Serverversion:                5.7.27-0ubuntu0.18.04.1 - (Ubuntu)
-- Server-OS:                    Linux
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumpar databasstruktur för appetize
DROP DATABASE IF EXISTS `appetize`;
CREATE DATABASE IF NOT EXISTS `appetize` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `appetize`;

-- Dumpar struktur för tabell appetize.forms
DROP TABLE IF EXISTS `forms`;
CREATE TABLE IF NOT EXISTS `forms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `day` date DEFAULT NULL,
  `submitted` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `edited` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `rating` float NOT NULL,
  `text` text COLLATE utf8_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Daily input and reviews from students are saved here.\r\n';

-- Dataexport var bortvalt.

-- Dumpar struktur för tabell appetize.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(250) COLLATE utf8_bin NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Dataexport var bortvalt.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
