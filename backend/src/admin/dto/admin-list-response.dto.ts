import { ApiProperty } from '@nestjs/swagger';
import { AdminListItemDto } from './admin-list-item.dto';

export class AdminListResponseDto {
  @ApiProperty({ description: '관리자 목록', type: [AdminListItemDto] })
  data!: AdminListItemDto[];

  @ApiProperty({
    description: '페이지네이션 정보',
    example: {
      total: 100,
      page: 1,
      last_page: 10,
      take: 10,
    },
  })
  meta!: { total: number; page: number; last_page: number; take: number };
}