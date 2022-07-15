/*
Date: 2022-03-17 21:18:20
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _users
-- ----------------------------
DROP TABLE IF EXISTS `_users`;
CREATE TABLE `_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `confirm_hash` varchar(255) DEFAULT NULL,
  `date_added` timestamp NULL DEFAULT current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL,
  `display_name` varchar(80) DEFAULT '',
  `settings` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `_users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `_user_roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
