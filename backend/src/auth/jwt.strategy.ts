import { Injectable, UnauthorizedException } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { ConfigService } from '@nestjs/config';
import { ManagerService } from '../manager/manager.service';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(
    private readonly configService: ConfigService,
    private readonly managerService: ManagerService,
  ) {
    const secret = configService.get('JWT_SECRET');
    if (!secret) {
      throw new Error('JWT_SECRET이 환경 변수에 정의되어 있지 않습니다.');
    }
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: secret,
    });
  }

  async validate(payload: any) {
    // 이 전략은 이제 관리자를 처리합니다.
    if (payload.type === 'manager') {
      const manager = await this.managerService.findOneByUserId(payload.username);
      if (!manager) {
        throw new UnauthorizedException();
      }
      // 전체 관리자 객체가 request.user에 첨부됩니다.
      return manager;
    }

    // 필요한 경우 여기에 다른 사용자 유형(예: 'admin')에 대한 로직을 추가할 수 있습니다.
    // 현재는 백오피스용 관리자만 처리합니다.
    throw new UnauthorizedException('토큰에 유효하지 않은 사용자 유형이 있습니다.');
  }
}

