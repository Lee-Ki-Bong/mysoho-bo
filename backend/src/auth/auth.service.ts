import { Injectable, UnauthorizedException, NotFoundException } from '@nestjs/common';
import { AdminService } from '../admin/admin.service';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(
    private readonly adminService: AdminService,
    private readonly jwtService: JwtService,
  ) {}

  async ssoLogin(adm_id: string) {
    const admin = await this.adminService.findOne(adm_id);
    if (!admin) {
      throw new NotFoundException(`Admin with ID ${adm_id} not found`);
    }
    const payload = { username: admin.adm_id, sub: admin.adm_seq };
    return this.getTokens(payload);
  }

  async guestLogin() {
    const payload = { username: 'guest', sub: 0 }; // Guest user
    return this.getTokens(payload);
  }

  async refreshToken(token: string) {
    try {
      const payload = await this.jwtService.verifyAsync(token, {
        secret: process.env.JWT_REFRESH_SECRET,
      });

      // Here you might want to check if the user still exists or is not blocked
      const newPayload = { username: payload.username, sub: payload.sub };
      return {
        accessToken: this.jwtService.sign(newPayload, {
          secret: process.env.JWT_SECRET,
          expiresIn: '15m',
        }),
      };
    } catch (e) {
      throw new UnauthorizedException('Invalid refresh token');
    }
  }

  private async getTokens(payload: { username: string; sub: number }) {
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
