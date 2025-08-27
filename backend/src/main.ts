import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import cookieParser from 'cookie-parser';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.enableCors({
    origin: ['http://localhost:5173', 'http://localhost'], // 여러 출처 허용
    credentials: true,
  });

  app.use(cookieParser());

  const config = new DocumentBuilder()
    .setTitle('마이소호 백오피스 API')
    .setDescription('마이소호 백오피스 API 문서')
    .setVersion('1.0')
    .addCookieAuth('refreshToken')
    .addBearerAuth() // JWT 인증을 위한 Bearer Auth 추가
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  await app.listen(process.env.PORT ?? 3000);
  console.log(`애플리케이션이 다음 주소에서 실행 중입니다: ${await app.getUrl()}`);
  console.log(`Swagger UI는 다음 주소에서 사용할 수 있습니다: ${await app.getUrl()}/api`);
}
bootstrap();
