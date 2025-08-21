import { Expose } from 'class-transformer';
import { ApiProperty } from '@nestjs/swagger';

export class AdminListItemDto {
  @ApiProperty({ description: '번호' }) @Expose() no!: number;
  @ApiProperty({ description: '관리자 순번' }) @Expose() adm_seq!: number;
  @ApiProperty({ description: '관리자 아이디' }) @Expose() adm_id!: string;
  @ApiProperty({ description: '관리자 이름' }) @Expose() adm_name!: string;
  @ApiProperty({ description: '관리자 이메일' }) @Expose() adm_email!: string;
  @ApiProperty({ description: '가입 유형', enum: ['SNS', 'NORMAL'] }) @Expose()
  registrationType!: 'SNS' | 'NORMAL';
  // 필요 필드만 노출 (민감정보 제외)
}

export class AdminListResponseDto {
    @ApiProperty({ type: [AdminListItemDto] })
    data!: AdminListItemDto[];

    @ApiProperty()
    meta!: { total: number; page: number; last_page: number; take: number };
}