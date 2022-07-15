/*
Date: 2022-03-17 21:19:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_packages
-- ----------------------------
DROP TABLE IF EXISTS `site_packages`;
CREATE TABLE `site_packages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `version` varchar(20) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `link` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
