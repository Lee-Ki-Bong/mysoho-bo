import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Brackets } from 'typeorm';
import { Admin } from './entities/admin.entity';
import { GetAdminsDto } from './dto/get-admins.dto';
import { AdminSalesStatistic } from './entities/admin_sales_statistic.entity';
import { Inquires } from './entities/inquires.entity';
import { AdminPg } from './entities/admin_pg.entity';
import { plainToInstance } from 'class-transformer';
import { AdminListItemDto } from './dto/admin-list-item.dto';
import { AdminListResponseDto } from './dto/admin-list-response.dto';


// ---- Explicit return contracts ----
export interface DashboardStats {
    adminStats: { total: number; newToday: number };
    salesStats: { totalRevenue: number; totalOrders: number };
    pgUsers: number;
    pendingInquiries: number;
}

@Injectable()
export class AdminService {
    private static readonly DEFAULT_TAKE = 30;

    constructor(
        @InjectRepository(Admin)
        private readonly adminRepository: Repository<Admin>,
        @InjectRepository(AdminSalesStatistic)
        private readonly salesRepository: Repository<AdminSalesStatistic>,
        @InjectRepository(Inquires)
        private readonly inquiresRepository: Repository<Inquires>,
        @InjectRepository(AdminPg)
        private readonly adminPgRepository: Repository<AdminPg>,
    ) { }

    /**
     * 대시보드 통계 집계
     * - 인덱스 친화적 범위 조건(CURRENT_DATE ~ +1day)
     * - 합계 결과는 Number()로 안전 변환
     */
    async getDashboardStats(): Promise<DashboardStats> {
        const [totalAdmins, newAdminsToday, todaySales, pgUsers, pendingInquiries] =
            await Promise.all([
                // 전체 관리자 수
                this.adminRepository.count(),

                // 오늘 신규 관리자 수 (DATE() 사용 지양, 범위 조건으로 인덱스 활용)
                this.adminRepository
                    .createQueryBuilder('admin')
                    .where(
                        'admin.created_at >= CURRENT_DATE AND admin.created_at < DATE_ADD(CURRENT_DATE, INTERVAL 1 DAY)',
                    )
                    .getCount(),

                // 오늘 매출/주문 합계 (컬럼이 DATE이면 = CURRENT_DATE로 집계)
                this.salesRepository
                    .createQueryBuilder('sales')
                    .select('COALESCE(SUM(sales.ass_shop_total_price), 0)', 'totalRevenue')
                    .addSelect('COALESCE(SUM(sales.ass_total_cnt), 0)', 'totalOrders')
                    .where('sales.std_date = CURRENT_DATE')
                    .getRawOne<{ totalRevenue: string | null; totalOrders: string | null }>(),

                // 사용중인 PG 가맹점 수
                this.adminPgRepository.count({ where: { ap_use: 'Y' } }),

                // 미답변 문의 수
                this.inquiresRepository.count({ where: { q_qsc_status: 'W' } }),
            ]);

        const totalRevenue = Number(todaySales?.totalRevenue ?? 0);
        const totalOrders = Number(todaySales?.totalOrders ?? 0);

        return {
            adminStats: {
                total: totalAdmins,
                newToday: newAdminsToday,
            },
            salesStats: {
                totalRevenue,
                totalOrders,
            },
            pgUsers,
            pendingInquiries,
        };
    }

    /**
     * 관리자 목록 조회 (검색 & 페이징)
     * - keyword trim, 단일 파라미터 바인딩(:kw) 재사용
     * - 페이지 보정 및 take 고정
     */
    async findAll(getAdminsDto: GetAdminsDto): Promise<AdminListResponseDto> {
        const take = AdminService.DEFAULT_TAKE;
        const pageNum = Math.max(1, Number.parseInt(getAdminsDto.page ?? '1', 10) || 1);
        const skip = (pageNum - 1) * take;
        const keyword = (getAdminsDto.keyword ?? '').trim();

        const qb = this.adminRepository
            .createQueryBuilder('admin')
            .leftJoin('admin.adminSns', 'adminSns');

        if (keyword.length > 0) {
            qb.where(
                new Brackets((kw) => {
                    kw.where('admin.adm_id LIKE :kw', { kw: `%${keyword}%` })
                        .orWhere('admin.adm_name LIKE :kw', { kw: `%${keyword}%` })
                        .orWhere('admin.adm_email LIKE :kw', { kw: `%${keyword}%` })
                        .orWhere('adminSns.as_id LIKE :kw', { kw: `%${keyword}%` });
                }),
            );
        }

        const [admins, total] = await qb
            .orderBy('admin.adm_seq', 'DESC')
            .skip(skip)
            .take(take)
            .getManyAndCount();

        const items = admins.map((admin, i) => ({
            // 여기서는 '엔티티 -> 평문'으로 필요한 필드만 만든 뒤
            // DTO로 변환하는 게 가장 안전
            no: total - skip - i,
            adm_seq: admin.adm_seq,
            adm_id: admin.adm_id,
            adm_name: admin.adm_name,
            adm_email: admin.adm_email,
            registrationType: admin.registrationType, // 혹은 규칙에 맞게 계산
        }));

        return {
            data: plainToInstance(AdminListItemDto, items, { excludeExtraneousValues: true }),
            meta: { total, page: pageNum, last_page: Math.ceil(total / take), take },
        };
    }

    /**
     * 단건 조회: 관련 연관관계 eager-load
     */
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
            throw new NotFoundException(`Admin not found: ${id}`);
        }

        return admin;
    }
}
