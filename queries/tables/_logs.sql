/*
Date: 2022-03-17 21:17:25
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _logs
-- ----------------------------
DROP TABLE IF EXISTS `_logs`;
CREATE TABLE `_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_added` timestamp NULL DEFAULT current_timestamp(),
  `message` longtext DEFAULT NULL,
  `type` enum('critical','warning','error','info','debug') DEFAULT NULL,
  `category` enum('website','payment_in','payment_out','general','sql_mutation','workers') DEFAULT NULL,
  `extra_properties` longtext DEFAULT NULL,
  `connected_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34579 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
