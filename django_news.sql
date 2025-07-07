/*
 Navicat Premium Data Transfer

 Source Server         : localhost_mysql8
 Source Server Type    : MySQL
 Source Server Version : 80037
 Source Host           : localhost:3306
 Source Schema         : django_news

 Target Server Type    : MySQL
 Target Server Version : 80037
 File Encoding         : 65001

 Date: 04/07/2025 14:40:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `group_id` int(0) NOT NULL,
  `permission_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content_type_id` int(0) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (5, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (8, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (9, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (10, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (11, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (12, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (17, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (18, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (19, 'Can add address', 7, 'add_address');
INSERT INTO `auth_permission` VALUES (20, 'Can change address', 7, 'change_address');
INSERT INTO `auth_permission` VALUES (21, 'Can delete address', 7, 'delete_address');
INSERT INTO `auth_permission` VALUES (22, 'Can add goods', 8, 'add_goods');
INSERT INTO `auth_permission` VALUES (23, 'Can change goods', 8, 'change_goods');
INSERT INTO `auth_permission` VALUES (24, 'Can delete goods', 8, 'delete_goods');
INSERT INTO `auth_permission` VALUES (25, 'Can add order', 9, 'add_order');
INSERT INTO `auth_permission` VALUES (26, 'Can change order', 9, 'change_order');
INSERT INTO `auth_permission` VALUES (27, 'Can delete order', 9, 'delete_order');
INSERT INTO `auth_permission` VALUES (28, 'Can add order_goods', 10, 'add_order_goods');
INSERT INTO `auth_permission` VALUES (29, 'Can change order_goods', 10, 'change_order_goods');
INSERT INTO `auth_permission` VALUES (30, 'Can delete order_goods', 10, 'delete_order_goods');
INSERT INTO `auth_permission` VALUES (31, 'Can add user', 11, 'add_user');
INSERT INTO `auth_permission` VALUES (32, 'Can change user', 11, 'change_user');
INSERT INTO `auth_permission` VALUES (33, 'Can delete user', 11, 'delete_user');
INSERT INTO `auth_permission` VALUES (34, 'Can add admin', 12, 'add_admin');
INSERT INTO `auth_permission` VALUES (35, 'Can change admin', 12, 'change_admin');
INSERT INTO `auth_permission` VALUES (36, 'Can delete admin', 12, 'delete_admin');
INSERT INTO `auth_permission` VALUES (37, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (38, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (39, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (40, 'Can view user', 4, 'view_user');
INSERT INTO `auth_permission` VALUES (41, 'Can view content type', 5, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (42, 'Can view session', 6, 'view_session');
INSERT INTO `auth_permission` VALUES (43, 'Can view address', 7, 'view_address');
INSERT INTO `auth_permission` VALUES (44, 'Can view goods', 8, 'view_goods');
INSERT INTO `auth_permission` VALUES (45, 'Can view order', 9, 'view_order');
INSERT INTO `auth_permission` VALUES (46, 'Can view order_goods', 10, 'view_order_goods');
INSERT INTO `auth_permission` VALUES (47, 'Can view user', 11, 'view_user');
INSERT INTO `auth_permission` VALUES (48, 'Can view admin', 12, 'view_admin');
INSERT INTO `auth_permission` VALUES (49, 'Can add diary', 13, 'add_diary');
INSERT INTO `auth_permission` VALUES (50, 'Can change diary', 13, 'change_diary');
INSERT INTO `auth_permission` VALUES (51, 'Can delete diary', 13, 'delete_diary');
INSERT INTO `auth_permission` VALUES (52, 'Can view diary', 13, 'view_diary');
INSERT INTO `auth_permission` VALUES (53, 'Can add scenic', 14, 'add_scenic');
INSERT INTO `auth_permission` VALUES (54, 'Can change scenic', 14, 'change_scenic');
INSERT INTO `auth_permission` VALUES (55, 'Can delete scenic', 14, 'delete_scenic');
INSERT INTO `auth_permission` VALUES (56, 'Can view scenic', 14, 'view_scenic');
INSERT INTO `auth_permission` VALUES (57, 'Can add visit', 15, 'add_visit');
INSERT INTO `auth_permission` VALUES (58, 'Can change visit', 15, 'change_visit');
INSERT INTO `auth_permission` VALUES (59, 'Can delete visit', 15, 'delete_visit');
INSERT INTO `auth_permission` VALUES (60, 'Can view visit', 15, 'view_visit');
INSERT INTO `auth_permission` VALUES (61, 'Can add visit_ order', 16, 'add_visit_order');
INSERT INTO `auth_permission` VALUES (62, 'Can change visit_ order', 16, 'change_visit_order');
INSERT INTO `auth_permission` VALUES (63, 'Can delete visit_ order', 16, 'delete_visit_order');
INSERT INTO `auth_permission` VALUES (64, 'Can view visit_ order', 16, 'view_visit_order');
INSERT INTO `auth_permission` VALUES (65, 'Can add comment', 17, 'add_comment');
INSERT INTO `auth_permission` VALUES (66, 'Can change comment', 17, 'change_comment');
INSERT INTO `auth_permission` VALUES (67, 'Can delete comment', 17, 'delete_comment');
INSERT INTO `auth_permission` VALUES (68, 'Can view comment', 17, 'view_comment');
INSERT INTO `auth_permission` VALUES (69, 'Can add area', 18, 'add_area');
INSERT INTO `auth_permission` VALUES (70, 'Can change area', 18, 'change_area');
INSERT INTO `auth_permission` VALUES (71, 'Can delete area', 18, 'delete_area');
INSERT INTO `auth_permission` VALUES (72, 'Can view area', 18, 'view_area');
INSERT INTO `auth_permission` VALUES (73, 'Can add perform', 19, 'add_perform');
INSERT INTO `auth_permission` VALUES (74, 'Can change perform', 19, 'change_perform');
INSERT INTO `auth_permission` VALUES (75, 'Can delete perform', 19, 'delete_perform');
INSERT INTO `auth_permission` VALUES (76, 'Can view perform', 19, 'view_perform');
INSERT INTO `auth_permission` VALUES (77, 'Can add order perform', 20, 'add_orderperform');
INSERT INTO `auth_permission` VALUES (78, 'Can change order perform', 20, 'change_orderperform');
INSERT INTO `auth_permission` VALUES (79, 'Can delete order perform', 20, 'delete_orderperform');
INSERT INTO `auth_permission` VALUES (80, 'Can view order perform', 20, 'view_orderperform');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NOT NULL,
  `group_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_groups_user_id_group_id_94350c0c_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `auth_user_groups_group_id_97559544_fk_auth_group_id`(`group_id`) USING BTREE,
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NOT NULL,
  `permission_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm`(`permission_id`) USING BTREE,
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NULL DEFAULT NULL,
  `object_id` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `content_type_id` int(0) NULL DEFAULT NULL,
  `user_id` int(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk`(`user_id`) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (7, 'mall', 'address');
INSERT INTO `django_content_type` VALUES (12, 'mall', 'admin');
INSERT INTO `django_content_type` VALUES (18, 'mall', 'area');
INSERT INTO `django_content_type` VALUES (17, 'mall', 'comment');
INSERT INTO `django_content_type` VALUES (13, 'mall', 'diary');
INSERT INTO `django_content_type` VALUES (8, 'mall', 'goods');
INSERT INTO `django_content_type` VALUES (9, 'mall', 'order');
INSERT INTO `django_content_type` VALUES (20, 'mall', 'orderperform');
INSERT INTO `django_content_type` VALUES (10, 'mall', 'order_goods');
INSERT INTO `django_content_type` VALUES (19, 'mall', 'perform');
INSERT INTO `django_content_type` VALUES (14, 'mall', 'scenic');
INSERT INTO `django_content_type` VALUES (11, 'mall', 'user');
INSERT INTO `django_content_type` VALUES (15, 'mall', 'visit');
INSERT INTO `django_content_type` VALUES (16, 'mall', 'visit_order');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `applied` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2024-03-07 13:17:14.568386');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2024-03-07 13:17:20.378547');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2024-03-07 13:17:21.557528');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2024-03-07 13:17:21.579523');
INSERT INTO `django_migrations` VALUES (5, 'contenttypes', '0002_remove_content_type_name', '2024-03-07 13:17:22.035251');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0002_alter_permission_name_max_length', '2024-03-07 13:17:22.299488');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0003_alter_user_email_max_length', '2024-03-07 13:17:22.540773');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0004_alter_user_username_opts', '2024-03-07 13:17:22.565938');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0005_alter_user_last_login_null', '2024-03-07 13:17:24.159265');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0006_require_contenttypes_0002', '2024-03-07 13:17:24.229800');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0007_alter_validators_add_error_messages', '2024-03-07 13:17:24.268535');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0008_alter_user_username_max_length', '2024-03-07 13:17:25.897200');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0009_alter_user_last_name_max_length', '2024-03-07 13:17:26.163452');
INSERT INTO `django_migrations` VALUES (14, 'mall', '0001_initial', '2024-03-07 13:17:26.836744');
INSERT INTO `django_migrations` VALUES (15, 'sessions', '0001_initial', '2024-03-07 13:17:27.286727');
INSERT INTO `django_migrations` VALUES (16, 'mall', '0002_user_password', '2024-03-07 13:44:23.175411');
INSERT INTO `django_migrations` VALUES (17, 'mall', '0003_auto_20240307_2148', '2024-03-07 13:49:04.818441');
INSERT INTO `django_migrations` VALUES (18, 'mall', '0004_admin', '2024-03-07 15:13:50.723276');
INSERT INTO `django_migrations` VALUES (19, 'mall', '0005_auto_20240308_0137', '2024-03-07 17:37:14.720861');
INSERT INTO `django_migrations` VALUES (20, 'mall', '0006_auto_20240309_0449', '2024-03-08 20:49:51.917337');
INSERT INTO `django_migrations` VALUES (21, 'mall', '0007_address_check', '2024-03-08 21:25:26.456919');
INSERT INTO `django_migrations` VALUES (22, 'mall', '0008_auto_20240310_0545', '2024-03-09 21:46:10.611101');
INSERT INTO `django_migrations` VALUES (23, 'mall', '0009_auto_20240310_1837', '2024-03-10 10:37:56.922261');
INSERT INTO `django_migrations` VALUES (24, 'mall', '0010_auto_20240404_0055', '2024-04-03 16:55:55.094987');
INSERT INTO `django_migrations` VALUES (25, 'admin', '0003_logentry_add_action_flag_choices', '2024-04-19 00:19:38.705333');
INSERT INTO `django_migrations` VALUES (26, 'auth', '0010_alter_group_name_max_length', '2024-04-19 00:19:39.436402');
INSERT INTO `django_migrations` VALUES (27, 'auth', '0011_update_proxy_permissions', '2024-04-19 00:19:39.470365');
INSERT INTO `django_migrations` VALUES (28, 'auth', '0012_alter_user_first_name_max_length', '2024-04-19 00:19:39.745209');
INSERT INTO `django_migrations` VALUES (29, 'mall', '0010_alter_goods_package', '2024-07-19 08:48:17.213361');
INSERT INTO `django_migrations` VALUES (30, 'mall', '0011_goods_cate_id', '2024-07-19 09:01:19.687608');
INSERT INTO `django_migrations` VALUES (31, 'mall', '0012_auto_20241119_1741', '2024-11-19 09:41:56.298324');
INSERT INTO `django_migrations` VALUES (32, 'mall', '0013_diary_scenic_visit', '2025-02-24 08:54:08.687292');
INSERT INTO `django_migrations` VALUES (33, 'mall', '0014_visit_order', '2025-02-24 12:11:20.013690');
INSERT INTO `django_migrations` VALUES (34, 'mall', '0015_visit_order_pic', '2025-02-24 12:52:45.732883');
INSERT INTO `django_migrations` VALUES (35, 'mall', '0016_visit_order_visit_id', '2025-02-24 13:18:45.449175');
INSERT INTO `django_migrations` VALUES (36, 'mall', '0017_diary_user_id', '2025-02-24 16:29:29.873309');
INSERT INTO `django_migrations` VALUES (37, 'mall', '0018_comment', '2025-04-07 16:29:31.828209');
INSERT INTO `django_migrations` VALUES (38, 'mall', '0019_area', '2025-04-07 16:29:34.014506');
INSERT INTO `django_migrations` VALUES (39, 'mall', '0020_perform', '2025-04-07 16:29:34.801909');
INSERT INTO `django_migrations` VALUES (40, 'mall', '0021_orderperform', '2025-04-07 21:58:48.591761');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `expire_date` datetime(6) NULL DEFAULT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mall_admin
-- ----------------------------
DROP TABLE IF EXISTS `mall_admin`;
CREATE TABLE `mall_admin`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_admin
-- ----------------------------
INSERT INTO `mall_admin` VALUES (1, 'admin', 'admin');

-- ----------------------------
-- Table structure for mall_comment
-- ----------------------------
DROP TABLE IF EXISTS `mall_comment`;
CREATE TABLE `mall_comment`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `newsId` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `content` varchar(5000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `timex` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `de` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_comment
-- ----------------------------
INSERT INTO `mall_comment` VALUES (5, '6', '很666666666666', '11', '2025-06-16 11:13:58', '1');
INSERT INTO `mall_comment` VALUES (6, '7', '希望战争早点结束', '12', '2025-06-16 12:09:26', '1');
INSERT INTO `mall_comment` VALUES (7, '8', '祝愿世界和平', '13', '2025-06-16 12:20:45', '1');
INSERT INTO `mall_comment` VALUES (8, '8', '世界经济大好', '12', '2025-06-16 12:22:00', '1');

-- ----------------------------
-- Table structure for mall_news
-- ----------------------------
DROP TABLE IF EXISTS `mall_news`;
CREATE TABLE `mall_news`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `cate` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `simple` varchar(500) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `content` varchar(5000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `staff_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `pic` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `timex` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `look` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `de` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_news
-- ----------------------------
INSERT INTO `mall_news` VALUES (3, '“马部长”上任百日：特斯拉暴跌33%，身家蒸发1130亿美元', '财经新闻', '财联社4月29日讯（编辑 夏军雄）特朗普政府执政届满100天之际，世界首富埃隆·马斯克的个人财富在这段时间缩水了1130亿美元，而他旗下最重要的公司、电动汽车巨头特斯拉股价同期暴跌了33%。', '在美国总统特朗普去年赢得大选的过程中，马斯克可谓是厥功至伟，他向支持特朗普2024年竞选的团体捐赠了2.59亿美元，成为美国历史上最大的总统竞选赞助人之一。\n\n作为回报，特朗普在白宫中新设立了“政府效率部”（DOGE），并任命马斯克为该部门的负责人。\n\n马斯克目前的官方身份是“特殊政府雇员”（SGE），这一身份允许其在政府工作130天。从特朗普1月20日就职开始计算，130天的限制大约会在5月底到期（不包括周末）。\n\n尽管马斯克的本职工作是领导DOGE，但他在特朗普内阁中发挥的作用远不局限于此。\n\n马斯克不仅获得了极高的通行权和数据访问权限，还参与了特朗普与外国领导人和内阁成员的会晤，并时常就国防、关税政策等事务发表意见。\n\n然而，马斯克的高调行事风格惹出了相当大的争议，他与多位特朗普内阁官员爆发过公开冲突，而他在民众中的声望更是大幅降低，并且直接影响到了其麾下企业。\n\n作为马斯克旗下唯一一家上市公司、他财富的重要来源，特斯拉成了公众愤怒的最大受害者。自他“就职”以来，特斯拉股价已下跌33%，市值蒸发4483亿美元，汽车销量也严重下滑。\n\n据估算，自1月17日以来，马斯克因与特朗普结盟，个人净资产缩水1130亿美元，降幅达25%。\n\n“这是100天的毁灭，”布鲁金斯学会有效公共管理中心主任Elaine Kamarck表示。“DOGE已经不再是削减‘肥肉’，而是在削‘肌肉’。人们把对特朗普政策的不满转嫁到了马斯克身上，甚至比对特朗普本人的愤怒还多。”\n\n虽然马斯克最初承诺要削减2万亿美元的“浪费性政府开支”，但根据DOGE官方数据，目前仅节省了1600亿美元。\n\n根据《华盛顿邮报》、美国广播公司（ABC）新闻和益普索（Ipsos）周一联合发布的民调，57%的美国人对马斯克在政府中的表现表示不满意，较2月的不到50%明显上升。\n\n在经历近年来最糟糕的一个季度后，马斯克在上周的特斯拉财报电话会上承认了公司面临的危机。\n\n“我花在政府上的时间确实带来了一些反作用，”马斯克表示。\n\n马斯克还透露，从5月开始，他“投入在DOGE上的时间将大幅减少”。', '1', 'http://localhost:8000/static/uploads/20250429223404下载.jpg', '2025-04-29 22:28:22', '通过', '3', '1');
INSERT INTO `mall_news` VALUES (4, '三河市公安局警徽变色事件引关注，公安系统正全面排查整治', '时政新闻', '南都讯 记者蒋小天 发自北京 近期，河北省廊坊市三河市“广告牌匾禁用红蓝黑底色” 一事被中央点名通报批评。', '此前媒体曝光，三河蜜雪冰城在内的商户牌匾变绿。4月27日，中央层面整治形式主义为基层减负专项工作机制办公室会同中央纪委办公厅通报典型案例点名三河，直指个别领导人推动出台“除国际国内连锁品牌，不允许用红蓝底色或字样”等禁止性规定，城管部门一刀切，将国内连锁品牌在内的1800余块商户门头牌匾变更颜色，损害了群众利益，造成不良影响。河北省廊坊市三河市在城市管理中盲目决策、机械执行，加重基层负担。\n\n而据此前媒体披露，三河市公安局（西院）围墙外和办公楼悬挂使用的警徽为浅金色，不符合标准。南都记者日前从知情人士处获悉，三河一事不止被中央通报批评，公安系统内亦发文要求各地整治排查，明确警徽要符合国家标准。\n\n《人民警察警徽国家标准》由市场监管总局、国家标准化管理委员会于去年8月23日发布，自2025年3月1日正式实施。这也是当前人民警察警徽唯一的国家标准。而在该标准出台前，不止是三河市公安局，多地公安机关悬挂警徽此前均设置为银白色或浅金色。一位知情人士表示，此前警徽的样式设计和颜色设定，更接近99式警徽，很多公安机关门口使用的都是单色方案，最新的警徽样式，则更接近此前83式警徽，颜色分明。\n\n三河市公安局警徽变色经媒体曝光后已迅速更换警徽，恢复正红深蓝底色加金穗的样式。曾有当地官方人士对此解释，三河市公安局警徽颜色主要是建造时为适配墙体颜色，在国家标准出台后已着手订货更换警徽，并不与三河广告牌改色事件相关。\n\n由广告牌换色引发的一系列舆论甚嚣尘上，廊坊市人民政府官网于4月15日发布消息回应，三河市委主要负责人已被免职。据公开简历，主要负责人为付顺义，毕业于河北经贸大学货币银行专业，2024年6月自河北固安县委书记一职调任三河市委书记，还担任燕郊高新区党工委副书记、管委会主任。该消息称，已要求三河市市委、市政府深刻反思，全面整改，后续将根据调查结果对相关责任人追责问责。', '1', 'http://localhost:8000/static/uploads/20250429222942下载 (1).jpg', '2025-04-29 22:29:44', '通过', '2', '1');
INSERT INTO `mall_news` VALUES (5, '辽宁辽阳火灾事故饭店经营者已被控制 善后处置全面展开', '时政新闻', '新华社沈阳4月29日电（记者徐扬、白涌泉）记者29日从辽宁省辽阳市委宣传部获悉，辽宁辽阳市白塔区一饭店发生火灾，共造成22人死亡、3人受伤。目前善后处置工作已全面展开，饭店经营负责人已被警方控制，起火原因正在调查中。', '事故发生后，辽宁省、辽阳市有关负责人在现场组织成立灭火搜救、伤员救治、善后处置等工作组，出动22辆消防车、85名消防员迅速扑灭现场明火，争分夺秒开展搜救，及时疏散周边群众，调派省市专家全力救治伤员。\n\n目前，现场救援工作已结束，伤者生命体征平稳。相关后续工作仍在进行中。', '1', 'http://localhost:8000/static/uploads/20250429223036下载 (2).jpg', '2025-04-29 22:30:38', '通过', '3', '1');
INSERT INTO `mall_news` VALUES (6, '英媒：美国悄悄向以色列运送“狱火”导弹', '时政新闻', '美被爆悄悄向以色列运送狱火导弹#【英媒：美国悄悄向以色列运送“狱火”导弹】据英国“中东之眼”新闻网6月13日报道，“中东之眼”新闻网了解到，美国在以色列13日对伊朗发动史无前例的袭击之前，悄悄向以色列运送了数百枚“狱火”导弹。', '在以色列发动袭击前大规模囤积物资之际，美国10日向以色列运送了大约300枚“狱火”导弹，同时特朗普政府表示准备继续与伊朗进行核谈判。\n\n　　两名要求匿名的美国官员告诉“中东之眼”新闻网，转移如此大量的“狱火”导弹表明，特朗普政府对以色列袭击伊朗伊斯兰共和国的计划非常了解。\n\n　　美国在以色列对伊朗发动袭击之前交付“狱火”或其他大量武器一事，此前从未有过报道。\n\n　　两名美国官员13日告诉路透社，美国军方帮助击落了飞向以色列的伊朗导弹。\n\n　　“狱火”是激光制导的空对地导弹。这种导弹对以色列轰炸伊朗核设施用处不大，但可用于精确打击。\n\n　　以色列军方在13日的袭击中使用了100多架飞机。这些飞机利用精确追踪技术瞄准高级军事官员、核科学家和指挥中心，杀死了数十名伊朗高级官员和核科学家。\n\n　　特朗普政府几个月前就知道以色列的袭击计划。“中东之眼”新闻网本月早些时候披露，美国中央情报局在4月和5月听取了以色列单方面袭击伊朗核设施计划的简报。以色列的“目标系统分析”，以及有关网络攻击叠加无需美国直接参与的精确打击行动的战斗计划，给美国政府留下了“深刻印象”。\n\n　　但特朗普近几个月的行为给观察人士、可能还有伊朗人留下这样的印象：他将继续抵制以色列总理内塔尼亚胡要求美国支持其打击行动的公开游说。\n\n　　两名美国官员说，在整个谈判过程中，特朗普政府近几个月来继续向以色列稳定供应武器。\n\n　　美国无需公开通知此次转让，因为该转让已作为一项价值74亿美元的武器交易的一部分获得批准，该交易包括炸弹、导弹和相关设备。国会已于今年2月收到通知。（来源：参考消息）', '2', 'http://localhost:8000/static/uploads/20250616111150w700d1q75cms.jpg', '2025-06-16 11:11:52', '通过', '3', '1');
INSERT INTO `mall_news` VALUES (7, '俄美总统第五次通话主谈以伊，特朗普：我和普京都认为以伊战争应该结束', '时政新闻', '【环球时报特约记者 王逸】据《今日美国》15日报道，美国总统特朗普14日称，他当天与俄罗斯总统普京通电话讨论了中东不断升级的局势以及俄乌冲突。自特朗普1月上任以来，这已是他与普京的第五次通话。', '特朗普14日在社交媒体上发文称，“普京总统今天早上打电话来，非常亲切地祝我生日快乐”。但他表示，更重要的是，两人集中讨论了伊朗与以色列的危机。特朗普称，“普京非常了解伊朗，他和我一样，认为以色列与伊朗之间的这场战争应该结束。我也跟他解释说，俄乌冲突也应该结束”。但特朗普表示，在大约一个小时的通话中，他和普京谈论俄乌冲突的时间“不多”。特朗普还称，俄罗斯和乌克兰正在交换大量战俘，俄乌下周将继续谈判。\n特朗普没有提供有关此次通话的更多细节，中东局势的危险升级，无疑是两国领导人意见交流的焦点。俄罗斯总统助理乌沙科夫14日对媒体介绍说，50分钟的通话中，普京谴责以色列对伊朗的军事行动，愿意为两国提供调解。此外，乌沙科夫说，“俄罗斯表示愿意在6月22日之后按照约定继续与乌克兰进行谈判。特朗普总统注意到了这一信息，并表示希望尽快结束俄乌冲突”。美国Axios网站15日称，特朗普目前的策略是尝试修复美俄关系，以共同解决全球危机。以伊危机将成为这种策略能否奏效的试金石。 \n\n　　据《纽约邮报》14日报道，乌克兰总统泽连斯基不满美俄领导人对话的基调“过于热情”，同时再次敦促华盛顿加大对俄制裁。他在社交媒体上写道：“恕我直言，这种过于热情的谈话语气无助于结束战斗。”除此之外，泽连斯基没谈到是否愿意展开下一轮和谈，只说“将完成（战俘）交换工作，双方将讨论下一步”。', '3', 'http://localhost:8000/static/uploads/20250616120719w700d1q75cms (1).jpg', '2025-06-16 12:07:21', '通过', '4', '1');
INSERT INTO `mall_news` VALUES (8, '参加G7前“顺路”访问格陵兰岛，马克龙“释放信号”', '时政新闻', '【文/观察者网 张菁娟】综合美联社、《华盛顿邮报》等媒体报道，当地时间6月15日，法国总统马克龙前往丹麦自治领地格陵兰岛，这是他赴加拿大出席七国集团峰会途中的一次短暂访问。他计划在格陵兰岛仅停留数小时，并就该地区的主权问题发出明确信号。', '　报道称，马克龙在访问时表示，他带来了法国和欧盟对这一北极战略要地的“团结与友谊之讯”。而美国总统特朗普曾誓言要“以某种方式”为美国“拿下”这块土地。\n\n　　这位法国总统告诉丹麦首相弗雷泽里克森和格陵兰岛自治政府总理延斯-弗雷德里克·尼尔森，自己此行是为了表达法国和欧盟对格陵兰岛主权和领土完整的支持，也是为了协助其应对在经济增长、气候紧急状况和教育方面的挑战。\n当地时间2025年6月15日，马克龙（中）在格陵兰岛与丹麦首相弗雷泽里克森（右）和格陵兰岛自治政府总理延斯-弗雷德里克·尼尔森交谈。 法新社\n\n　　马克龙说，他反对特朗普吞并格陵兰岛的企图，“这不像盟友之间应该做的事”。他认为，丹麦和欧洲各国必须致力于支持这片领土，它具有极高的战略重要性，其领土完整必须得到尊重。\n\n　　当被问及如果特朗普决定对格陵兰岛“出手”，法国是否准备在军事上支持格陵兰岛时，马克龙拒绝对这种假设进行讨论。\n\n　　“我不会公开阐述‘假设情景’。因为我不相信，作为盟友和朋友的美国最终会对另一个盟友采取侵略行动”。\n\n　　在格陵兰岛首府努克举行的联合记者会上，马克龙表示，美国一再表达希望接管格陵兰岛的想法是错误的，“所有法国人和欧盟成员都认为，格陵兰岛不可出售，也不可被夺取”。\n\n　　他补充道，格陵兰岛的局势显然给所有欧洲人敲响了警钟。“让我非常直接地告诉你们，你们并不孤单。”\n\n　　马克龙此行是应丹麦政府及格陵兰自治区政府之邀进行，期间他将全程由弗雷泽里克森和尼尔森陪同。爱丽舍宫表示，在格陵兰岛访问期间，马克龙将参观一处正在加速融化的冰川、一座由欧盟出资建设的水力发电站，以及停泊在格陵兰岛首府努克附近的一艘丹麦军舰。\n\n　　美联社称，对格陵兰岛的象征性访问正值这位法国领导人前往加拿大参加G7峰会的途中，特朗普也将出席该峰会。\n\n　　马克龙成为首位访问该岛的法国国家元首，也是自特朗普放言“夺取格陵兰岛”后，首位正式访问该岛的外国元首。\n\n　　他透露，自己在出发前已通知美国总统特朗普。他强调，美国仍是盟友，但作为欧洲人，必须减少对美国的依赖。\n\n　　据报道，近几个月来，马克龙一直致力于重振法国作为欧盟27国外交和经济重要力量的地位。\n\n　　在特朗普威胁不再支持乌克兰之际，这位法国总统将自己定位为欧洲的领导者。马克龙在巴黎与其他欧洲国家元首举行了一次峰会，讨论基辅问题以及欧洲大陆的安全问题。\n\n　　至于格陵兰岛的问题，马克龙本月早些时候也在法国尼斯举行的联合国海洋大会上公开表示，深海不是商品，格陵兰岛亦非商品，不可交易，也不', '4', 'http://localhost:8000/static/uploads/20250616121744w700d1q75cms (2).jpg', '2025-06-16 12:17:47', '通过', '7', '1');

-- ----------------------------
-- Table structure for mall_save
-- ----------------------------
DROP TABLE IF EXISTS `mall_save`;
CREATE TABLE `mall_save`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `newsId` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `user_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `de` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_save
-- ----------------------------
INSERT INTO `mall_save` VALUES (5, '3', 'True', '8', '1');
INSERT INTO `mall_save` VALUES (6, '4', 'False', '1', '1');
INSERT INTO `mall_save` VALUES (7, '6', 'True', '11', '1');
INSERT INTO `mall_save` VALUES (8, '7', 'True', '12', '1');
INSERT INTO `mall_save` VALUES (9, '8', 'True', '13', '1');
INSERT INTO `mall_save` VALUES (10, '8', 'True', '12', '1');

-- ----------------------------
-- Table structure for mall_staff
-- ----------------------------
DROP TABLE IF EXISTS `mall_staff`;
CREATE TABLE `mall_staff`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `sex` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `pic` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `addr` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `de` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_staff
-- ----------------------------
INSERT INTO `mall_staff` VALUES (1, '王翠湖', '女', 'http://localhost:8000/static/uploads/202504211902537e5fd5bc09df0f57aebc62985afc51fa.jpg', 'A区-102', '18912341234', '111', '1');
INSERT INTO `mall_staff` VALUES (2, '王七', '男', 'http://localhost:8000/static/uploads/20250616110917c1b56505c8cc4afa01c7d8b929fc7271.jpeg', 'A区-107', '18412341234', '111', '1');
INSERT INTO `mall_staff` VALUES (3, '李连花', '男', 'http://localhost:8000/static/uploads/20250616120432a97410382295a0eef2a0805529541912.png', 'A区-109', '18712341234', '111', '1');
INSERT INTO `mall_staff` VALUES (4, '刘兰', '男', 'http://localhost:8000/static/uploads/20250616121551b0c3bc4c09e9a1dae04b0cf0ae2b19ee.jpg', 'A区-205', '18312341234', '111', '1');

-- ----------------------------
-- Table structure for mall_user
-- ----------------------------
DROP TABLE IF EXISTS `mall_user`;
CREATE TABLE `mall_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `nickname` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `date` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `sex` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `email` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `qq` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `de` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `mall_user_phone_241de97f_uniq`(`phone`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_user
-- ----------------------------
INSERT INTO `mall_user` VALUES (1, '苏珊大妈', '苏珊', '1982-02-02', '女', '63334466@qq.com', '6667777444', '17834563456', '123456', '1');
INSERT INTO `mall_user` VALUES (8, '小华', '王小华', '2025-04-10', '男', '123@qq.com', '123', '18812341234', '111', '1');
INSERT INTO `mall_user` VALUES (9, '花花', '王小画', '2025-04-04', '女', '111@qq.com', '111', '19912341234', '222', '1');
INSERT INTO `mall_user` VALUES (10, '笑笑', '王笑笑', '2025-04-25', '女', '2345@qq.com', '123456', '19912344321', '111', '1');
INSERT INTO `mall_user` VALUES (11, '东东六', '王冬冬', '2025-05-29', '男', '3456789@qq.com', '34567678', '15912341234', '111', '1');
INSERT INTO `mall_user` VALUES (12, '喜喜七', '王喜喜', '2025-06-14', '男', '456789@qq.com', '45678', '15712341234', '111', '1');
INSERT INTO `mall_user` VALUES (13, '楠楠九', '王楠', '2025-06-13', '女', '456789@qq.com', '456789', '15312341234', '111', '1');

SET FOREIGN_KEY_CHECKS = 1;
