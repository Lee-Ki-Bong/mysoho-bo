import { Controller, Get, UseGuards, Req } from '@nestjs/common';
import { MenusService } from './menus.service';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { PermissionsGuard } from '../permissions/permissions.guard';
import { Permissions } from '../permissions/permissions.decorator';
import { Manager } from '../manager/entities/manager.entity';

@ApiTags('menus')
@ApiBearerAuth()
@Controller('menus')
export class MenusController {
  constructor(private readonly menusService: MenusService) {}

  @Get()
  @UseGuards(AuthGuard('jwt'), PermissionsGuard)
  @Permissions('menu:read') // 메뉴 시스템을 보기 위한 기본 권한
  @ApiOperation({ summary: '로그인된 관리자의 메뉴 구조 가져오기' })
  @ApiResponse({
    status: 200,
    description: '관리자 역할에 따른 메뉴 구조를 반환합니다.',
  })
  getMenus(@Req() req: { user: Manager }) {
    return this.menusService.getMenusForManager(req.user);
  }
}
