import { ApiProperty } from '@nestjs/swagger';

class AdminStatsDto {
  @ApiProperty({ description: '총 관리자 수', example: 19647 })
  total: number;

  @ApiProperty({ description: '오늘 가입한 신규 관리자 수', example: 5 })
  newToday: number;
}

class SalesStatsDto {
  @ApiProperty({ description: '오늘의 총 매출', example: 1234567 })
  totalRevenue: number;

  @ApiProperty({ description: '오늘의 총 주문 건수', example: 89 })
  totalOrders: number;
}

export class DashboardResponseDto {
  @ApiProperty()
  adminStats: AdminStatsDto;

  @ApiProperty()
  salesStats: SalesStatsDto;

  @ApiProperty({ description: 'PG 사용 상점 수', example: 8500 })
  pgUsers: number;

  @ApiProperty({ description: '처리 대기중인 문의 수', example: 15 })
  pendingInquiries: number;
}
