/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50549
 Source Host           : localhost:3306
 Source Schema         : website

 Target Server Type    : MySQL
 Target Server Version : 50549
 File Encoding         : 65001

 Date: 10/11/2019 11:38:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_actor
-- ----------------------------
DROP TABLE IF EXISTS `tb_actor`;
CREATE TABLE `tb_actor`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `chinese_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `contry` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `birth` year(4) NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL COMMENT '1：日本；2：美国；3:图片',
  `cover_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creat_time` datetime NULL DEFAULT NULL,
  `creater` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_actor
-- ----------------------------
INSERT INTO `tb_actor` VALUES (1, 'cxy', '崔祥瑜', 'china', NULL, 3, NULL, NULL, NULL, '');
INSERT INTO `tb_actor` VALUES (2, 'zs', '张三', 'china', NULL, 3, NULL, NULL, NULL, '');
INSERT INTO `tb_actor` VALUES (3, 'cxy', '崔祥瑜', 'china', NULL, 1, NULL, NULL, NULL, '');
INSERT INTO `tb_actor` VALUES (4, 'zs', '张三', 'china', NULL, 1, NULL, NULL, NULL, '');

-- ----------------------------
-- Table structure for tb_actor_type
-- ----------------------------
DROP TABLE IF EXISTS `tb_actor_type`;
CREATE TABLE `tb_actor_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actor_id` int(11) NULL DEFAULT NULL,
  `type_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_level
-- ----------------------------
DROP TABLE IF EXISTS `tb_level`;
CREATE TABLE `tb_level`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `production_id` int(11) NULL DEFAULT NULL,
  `level` int(11) NULL DEFAULT NULL,
  `watch_num` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_picture
-- ----------------------------
DROP TABLE IF EXISTS `tb_picture`;
CREATE TABLE `tb_picture`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `picture_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cover_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creat_time` datetime NULL DEFAULT NULL,
  `creater` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  `number` int(11) NULL DEFAULT NULL,
  `language` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `exist` int(11) NULL DEFAULT NULL COMMENT '1：存在；2：已删除；3：未入库',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_picture
-- ----------------------------
INSERT INTO `tb_picture` VALUES (1, 'ccc', '/pics', '/pics/pic1.jpg', '2019-11-08 13:48:03', NULL, NULL, NULL, 'chinese', 1, NULL);
INSERT INTO `tb_picture` VALUES (2, 'ccc', '/pics', '/pics/pic1.jpg', '2019-11-08 13:48:03', NULL, NULL, NULL, 'chinese', 1, NULL);
INSERT INTO `tb_picture` VALUES (3, 'ccc', '/pics', '/pics/pic2.jpg', '2019-11-08 13:48:03', NULL, NULL, NULL, 'chinese', 1, NULL);
INSERT INTO `tb_picture` VALUES (4, 'ccc', '/pics', '/pics/pic2.jpg', '2019-11-08 13:48:03', NULL, NULL, NULL, 'chinese', 1, NULL);
INSERT INTO `tb_picture` VALUES (5, 'Sennou Ryokan', '/Sennou Ryokan', '/Sennou Ryokan\\01.jpg', '2019-11-08 13:48:03', NULL, NULL, NULL, 'chinese', 1, NULL);

-- ----------------------------
-- Table structure for tb_picture_actor
-- ----------------------------
DROP TABLE IF EXISTS `tb_picture_actor`;
CREATE TABLE `tb_picture_actor`  (
  `id` int(11) NOT NULL,
  `picture_id` int(11) NULL DEFAULT NULL,
  `actor_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_picture_actor
-- ----------------------------
INSERT INTO `tb_picture_actor` VALUES (1, 1, 1);
INSERT INTO `tb_picture_actor` VALUES (2, 1, 2);
INSERT INTO `tb_picture_actor` VALUES (3, 2, 1);
INSERT INTO `tb_picture_actor` VALUES (4, 3, 2);
INSERT INTO `tb_picture_actor` VALUES (5, 4, 1);
INSERT INTO `tb_picture_actor` VALUES (6, 5, 2);

-- ----------------------------
-- Table structure for tb_picture_type
-- ----------------------------
DROP TABLE IF EXISTS `tb_picture_type`;
CREATE TABLE `tb_picture_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture_id` int(11) NULL DEFAULT NULL,
  `type_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_picture_type
-- ----------------------------
INSERT INTO `tb_picture_type` VALUES (1, 1, 1);
INSERT INTO `tb_picture_type` VALUES (2, 1, 2);
INSERT INTO `tb_picture_type` VALUES (3, 1, 3);
INSERT INTO `tb_picture_type` VALUES (4, 1, 4);
INSERT INTO `tb_picture_type` VALUES (5, 2, 4);
INSERT INTO `tb_picture_type` VALUES (6, 3, 2);
INSERT INTO `tb_picture_type` VALUES (7, 4, 1);
INSERT INTO `tb_picture_type` VALUES (8, 4, 3);
INSERT INTO `tb_picture_type` VALUES (9, 5, 4);
INSERT INTO `tb_picture_type` VALUES (10, 5, 1);

-- ----------------------------
-- Table structure for tb_sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_menu`;
CREATE TABLE `tb_sys_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `pid` int(10) NULL DEFAULT NULL COMMENT '父菜单ID',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单名称',
  `permission` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限：用于权限认证',
  `order_no` int(5) NULL DEFAULT NULL COMMENT '排序号',
  `menu_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '菜单访问路径',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单描述',
  `menu_level` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '菜单级别',
  `is_valid` int(1) NOT NULL COMMENT '是否启用：0不启用；1启用；',
  `img_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标路径',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建日期',
  `creater` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统菜单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_sys_menu
-- ----------------------------
INSERT INTO `tb_sys_menu` VALUES (1, 0, '功能列表', 'all', 1, 'Layout', '功能列表', '1', 1, '1', '2019-10-16 13:53:32', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (2, 1, '系统管理', 'admin', 1, 'Layout', '系统管理', '2', 1, '1', '2019-10-16 14:16:47', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (3, 2, '用户管理', 'admin_userManage', 2, 'userManage', '用户管理', '3', 1, '1', '2019-10-16 14:18:22', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (4, 2, '角色管理', 'admin_roleManage', 1, 'roleManage', '角色管理', '3', 1, '1', '2019-10-16 14:19:00', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (5, 1, '护士分诊台', 'nurse', 1, 'Layout', '诊室管理', '2', 1, '1', '2019-10-18 09:26:46', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (6, 5, '已诊队列', 'nurse_doneList', 1, 'doneList', '已诊队列', '3', 1, '1', '2019-10-18 09:29:49', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (7, 5, '未诊队列', 'nurse_waitList', 2, 'waitList', '未诊队列', '3', 1, '1', '2019-10-18 09:29:49', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (8, 5, '未归属医生队列', 'nurse_noDoctorList', 3, 'noDoctorList', '未归属医生队列', '3', 1, '1', '2019-10-18 09:29:49', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (9, 2, '日志管理', 'admin_logManage', 3, 'logManage', '日志管理', '3', 1, '1', '2019-10-18 09:29:49', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (10, 1, '医院配置管理', 'hosp_manager', 3, 'Layout', '医院配置管理', '2', 1, '1', '2019-10-22 09:26:46', NULL, '');
INSERT INTO `tb_sys_menu` VALUES (11, 10, '设备管理', 'dev_manager', 1, 'devManager', '设备管理', '3', 1, '1', '2019-10-22 09:26:46', NULL, '');
INSERT INTO `tb_sys_menu` VALUES (12, 10, '科室管理', 'dep_manager', 2, 'depManager', '科室管理', '3', 1, '1', '2019-10-22 09:26:43', NULL, '');
INSERT INTO `tb_sys_menu` VALUES (13, 10, '诊室管理', 'con_manager', 3, 'conManager', '诊室管理', '3', 1, '1', '2019-10-22 09:43:02', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (14, 10, '医生管理', 'doc_manager', 4, 'docManager', '医生管理', '3', 1, '1', '2019-10-22 13:38:34', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (15, 5, '医生签到', 'nurse_doctorSign', 4, 'doctorSign', '医生签到', '3', 1, '1', '2019-10-21 11:33:02', NULL, NULL);
INSERT INTO `tb_sys_menu` VALUES (16, 5, '图片', 'picture', 1, 'picture', '图片', '1', 1, '1', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for tb_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_role`;
CREATE TABLE `tb_sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名字',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色描述',
  `is_del` int(1) NULL DEFAULT NULL COMMENT '0：未删除；1：已删除；',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_sys_role
-- ----------------------------
INSERT INTO `tb_sys_role` VALUES (1, 'admin', '系统管理员', 0, '2019-10-11 16:03:44', '12212');
INSERT INTO `tb_sys_role` VALUES (2, 'nurse', '护士', 0, '2019-10-11 08:53:25', '护123');
INSERT INTO `tb_sys_role` VALUES (7, '123', '123', 1, '2019-10-18 10:25:54', '123');
INSERT INTO `tb_sys_role` VALUES (8, 'a', 'a', 1, '2019-10-23 18:57:02', 'a');
INSERT INTO `tb_sys_role` VALUES (9, 'q', 'q', 1, '2019-10-23 18:58:16', 'q');
INSERT INTO `tb_sys_role` VALUES (10, 'doctor', '医生啊', 1, '2019-10-24 10:12:19', NULL);
INSERT INTO `tb_sys_role` VALUES (11, '', '', 1, '2019-10-24 10:27:15', NULL);
INSERT INTO `tb_sys_role` VALUES (12, '测试1', '测试', 0, '2019-10-24 10:29:37', '测试');
INSERT INTO `tb_sys_role` VALUES (13, '测试2', '测试2', 1, '2019-10-24 10:31:47', '测试2');
INSERT INTO `tb_sys_role` VALUES (14, '测试2', '测试2', 0, '2019-10-24 10:35:05', '测试2');
INSERT INTO `tb_sys_role` VALUES (15, '', '', 1, '2019-10-24 10:45:15', NULL);
INSERT INTO `tb_sys_role` VALUES (16, '', '8', 1, '2019-10-24 10:49:17', '2');
INSERT INTO `tb_sys_role` VALUES (17, 'doctor', '医生', 0, '2019-10-24 17:43:43', 'aaa');
INSERT INTO `tb_sys_role` VALUES (18, 'dd', 'd\'d', 0, '2019-10-24 17:44:10', 'd\'d');
INSERT INTO `tb_sys_role` VALUES (19, 'a', 'a', 0, '2019-10-24 17:45:36', NULL);
INSERT INTO `tb_sys_role` VALUES (20, '', 'b', 1, '2019-10-24 17:45:46', NULL);
INSERT INTO `tb_sys_role` VALUES (21, 'h', 'h', 1, '2019-10-24 18:02:44', 'h');
INSERT INTO `tb_sys_role` VALUES (22, '', '', 1, '2019-10-25 15:05:40', NULL);
INSERT INTO `tb_sys_role` VALUES (23, '发', '', 1, '2019-10-28 11:34:53', NULL);
INSERT INTO `tb_sys_role` VALUES (24, 'ss', '', 1, '2019-10-28 11:57:27', NULL);
INSERT INTO `tb_sys_role` VALUES (25, '', '', 1, '2019-10-28 14:01:14', NULL);
INSERT INTO `tb_sys_role` VALUES (26, '', '', 1, '2019-10-28 14:08:19', NULL);
INSERT INTO `tb_sys_role` VALUES (27, '', '', 1, '2019-10-28 14:09:04', NULL);
INSERT INTO `tb_sys_role` VALUES (28, '', '', 1, '2019-10-28 14:09:50', NULL);
INSERT INTO `tb_sys_role` VALUES (29, '', '', 1, '2019-10-28 14:18:29', NULL);
INSERT INTO `tb_sys_role` VALUES (30, '', 's\'s', 1, '2019-10-28 14:23:20', 'ss');
INSERT INTO `tb_sys_role` VALUES (31, '搜索', '你是', 0, '2019-10-28 14:26:24', '我书');
INSERT INTO `tb_sys_role` VALUES (32, '我是', 'and', 0, '2019-10-28 15:27:07', '等待');

-- ----------------------------
-- Table structure for tb_sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_role_menu`;
CREATE TABLE `tb_sys_role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_id` int(10) NOT NULL COMMENT '角色ID',
  `menu_id` int(10) NULL DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 240 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_sys_role_menu
-- ----------------------------
INSERT INTO `tb_sys_role_menu` VALUES (168, 14, 3);
INSERT INTO `tb_sys_role_menu` VALUES (212, 17, 5);
INSERT INTO `tb_sys_role_menu` VALUES (213, 17, 7);
INSERT INTO `tb_sys_role_menu` VALUES (214, 1, 2);
INSERT INTO `tb_sys_role_menu` VALUES (215, 1, 3);
INSERT INTO `tb_sys_role_menu` VALUES (216, 1, 4);
INSERT INTO `tb_sys_role_menu` VALUES (217, 1, 9);
INSERT INTO `tb_sys_role_menu` VALUES (218, 1, 5);
INSERT INTO `tb_sys_role_menu` VALUES (219, 1, 6);
INSERT INTO `tb_sys_role_menu` VALUES (220, 1, 7);
INSERT INTO `tb_sys_role_menu` VALUES (221, 1, 10);
INSERT INTO `tb_sys_role_menu` VALUES (222, 1, 11);
INSERT INTO `tb_sys_role_menu` VALUES (223, 1, 12);
INSERT INTO `tb_sys_role_menu` VALUES (224, 1, 13);
INSERT INTO `tb_sys_role_menu` VALUES (225, 1, 14);
INSERT INTO `tb_sys_role_menu` VALUES (226, 1, 8);
INSERT INTO `tb_sys_role_menu` VALUES (227, 1, 15);
INSERT INTO `tb_sys_role_menu` VALUES (228, 12, 2);
INSERT INTO `tb_sys_role_menu` VALUES (229, 12, 3);
INSERT INTO `tb_sys_role_menu` VALUES (230, 12, 4);
INSERT INTO `tb_sys_role_menu` VALUES (231, 12, 9);
INSERT INTO `tb_sys_role_menu` VALUES (232, 12, 5);
INSERT INTO `tb_sys_role_menu` VALUES (233, 12, 6);
INSERT INTO `tb_sys_role_menu` VALUES (234, 12, 7);
INSERT INTO `tb_sys_role_menu` VALUES (235, 2, 5);
INSERT INTO `tb_sys_role_menu` VALUES (236, 2, 6);
INSERT INTO `tb_sys_role_menu` VALUES (237, 2, 7);
INSERT INTO `tb_sys_role_menu` VALUES (238, 2, 8);
INSERT INTO `tb_sys_role_menu` VALUES (239, 1, 16);

-- ----------------------------
-- Table structure for tb_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_sys_user`;
CREATE TABLE `tb_sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '真实姓名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `salt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码盐',
  `state` tinyint(4) NOT NULL COMMENT '状态',
  `tel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `user_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `sex` int(11) NOT NULL COMMENT '性别 0：男 1:女',
  `ip_limit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP限制：允许登录的IP或者IP段',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `creater` int(11) NULL DEFAULT NULL COMMENT '创建人',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_del` int(1) NULL DEFAULT NULL COMMENT '0：未删除；1：已删除；',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_4bakctviobmdk6ddh2nwg08c2`(`user_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_sys_user
-- ----------------------------
INSERT INTO `tb_sys_user` VALUES (1, NULL, '管理员', 'd3c59d25033dbf980d29554025c23a75', '8d78869f470951332959580424d4bf4f', 0, '111', 'admin', 4545, 0, NULL, '2019-10-11 16:00:01', NULL, NULL, 0);
INSERT INTO `tb_sys_user` VALUES (2, '123', 'xx', 'd3c59d25033dbf980d29554025c23a75', '8d78869f470951332959580424d4bf4f', 0, '123', '123', 123, 0, NULL, '2019-10-18 11:29:44', NULL, NULL, 0);
INSERT INTO `tb_sys_user` VALUES (3, '123', '123', 'd3c59d25033dbf980d29554025c23a75', '8d78869f470951332959580424d4bf4f', 0, '123', 'xx', 123, 0, NULL, '2019-10-18 11:30:13', NULL, NULL, 1);
INSERT INTO `tb_sys_user` VALUES (4, '123', '123', 'd3c59d25033dbf980d29554025c23a75', '8d78869f470951332959580424d4bf4f', 0, '123', '侯森林', 123, 0, NULL, '2019-10-18 11:34:58', NULL, NULL, 1);
INSERT INTO `tb_sys_user` VALUES (5, '123', '123', 'd3c59d25033dbf980d29554025c23a75', '8d78869f470951332959580424d4bf4f', 0, '123', '444', 123, 0, NULL, '2019-10-18 11:41:39', NULL, NULL, 0);
INSERT INTO `tb_sys_user` VALUES (6, '1', '1', '4f16136cf4e2f7d7969aa5ef61c0a304', '8d78869f470951332959580424d4bf4f', 0, '1', '1', 1, 0, NULL, '2019-10-23 18:57:42', NULL, NULL, 1);
INSERT INTO `tb_sys_user` VALUES (7, 'dd', '管2', 'f578984e1bd1f636765e4423a3183359', '8d78869f470951332959580424d4bf4f', 0, '1326504874', '4a', 15, 1, NULL, '2019-10-24 10:14:45', NULL, NULL, 0);
INSERT INTO `tb_sys_user` VALUES (8, '1', '2', 'a85c5f0cf8102d7371bf011415f24d14', '8d78869f470951332959580424d4bf4f', 0, '2', '32', 2, 0, NULL, '2019-10-24 10:40:45', NULL, NULL, 0);
INSERT INTO `tb_sys_user` VALUES (10, '24', '测试', '265a6b735be1274af944d1231187acf8', '8d78869f470951332959580424d4bf4f', 0, '5421', '', 11, 0, NULL, '2019-10-24 10:52:41', NULL, NULL, 1);
INSERT INTO `tb_sys_user` VALUES (12, '2', '手段解决', '69de03c1fa1b8cf4c1101fc2a5d508b5', '8d78869f470951332959580424d4bf4f', 0, '1', '是十分发是', 15, 0, NULL, '2019-10-28 15:14:13', NULL, NULL, 0);
INSERT INTO `tb_sys_user` VALUES (14, '', 'cxy', '207975495dae1d48557310cc7f145719', '8d78869f470951332959580424d4bf4f', 0, '', 'cxy', 11, 0, NULL, '2019-11-01 11:43:56', NULL, NULL, 0);

-- ----------------------------
-- Table structure for tb_type
-- ----------------------------
DROP TABLE IF EXISTS `tb_type`;
CREATE TABLE `tb_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `chinese_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL COMMENT '1:日本影片；2：美国影片；3：漫画',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_type
-- ----------------------------
INSERT INTO `tb_type` VALUES (1, 'aaa', 'aaa', 3);
INSERT INTO `tb_type` VALUES (2, 'bbb', 'bbb', 3);
INSERT INTO `tb_type` VALUES (3, 'type3', 'type3', 3);
INSERT INTO `tb_type` VALUES (4, 'type4', 'type4', 3);
INSERT INTO `tb_type` VALUES (5, 'aaa', 'aaa', 1);
INSERT INTO `tb_type` VALUES (6, 'bbb', 'bbb', 1);
INSERT INTO `tb_type` VALUES (7, 'type3', 'type3', 1);
INSERT INTO `tb_type` VALUES (8, 'type4', 'type4', 1);

-- ----------------------------
-- Table structure for tb_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_role`;
CREATE TABLE `tb_user_role`  (
  `ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `ROLE_ID` int(11) NULL DEFAULT NULL COMMENT '角色ID',
  `USER_ID` int(11) NULL DEFAULT NULL COMMENT '用户ID',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_user_role
-- ----------------------------
INSERT INTO `tb_user_role` VALUES (4, 1, 5);
INSERT INTO `tb_user_role` VALUES (5, 2, 5);
INSERT INTO `tb_user_role` VALUES (8, 9, 6);
INSERT INTO `tb_user_role` VALUES (9, 2, 7);
INSERT INTO `tb_user_role` VALUES (10, 12, 10);
INSERT INTO `tb_user_role` VALUES (15, 1, 1);
INSERT INTO `tb_user_role` VALUES (17, 1, 2);
INSERT INTO `tb_user_role` VALUES (18, 2, 2);
INSERT INTO `tb_user_role` VALUES (19, 2, 14);
INSERT INTO `tb_user_role` VALUES (20, 2, 1);

-- ----------------------------
-- Table structure for tb_util
-- ----------------------------
DROP TABLE IF EXISTS `tb_util`;
CREATE TABLE `tb_util`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tb_video
-- ----------------------------
DROP TABLE IF EXISTS `tb_video`;
CREATE TABLE `tb_video`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `video_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cover_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `creat_time` datetime NULL DEFAULT NULL,
  `creater` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL COMMENT '1：日本；2：美国',
  `exist` int(11) NULL DEFAULT NULL COMMENT '1：存在；2：已删除；3：未入库',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_video
-- ----------------------------
INSERT INTO `tb_video` VALUES (1, 'GVG-624-0', '/GVG-624.mp4', '/7e6n.jpg', '2019-11-10 10:03:14', NULL, 1, 1, NULL);
INSERT INTO `tb_video` VALUES (2, 'GVG-624-1', '/GVG-624.mp4', '/7e6n.jpg', '2019-11-10 10:03:14', NULL, 1, 1, NULL);
INSERT INTO `tb_video` VALUES (3, 'GVG-624-2', '/GVG-624.mp4', '/7e6n.jpg', '2019-11-10 10:03:14', NULL, 1, 1, NULL);

-- ----------------------------
-- Table structure for tb_video_actor
-- ----------------------------
DROP TABLE IF EXISTS `tb_video_actor`;
CREATE TABLE `tb_video_actor`  (
  `id` int(11) NOT NULL,
  `video_id` int(11) NULL DEFAULT NULL,
  `actor_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_video_actor
-- ----------------------------
INSERT INTO `tb_video_actor` VALUES (1, 1, 3);
INSERT INTO `tb_video_actor` VALUES (2, 1, 4);
INSERT INTO `tb_video_actor` VALUES (3, 2, 3);
INSERT INTO `tb_video_actor` VALUES (4, 3, 4);

-- ----------------------------
-- Table structure for tb_video_type
-- ----------------------------
DROP TABLE IF EXISTS `tb_video_type`;
CREATE TABLE `tb_video_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `video_id` int(11) NULL DEFAULT NULL,
  `type_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tb_video_type
-- ----------------------------
INSERT INTO `tb_video_type` VALUES (1, 1, 5);
INSERT INTO `tb_video_type` VALUES (2, 1, 6);
INSERT INTO `tb_video_type` VALUES (3, 1, 7);
INSERT INTO `tb_video_type` VALUES (4, 1, 8);
INSERT INTO `tb_video_type` VALUES (5, 2, 5);
INSERT INTO `tb_video_type` VALUES (6, 2, 7);
INSERT INTO `tb_video_type` VALUES (7, 3, 6);
INSERT INTO `tb_video_type` VALUES (8, 3, 8);

SET FOREIGN_KEY_CHECKS = 1;
