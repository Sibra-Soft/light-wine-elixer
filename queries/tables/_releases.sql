/*
Date: 2022-03-17 21:17:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _releases
-- ----------------------------
DROP TABLE IF EXISTS `_releases`;
CREATE TABLE `_releases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(8) DEFAULT NULL,
  `commits` text DEFAULT NULL,
  `remarks` longtext DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_on` datetime DEFAULT current_timestamp(),
  `released` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
