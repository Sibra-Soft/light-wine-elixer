/*
Date: 2022-03-17 21:20:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_templates
-- ----------------------------
DROP TABLE IF EXISTS `site_templates`;
CREATE TABLE `site_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` enum('css','javascript','html','sql','mail','markdown','module','worker','folder') DEFAULT NULL,
  `scripts` text DEFAULT NULL,
  `stylesheets` text DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT current_timestamp(),
  `date_modified` timestamp NULL DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `modified_by` varchar(255) DEFAULT NULL,
  `template_version_dev` int(11) DEFAULT NULL,
  `template_version_test` int(11) DEFAULT NULL,
  `template_version_live` int(11) DEFAULT NULL,
  `caching_hours` int(255) DEFAULT NULL,
  `caching_method` int(1) DEFAULT 0,
  `policies` varchar(255) DEFAULT '1004,1005,1006,1007',
  `parent_id` int(11) DEFAULT 0,
  `icon_index` int(11) DEFAULT 0,
  `active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
