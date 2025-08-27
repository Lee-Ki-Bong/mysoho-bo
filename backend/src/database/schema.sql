-- ----------------------------
-- 0. Alter existing tables for compatibility
-- ----------------------------
ALTER TABLE `permissions` ENGINE=InnoDB, CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE `manager` ENGINE=InnoDB, CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- ----------------------------
-- 1. Roles Table: 관리자 역할 정의
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `role_code` varchar(20) NOT NULL COMMENT '역할 코드 (e.g., SUPER_ADMIN)',
  `role_name` varchar(50) NOT NULL COMMENT '역할 이름 (e.g., 최고 관리자)',
  `role_desc` varchar(255) DEFAULT NULL COMMENT '역할 설명',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='백오피스 관리자 역할';

-- ----------------------------
-- 2. Menus Table: 메뉴 구조 정의
-- ----------------------------
DROP TABLE IF EXISTS `menus`;
CREATE TABLE `menus` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL COMMENT '상위 메뉴 ID (1뎁스 메뉴는 NULL)',
  `menu_name` varchar(50) NOT NULL COMMENT '메뉴 이름',
  `menu_path` varchar(100) DEFAULT NULL COMMENT '프론트엔드 경로 (e.g., /stores/all)',
  `menu_order` int(11) NOT NULL DEFAULT '0' COMMENT '메뉴 정렬 순서',
  `permission_code` varchar(30) DEFAULT NULL COMMENT '메뉴 접근에 필요한 권한 코드',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`menu_id`),
  KEY `fk_menu_parent` (`parent_id`),
  CONSTRAINT `fk_menu_parent` FOREIGN KEY (`parent_id`) REFERENCES `menus` (`menu_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='백오피스 메뉴 구조';

-- ----------------------------
-- 3. Role-Permissions Junction Table: 역할-권한 매핑
-- ----------------------------
DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE `role_permissions` (
  `role_code` varchar(20) NOT NULL,
  `permission_code` varchar(30) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_code`, `permission_code`),
  KEY `fk_rp_permission` (`permission_code`),
  CONSTRAINT `fk_rp_role` FOREIGN KEY (`role_code`) REFERENCES `roles` (`role_code`) ON DELETE CASCADE,
  CONSTRAINT `fk_rp_permission` FOREIGN KEY (`permission_code`) REFERENCES `permissions` (`prm_code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='역할-권한 매핑';

-- ----------------------------
-- 4. Add role_code to manager table
-- ----------------------------
ALTER TABLE `manager` ADD `role_code` VARCHAR(20) NULL COMMENT '매니저 역할 코드' AFTER `mng_group`;
ALTER TABLE `manager` ADD CONSTRAINT `fk_manager_role` FOREIGN KEY (`role_code`) REFERENCES `roles` (`role_code`) ON DELETE SET NULL;

-- ----------------------------
-- Sample Data Insertion
-- ----------------------------

-- 1. 역할(Roles) 샘플 데이터
INSERT INTO `roles` (`role_code`, `role_name`, `role_desc`) VALUES
('SUPER_ADMIN', '최고 관리자', '시스템의 모든 기능에 접근할 수 있는 최상위 관리자'),
('OPERATOR', '운영자', '상점 관리, 운영 등 핵심 기능을 담당하는 관리자'),
('SUPPORT', '서포터', '고객 지원을 위한 조회 위주의 최소 권한을 가진 관리자');

-- manager 시드: roles가 먼저 존재해야 FK(fk_manager_role)를 통과한다
INSERT INTO `manager`
(`mng_user`, `mng_ip`, `mng_name`, `mng_part`, `mng_group`, `role_code`, `mng_desc`, `mng_status`, `mng_last_connection`, `created_at`, `updated_at`)
VALUES
('super_tester', '', '테스트최고관리자', '개발팀', 'SUPER_ADMIN', 'SUPER_ADMIN', '테스트용 최고 관리자 계정', 'active', '1000-01-01', '1000-01-01 00:00:00', '1000-01-01 00:00:00');

-- 2. 권한(Permissions) 샘플 데이터 (prm_code, prm_name, prm_desc)
-- 기존 permissions 테이블에 데이터를 추가합니다.
INSERT INTO `permissions` (`prm_code`, `prm_name`, `prm_desc`) VALUES
('menu:store', '상점 관리 메뉴', '상점 관리 1뎁스 메뉴 접근 권한'),
('menu:operation', '운영 관리 메뉴', '운영 관리 1뎁스 메뉴 접근 권한'),
('menu:data', '데이터 센터 메뉴', '데이터 센터 1뎁스 메뉴 접근 권한'),
('menu:system', '시스템 설정 메뉴', '시스템 설정 1뎁스 메뉴 접근 권한'),
('store:list:read', '상점 목록 조회', '상점 목록을 조회할 수 있는 권한'),
('store:detail:read', '상점 상세 조회', '상점 상세 정보를 조회할 수 있는 권한'),
('store:detail:update', '상점 상세 수정', '상점 상세 정보를 수정할 수 있는 권한'),
('store:ip:manage', 'IP 차단 관리', '상점 접속 IP를 차단/해제하는 권한'),
('operation:notice:manage', '공지사항 관리', '공지사항을 등록/수정/삭제하는 권한'),
('data:sales:read', '매출 통계 조회', '매출 통계를 조회하는 권한'),
('system:manager:read', '관리자 계정 조회', '관리자 계정 목록을 조회하는 권한'),
('system:manager:manage', '관리자 계정 관리', '관리자 계정을 생성/수정/삭제하는 권한'),
('system:permission:manage', '역할/권한 관리', '역할별 권한을 관리하는 권한')
ON DUPLICATE KEY UPDATE prm_name=VALUES(prm_name), prm_desc=VALUES(prm_desc);

-- 3. 메뉴(Menus) 샘플 데이터
-- 1뎁스
INSERT INTO `menus` (menu_id, parent_id, menu_name, menu_order, permission_code) VALUES
(1, NULL, '상점 관리', 1, 'menu:store'),
(2, NULL, '운영 관리', 2, 'menu:operation'),
(3, NULL, '데이터 센터', 3, 'menu:data'),
(4, NULL, '시스템 설정', 4, 'menu:system');
-- 2뎁스
INSERT INTO `menus` (parent_id, menu_name, menu_path, menu_order, permission_code) VALUES
(1, '상점 목록', '/stores', 1, 'store:list:read'),
(1, 'IP 차단 관리', '/stores/ip-block', 2, 'store:ip:manage'),
(2, '공지사항 관리', '/operation/notices', 1, 'operation:notice:manage'),
(3, '매출 통계', '/data/sales', 1, 'data:sales:read'),
(4, '관리자 계정 관리', '/system/managers', 1, 'system:manager:manage'),
(4, '역할 및 권한 관리', '/system/permissions', 2, 'system:permission:manage');

-- 4. 역할-권한 매핑(Role-Permissions) 샘플 데이터
-- SUPER_ADMIN (모든 권한)
INSERT INTO `role_permissions` (role_code, permission_code) SELECT 'SUPER_ADMIN', prm_code FROM permissions;

-- OPERATOR
INSERT INTO `role_permissions` (role_code, permission_code) VALUES
('OPERATOR', 'menu:store'),
('OPERATOR', 'menu:operation'),
('OPERATOR', 'menu:data'),
('OPERATOR', 'store:list:read'),
('OPERATOR', 'store:detail:read'),
('OPERATOR', 'store:detail:update'),
('OPERATOR', 'store:ip:manage'),
('OPERATOR', 'operation:notice:manage'),
('OPERATOR', 'data:sales:read');

-- SUPPORT
INSERT INTO `role_permissions` (role_code, permission_code) VALUES
('SUPPORT', 'menu:store'),
('SUPPORT', 'store:list:read'),
('SUPPORT', 'store:detail:read');
