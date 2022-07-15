/*
Date: 2022-03-17 21:16:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _commits_objects
-- ----------------------------
DROP TABLE IF EXISTS `_commits_objects`;
CREATE TABLE `_commits_objects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `commit_id` int(11) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  `template_version` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `template_id` (`template_id`,`template_version`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=292 DEFAULT CHARSET=latin1;
