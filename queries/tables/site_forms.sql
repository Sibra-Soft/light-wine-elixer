/*
Date: 2022-03-17 21:19:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_forms
-- ----------------------------
DROP TABLE IF EXISTS `site_forms`;
CREATE TABLE `site_forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `send_mail` tinyint(1) DEFAULT 0,
  `mail_template` int(11) DEFAULT NULL,
  `use_formvalidation` tinyint(1) DEFAULT 0,
  `use_recaptcha` tinyint(1) DEFAULT 0,
  `button_text` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
