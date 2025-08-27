import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Menu } from './entities/menu.entity';
import { MenusService } from './menus.service';
import { MenusController } from './menus.controller';
import { ManagerModule } from '../manager/manager.module';

@Module({
  imports: [TypeOrmModule.forFeature([Menu]), ManagerModule],
  providers: [MenusService],
  controllers: [MenusController],
})
export class MenusModule {}
