/*
Date: 2022-03-17 21:18:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_dynamic_content
-- ----------------------------
DROP TABLE IF EXISTS `site_dynamic_content`;
CREATE TABLE `site_dynamic_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `mode` varchar(255) DEFAULT '',
  `settings` longtext DEFAULT NULL,
  `type` enum('dataview','device-verification','account') DEFAULT NULL,
  `added_on` datetime DEFAULT current_timestamp(),
  `added_by` varchar(255) DEFAULT '',
  `changed_on` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `changed_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
