import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Brackets, Raw } from 'typeorm';
import { Admin } from './entities/admin.entity';
import { GetAdminsDto } from './dto/get-admins.dto';
import { AdminSalesStatistic } from './entities/admin_sales_statistic.entity';
import { Inquires } from './entities/inquires.entity';
import { AdminPg } from './entities/admin_pg.entity';

@Injectable()
export class AdminService {
    constructor(
        @InjectRepository(Admin)
        private readonly adminRepository: Repository<Admin>,
        @InjectRepository(AdminSalesStatistic)
        private readonly salesRepository: Repository<AdminSalesStatistic>,
        @InjectRepository(Inquires)
        private readonly inquiresRepository: Repository<Inquires>,
        @InjectRepository(AdminPg)
        private readonly adminPgRepository: Repository<AdminPg>,
    ) {}

    async getDashboardStats() {
        const today = new Date().toISOString().slice(0, 10);

        const [totalAdmins, newAdminsToday] = await Promise.all([
            this.adminRepository.count(),
            this.adminRepository.count({
                where: {
                    created_at: Raw((alias) => `${alias} >= :date`, {
                        date: today,
                    }),
                },
            }),
        ]);

        const todaySales = await this.salesRepository
            .createQueryBuilder('sales')
            .select('SUM(sales.ass_shop_total_price)', 'totalRevenue')
            .addSelect('SUM(sales.ass_total_cnt)', 'totalOrders')
            .where('sales.std_date = :today', { today })
            .getRawOne();

        const [pgUsers, pendingInquiries] = await Promise.all([
            this.adminPgRepository.count({ where: { ap_use: 'Y' } }),
            this.inquiresRepository.count({ where: { q_qsc_status: 'W' } }),
        ]);

        return {
            adminStats: {
                total: totalAdmins,
                newToday: newAdminsToday,
            },
            salesStats: {
                totalRevenue: parseFloat(todaySales.totalRevenue) || 0,
                totalOrders: parseInt(todaySales.totalOrders, 10) || 0,
            },
            pgUsers,
            pendingInquiries,
        };
    }

    async findAll(getAdminsDto: GetAdminsDto) {
        const { page = '1', keyword } = getAdminsDto;
        const take = 30;
        const pageNum = parseInt(page, 10);
        const skip = (pageNum - 1) * take;

        const query = this.adminRepository
            .createQueryBuilder('admin')
            .leftJoin('admin.adminSns', 'adminSns');

        if (keyword) {
            query.where(
                new Brackets((qb) => {
                    qb.where('admin.adm_id LIKE :keyword', {
                        keyword: `%${keyword}%`,
                    })
                        .orWhere('admin.adm_name LIKE :keyword', {
                            keyword: `%${keyword}%`,
                        })
                        .orWhere('admin.adm_email LIKE :keyword', {
                            keyword: `%${keyword}%`,
                        })
                        .orWhere('adminSns.as_id LIKE :keyword', {
                            keyword: `%${keyword}%`,
                        });
                }),
            );
        }

        const [admins, total] = await query
            .orderBy('admin.adm_seq', 'DESC')
            .skip(skip)
            .take(take)
            .getManyAndCount();

        const data = admins.map((admin, index) => ({
            ...admin,
            no: total - skip - index,
        }));

        return {
            data,
            meta: {
                total,
                page: pageNum,
                last_page: Math.ceil(total / take),
            },
        };
    }

    async findOne(id: string): Promise<Admin> {
        const admin = await this.adminRepository
            .createQueryBuilder('admin')
            .leftJoinAndSelect('admin.adminAddInfo', 'adminAddInfo')
            .leftJoinAndSelect('admin.adminPgs', 'adminPgs')
            .leftJoinAndSelect('admin.adminSearch', 'adminSearch')
            .leftJoinAndSelect('admin.adminSns', 'adminSns')
            .leftJoinAndSelect('admin.adminServerInfo', 'adminServerInfo')
            .where('admin.adm_id = :id', { id })
            .getOne();

        if (!admin) {
            throw new NotFoundException(`Admin with ID ${id} not found`);
        }

        return admin;
    }
}
