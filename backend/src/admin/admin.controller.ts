import {
    Controller,
    Get,
    Param,
    Query,
    UseGuards,
    ValidationPipe,
} from '@nestjs/common';
import { AdminService } from './admin.service';
import { GetAdminsDto } from './dto/get-admins.dto';
import {
    ApiBearerAuth,
    ApiOperation,
    ApiResponse,
    ApiTags,
} from '@nestjs/swagger';
import { Admin } from './entities/admin.entity';
import { DashboardResponseDto } from './dto/dashboard-response.dto';
import { AuthGuard } from '@nestjs/passport';
import { AdminListResponseDto } from './dto/admin-list-item.dto';

@ApiTags('admin')
@ApiBearerAuth() // 이 컨트롤러의 모든 API에 Bearer Auth 적용
@UseGuards(AuthGuard('jwt')) // 이 컨트롤러의 모든 API에 JWT 가드 적용
@Controller('admin')
export class AdminController {
    constructor(private readonly adminService: AdminService) {}

    @Get('dashboard')
    @ApiOperation({ summary: '대시보드 통계 조회' })
    @ApiResponse({
        status: 200,
        description: '대시보드 통계를 반환합니다.',
        type: DashboardResponseDto,
    })
    getDashboardStats() {
        return this.adminService.getDashboardStats();
    }

    @Get()
    @ApiOperation({ summary: '관리자 목록 조회 (페이징 및 검색)' })
    @ApiResponse({ status: 200, description: '관리자 목록을 반환합니다.', type: AdminListResponseDto })
    findAll(
        @Query(new ValidationPipe({ transform: true }))
        getAdminsDto: GetAdminsDto,
    ) {
        return this.adminService.findAll(getAdminsDto);
    }

    @Get(':id')
    @ApiOperation({ summary: 'ID로 단일 관리자 조회' })
    @ApiResponse({
        status: 200,
        description: '단일 관리자 정보를 반환합니다.',
        type: Admin,
    })
    @ApiResponse({ status: 404, description: '관리자를 찾을 수 없습니다.' })
    findOne(@Param('id') id: string) {
        return this.adminService.findOne(id);
    }
}
