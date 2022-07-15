/*
Date: 2022-03-17 21:18:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_files
-- ----------------------------
DROP TABLE IF EXISTS `site_files`;
CREATE TABLE `site_files` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT 0,
  `item_id` int(11) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `content` longblob DEFAULT NULL,
  `content_type` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `date_added` datetime DEFAULT current_timestamp(),
  `date_modified` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `created_by` varchar(255) DEFAULT '',
  `download_count` int(11) DEFAULT 0,
  `parent_id` int(11) DEFAULT 0,
  `type` enum('image','folder') DEFAULT 'image',
  `cache` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `filename` (`filename`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=786 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
