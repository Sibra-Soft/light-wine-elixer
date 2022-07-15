/*
Date: 2022-03-17 21:19:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_settings
-- ----------------------------
DROP TABLE IF EXISTS `site_settings`;
CREATE TABLE `site_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `possible_values` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `group` varchar(255) DEFAULT NULL,
  `type` enum('string','boolean','integer','enum','query') DEFAULT NULL,
  `data_query` text DEFAULT NULL,
  `environment` enum('dev','test','live','') NOT NULL,
  `uid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `key` (`key`,`environment`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
