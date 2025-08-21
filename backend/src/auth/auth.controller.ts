import { Controller, Post, Res, Req, Body } from '@nestjs/common';
import { AuthService } from './auth.service';
import express from 'express';
import {
  ApiOperation,
  ApiResponse,
  ApiTags,
  ApiBody,
  ApiProperty,
} from '@nestjs/swagger';

class SsoLoginDto {
  @ApiProperty({ description: 'Admin ID' })
  adm_id: string;
}

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('sso-login')
  @ApiOperation({ summary: 'SSO 로그인 및 토큰 발급' })
  @ApiBody({ type: SsoLoginDto })
  @ApiResponse({
    status: 201,
    description: 'SSO 인증 성공 후 액세스 및 리프레시 토큰을 발급합니다.',
  })
  async ssoLogin(
    @Body() ssoLoginDto: SsoLoginDto,
    @Res({ passthrough: true }) res: express.Response,
  ) {
    const { accessToken, refreshToken } = await this.authService.ssoLogin(
      ssoLoginDto.adm_id,
    );

    res.cookie('refreshToken', refreshToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: process.env.NODE_ENV === 'production' ? 'none' : 'lax',
      path: '/',
    });

    return { accessToken };
  }

  @Post('guest')
  @ApiOperation({ summary: '게스트 토큰 발급 (테스트용)' })
  @ApiResponse({
    status: 201,
    description: '게스트 액세스 및 리프레시 토큰을 발급합니다.',
  })
  async issueGuestToken(@Res({ passthrough: true }) res: express.Response) {
    const { accessToken, refreshToken } = await this.authService.guestLogin();

    res.cookie('refreshToken', refreshToken, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production', // 프로덕션에서만 true
      sameSite: process.env.NODE_ENV === 'production' ? 'none' : 'lax', // 프로덕션에서만 none
      path: '/',
    });

    return { accessToken };
  }

  @Post('refresh')
  @ApiOperation({ summary: '액세스 토큰 갱신' })
  @ApiResponse({
    status: 200,
    description: '새로운 액세스 토큰을 발급합니다.',
  })
  async refresh(@Req() req: express.Request) {
    const refreshToken = req.cookies['refreshToken'];
    return this.authService.refreshToken(refreshToken);
  }
}
