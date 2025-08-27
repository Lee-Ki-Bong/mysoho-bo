import { Injectable, UnauthorizedException, NotFoundException } from '@nestjs/common';
import { ManagerService } from '../manager/manager.service';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private readonly managerService: ManagerService,
    private readonly jwtService: JwtService,
  ) {}

  async issueManagerSsoToken(userId: string) {
    const manager = await this.managerService.findOneByUserId(userId);
    if (!manager) {
      throw new NotFoundException(`사용자 ID가 ${userId}인 관리자를 찾을 수 없습니다.`);
    }
    const payload = { username: manager.mng_user, sub: manager.mng_id, type: 'manager' };
    return this.getTokens(payload);
  }

  async refreshToken(token: string) {
    try {
      const payload = await this.jwtService.verifyAsync(token, {
        secret: process.env.JWT_REFRESH_SECRET,
      });

      if (payload.type !== 'manager') {
        throw new UnauthorizedException('유효하지 않은 토큰 타입입니다.');
      }

      const newPayload = { username: payload.username, sub: payload.sub, type: 'manager' };
      return {
        accessToken: this.jwtService.sign(newPayload, {
          secret: process.env.JWT_SECRET,
          expiresIn: '15m',
        }),
      };
    } catch (e) {
      throw new UnauthorizedException('유효하지 않은 리프레시 토큰입니다.');
    }
  }

  private async getTokens(payload: { username: string; sub: number; type: string }) {
    const accessToken = this.jwtService.sign(payload, {
      secret: process.env.JWT_SECRET,
      expiresIn: '15m',
    });
    const refreshToken = this.jwtService.sign(payload, {
      secret: process.env.JWT_REFRESH_SECRET,
      expiresIn: '7d',
    });

    return {
      accessToken,
      refreshToken,
    };
  }
}
