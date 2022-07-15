/*
Date: 2022-03-17 21:18:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _user_roles
-- ----------------------------
DROP TABLE IF EXISTS `_user_roles`;
CREATE TABLE `_user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;
