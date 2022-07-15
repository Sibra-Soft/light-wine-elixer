/*
Date: 2022-03-17 21:17:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _traffic
-- ----------------------------
DROP TABLE IF EXISTS `_traffic`;
CREATE TABLE `_traffic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `size` int(11) DEFAULT NULL,
  `code` int(5) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `os` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `browser` varchar(255) DEFAULT '',
  `device_id` int(11) DEFAULT NULL,
  `device_type` varchar(255) DEFAULT '',
  `request_url` varchar(255) DEFAULT '',
  `date_added` timestamp NULL DEFAULT current_timestamp(),
  `session_id` varchar(255) DEFAULT '',
  `user_agent` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
