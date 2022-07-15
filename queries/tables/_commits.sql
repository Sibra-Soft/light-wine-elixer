/*
Date: 2022-03-17 21:13:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _commits
-- ----------------------------
DROP TABLE IF EXISTS `_commits`;
CREATE TABLE `_commits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT current_timestamp(),
  `templates` text DEFAULT NULL,
  `enviroment` int(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
