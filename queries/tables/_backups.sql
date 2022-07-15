/*
Date: 2022-03-17 21:13:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _backups
-- ----------------------------
DROP TABLE IF EXISTS `_backups`;
CREATE TABLE `_backups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT current_timestamp(),
  `created_by` varchar(255) DEFAULT NULL,
  `size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
