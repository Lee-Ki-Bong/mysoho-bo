import { Controller, Post, Res, Req, Body, Get, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import express from 'express';
import {
  ApiOperation,
  ApiResponse,
  ApiTags,
  ApiBody,
  ApiProperty,
  ApiBearerAuth,
  ApiCookieAuth,
} from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';
import { Manager } from '../manager/entities/manager.entity';

class ManagerSsoLoginDto {
  @ApiProperty({ description: 'SSO로부터 받은 관리자 사용자 ID' })
  userId: string;
}

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('manager/sso-login')
  @ApiOperation({ summary: '관리자 SSO 로그인 및 토큰 발급' })
  @ApiBody({ type: ManagerSsoLoginDto })
  @ApiResponse({
    status: 201,
    description: '관리자 SSO 인증 성공 후 토큰을 발급합니다.',
    headers: {
      'Set-Cookie': {
        description: 'http-only 쿠키에 리프레시 토큰이 포함되어 있습니다.',
        schema: {
          type: 'string',
          example: 'refreshToken=...; Path=/; HttpOnly; SameSite=Lax',
        },
      },
    },
  })
  async ssoLogin(
    @Body() ssoLoginDto: ManagerSsoLoginDto,
    @Res({ passthrough: true }) res: express.Response,
  ) {
    const { accessToken, refreshToken } = await this.authService.issueManagerSsoToken(
      ssoLoginDto.userId,
    );

    res.cookie('refreshToken', refreshToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: process.env.NODE_ENV === 'production' ? 'none' : 'lax',
      path: '/',
    });

    return { accessToken };
  }

  @Post('manager/refresh')
  @ApiCookieAuth('refreshToken')
  @ApiOperation({ summary: '관리자 액세스 토큰 갱신' })
  @ApiResponse({
    status: 200,
    description: '관리자를 위한 새로운 액세스 토큰을 발급합니다.',
  })
  async refresh(@Req() req: express.Request) {
    const refreshToken = req.cookies['refreshToken'];
    return this.authService.refreshToken(refreshToken);
  }

  @Get('manager/me')
  @UseGuards(AuthGuard('jwt'))
  @ApiBearerAuth()
  @ApiOperation({ summary: '로그인된 관리자 프로필 가져오기' })
  @ApiResponse({
    status: 200,
    description: '역할 및 권한을 포함한 관리자 프로필을 반환합니다.',
  })
  getProfile(@Req() req: { user: Manager }) {
    // req.user는 JwtStrategy에 의해 채워집니다
    return req.user;
  }
}
