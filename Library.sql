/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : localhost
 Source Database       : Library

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : utf-8

 Date: 11/02/2017 21:11:00 PM
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `book_type`
-- ----------------------------
DROP TABLE IF EXISTS `book_type`;
CREATE TABLE `book_type` (
  `book_type` text COLLATE utf8_bin,
  `id` int(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `book_type`
-- ----------------------------
BEGIN;
INSERT INTO `book_type` VALUES ('数学分析', '0'), ('考研英语', '1'), ('马克思主义', '2'), ('中国特色社会主义', '3'), ('数据结构', '4');
COMMIT;

-- ----------------------------
--  Table structure for `books`
-- ----------------------------
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `id` int(8) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `type` int(255) DEFAULT NULL,
  `edition` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `writer` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `isAvailable` int(255) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `cover_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `books`
-- ----------------------------
BEGIN;
INSERT INTO `books` VALUES ('20170001', '高等数学', '0', '上海大学', '你猜', '10', '10', 'gaoDengShuXue.jpeg'), ('20170003', 'Javascript高级程序设计(第3版)', '4', '人民邮电出版社', 'Nicholas C.Zakas', '8', '8', 'jsGaoJiChengXuSheJi.jpg'), ('20170004', '深入浅出nodeJs', '4', '人民邮电出版社', '朴灵', '3', '3', 'shenruqianchunode.jpg'), ('20170005', '锋利的jQuery', '4', '人民邮电出版社', '单东林', '2', '2', 'fenglidejquery.jpg'), ('20170006', '恋恋有词', '1', '浙江教育出版社', '朱伟', '6', '6', 'lianlianyouci.jpg'), ('20170007', 'A Song of Ice and Fire', '1', 'Bantam Books ', ' George R. R. Martin', '3', '3', 'asongoficeandfire.jpg'), ('20170008', '共产党宣言', '2', '人民出版社', '马克思', '3', '3', 'gongchandangxuanyan.jpg'), ('20170009', '习近平治国理政', '3', '中央党校出版社', '习近平', '30', '30', 'zhiguolizheng.jpg'), ('20170010', '线性代数', '0', '高等教育出版社', '同济大学数学系', '3', '3', 'xiandai.jpeg'), ('20170011', '概率论与数理统计', '0', '高等教育出版社', '浙江大学', '3', '4', 'gailvlun.jpg'), ('20170012', '高中数学', '0', '你下', '胡圣翔', '2', '2', 'gaozhongshuxue.jpg');
COMMIT;

-- ----------------------------
--  Table structure for `books_lent`
-- ----------------------------
DROP TABLE IF EXISTS `books_lent`;
CREATE TABLE `books_lent` (
  `id` int(8) NOT NULL,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `owner_id` int(6) NOT NULL,
  `beginning_date` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `deadline` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `isExtended` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `books_lent`
-- ----------------------------
BEGIN;
INSERT INTO `books_lent` VALUES ('20170011', '概率论与数理统计', '20170008', '1508325611338', '1513509611338', 'true');
COMMIT;

-- ----------------------------
--  Table structure for `customer`
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `password` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `isAdmin` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20170009 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
--  Records of `customer`
-- ----------------------------
BEGIN;
INSERT INTO `customer` VALUES ('20170001', 'hu', '123', 'true'), ('20170002', 'zhou', '123', 'true'), ('20170003', 'chen', '123', 'true'), ('20170004', 'luo', '123', 'true'), ('20170007', 'fang', '123', 'true'), ('20170008', 'xiaogui', '123', 'false');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
