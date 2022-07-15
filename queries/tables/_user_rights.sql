/*
Date: 2022-03-17 21:18:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _user_rights
-- ----------------------------
DROP TABLE IF EXISTS `_user_rights`;
CREATE TABLE `_user_rights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `show` tinyint(1) DEFAULT NULL,
  `read` tinyint(1) DEFAULT NULL,
  `create` tinyint(1) DEFAULT NULL,
  `delete` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
