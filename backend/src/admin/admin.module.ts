import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AdminController } from './admin.controller';
import { AdminService } from './admin.service';
import { Admin } from './entities/admin.entity';
import { AdminAddInfo } from './entities/admin_add_info.entity';
import { AdminPg } from './entities/admin_pg.entity';
import { AdminSearch } from './entities/admin_search.entity';
import { AdminSns } from './entities/admin_sns.entity';
import { AdminServerInfo } from './entities/admin_server_info.entity';
import { AdminSalesStatistic } from './entities/admin_sales_statistic.entity';
import { Inquires } from './entities/inquires.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Admin,
      AdminAddInfo,
      AdminPg,
      AdminSearch,
      AdminSns,
      AdminServerInfo,
      AdminSalesStatistic,
      Inquires,
    ]),
  ],
  controllers: [AdminController],
  providers: [AdminService],
})
export class AdminModule {}
