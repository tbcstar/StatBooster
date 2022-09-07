-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.29 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
INSERT INTO `world`.`command`(`name`, `security`, `help`) VALUES ('sb', 4, '语法：.sb - 键入 .sb 以列出子命令。');
INSERT INTO `world`.`command`(`name`, `security`, `help`) VALUES ('sb reload', 4, '语法：.sb reload - 重新加载 statbooster_enchant_template 表。');
INSERT INTO `world`.`command`(`name`, `security`, `help`) VALUES ('sb additem', 4, '语法：.sb additem <itemid> <count> - 尝试将附魔物品添加到目标玩家。');

-- Dumping structure for table world.statbooster_enchant_template
CREATE TABLE IF NOT EXISTS `statbooster_enchant_template` (
  `Id` int unsigned DEFAULT NULL,
  `iLvlMin` int unsigned DEFAULT NULL,
  `iLvlMax` int unsigned DEFAULT NULL,
  `RoleMask` int unsigned DEFAULT NULL,
  `ClassMask` int unsigned DEFAULT NULL,
  `SubClassMask` int unsigned DEFAULT NULL,
  `Description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Note` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table world.statbooster_enchant_template: ~20 rows (approximately)
INSERT INTO `statbooster_enchant_template` (`Id`, `iLvlMin`, `iLvlMax`, `RoleMask`, `ClassMask`, `SubClassMask`, `Description`, `Note`) VALUES
	(68, 1, 20, 3, 0, 0, '+1 力量', 'TANK/PHYS - ALL - ALL'),
	(74, 1, 20, 7, 0, 0, '+1 敏捷', 'TANK/PHYS/HYBRID - ALL - ALL'),
	(79, 1, 20, 12, 0, 0, '+1 智力', 'HYBRID/SPELL - ALL - ALL'),
	(206, 1, 20, 8, 0, 0, '+1 法术强度', 'SPELL - ALL - ALL'),
	(66, 1, 20, 0, 0, 0, '+1 耐力', 'ALL - ALL - ALL'),
	(82, 1, 20, 8, 0, 0, '+1 精神', 'SPELL - ALL - ALL'),
	(75, 10, 30, 7, 0, 0, '+2 敏捷', 'TANK/PHYS/HYBRID - ALL - ALL'),
	(69, 10, 30, 3, 0, 0, '+2 力量', 'TANK/PHYS - ALL - ALL'),
	(80, 10, 30, 12, 0, 0, '+2 智力', 'HYBRID/SPELL - ALL - ALL'),
	(72, 10, 30, 0, 0, 0, '+2 耐力', 'ALL - ALL - ALL'),
	(83, 10, 30, 8, 0, 0, '+2 精神', 'SPELL - ALL - ALL'),
	(207, 10, 30, 8, 0, 0, '+2 法术强度', 'SPELL - ALL - ALL'),
	(76, 20, 40, 7, 0, 0, '+3 敏捷', 'TANK/PHYS/HYBRID - ALL - ALL'),
	(81, 20, 40, 12, 0, 0, '+3 智力', 'HYBRID/SPELL - ALL - ALL'),
	(73, 20, 40, 0, 0, 0, '+3 耐力', 'ALL - ALL - ALL'),
	(64, 20, 40, 8, 0, 0, '+3 精神', 'SPELL - ALL - ALL'),
	(70, 20, 40, 3, 0, 0, '+3 力量', 'TANK/PHYS - ALL - ALL'),
	(2910, 20, 40, 8, 0, 0, '+3 法术强度', 'SPELL - ALL - ALL'),
	(90, 30, 50, 7, 0, 0, '+4 敏捷', 'TANK/PHYS/HYRBRID - ALL - ALL'),
	(94, 30, 50, 12, 0, 0, '+4 智力', 'HYBRID/SPELL - ALL - ALL'),
	(102, 30, 50, 0, 0, 0, '+4 耐力', 'ALL - ALL - ALL'),
	(99, 30, 50, 8, 0, 0, '+4 精神', 'SPELL - ALL - ALL'),
	(106, 30, 50, 3, 0, 0, '+4 力量', 'TANK/PHYS - ALL - ALL'),
	(208, 30, 50, 8, 0, 0, '+4 法术强度', 'SPELL - ALL - ALL'),
	(91, 40, 60, 7, 0, 0, '+5 敏捷', 'TANK/PHYS/HYBRID - ALL - ALL'),
	(95, 40, 60, 12, 0, 0, '+5 智力', 'HYBRID/SPELL - ALL - ALL'),
	(103, 40, 60, 0, 0, 0, '+5 耐力', 'ALL - ALL - ALL'),
	(99, 40, 60, 8, 0, 0, '+5 精神', 'SPELL - ALL - ALL'),
	(107, 40, 60, 3, 0, 0, '+5 力量', 'TANK/PHYS - ALL - ALL'),
	(209, 40, 60, 8, 0, 0, '+5 法术强度', 'SPELL - ALL - ALL'),
	(92, 50, 70, 7, 0, 0, '+6 敏捷', 'TANK/PHYS/HYBRID - ALL - ALL'),
	(96, 50, 70, 12, 0, 0, '+6 智力', 'HYBRID/SPELL - ALL - ALL'),
	(104, 50, 70, 0, 0, 0, '+6 耐力', 'ALL - ALL - ALL'),
	(100, 50, 70, 8, 0, 0, '+6 精神', 'SPELL - ALL - ALL'),
	(108, 50, 70, 3, 0, 0, '+6 力量', 'TANK/PHYS - ALL - ALL'),
	(210, 50, 70, 8, 0, 0, '+6 法术强度', 'SPELL - ALL - ALL'),
	(93, 60, 80, 7, 0, 0, '+7 敏捷', 'TANK/PHYS/HYBRID - ALL - ALL'),
	(97, 60, 80, 12, 0, 0, '+7 智力', 'HYBRID/SPELL - ALL - ALL'),
	(105, 60, 80, 0, 0, 0, '+7 耐力', 'ALL - ALL - ALL'),
	(101, 60, 80, 8, 0, 0, '+7 精神', 'SPELL - ALL - ALL'),
	(109, 60, 80, 3, 0, 0, '+7 力量', 'TANK/PHYS - ALL - ALL'),
	(211, 60, 80, 8, 0, 0, '+7 法术强度', 'SPELL - ALL - ALL');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
