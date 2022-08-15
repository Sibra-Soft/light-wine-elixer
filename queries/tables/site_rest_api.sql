/*
Navicat MySQL Data Transfer

Source Server         : Webhosting Server - Vimexx - Sibra-Soft
Source Server Version : 100328
Source Host           : 185.104.29.106:3306
Source Database       : u62338p93741_moviedos

Target Server Type    : MYSQL
Target Server Version : 100328
File Encoding         : 65001

Date: 2022-08-15 21:47:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for site_rest_api
-- ----------------------------
DROP TABLE IF EXISTS `site_rest_api`;
CREATE TABLE `site_rest_api` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `match_pattern` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `allowed_methodes` varchar(80) DEFAULT NULL,
  `readonly` tinyint(2) DEFAULT NULL,
  `exclude_paramters` varchar(255) DEFAULT NULL,
  `include_columns` text DEFAULT NULL,
  `exclude_columns` text DEFAULT NULL,
  `datasource` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT current_timestamp(),
  `date_changed` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
