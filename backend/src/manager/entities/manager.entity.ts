import { Role } from '../../roles/entities/role.entity';
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
  ManyToOne,
  JoinColumn,
} from 'typeorm';

@Entity('manager')
export class Manager {
  @PrimaryGeneratedColumn()
  mng_id: number;

  @Column({ length: 30 })
  mng_user: string;

  @Column({ length: 15 })
  mng_ip: string;

  @Column({ length: 20 })
  mng_name: string;

  @Column({ length: 20 })
  mng_part: string;

  @Column({ length: 20 })
  mng_group: string;

  @Column({ type: 'text' })
  mng_desc: string;

  @Column({ type: 'enum', enum: ['active', 'disable'] })
  mng_status: 'active' | 'disable';

  @Column()
  mng_last_connection: Date;

  @CreateDateColumn()
  created_at: Date;

  @UpdateDateColumn()
  updated_at: Date;

  @Column({ length: 20, nullable: true })
  role_code: string;

  @ManyToOne(() => Role) // eager: true 제거
  @JoinColumn({ name: 'role_code' })
  role: Role;
}
