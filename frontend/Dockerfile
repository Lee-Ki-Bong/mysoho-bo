FROM node:20-alpine

WORKDIR /usr/src/app

COPY entrypoint.sh .

# sh를 통해 스크립트를 실행하여 permission 문제를 원천적으로 해결합니다.
ENTRYPOINT ["sh", "./entrypoint.sh"]
