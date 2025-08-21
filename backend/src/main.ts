import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import cookieParser from 'cookie-parser';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.enableCors({
    origin: ['http://localhost:5173', 'http://localhost'], // 여러 오리진 허용
    credentials: true,
  });

  app.use(cookieParser());

  const config = new DocumentBuilder()
    .setTitle('마이소호 백오피스 API')
    .setDescription('마이소호 백오피스 API 문서')
    .setVersion('1.0')
    .addBearerAuth() // JWT 인증을 위한 Bearer Auth 추가
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  await app.listen(process.env.PORT ?? 3000);
  console.log(`Application is running on: ${await app.getUrl()}`);
  console.log(`Swagger UI is available at: ${await app.getUrl()}/api`);
  console.log('Guest token can be obtained from POST /auth/guest');
}
bootstrap();
