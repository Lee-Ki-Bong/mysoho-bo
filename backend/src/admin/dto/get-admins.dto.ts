import { ApiProperty } from '@nestjs/swagger';
import { IsOptional, IsString, IsNumberString } from 'class-validator';

export class GetAdminsDto {
  @ApiProperty({ required: false, description: '페이지 번호', default: 1 })
  @IsOptional()
  @IsNumberString()
  page?: string;

  @ApiProperty({ required: false, description: '검색 키워드' })
  @IsOptional()
  @IsString()
  keyword?: string;
}
