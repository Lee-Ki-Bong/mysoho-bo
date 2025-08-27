import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from './auth/auth.module';
import { ManagerModule } from './manager/manager.module';
import { RolesModule } from './roles/roles.module';
import { PermissionsModule } from './permissions/permissions.module';
import { MenusModule } from './menus/menus.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',
      host: 'db',
      port: 3306,
      username: 'mysoho',
      password: '1234',
      database: 'bo_mysoho',
      entities: [__dirname + '/**/*.entity{.ts,.js}'],
      synchronize: false, // DB 스키마를 자동으로 동기화하지 않음
    }),
    AuthModule,
    ManagerModule,
    RolesModule,
    PermissionsModule,
    MenusModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
