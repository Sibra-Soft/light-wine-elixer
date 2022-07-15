/*
Date: 2022-03-17 21:17:16
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _events
-- ----------------------------
DROP TABLE IF EXISTS `_events`;
CREATE TABLE `_events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `guid` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `expression` varchar(50) DEFAULT NULL,
  `last_run` datetime DEFAULT NULL,
  `next_run` datetime DEFAULT NULL,
  `added_on` datetime DEFAULT current_timestamp(),
  `status` enum('pending','running') DEFAULT 'pending',
  `template` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
