/*
Date: 2022-03-17 21:18:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_form_fields
-- ----------------------------
DROP TABLE IF EXISTS `site_form_fields`;
CREATE TABLE `site_form_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` text DEFAULT NULL,
  `is_required` tinyint(1) DEFAULT 0,
  `validation_type` enum('text','date','number','zipcode','email','phone') DEFAULT 'text',
  `add_field_to_new_row` tinyint(1) DEFAULT 0,
  `row_column` varchar(255) DEFAULT NULL,
  `label_caption` varchar(255) DEFAULT NULL,
  `field_type` enum('inputbox','textarea','checkbox','dropdown','optionbox','inputbox-password') DEFAULT NULL,
  `placeholder` varchar(255) DEFAULT '',
  `row_field_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
