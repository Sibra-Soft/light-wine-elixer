/*
Date: 2022-03-17 21:19:58
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_template_renders
-- ----------------------------
DROP TABLE IF EXISTS `site_template_renders`;
CREATE TABLE `site_template_renders` (
  `id` int(11) NOT NULL,
  `template_id` int(11) DEFAULT NULL,
  `render_time_in_ms` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
