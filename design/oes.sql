/*
SQLyog 企业版 - MySQL GUI v8.14 
MySQL - 5.1.49-community : Database - oes_new
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`oes_new` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `oes_new`;

/*Table structure for table `examination` */

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

/*Data for the table `examination` */

insert  into `examination`(`uuid`,`exam_type`,`exam_paper_pid`,`exam_begin_time`,`exam_end_time`,`exam_name`) values ('1','1','1',NULL,NULL,'java测验'),('2','1','2',NULL,NULL,'c语言测验');

/*Table structure for table `member` */

DROP TABLE IF EXISTS `member`;

CREATE TABLE `member` (
  `uuid` varchar(15) NOT NULL,
  `user_name` varchar(15) DEFAULT NULL,
  `user_pwd` varchar(15) DEFAULT NULL,
  `user_reg_time` varchar(15) DEFAULT NULL,
  `user_is_del` char(1) DEFAULT 'N',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `member` */

insert  into `member`(`uuid`,`user_name`,`user_pwd`,`user_reg_time`,`user_is_del`) values ('1','admin','admin',NULL,'N'),('2','cw','123456','2015-08-31','N');

/*Table structure for table `member_exam_link` */

DROP TABLE IF EXISTS `member_exam_link`;

CREATE TABLE `member_exam_link` (
  `member_pid` varchar(15) NOT NULL,
  `exam_pid` varchar(15) NOT NULL,
  `answer` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`member_pid`,`exam_pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `member_exam_link` */

insert  into `member_exam_link`(`member_pid`,`exam_pid`,`answer`) values ('1','1','4:1'),('1','2','3:1|2:1|1:1');

/*Table structure for table `paper` */

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

/*Data for the table `paper` */

insert  into `paper`(`uuid`,`title`,`type`,`serial_num`,`topic_num`,`total_point`,`difficulty`,`finished_time`,`edit_time`,`create_time`) values ('1','JAVA考卷','高级编程语言','java-2015-08-27',3,15,'1',100000,NULL,NULL),('2','c语言考卷','高级编程语言','c-2015-08-30',3,15,'3',300000,NULL,NULL);

/*Table structure for table `paper_topic_link` */

DROP TABLE IF EXISTS `paper_topic_link`;

CREATE TABLE `paper_topic_link` (
  `paper_pid` varchar(15) NOT NULL,
  `topic_pid` varchar(15) NOT NULL,
  `sort` int(11) NOT NULL,
  PRIMARY KEY (`paper_pid`,`topic_pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `paper_topic_link` */

insert  into `paper_topic_link`(`paper_pid`,`topic_pid`,`sort`) values ('1','1',1),('1','2',2),('1','3',3),('2','4',1),('2','5',2),('2','6',3);

/*Table structure for table `sys_url_service_map` */

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

/*Data for the table `sys_url_service_map` */

insert  into `sys_url_service_map`(`url_flag`,`full_url`,`priv_id`,`tilte`,`service_command`,`page`,`creater_pid`,`create_time`) values ('beginExamByPersonal','/oes/common/ajax/beginExamByPersonal',NULL,'开始考试','beginExamByPersonal',NULL,NULL,NULL),('commitExam','/oes/common/ajax/commitExam',NULL,'提交考卷','commitExam',NULL,NULL,NULL),('getExams','/oes/common/ajax/getExams',NULL,'读取个人测验列表','getExams',NULL,NULL,NULL),('getPaper','/oes/common/ajax/getPaper',NULL,'读取考卷','getPaper',NULL,NULL,NULL),('getTopic','/oes/common/ajax/getTopic',NULL,'读取试题','getTopic',NULL,NULL,NULL),('memberLogin','/oes/common/memberLogin',NULL,'登录','memberLogin','oes/personalPage',NULL,NULL),('refreshCache','/oes/common/ajax/refreshCache',NULL,'刷新缓存','refreshCache',NULL,NULL,NULL),('saveAnswerOne','/oes/common/ajax/saveAnswerOne',NULL,'保存一个题目的答案','saveAnswerOne',NULL,NULL,NULL),('toExamPage','/oes/common/toExamPage',NULL,'去考试页面',NULL,'oes/examPage',NULL,NULL),('toLoginPage','/oes/common/toLoginPage',NULL,'去登录页面',NULL,'oes/login',NULL,NULL),('toPersonalPage','/oes/common/toPersonalPage',NULL,'个人页面',NULL,'oes/personalPage',NULL,NULL);

/*Table structure for table `topic` */

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

/*Data for the table `topic` */

insert  into `topic`(`uuid`,`content`,`type`,`answer`,`opn_1`,`opn_2`,`opn_3`,`opn_4`,`opn_5`,`opn_6`,`opn_7`,`is_correct`,`difficulty`,`create_time`,`edit_time`) values ('1','下面哪些是Thread类的方法（）','1','1','start()','running()  ','exit()','以上都是',NULL,NULL,NULL,'N','1',NULL,NULL),('2','下面关于java.lang.Exception类的说法正确的是（）','1','1','继承自Throwable','Serialable','只运行时异常类','以上都不是',NULL,NULL,NULL,'N',NULL,NULL,NULL),('3','下列说法正确的有（）','1','3','class中的constructor不可省略','constructor必须与class同名，但方法不能与class同名','constructor在一个对象被new时执行','一个class只能定义一个constructor',NULL,NULL,NULL,'N',NULL,NULL,NULL),('4','C语言规定C程序中的标识符是（）组成的','1','3','由任意顺序的字符','仅由字母和数字','由字母、数字和下划线','由字母、数字作为首字符的任意字符串',NULL,NULL,NULL,'N','1',NULL,NULL),('5','下列数据中( )是C语言规定的合法数据常量','1','4','01010011B ','0X37GF','07182',' 0X87AF',NULL,NULL,NULL,'N',NULL,NULL,NULL),('6','C语言包括（）种基本的程序结构','1','3','1','2','3','4',NULL,NULL,NULL,'N',NULL,NULL,NULL),(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'N',NULL,NULL,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
