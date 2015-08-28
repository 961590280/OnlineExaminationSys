/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2015/8/27 14:28:42                           */
/*==============================================================*/


drop table if exists examination;

drop table if exists member;

drop table if exists member_exam_link;

drop table if exists paper;

drop table if exists paper_topic_link;

drop table if exists sys_url_service_map;

drop table if exists topic;

/*==============================================================*/
/* Table: examination                                           */
/*==============================================================*/
create table examination
(
   uuid                 varchar(15) not null,
   exam_type            varchar(10) not null comment '1：为测验。2：为考试',
   exam_paper_pid       varchar(15) not null,
   exam_begin_time      varchar(50) comment '考试类型为考试时才设置',
   exam_end_time        varchar(50) comment '考试类型为考试时才设置',
   primary key (uuid)
);

/*==============================================================*/
/* Table: member                                                */
/*==============================================================*/
create table member
(
   uuid                 varchar(15) not null,
   user_name            varchar(15),
   user_pwd             varchar(15),
   user_reg_time        varchar(15),
   user_is_del          char default 'N',
   primary key (uuid)
);

/*==============================================================*/
/* Table: member_exam_link                                      */
/*==============================================================*/
create table member_exam_link
(
   member_pid           varchar(15) not null,
   exam_pid             varchar(15) not null,
   primary key (member_pid, exam_pid)
);

/*==============================================================*/
/* Table: paper                                                 */
/*==============================================================*/
create table paper
(
   uuid                 varchar(15) not null,
   title                varchar(15),
   type                 varchar(15),
   serial_num           varchar(15),
   topic_num            int,
   total_point          int,
   difficulty           varchar(3),
   finished_time        int comment '存的是毫秒数',
   edit_time            varchar(50),
   create_time          varchar(50),
   primary key (uuid)
);

/*==============================================================*/
/* Table: paper_topic_link                                      */
/*==============================================================*/
create table paper_topic_link
(
   paper_pid            varchar(15) not null,
   topic_pid            varchar(15) not null,
   primary key (paper_pid, topic_pid)
);

/*==============================================================*/
/* Table: sys_url_service_map                                   */
/*==============================================================*/
create table sys_url_service_map
(
   url_flag             varchar(200) not null,
   full_url             varchar(200),
   priv_id              varchar(15),
   tilte                varchar(200),
   service_command      varchar(200),
   page                 varchar(200),
   creater_pid          varchar(15),
   create_time          varchar(20),
   primary key (url_flag)
);

/*==============================================================*/
/* Table: topic                                                 */
/*==============================================================*/
create table topic
(
   unid                 varchar(15),
   content              varchar(1000),
   type                 char,
   answer               varchar(1000),
   opn_1                varchar(100),
   opn_2                varchar(100),
   opn_3                varchar(100),
   opn_4                varchar(100),
   opn_5                varchar(100),
   opn_6                varchar(100),
   opn_7                varchar(100),
   is_correct           varchar(1) default 'N',
   difficulty           varchar(3),
   create_time          varchar(20),
   edit_time            varchar(20)
);

