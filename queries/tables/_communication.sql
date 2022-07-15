/*
Date: 2022-03-17 21:17:02
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for _communication
-- ----------------------------
DROP TABLE IF EXISTS `_communication`;
CREATE TABLE `_communication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `receiver_email` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `body` longtext DEFAULT NULL,
  `date_scheduled` datetime DEFAULT current_timestamp() COMMENT 'The date and time the mail must be send',
  `attachments` text DEFAULT NULL COMMENT 'Comma seperated the fullpath to the files',
  `date_added` datetime DEFAULT current_timestamp(),
  `date_processed` datetime DEFAULT NULL,
  `date_sent` datetime DEFAULT NULL,
  `type` enum('email','sms','whatsapp') CHARACTER SET utf8mb4 NOT NULL DEFAULT 'email' COMMENT 'The communication type',
  `last_attempt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
