/*
Navicat MySQL Data Transfer

Source Server         : Webhosting Server - Vimexx - Sibra-Soft
Source Server Version : 100328
Source Host           : 185.104.29.106:3306
Source Database       : u62338p93741_moviedos

Target Server Type    : MYSQL
Target Server Version : 100328
File Encoding         : 65001

Date: 2022-08-15 21:47:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_routes
-- ----------------------------
DROP TABLE IF EXISTS `site_routes`;
CREATE TABLE `site_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT '',
  `url` varchar(255) DEFAULT '',
  `template_id` int(11) DEFAULT NULL,
  `published` tinyint(1) DEFAULT NULL,
  `meta_title` varchar(60) DEFAULT '',
  `meta_description` text DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `type` enum('template-link','page-link','channel','webmethod','api-handler') DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT '',
  `description` text DEFAULT NULL,
  `redirect_type` enum('301','302') DEFAULT NULL,
  `redirect_url` text DEFAULT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `date_changed` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;
