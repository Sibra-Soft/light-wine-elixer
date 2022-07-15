/*
Date: 2022-03-17 21:17:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _release_changelog
-- ----------------------------
DROP TABLE IF EXISTS `_release_changelog`;
CREATE TABLE `_release_changelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `release_id` int(11) DEFAULT NULL,
  `type` enum('Added','Changed','Deprecated','Removed','Fixed','Security') DEFAULT NULL,
  `change_description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `release_id` (`release_id`),
  CONSTRAINT `_release_changelog_ibfk_1` FOREIGN KEY (`release_id`) REFERENCES `_releases` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
