
# 도커 실행
docker compose up -d

# db 컨테이너 root 로 cli 에서 데이터베이스에 권한주기
GRANT ALL PRIVILEGES ON `bo_mysoho`.* TO 'mysoho'@'%';
FLUSH PRIVILEGES;

# 이미지 생성후 DB 스키마 & insert
docker exec -i my-mysql-db mysql -umysoho -p'1234' bo_mysoho < ./dev_mysoho_schema.sql
docker exec -i my-mysql-db mysql -umysoho -p'1234' bo_mysoho < ./backend/src/database/schema.sql