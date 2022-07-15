/*
Date: 2022-03-17 21:19:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_objects
-- ----------------------------
DROP TABLE IF EXISTS `site_objects`;
CREATE TABLE `site_objects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `object_key` varchar(255) DEFAULT NULL,
  `object_value` varchar(255) DEFAULT NULL,
  `object_value_seo` varchar(255) DEFAULT NULL,
  `type` enum('item','folder') DEFAULT NULL,
  `expires` datetime DEFAULT NULL,
  `items` text DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `icon_index` int(255) DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
