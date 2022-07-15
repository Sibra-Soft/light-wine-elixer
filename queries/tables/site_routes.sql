/*
Date: 2022-03-17 21:19:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_routes
-- ----------------------------
DROP TABLE IF EXISTS `site_routes`;
CREATE TABLE `site_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '',
  `url` varchar(255) DEFAULT '',
  `template_id` int(11) DEFAULT NULL,
  `published` tinyint(1) DEFAULT NULL,
  `meta_title` varchar(60) DEFAULT '',
  `meta_description` text DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `type` enum('template-link','redirect') DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT '',
  `description` text DEFAULT NULL,
  `redirect_url` text DEFAULT NULL,
  `redirect_type` enum('301','302') DEFAULT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `date_changed` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
