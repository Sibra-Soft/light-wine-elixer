/*
Date: 2022-03-17 21:20:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_translations
-- ----------------------------
DROP TABLE IF EXISTS `site_translations`;
CREATE TABLE `site_translations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anchor` varchar(255) NOT NULL DEFAULT '',
  `translation` longtext DEFAULT NULL,
  `language_code` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `anchor` (`anchor`,`language_code`) USING BTREE,
  KEY `language_code` (`language_code`),
  CONSTRAINT `site_translations_ibfk_1` FOREIGN KEY (`language_code`) REFERENCES `site_languages` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
