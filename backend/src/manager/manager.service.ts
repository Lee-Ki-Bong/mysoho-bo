import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Manager } from './entities/manager.entity';

@Injectable()
export class ManagerService {
  constructor(
    @InjectRepository(Manager)
    private readonly managerRepository: Repository<Manager>,
  ) {}

  async findOneByUserId(userId: string): Promise<Manager | null> {
    return this.managerRepository.findOne({
      where: { mng_user: userId },
      relations: {
        role: {
          permissions: true,
        },
      },
    });
  }
}
