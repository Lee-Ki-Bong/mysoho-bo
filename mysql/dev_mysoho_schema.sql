-- MySQL dump 10.13  Distrib 5.1.44, for unknown-freebsd11.0 (x86_64)
--
-- Host: mysoho-db2    Database: dev_mysoho
-- ------------------------------------------------------
-- Server version	5.1.44-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `adm_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '상점 고유번호',
  `adm_id` varchar(30) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `adm_pw` varchar(100) NOT NULL DEFAULT '' COMMENT '상점 비밀번호',
  `adm_ci` varchar(100) NOT NULL DEFAULT '' COMMENT '상점 인증번호',
  `adm_ms_integrated` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '통합회원여부',
  `adm_ms_integrated_id` varchar(30) NOT NULL DEFAULT '' COMMENT '통합회원 아이디',
  `adm_ms_member_key` varchar(255) NOT NULL DEFAULT '' COMMENT '통합회원 연동 member key',
  `adm_name` varchar(20) NOT NULL DEFAULT '' COMMENT '상점주 성명',
  `adm_phone` char(15) NOT NULL DEFAULT '' COMMENT '상점주 휴대폰 번호',
  `adm_email` varchar(100) NOT NULL DEFAULT '' COMMENT '상점주 이메일 주소',
  `adm_domain` varchar(255) NOT NULL DEFAULT '' COMMENT '상점 도메인',
  `adm_join_path` varchar(100) NOT NULL DEFAULT '' COMMENT '상점 가입 경로',
  `adm_agree_provision` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '마이소호 이용약관 동의 여부',
  `adm_agree_privacy` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '마이소호 개인정보 수집 및 이용 동의 여부',
  `adm_agree_third_person` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '제3자 이용 동의여부',
  `adm_agree_third_person_update_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '제3자 이용 동의여부 갱신일시',
  `adm_recommend_id` varchar(30) NOT NULL DEFAULT '' COMMENT '추천인 리셀러 ID',
  `adm_ipv4` varchar(15) NOT NULL DEFAULT '' COMMENT '가입시 ip v4',
  `adm_type` enum('DELETED','WAIT','TEST','LIVE','DORMANT') NOT NULL DEFAULT 'WAIT' COMMENT '테스트 계정 여부',
  `adm_join_group` varchar(20) NOT NULL DEFAULT 'SOHO' COMMENT '회원 가입 그룹을 구분하기 위한 값. 그룹별로 특별 처리 위해 추가',
  `adm_ssl` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT 'SSL 인증서 발급 여부',
  `adm_memo` text NOT NULL COMMENT '상점 이슈 사항 메모',
  `adm_date_login` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '최근 로그인 일시',
  `adm_dormant_send` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '휴면 안내문 발송 여부',
  `adm_dormant_send_type` enum('N','E','S') NOT NULL DEFAULT 'N' COMMENT '휴면 안내문 발송 방법 N: 발송안함 E: email발송 , S: sms발송',
  `adm_dormant_send_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '휴면 안내문 발송 날짜',
  `dormant_complete_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '휴면처리 완료일',
  `dormant_cancel_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '휴면해제 처리 완료일',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '상점 가입 날짜',
  `expired_at` date NOT NULL DEFAULT '0000-00-00' COMMENT '상점 만료 날짜',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '변경 날짜',
  `adm_agree_14years` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '마이소호 14세 이상 동의여부',
  PRIMARY KEY (`adm_seq`),
  UNIQUE KEY `adm_id` (`adm_id`),
  KEY `adm_name` (`adm_name`,`adm_phone`),
  KEY `adm_domain` (`adm_domain`)
) ENGINE=InnoDB AUTO_INCREMENT=19648 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 관리자 기본 정보 v2017-07-28';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_add_info`
--

DROP TABLE IF EXISTS `admin_add_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_add_info` (
  `aai_adm_seq` int(10) NOT NULL COMMENT '상점 고유번호',
  `aai_bank_uid` varchar(3) NOT NULL DEFAULT '' COMMENT '계좌 은행코드',
  `aai_bank_number` varchar(30) NOT NULL DEFAULT '' COMMENT '계좌 번호',
  `aai_bank_owner` varchar(20) NOT NULL DEFAULT '' COMMENT '계좌 예금주',
  PRIMARY KEY (`aai_adm_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 관리자 부가 정보 v2017-08-07';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_lives_statistic`
--

DROP TABLE IF EXISTS `admin_lives_statistic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_lives_statistic` (
  `als_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '고유번호',
  `als_lives` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 live 상점수',
  `als_logins` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'live 중 회원가입/로그인 상점수',
  `als_orders` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'live 중 주문 상점수',
  `als_condition` varchar(10) NOT NULL DEFAULT '' COMMENT '수집 조건(ex. 최근 3개월)',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록 날짜',
  PRIMARY KEY (`als_id`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='LIVE 상점 통계 정보(daily) v2021-07-09';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_pg`
--

DROP TABLE IF EXISTS `admin_pg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_pg` (
  `ap_adm_id` varchar(20) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `ap_code` varchar(10) NOT NULL DEFAULT '' COMMENT 'pg 구분 코드',
  `ap_use` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT 'PG 사용여부',
  `ap_status` varchar(1) NOT NULL DEFAULT '' COMMENT 'PG 상태 구분값',
  `ap_manager_set_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '운영팀 최초 세팅한 날짜',
  `confirmed_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '인증 날짜',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정 날짜',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록 날짜',
  PRIMARY KEY (`ap_adm_id`,`ap_code`),
  KEY `idx_ap_code` (`ap_code`),
  KEY `idx_ap_manager_set_date` (`ap_manager_set_date`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 pg 정보 2018-12-24';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_pg_history`
--

DROP TABLE IF EXISTS `admin_pg_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_pg_history` (
  `aph_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '자동 생성 아이디',
  `aph_adm_id` varchar(20) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `aph_code` varchar(10) NOT NULL DEFAULT '' COMMENT 'pg 구분 코드',
  `aph_use` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT 'PG 사용여부',
  `aph_status` varchar(1) NOT NULL DEFAULT '' COMMENT 'PG 상태 구분값',
  `aph_create_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '등록 아이피',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록 날짜',
  PRIMARY KEY (`aph_id`),
  KEY `idx_aph_adm_id` (`aph_adm_id`),
  KEY `idx_aph_code` (`aph_code`),
  KEY `idx_aph_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 pg정보 수정내역 2019-11-01';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_sales_statistic`
--

DROP TABLE IF EXISTS `admin_sales_statistic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_sales_statistic` (
  `ass_seq` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ass_adm_id` varchar(20) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `ass_shop_total_price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ass_price_total + ass_price_simple_total',
  `ass_price_total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 매출',
  `ass_price_bank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 매출',
  `ass_price_pg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 매출',
  `ass_price_mobile_pg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 매출(mobile)',
  `ass_price_mobile_bank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 매출(mobile)',
  `ass_price_pc_pg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 매출(pc)',
  `ass_price_pc_bank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 매출(pc)',
  `ass_price_etc_pg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 매출(etc)',
  `ass_price_etc_bank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 매출(etc)',
  `ass_price_naverpaypg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '네이버페이 결제형 매출',
  `ass_price_pc_naverpaypg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '네이버페이 결제형 매출(pc)',
  `ass_price_mobile_naverpaypg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '네이버페이 결제형 매출(mobile)',
  `ass_naverpaypg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '네이버페이 결제형 건수',
  `ass_pc_naverpaypg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '네이버페이 결제형 주문건수(pc)',
  `ass_mobile_naverpaypg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '네이버페이 결제형 주문건수(mobile)',
  `ass_price_simple_total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 매출',
  `ass_price_simple_bank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 매출',
  `ass_price_simple_pg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 매출',
  `ass_total_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 주문건수',
  `ass_bank_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 주문건수',
  `ass_pg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 주문건수',
  `ass_mobile_bank_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 주문건수(mobile)',
  `ass_mobile_pg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 주문건수(mobile)',
  `ass_pc_bank_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 주문건수(pc)',
  `ass_pc_pg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 주문건수(pc)',
  `ass_etc_bank_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 주문건수(etc)',
  `ass_etc_pg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 주문건수(etc)',
  `ass_simple_total_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '개인결제 총 주문건수',
  `ass_simple_bank_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '개인결제 무통장 주문건수',
  `ass_simple_pg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '개인결제 PG 주문건수',
  `ass_pg_wait` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 결제 대기',
  `ass_pg_fail` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 결제 실패',
  `ass_deli_progress` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '배송중 건수',
  `ass_deli_complete` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '배송완료 건수',
  `std_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '수집 기준 날짜',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록 날짜',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정 날짜',
  PRIMARY KEY (`ass_seq`),
  KEY `ass_adm_id` (`ass_adm_id`),
  KEY `std_date` (`std_date`),
  KEY `idx_ass_shop_total_price` (`ass_shop_total_price`)
) ENGINE=InnoDB AUTO_INCREMENT=2912591 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 매출 통계용 정보(daily) v2022-02-21';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_sales_statistic_20190903`
--

DROP TABLE IF EXISTS `admin_sales_statistic_20190903`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_sales_statistic_20190903` (
  `ass_seq` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ass_adm_id` varchar(20) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `ass_shop_total_price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ass_price_total + ass_price_simple_total',
  `ass_price_total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 매출',
  `ass_price_bank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 매출',
  `ass_price_pg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 매출',
  `ass_price_simple_total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 매출',
  `ass_price_simple_bank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 매출',
  `ass_price_simple_pg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 매출',
  `ass_total_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 주문건수',
  `ass_bank_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 주문건수',
  `ass_pg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 주문건수',
  `ass_simple_total_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '개인결제 총 주문건수',
  `ass_simple_bank_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '개인결제 무통장 주문건수',
  `ass_simple_pg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '개인결제 PG 주문건수',
  `ass_pg_wait` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 결제 대기',
  `ass_pg_fail` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 결제 실패',
  `std_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '수집 기준 날짜',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록 날짜',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정 날짜',
  PRIMARY KEY (`ass_seq`),
  KEY `ass_adm_id` (`ass_adm_id`),
  KEY `std_date` (`std_date`),
  KEY `idx_ass_shop_total_price` (`ass_shop_total_price`)
) ENGINE=InnoDB AUTO_INCREMENT=2912439 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 매출 통계용 정보(daily) v2017-09-14';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_sales_statistic_new`
--

DROP TABLE IF EXISTS `admin_sales_statistic_new`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_sales_statistic_new` (
  `ass_seq` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ass_adm_id` varchar(20) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `ass_shop_total_price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'ass_price_total + ass_price_simple_total',
  `ass_price_total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 매출',
  `ass_price_bank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 매출',
  `ass_price_pg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 매출',
  `ass_price_simple_total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 매출',
  `ass_price_simple_bank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 매출',
  `ass_price_simple_pg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 매출',
  `ass_total_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 주문건수',
  `ass_bank_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 주문건수',
  `ass_pg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 주문건수',
  `ass_simple_total_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '개인결제 총 주문건수',
  `ass_simple_bank_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '개인결제 무통장 주문건수',
  `ass_simple_pg_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '개인결제 PG 주문건수',
  `ass_pg_wait` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 결제 대기',
  `ass_pg_fail` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 결제 실패',
  `std_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '수집 기준 날짜',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록 날짜',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정 날짜',
  PRIMARY KEY (`ass_seq`),
  KEY `ass_adm_id` (`ass_adm_id`),
  KEY `std_date` (`std_date`),
  KEY `idx_ass_shop_total_price` (`ass_shop_total_price`)
) ENGINE=InnoDB AUTO_INCREMENT=2912359 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 매출 통계용 정보(daily) v2017-09-14';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_search`
--

DROP TABLE IF EXISTS `admin_search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_search` (
  `as_adm_id` varchar(20) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `as_shop_name` varchar(100) NOT NULL DEFAULT '' COMMENT '쇼핑몰명',
  `as_biz_company_name` varchar(50) NOT NULL DEFAULT '',
  `as_biz_status` char(1) NOT NULL DEFAULT '' COMMENT '사업자 인증 상태',
  `as_biz_type` varchar(50) NOT NULL DEFAULT '' COMMENT '사업자 구분',
  `as_biz_num` varchar(12) NOT NULL DEFAULT '' COMMENT '사업자 번호',
  `as_pg_use` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT 'PG 셋팅 여부',
  `as_pg_confirm_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'PG 승인 날짜',
  `as_pg_set_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'PG 등록 날짜',
  `as_sms_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'SMS 건수',
  `as_price_total` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 매출',
  `as_price_bank` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '무통장 매출',
  `as_price_pg` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'PG 매출',
  `as_prd_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '총 상품 갯수',
  `as_user_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '회원수',
  `as_advertise_agree` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '광고성 정보 수집 동의',
  `as_mobile_skin` varchar(10) NOT NULL DEFAULT '' COMMENT '상점 모바일 스킨',
  `as_pc_skin` varchar(10) NOT NULL DEFAULT '' COMMENT '상점 pc 스킨',
  `as_users_display` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '회원가입기능 노출 미노출 여부',
  `as_is_total_sales_limit` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '기준 매출 초과에 따른 제한 여부',
  `advertised_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '광고성 정보 변경 날짜',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록 날짜',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수집 날짜',
  PRIMARY KEY (`as_adm_id`),
  KEY `idx_as_mobile_skin` (`as_mobile_skin`),
  KEY `idx_as_pc_skin` (`as_pc_skin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 검색 정보 v2017-09-14';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_server_info`
--

DROP TABLE IF EXISTS `admin_server_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_server_info` (
  `asi_adm_seq` int(10) unsigned NOT NULL COMMENT '상점 고유번호',
  `asi_db_master_si_seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'master db',
  `asi_db_slave_si_seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'slave db',
  `asi_session_si_seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'session',
  `asi_db` varchar(255) NOT NULL DEFAULT '' COMMENT 'DB 명',
  PRIMARY KEY (`asi_adm_seq`),
  KEY `asi_db` (`asi_db`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 server 정보 v2017-07-28';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_sms_auth`
--

DROP TABLE IF EXISTS `admin_sms_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_sms_auth` (
  `asa_adm_id` varchar(20) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `asa_type` enum('JOIN','RESET_PW','FIND_ID') NOT NULL DEFAULT 'JOIN' COMMENT '휴대폰 인증 타입. 회원가입 or 아이디,비번 찾기',
  `asa_phone` char(14) NOT NULL DEFAULT '' COMMENT '인증받는 휴대폰 번호',
  `asa_auth` varchar(6) NOT NULL DEFAULT '' COMMENT '인증번호 6자리',
  `asa_issue_cnt` int(10) NOT NULL DEFAULT '1' COMMENT '인증번호 발급횟수',
  `asa_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '인증번호 발급 요청 IP',
  `asa_auth_result` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '인증 결과',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '인증번호 발급 날짜',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '인증 완료 날짜',
  PRIMARY KEY (`asa_adm_id`,`asa_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='휴대폰 인증 v2017-07-28';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_sns`
--

DROP TABLE IF EXISTS `admin_sns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_sns` (
  `adm_id` varchar(30) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `as_type` char(2) NOT NULL DEFAULT '' COMMENT 'SNS 타입',
  `as_id` varchar(255) NOT NULL DEFAULT '' COMMENT 'SNS 고유번호',
  `as_key` varchar(255) NOT NULL DEFAULT '' COMMENT '추가정보',
  `as_date` date NOT NULL DEFAULT '0000-00-00' COMMENT '등록일',
  PRIMARY KEY (`adm_id`,`as_type`),
  UNIQUE KEY `index_asid` (`as_type`,`as_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 관리자 SNS 정보 v2017-08-01';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_ssl`
--

DROP TABLE IF EXISTS `admin_ssl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_ssl` (
  `as_adm_id` varchar(20) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `as_domain` varchar(255) NOT NULL DEFAULT '' COMMENT '인증서 발급 도메인',
  `as_status` enum('WAIT','ISSUE') NOT NULL DEFAULT 'WAIT' COMMENT '발급 여부',
  `issued_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '인증서 발급 날짜',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록 날짜',
  PRIMARY KEY (`as_adm_id`,`as_domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 ssl 인증서 발급정보 v2017-09-06';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_super_login_keys`
--

DROP TABLE IF EXISTS `admin_super_login_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_super_login_keys` (
  `ask_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '고유 번호',
  `ask_adm_user_id` varchar(20) NOT NULL DEFAULT '' COMMENT '어드민 아이디',
  `ask_auth_id` varchar(20) NOT NULL DEFAULT '' COMMENT '접속 아이디',
  `ask_key` varchar(64) NOT NULL DEFAULT '' COMMENT '접속키',
  `ask_regist_ip` varchar(23) NOT NULL DEFAULT '' COMMENT '등록 아이피',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '접속 일자',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정 일자',
  PRIMARY KEY (`ask_seq`,`ask_adm_user_id`),
  UNIQUE KEY `idx_unique` (`ask_seq`,`ask_key`,`ask_adm_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='어드민 슈퍼로그인 접속 키';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admin_super_login_logs`
--

DROP TABLE IF EXISTS `admin_super_login_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_super_login_logs` (
  `asl_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '고유 번호',
  `asl_adm_user_id` varchar(20) NOT NULL DEFAULT '' COMMENT '어드민 아이디',
  `asl_auth_id` varchar(20) NOT NULL DEFAULT '' COMMENT '접속 아이디',
  `asl_memo` varchar(64) NOT NULL DEFAULT '' COMMENT '접속 사유',
  `asl_regist_ip` varchar(23) NOT NULL DEFAULT '' COMMENT '등록 아이피',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '접속 일자',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정 일자',
  PRIMARY KEY (`asl_seq`,`asl_adm_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='어드민 슈퍼로그인 접속 로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `block_ip`
--

DROP TABLE IF EXISTS `block_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block_ip` (
  `bi_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '차단 번호',
  `bi_ipv4` varchar(15) NOT NULL DEFAULT '' COMMENT '로그인 시도 ip',
  `bi_status` enum('ALERT','BLOCK','NONE') NOT NULL DEFAULT 'ALERT' COMMENT '차단 상태',
  `bi_fail_cnt` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '로그인 시도 횟수',
  `created_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  `updated_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`bi_seq`),
  UNIQUE KEY `bi_ipv4` (`bi_ipv4`)
) ENGINE=InnoDB AUTO_INCREMENT=7967 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='mysoho 로그인 차단 관리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `cate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '판매 아이템 고유번호',
  `cate_parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '상위 판매 아이템 코드',
  `cate_name` varchar(100) NOT NULL DEFAULT '' COMMENT '판매 아이템명',
  `cate_depth` tinyint(1) NOT NULL DEFAULT '0',
  `cate_status` enum('LIVE','DELETE') NOT NULL DEFAULT 'LIVE' COMMENT '판매 아이템 상태',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`cate_id`,`cate_parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='마이소호 판매 아이템 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_sort`
--

DROP TABLE IF EXISTS `category_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_sort` (
  `cs_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '판매 아이템 고유번호',
  `cs_sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '판매 아이템 순서',
  PRIMARY KEY (`cs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='마이소호 판매 아이템 순서 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_tmp`
--

DROP TABLE IF EXISTS `category_tmp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_tmp` (
  `cate_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '판매 아이템 고유번호',
  `cate_parent_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '상위 판매 아이템 코드',
  `cate_name` varchar(100) NOT NULL DEFAULT '' COMMENT '판매 아이템명',
  `cate_depth` tinyint(1) NOT NULL DEFAULT '0',
  `cate_status` enum('LIVE','DELETE') NOT NULL DEFAULT 'LIVE' COMMENT '판매 아이템 상태',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`cate_id`,`cate_parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='마이소호 임시 판매 아이템 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `category_tmp_sort`
--

DROP TABLE IF EXISTS `category_tmp_sort`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_tmp_sort` (
  `cs_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '판매 아이템 고유번호',
  `cs_sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '판매 아이템 순서',
  PRIMARY KEY (`cs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='임시 판매 아이템 순서';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_func_info`
--

DROP TABLE IF EXISTS `custom_func_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_func_info` (
  `cfi_func_name` varchar(20) NOT NULL DEFAULT '' COMMENT '커스텀기능 이름',
  `cfi_func_kor_name` varchar(20) NOT NULL DEFAULT '' COMMENT '커스텀기능 한글이름',
  `cfi_func_explain` varchar(200) NOT NULL DEFAULT '' COMMENT '커스텀기능 설명',
  PRIMARY KEY (`cfi_func_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dev_account`
--

DROP TABLE IF EXISTS `dev_account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dev_account` (
  `da_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '관리번호',
  `da_database_name` varchar(20) NOT NULL DEFAULT 'testmysoho' COMMENT '데이터베이스 이름',
  `da_shop_id` varchar(20) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `da_password` varchar(100) NOT NULL DEFAULT '' COMMENT '상점 비밀번호.',
  `da_src_ver` enum('TEST','DEV','LIVE') NOT NULL DEFAULT 'TEST' COMMENT '소스 버전',
  `da_is_developer` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '개발자 계정 여부',
  `da_owner` varchar(30) NOT NULL DEFAULT '' COMMENT '계정 소유자',
  `da_state` enum('WAIT','LIVE','DENY') NOT NULL DEFAULT 'WAIT' COMMENT '상태',
  `created_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '등록 요청 ip',
  `created_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  `updated_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`da_id`),
  UNIQUE KEY `da_database_name` (`da_database_name`,`da_shop_id`,`da_src_ver`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='개발서버 계정 관리 v2019-11-14';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dev_account_domain`
--

DROP TABLE IF EXISTS `dev_account_domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dev_account_domain` (
  `dad_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '시퀀스',
  `dad_mng_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '매니저 번호',
  `dad_adm_id` varchar(30) NOT NULL DEFAULT '' COMMENT 'dev 상점 아이디',
  `dad_domain` varchar(100) NOT NULL DEFAULT '' COMMENT '도메인',
  `dad_insert_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일시',
  `dad_update_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정일시',
  PRIMARY KEY (`dad_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=649 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='DEV 계정 도메인 매칭';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dormant_admin`
--

DROP TABLE IF EXISTS `dormant_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dormant_admin` (
  `dor_adm_seq` int(10) unsigned NOT NULL COMMENT '상점 고유번호',
  `dor_adm_id` varchar(30) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `dor_adm_pw` varchar(100) NOT NULL DEFAULT '' COMMENT '상점 비밀번호',
  `dor_adm_name` varchar(20) NOT NULL DEFAULT '' COMMENT '상점주 성명',
  `dor_adm_phone` char(15) NOT NULL DEFAULT '' COMMENT '상점주 휴대폰 번호',
  `dor_adm_email` varchar(100) NOT NULL DEFAULT '' COMMENT '상점주 이메일 주소',
  `dor_adm_domain` varchar(255) NOT NULL DEFAULT '' COMMENT '상점 도메인',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '상점 휴면 처리 일시',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '상점 휴면 처리 갱신 일시',
  PRIMARY KEY (`dor_adm_seq`),
  UNIQUE KEY `dor_adm_id` (`dor_adm_id`),
  KEY `idx_dor_adm_domain` (`dor_adm_domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='휴면 상점 관리자 기본 정보 v2023-04-19';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_category`
--

DROP TABLE IF EXISTS `faq_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faq_category` (
  `fcg_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'FAQ 카테고리 시퀀스',
  `fcg_name` varchar(30) NOT NULL DEFAULT '' COMMENT '카테고리명',
  `fcg_sort` tinyint(4) NOT NULL DEFAULT '127' COMMENT '노출순서',
  `fcg_insert_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일시',
  `fcg_update_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일시',
  PRIMARY KEY (`fcg_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='FAQ 카테고리';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `faq_contents`
--

DROP TABLE IF EXISTS `faq_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `faq_contents` (
  `fct_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'FAQ 내용 시퀀스',
  `fct_fcg_seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'FAQ 카테고리 시퀀스',
  `fct_question` varchar(100) NOT NULL DEFAULT '' COMMENT '질문',
  `fct_answer_pc` text NOT NULL COMMENT '대답(pc)',
  `fct_answer_m` text NOT NULL COMMENT '대답(mobile)',
  `fct_answer_strip_tag_pc` text NOT NULL COMMENT 'PC FAQ 컨텐츠 대답 (strip_tag)',
  `fct_answer_strip_tag_m` text NOT NULL COMMENT '모바일 FAQ 컨텐츠 대답(strip_tag)',
  `fct_display` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '노출여부',
  `fct_insert_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일시',
  `fct_update_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일시',
  PRIMARY KEY (`fct_seq`),
  KEY `idx_fct_fcg_seq` (`fct_fcg_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='FAQ 내용';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inquires`
--

DROP TABLE IF EXISTS `inquires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inquires` (
  `q_no` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '문의번호',
  `q_qcc_category` char(3) NOT NULL DEFAULT '' COMMENT '문의유형코드',
  `q_name` varchar(40) NOT NULL DEFAULT '' COMMENT '작성자',
  `q_adm_userid` varchar(20) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `q_phone` varchar(30) NOT NULL DEFAULT '' COMMENT '휴대폰번호',
  `q_adm_email` varchar(50) NOT NULL DEFAULT '' COMMENT '이메일',
  `q_subject` varchar(255) NOT NULL DEFAULT '' COMMENT '제목',
  `q_content` text NOT NULL COMMENT '내용',
  `q_img_url` text NOT NULL COMMENT '문의 이미지 URL',
  `q_hit` int(11) NOT NULL DEFAULT '0' COMMENT '조회수',
  `q_reply_cnt` int(11) NOT NULL DEFAULT '0' COMMENT '답글수',
  `q_handler` varchar(20) NOT NULL DEFAULT 'N' COMMENT '처리자',
  `q_qsc_status` char(3) NOT NULL DEFAULT 'W' COMMENT '처리상태코드',
  `q_insert_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  `q_update_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일',
  `q_complete_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '처리일',
  `q_is_data_expiration` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '개인정보만료여부',
  `q_expiration_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '개인정보만료일',
  PRIMARY KEY (`q_no`),
  KEY `idx_q_id` (`q_adm_userid`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='mysoho 1:1문의 리스트 v2018-09-13';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inquires_category_code`
--

DROP TABLE IF EXISTS `inquires_category_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inquires_category_code` (
  `qcc_category` char(3) NOT NULL DEFAULT '' COMMENT '문의유형코드',
  `qcc_category_name` varchar(40) NOT NULL DEFAULT '' COMMENT '문의유형이름',
  PRIMARY KEY (`qcc_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='mysoho 1:1문의 유형코드 리스트  v2018-09-13';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inquires_status_code`
--

DROP TABLE IF EXISTS `inquires_status_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inquires_status_code` (
  `qsc_status` char(3) NOT NULL DEFAULT '' COMMENT '처리상태코드',
  `qsc_status_name` varchar(40) NOT NULL DEFAULT '' COMMENT '처리상태이름',
  PRIMARY KEY (`qsc_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='mysoho 1:1문의 처리상태코드 리스트  v2018-09-13';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager` (
  `mng_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '고유번호',
  `mng_user` varchar(30) NOT NULL DEFAULT '' COMMENT 'OTP 인증 아이디',
  `mng_ip` varchar(15) NOT NULL DEFAULT '' COMMENT 'ip v4',
  `mng_name` varchar(20) NOT NULL DEFAULT '' COMMENT '이름',
  `mng_part` varchar(20) NOT NULL DEFAULT '' COMMENT '부서(단순 노출용 텍스트)',
  `mng_group` varchar(20) NOT NULL DEFAULT '' COMMENT '그룹',
  `mng_desc` text NOT NULL COMMENT '설명',
  `mng_status` enum('active','disable') NOT NULL DEFAULT 'disable',
  `mng_last_connection` date NOT NULL DEFAULT '1000-01-01' COMMENT '마지막 접속 날짜',
  `created_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록 날짜',
  `updated_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '변경 날짜',
  PRIMARY KEY (`mng_id`),
  UNIQUE KEY `idx_mng_ip` (`mng_ip`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='관리자 관리목록';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manager_permissions`
--

DROP TABLE IF EXISTS `manager_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager_permissions` (
  `mp_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '권한 매칭 고유값',
  `mp_mng_id` int(10) unsigned NOT NULL COMMENT '관리자 고유 번호',
  `mp_prm_code` varchar(30) NOT NULL DEFAULT '' COMMENT '권한 코드',
  `created_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  PRIMARY KEY (`mp_id`),
  UNIQUE KEY `idx_unique` (`mp_mng_id`,`mp_prm_code`)
) ENGINE=InnoDB AUTO_INCREMENT=1872 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사용자 권한 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manual_contents`
--

DROP TABLE IF EXISTS `manual_contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manual_contents` (
  `mct_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '마이소호 메뉴얼 컨텐츠 시퀀스',
  `mct_msc_seq` int(10) unsigned NOT NULL COMMENT '마이소호 메뉴얼 소분류 시퀀스',
  `mct_detail_pc` text NOT NULL COMMENT 'PC 메뉴얼 컨텐츠 상세',
  `mct_detail_m` text NOT NULL COMMENT '모바일 메뉴얼 컨텐츠 상세',
  `mct_detail_strip_tag_pc` text NOT NULL COMMENT 'PC 메뉴얼 컨텐츠 상세 (strip_tag)',
  `mct_detail_strip_tag_m` text NOT NULL COMMENT '모바일 메뉴얼 컨텐츠 상세 (strip_tag)',
  `mct_insert_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  `mct_update_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`mct_seq`),
  KEY `idx_mct_psc_id` (`mct_msc_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='마이소호 메뉴얼 컨텐츠';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manual_faq_recommend_list`
--

DROP TABLE IF EXISTS `manual_faq_recommend_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manual_faq_recommend_list` (
  `mfr_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '매뉴얼 faq 주천리스트 시퀀스',
  `mfr_target_seq` int(10) unsigned NOT NULL COMMENT '대상 시퀀스',
  `mfr_target_kind` enum('manual','faq') NOT NULL DEFAULT 'manual' COMMENT '주천리스트 종류',
  `mfr_sort` tinyint(4) DEFAULT '127' COMMENT '노출 순서',
  `mfr_insert_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  `mfr_update_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`mfr_seq`),
  KEY `idx_mfc_id` (`mfr_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='매뉴얼 faq 주천리스트';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manual_large_category`
--

DROP TABLE IF EXISTS `manual_large_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manual_large_category` (
  `mlc_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '마이소호 메뉴얼 대분류 시퀀스',
  `mlc_display` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '노출여부',
  `mlc_title` varchar(100) NOT NULL DEFAULT '' COMMENT '대분류 명',
  `mlc_desc` varchar(300) NOT NULL DEFAULT '' COMMENT '대분류 문구',
  `mlc_sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '노출 순서',
  `mlc_insert_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  `mlc_update_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`mlc_seq`),
  KEY `idx_mlc_id` (`mlc_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='마이소호 메뉴얼 대분류';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manual_middle_category`
--

DROP TABLE IF EXISTS `manual_middle_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manual_middle_category` (
  `mmc_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '마이소호 메뉴얼 중분류 시퀀스',
  `mmc_mlc_seq` int(10) unsigned NOT NULL COMMENT '마이소호 메뉴얼 대분류 시퀀스',
  `mmc_display` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '노출여부',
  `mmc_title` varchar(100) NOT NULL DEFAULT '' COMMENT '중분류 명',
  `mmc_sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '노출 순서',
  `mmc_insert_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  `mmc_update_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`mmc_seq`),
  KEY `idx_mmc_id` (`mmc_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='마이소호 메뉴얼 중분류';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `manual_small_category`
--

DROP TABLE IF EXISTS `manual_small_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manual_small_category` (
  `msc_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '마이소호 메뉴얼 중분류 시퀀스',
  `msc_mlc_seq` int(10) unsigned NOT NULL COMMENT '마이소호 메뉴얼 대분류 시퀀스',
  `msc_mmc_seq` int(10) unsigned NOT NULL COMMENT '마이소호 메뉴얼 중분류 시퀀스',
  `msc_view_cnt` int(10) unsigned NOT NULL COMMENT '조회수',
  `msc_display` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '노출여부',
  `msc_title` varchar(100) NOT NULL DEFAULT '' COMMENT '소분류 명',
  `msc_sort` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '노출 순서',
  `msc_insert_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  `msc_update_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`msc_seq`),
  KEY `idx_mmc_id` (`msc_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='마이소호 메뉴얼 소분류';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_identify_logs`
--

DROP TABLE IF EXISTS `mobile_identify_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_identify_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '고유번호',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '이름',
  `gender` enum('W','M') NOT NULL DEFAULT 'W' COMMENT '성별',
  `phone` varchar(30) NOT NULL DEFAULT '' COMMENT '휴대폰번호',
  `tel_company` varchar(5) NOT NULL DEFAULT '' COMMENT '통신사',
  `birth` varchar(8) NOT NULL DEFAULT '' COMMENT '생년월일',
  `identifier_ci` varchar(100) NOT NULL DEFAULT '' COMMENT '본인인증 CI',
  `identifier_di` varchar(64) NOT NULL DEFAULT '' COMMENT '본인인증 DI',
  `access_ip` varchar(50) NOT NULL DEFAULT '' COMMENT '요청 IP',
  `ret_code` varchar(10) NOT NULL DEFAULT '' COMMENT '인증결과코드',
  `ret_message` varchar(100) NOT NULL DEFAULT '' COMMENT '인증결과메시지',
  `cert_no` varchar(20) NOT NULL DEFAULT '' COMMENT '인증번호',
  `cert_etc` text NOT NULL COMMENT '암호화 문자열',
  `created_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '인증 요청일',
  PRIMARY KEY (`id`),
  KEY `phone` (`phone`),
  KEY `identifier_ci` (`identifier_ci`)
) ENGINE=InnoDB AUTO_INCREMENT=464 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='휴대폰 본인 인증 로그';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notice` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category` char(2) NOT NULL DEFAULT '' COMMENT '공지 사항 종류',
  `subject` varchar(255) NOT NULL DEFAULT '' COMMENT '제목',
  `content` text NOT NULL COMMENT '내용',
  `m_content` text NOT NULL COMMENT '모바일 내용',
  `display` set('ADMIN','FRONT') NOT NULL DEFAULT '' COMMENT '노출범위',
  `hit` int(11) NOT NULL DEFAULT '0' COMMENT '조회수',
  `ip` varchar(39) NOT NULL DEFAULT '' COMMENT '등록 IP',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='mysoho 공지사항 게시판 리스트 v2018-01-31';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `prm_code` varchar(30) NOT NULL DEFAULT '' COMMENT '권한 코드',
  `prm_name` varchar(30) NOT NULL DEFAULT '' COMMENT '권한명',
  `prm_desc` varchar(200) NOT NULL DEFAULT '' COMMENT '권한 설명',
  `created_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  PRIMARY KEY (`prm_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='권한 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pg_bank_info`
--

DROP TABLE IF EXISTS `pg_bank_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pg_bank_info` (
  `pg_code` char(10) NOT NULL DEFAULT '' COMMENT 'pg사 코드',
  `pg_bank_code` varchar(3) NOT NULL DEFAULT '' COMMENT 'pg 은행코드',
  `pg_bank_name` varchar(50) NOT NULL DEFAULT '' COMMENT 'pg 은행명',
  `created_at` date NOT NULL DEFAULT '0000-00-00' COMMENT '등록일',
  PRIMARY KEY (`pg_code`,`pg_bank_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='pg 은행 정보 테이블';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin` (
  `pi_code` mediumint(3) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '플러그인 코드',
  `pi_name` varchar(20) NOT NULL DEFAULT '' COMMENT '플러그인 이름',
  `pi_name_eng` varchar(20) NOT NULL DEFAULT '' COMMENT '플러그인 영문 이름',
  `pi_open_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '오픈 날짜',
  PRIMARY KEY (`pi_code`),
  UNIQUE KEY `pi_name` (`pi_name`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='플러그인 정보 v2018-06-01';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `plugin_statistic`
--

DROP TABLE IF EXISTS `plugin_statistic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugin_statistic` (
  `ps_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '플러그인 통계 정보 시퀀스',
  `ps_pi_code` int(3) unsigned zerofill NOT NULL DEFAULT '000' COMMENT '플러그인 코드',
  `ps_pi_install_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '플러그인 설치 상점수',
  `ps_pi_use_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '최종 사용중인 상점수',
  `ps_pi_un_use_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '최종 사용중인 상점수',
  `ps_std_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수집 기준 날짜',
  PRIMARY KEY (`ps_id`),
  KEY `ps_std_date` (`ps_std_date`)
) ENGINE=InnoDB AUTO_INCREMENT=4358 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='플러그인 통계용 정보(daily) v2018-08-07';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qa`
--

DROP TABLE IF EXISTS `qa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qa` (
  `qa_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '문의번호',
  `qa_user_type` varchar(1) NOT NULL DEFAULT '' COMMENT '회원 : M(member), 비회원 : G(Guest)',
  `qa_adm_id` varchar(20) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `qa_name` varchar(20) NOT NULL DEFAULT '' COMMENT '작성자',
  `qa_phone` varchar(11) NOT NULL DEFAULT '' COMMENT '휴대폰번호',
  `qa_email` varchar(70) NOT NULL DEFAULT '' COMMENT '이메일',
  `qa_title` varchar(100) NOT NULL DEFAULT '' COMMENT '제목',
  `qa_content` text NOT NULL COMMENT '내용',
  `qa_file` varchar(50) NOT NULL DEFAULT '' COMMENT '저장된 파일명',
  `qa_file_origin` varchar(50) NOT NULL DEFAULT '' COMMENT '원본 파일명',
  `qa_status` char(1) NOT NULL DEFAULT 'W' COMMENT '대기 W, 처리중 P, 완료 C',
  `qa_type` varchar(20) NOT NULL DEFAULT 'ETC' COMMENT 'USE : 사용방법, SUGGEST : 건의사항, RELOCATE : 타사이전, ERROR : 오류(장애) 접수, ETC : 기타',
  `qa_terms_privacy` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '개인정보 체크 여부',
  `qa_terms_privacy_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '개인정보 체크 날짜',
  `qa_create_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '등록 아이피',
  `created_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  `updated_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일',
  `completed_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '처리일',
  PRIMARY KEY (`qa_id`),
  KEY `idx_qa_user_type` (`qa_user_type`),
  KEY `idx_qa_adm_id` (`qa_adm_id`),
  KEY `idx_qa_name_phone` (`qa_name`,`qa_phone`),
  KEY `idx_qa_status` (`qa_status`),
  KEY `idx_qcreated_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=264 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='mysoho 1:1문의 리스트 v2019-01-14';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `qa_reply`
--

DROP TABLE IF EXISTS `qa_reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qa_reply` (
  `qr_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '답변번호',
  `qr_qa_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '문의번호',
  `qr_name` varchar(20) NOT NULL DEFAULT '' COMMENT '작성자',
  `qr_content` text NOT NULL COMMENT '내용',
  `qr_file` varchar(50) NOT NULL DEFAULT '' COMMENT '저장된 파일명',
  `qr_file_origin` varchar(50) NOT NULL DEFAULT '' COMMENT '원본 파일명',
  `qr_send_email` varchar(70) NOT NULL DEFAULT '' COMMENT '발송 이메일',
  `qr_create_ip` varchar(15) NOT NULL DEFAULT '' COMMENT '등록 아이피',
  `created_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  `updated_at` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`qr_id`),
  KEY `idx_qr_qa_id` (`qr_qa_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='mysoho 1:1문의 답변 리스트 v2019-01-22';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reply` (
  `rp_no` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '답변테이블 시퀀스',
  `rp_q_no` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '문의번호',
  `rp_q_no_sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '문의번호 답변순번',
  `rp_name` varchar(40) NOT NULL DEFAULT '' COMMENT '작성자',
  `rp_content` text NOT NULL COMMENT '내용',
  `rp_img_url` text NOT NULL COMMENT '답변 이미지 URL',
  `rp_hit` int(11) NOT NULL DEFAULT '0' COMMENT '조회수',
  `rp_insert_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '등록일',
  `rp_update_date` datetime NOT NULL DEFAULT '1000-01-01 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`rp_no`),
  KEY `idx_rq_id` (`rp_q_no`,`rp_q_no_sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='mysoho 1:1문의(답글) 리스트 v2018-09-13';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reserved_admin`
--

DROP TABLE IF EXISTS `reserved_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserved_admin` (
  `adm_id` varchar(30) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `ra_status` enum('WAIT','ISSUE') NOT NULL DEFAULT 'WAIT' COMMENT '아이디 발급 여부',
  `ra_created_at` date NOT NULL DEFAULT '0000-00-00' COMMENT '등록일',
  `ra_issued_at` date NOT NULL DEFAULT '0000-00-00' COMMENT '발급일',
  PRIMARY KEY (`adm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 관리자 SNS 가입 아이디(미리 정의된) v2017-08-01';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `server_info`
--

DROP TABLE IF EXISTS `server_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `server_info` (
  `si_seq` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `si_type` enum('DB_MASTER','DB_SLAVE','SESSION') NOT NULL DEFAULT 'DB_MASTER' COMMENT 'server type',
  `si_host` varchar(50) NOT NULL DEFAULT '' COMMENT 'server host',
  `si_ipv4` varchar(15) NOT NULL DEFAULT '' COMMENT 'server ip',
  `si_status` enum('DELETE','TEST','LIVE') NOT NULL DEFAULT 'LIVE' COMMENT 'server 현재 상태',
  `si_use_cnt` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '서버 이용 상점 갯수',
  `si_memo` varchar(255) NOT NULL DEFAULT '' COMMENT '메모',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '서버 생성 날짜',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '서버 상태 변경 날짜',
  PRIMARY KEY (`si_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='mysoho용 server 리스트 v2017-07-28';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `term`
--

DROP TABLE IF EXISTS `term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `term` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '약관 고유번호',
  `type` enum('1','2') NOT NULL DEFAULT '1' COMMENT '유형(이용약관 1, 개인정보처리방침 2)',
  `date` date NOT NULL COMMENT '시행날짜',
  `content_pc` mediumtext NOT NULL COMMENT '내용(PC)',
  `content_m` mediumtext NOT NULL COMMENT '내용(모바일)',
  `is_display` enum('N','Y') NOT NULL DEFAULT 'N' COMMENT '노출여부',
  `ip` varchar(39) NOT NULL DEFAULT '' COMMENT '등록 IP',
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정일',
  PRIMARY KEY (`tid`),
  KEY `type` (`type`),
  KEY `is_display` (`is_display`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='이용약관, 개인정보처리방침';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_adjustment_history`
--

DROP TABLE IF EXISTS `user_adjustment_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_adjustment_history` (
  `uah_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '정산 히스토리 시퀀스',
  `uah_mng_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '수정 매니저 번호',
  `uah_change_value` enum('C','CC','TS','TE','TSA','TEA','') NOT NULL DEFAULT '' COMMENT '처리값',
  `uah_ual_seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '대상 시퀀스(단일변경)',
  `uah_insert_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '처리일시',
  PRIMARY KEY (`uah_seq`),
  KEY `idx_insert_at` (`uah_insert_at`)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 정산 변경 내역기록';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_adjustment_list`
--

DROP TABLE IF EXISTS `user_adjustment_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_adjustment_list` (
  `ual_seq` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '정산 시퀀스',
  `ual_adm_seq` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '운영자 번호',
  `ual_adm_id` varchar(30) NOT NULL DEFAULT '' COMMENT '상점 아이디',
  `ual_kind` enum('JOIN','PG') NOT NULL DEFAULT 'JOIN' COMMENT '정산종류',
  `ual_kind_target_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '종류매칭 시퀀스',
  `ual_is_target` enum('Y','N') NOT NULL DEFAULT 'Y' COMMENT '정산대상여부',
  `ual_closing_state` enum('Y','N') NOT NULL DEFAULT 'N' COMMENT '마감여부',
  `ual_payment_price` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '지급 금액',
  `ual_insert_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '등록일시',
  `ual_update_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '수정일시',
  PRIMARY KEY (`ual_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상점 정산 리스트';
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-08-19 17:27:45
