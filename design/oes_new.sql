/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50149
Source Host           : localhost:3306
Source Database       : oes_new

Target Server Type    : MYSQL
Target Server Version : 50149
File Encoding         : 65001

Date: 2015-10-23 16:57:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for collection
-- ----------------------------
DROP TABLE IF EXISTS `collection`;
CREATE TABLE `collection` (
  `user_pid` varchar(15) NOT NULL COMMENT '收藏用户id',
  `collector_pid` varchar(15) NOT NULL COMMENT '被收藏记录id',
  `create_time` varchar(100) NOT NULL COMMENT '创建时间',
  `collection_type` varchar(1) NOT NULL COMMENT '被收藏记录类型',
  PRIMARY KEY (`user_pid`,`collector_pid`,`collection_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for examination
-- ----------------------------
DROP TABLE IF EXISTS `examination`;
CREATE TABLE `examination` (
  `uuid` varchar(15) NOT NULL,
  `exam_type` varchar(10) NOT NULL COMMENT '1£ºÎª²âÑé¡£2£ºÎª¿¼ÊÔ',
  `exam_paper_pid` varchar(15) NOT NULL,
  `exam_begin_time` varchar(50) DEFAULT NULL COMMENT '¿¼ÊÔÀàÐÍÎª¿¼ÊÔÊ±²ÅÉèÖÃ',
  `exam_end_time` varchar(50) DEFAULT NULL COMMENT '¿¼ÊÔÀàÐÍÎª¿¼ÊÔÊ±²ÅÉèÖÃ',
  `exam_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `uuid` varchar(15) NOT NULL,
  `user_name` varchar(15) DEFAULT NULL,
  `user_pwd` varchar(15) DEFAULT NULL,
  `user_reg_time` varchar(15) DEFAULT NULL,
  `user_is_del` char(1) DEFAULT 'N',
  `user_head` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for member_exam_link
-- ----------------------------
DROP TABLE IF EXISTS `member_exam_link`;
CREATE TABLE `member_exam_link` (
  `member_pid` varchar(15) NOT NULL,
  `exam_pid` varchar(15) NOT NULL,
  `answer` varchar(5000) DEFAULT NULL,
  `create_time` varchar(100) NOT NULL,
  PRIMARY KEY (`member_pid`,`exam_pid`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `sender_pid` varchar(15) NOT NULL COMMENT '发送用户id',
  `reciver_pid` varchar(15) NOT NULL COMMENT '接受用户id',
  `send_time` varchar(100) DEFAULT NULL COMMENT '发送时间',
  `type` varchar(1) DEFAULT NULL COMMENT '消息类型 0 系统消息 1 用户消息',
  `is_read` varchar(1) DEFAULT NULL COMMENT '是否已读 0 未读 1 已读',
  `uuid` varchar(15) NOT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for paper
-- ----------------------------
DROP TABLE IF EXISTS `paper`;
CREATE TABLE `paper` (
  `uuid` varchar(15) NOT NULL,
  `title` varchar(15) DEFAULT NULL,
  `type` varchar(15) DEFAULT NULL,
  `serial_num` varchar(15) DEFAULT NULL,
  `topic_num` int(11) DEFAULT NULL,
  `total_point` int(11) DEFAULT NULL,
  `difficulty` varchar(3) DEFAULT NULL,
  `finished_time` int(11) DEFAULT NULL COMMENT '´æµÄÊÇºÁÃëÊý',
  `edit_time` varchar(50) DEFAULT NULL,
  `create_time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for paper_topic_link
-- ----------------------------
DROP TABLE IF EXISTS `paper_topic_link`;
CREATE TABLE `paper_topic_link` (
  `paper_pid` varchar(15) NOT NULL,
  `topic_pid` varchar(15) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`paper_pid`,`topic_pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_url_service_map
-- ----------------------------
DROP TABLE IF EXISTS `sys_url_service_map`;
CREATE TABLE `sys_url_service_map` (
  `url_flag` varchar(200) NOT NULL,
  `full_url` varchar(200) DEFAULT NULL,
  `priv_id` varchar(15) DEFAULT NULL,
  `tilte` varchar(200) DEFAULT NULL,
  `service_command` varchar(200) DEFAULT NULL,
  `page` varchar(200) DEFAULT NULL,
  `creater_pid` varchar(15) DEFAULT NULL,
  `create_time` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`url_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `uuid` varchar(15) NOT NULL,
  `type` varchar(2) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `create_time` varchar(100) DEFAULT NULL COMMENT '创建时间',
  `is_del` varchar(1) DEFAULT 'N' COMMENT '是否被删除',
  `describe` varchar(1000) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tag_other_link
-- ----------------------------
DROP TABLE IF EXISTS `tag_other_link`;
CREATE TABLE `tag_other_link` (
  `tag_pid` varchar(15) NOT NULL,
  `other_pid` varchar(15) NOT NULL,
  PRIMARY KEY (`tag_pid`,`other_pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for topic
-- ----------------------------
DROP TABLE IF EXISTS `topic`;
CREATE TABLE `topic` (
  `uuid` varchar(15) DEFAULT NULL,
  `content` varchar(1000) DEFAULT NULL,
  `type` char(1) DEFAULT NULL,
  `answer` varchar(1000) DEFAULT NULL,
  `opn_1` varchar(1000) DEFAULT NULL,
  `opn_2` varchar(100) DEFAULT NULL,
  `opn_3` varchar(100) DEFAULT NULL,
  `opn_4` varchar(100) DEFAULT NULL,
  `opn_5` varchar(100) DEFAULT NULL,
  `opn_6` varchar(100) DEFAULT NULL,
  `opn_7` varchar(100) DEFAULT NULL,
  `is_correct` varchar(1) DEFAULT 'N',
  `difficulty` varchar(3) DEFAULT NULL,
  `create_time` varchar(20) DEFAULT NULL,
  `edit_time` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
