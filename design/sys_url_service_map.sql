/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50149
Source Host           : localhost:3306
Source Database       : oes_new

Target Server Type    : MYSQL
Target Server Version : 50149
File Encoding         : 65001

Date: 2015-10-23 16:56:26
*/

SET FOREIGN_KEY_CHECKS=0;

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
-- Records of sys_url_service_map
-- ----------------------------
INSERT INTO `sys_url_service_map` VALUES ('beginExamByPersonal', '/oes/common/ajax/beginExamByPersonal', null, '开始考试', 'beginExamByPersonal', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('collectionExam', '/oes/common/ajax/collectionExam', null, '收藏测验', 'collectionExam', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('commitExam', '/oes/common/ajax/commitExam', null, '提交考卷', 'commitExam', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('getExams', '/oes/common/ajax/getLikeExams', null, '读取个人测验列表', 'getLikeExams', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('getPaper', '/oes/common/ajax/getPaper', null, '读取考卷', 'getPaper', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('getPersonalExamRecordList', '/oes/common/ajax/getPersonalExamRecordList', null, '读取个人测验记录', 'getPersonalExamRecordList', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('getPersonalInfo', '/oes/common/ajax/getPersonalInfo', null, '读取个人信息', 'getPersonalInfo', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('getPersonalTag', '/oes/common/ajax/getPersonalTag', null, '获取用户标签', 'getPersonalTag', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('getTopic', '/oes/common/ajax/getTopic', null, '读取试题', 'getTopic', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('index', '/oes/common/index', null, '首页', null, 'index', null, null);
INSERT INTO `sys_url_service_map` VALUES ('memberAjaxLogin', '/oes/common/ajax/memberLogin', null, 'ajax登录', 'memberLogin', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('memberLogin', '/oes/common/memberLogin', null, '登录', 'memberLogin', 'oes/personalPage', null, null);
INSERT INTO `sys_url_service_map` VALUES ('memberSignOut', '/oes/common/ajax/memberSignOut', null, '安全退出', 'memberSignOut', 'index', null, null);
INSERT INTO `sys_url_service_map` VALUES ('refreshCache', '/oes/common/ajax/refreshCache', null, '刷新缓存', 'refreshCache', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('saveAnswerOne', '/oes/common/ajax/saveAnswerOne', null, '保存一个题目的答案', 'saveAnswerOne', null, null, null);
INSERT INTO `sys_url_service_map` VALUES ('toExamPage', '/oes/common/toExamPage', null, '去考试页面', null, 'oes/examPage', null, null);
INSERT INTO `sys_url_service_map` VALUES ('toExamRecordInfoPage', 'oes/common/toExamRecordInfoPage', null, '测验结果页面', null, 'oes/examRecordInfoPage', null, null);
INSERT INTO `sys_url_service_map` VALUES ('toLoginPage', '/oes/common/toLoginPage', null, '去登录页面', null, 'oes/login', null, null);
INSERT INTO `sys_url_service_map` VALUES ('toPersonalPage', '/oes/common/toPersonalPage', null, '个人页面', null, 'oes/personalPage', null, null);
INSERT INTO `sys_url_service_map` VALUES ('unCollectionExam', '/oes/common/ajax/unCollectionExam', null, '取消收藏测验', 'unCollectionExam', null, null, null);
