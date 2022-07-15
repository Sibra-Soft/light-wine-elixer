/*
Date: 2022-03-17 21:19:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_rest_api_parameters
-- ----------------------------
DROP TABLE IF EXISTS `site_rest_api_parameters`;
CREATE TABLE `site_rest_api_parameters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `api_id` int(11) DEFAULT NULL,
  `parameter` varchar(255) DEFAULT NULL,
  `data_type` enum('integer','string','date','datetime','blob') DEFAULT NULL,
  `is_key` tinyint(2) DEFAULT 0,
  `is_required` tinyint(2) DEFAULT 0,
  `default_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
