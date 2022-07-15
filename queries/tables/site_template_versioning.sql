/*
Date: 2022-03-17 21:20:04
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_template_versioning
-- ----------------------------
DROP TABLE IF EXISTS `site_template_versioning`;
CREATE TABLE `site_template_versioning` (
  `template_id` int(11) NOT NULL,
  `version` int(11) NOT NULL,
  `date_modified` datetime DEFAULT current_timestamp(),
  `content` longtext DEFAULT NULL,
  `content_minified` longtext DEFAULT NULL,
  PRIMARY KEY (`template_id`,`version`),
  UNIQUE KEY `template_id` (`template_id`,`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
