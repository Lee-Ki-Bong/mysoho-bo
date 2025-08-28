
# 도커 실행
docker compose up -d

# db 컨테이너 root 로 cli 에서 데이터베이스에 권한주기 ( 필요한 경우 )
GRANT ALL PRIVILEGES ON `bo_mysoho`.* TO 'mysoho'@'%';
FLUSH PRIVILEGES;