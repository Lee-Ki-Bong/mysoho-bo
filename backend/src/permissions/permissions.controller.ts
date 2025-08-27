import { Controller, Get, UseGuards } from '@nestjs/common';
import { PermissionsService } from './permissions.service';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { PermissionsGuard } from './permissions.guard';
import { Permissions } from './permissions.decorator';

@ApiTags('permissions')
@ApiBearerAuth()
@Controller('permissions')
export class PermissionsController {
  constructor(private readonly permissionsService: PermissionsService) {}

  @Get()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('system:permission:manage')
  @ApiOperation({ summary: '사용 가능한 모든 권한 가져오기' })
  @ApiResponse({
    status: 200,
    description: '모든 권한 목록을 반환합니다.',
  })
  findAll() {
    return this.permissionsService.findAll();
  }
}
