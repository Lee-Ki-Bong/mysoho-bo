import { Controller, Post, Res } from '@nestjs/common';
import { AuthService } from './auth.service';
import express from 'express';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
    constructor(private readonly authService: AuthService) {}

    @Post('guest')
    @ApiOperation({ summary: '이슈 게스트 토큰' })
    @ApiResponse({
        status: 201,
        description: '게스트 액세스 및 리프레시 토큰을 발급합니다.',
    })
    async issueGuestToken(@Res({ passthrough: true }) res: express.Response) {
        const { accessToken, refreshToken } =
            await this.authService.generateGuestTokens();

        res.cookie('refreshToken', refreshToken, {
            httpOnly: true,
            secure: process.env.NODE_ENV === 'production', // 프로덕션에서만 true
            sameSite: process.env.NODE_ENV === 'production' ? 'none' : 'lax', // 프로덕션에서만 none
            path: '/',
        });

        return { accessToken };
    }
}
