/*
Date: 2022-03-17 21:18:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_bindings
-- ----------------------------
DROP TABLE IF EXISTS `site_bindings`;
CREATE TABLE `site_bindings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` enum('query-template','static-query') DEFAULT NULL,
  `source_template_id` int(11) DEFAULT NULL,
  `destination_template_id` int(11) DEFAULT NULL,
  `static_content` longtext DEFAULT NULL,
  `result_can_be_empty` tinyint(1) DEFAULT 0,
  `result_as_json` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
