/*
Date: 2022-03-17 21:17:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _devices
-- ----------------------------
DROP TABLE IF EXISTS `_devices`;
CREATE TABLE `_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_guid` varchar(255) NOT NULL DEFAULT '',
  `user_id` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT current_timestamp(),
  `status` enum('verified','waiting') DEFAULT 'waiting',
  `ip` varchar(255) DEFAULT NULL,
  `hostname` varchar(255) DEFAULT NULL,
  `os` varchar(255) DEFAULT NULL,
  `verification_pincode` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `device_guid` (`device_guid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
