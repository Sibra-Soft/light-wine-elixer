/*
Date: 2022-03-17 21:19:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_rest_api
-- ----------------------------
DROP TABLE IF EXISTS `site_rest_api`;
CREATE TABLE `site_rest_api` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `match_pattern` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `allowed_methodes` varchar(80) DEFAULT NULL,
  `readonly` tinyint(2) DEFAULT NULL,
  `exclude_paramters` varchar(255) DEFAULT NULL,
  `include_columns` text DEFAULT NULL,
  `exclude_columns` text DEFAULT NULL,
  `datasource` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `date_changed` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
