DELETE FROM `command` WHERE name='sb';
INSERT INTO `command`(`name`, `security`, `help`) VALUES ('sb', 3, '语法：.sb - type .sb to list subcommands.');

DELETE FROM `command` WHERE name='sb additem';
INSERT INTO `command`(`name`, `security`, `help`) VALUES ('sb additem', 3, '语法：.sb additem <物品ID> <数量> - 尝试向目标玩家添加附魔物品。');

DROP TABLE IF EXISTS `statbooster_enchant_template`;
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
	
DROP TABLE IF EXISTS `statbooster_enchant_scores`;
CREATE TABLE IF NOT EXISTS `statbooster_enchant_scores` (
  `mod_type` int(11) DEFAULT NULL,
  `mod_id` int(11) DEFAULT NULL,
  `subclass` int(11) DEFAULT NULL,
  `tank_score` int(11) DEFAULT NULL,
  `phys_score` int(11) DEFAULT NULL,
  `spell_score` int(11) DEFAULT NULL,
  `hybrid_score` int(11) DEFAULT NULL,
  `note` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `statbooster_enchant_scores` (`mod_type`, `mod_id`, `subclass`, `tank_score`, `phys_score`, `spell_score`, `hybrid_score`, `note`) VALUES
	(0, 44, 0, 1, 2, 0, 1, 'ITEM_MOD_ARMOR_PENETRATION_RATING - ALL'),
	(0, 38, 0, 1, 2, 0, 1, 'ITEM_MOD_ATTACK_POWER - ALL'),
	(0, 4, 0, 1, 2, 0, 1, 'ITEM_MOD_STRENGTH - ALL'),
	(0, 3, 0, 1, 2, 0, 1, 'ITEM_MOD_AGILITY - ALL'),
	(0, 5, 1, 0, 0, 1, 0, 'ITEM_MOD_INTELLECT - CLOTH'),
	(0, 5, 2, 0, 0, 1, 1, 'ITEM_MOD_INTELLECT - LEATHER'),
	(0, 5, 3, 1, 0, 1, 1, 'ITEM_MOD_INTELLECT - MAIL'),
	(0, 5, 4, 1, 0, 1, 0, 'ITEM_MOD_INTELLECT - PLATE'),
	(0, 5, 0, 1, 0, 3, 2, 'ITEM_MOD_INTELLECT - ALL'),
	(0, 6, 0, 0, 0, 1, 0, 'ITEM_MOD_SPIRIT - ALL'),
	(0, 43, 0, 0, 0, 1, 0, 'ITEM_MOD_MANA_REGENERATION - ALL'),
	(0, 41, 0, 0, 0, 1, 0, 'ITEM_MOD_SPELL_HEALING_DONE - ALL'),
	(0, 45, 0, 0, 0, 1, 0, 'ITEM_MOD_SPELL_POWER - ALL'),
	(0, 47, 0, 0, 0, 1, 0, 'ITEM_MOD_SPELL_PENETRATION - ALL'),
	(0, 42, 0, 0, 0, 1, 0, 'ITEM_MOD_SPELL_DAMAGE_DONE - ALL'),
	(0, 14, 0, 3, 0, 0, 0, 'ITEM_MOD_PARRY_RATING - ALL'),
	(0, 13, 0, 3, 0, 0, 0, 'ITEM_MOD_DODGE_RATING - ALL'),
	(0, 12, 0, 3, 0, 0, 0, 'ITEM_MOD_DEFENSE_SKILL_RATING - ALL'),
	(0, 15, 0, 3, 0, 0, 0, 'ITEM_MOD_BLOCK_RATING - ALL'),
	(1, 99, 0, 1, 2, 0, 1, 'SPELL_AURA_MOD_ATTACK_POWER - ALL'),
	(1, 135, 0, 0, 0, 0, 1, 'SPELL_AURA_MOD_HEALING_DONE - ALL'),
	(1, 85, 0, 0, 0, 0, 1, 'SPELL_AURA_MOD_POWER_REGEN - ALL'),
	(1, 13, 0, 0, 0, 0, 1, 'SPELL_AURA_MOD_DAMAGE_DONE - ALL');
