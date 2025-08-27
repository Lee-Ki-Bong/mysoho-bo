import { Permission } from '../../permissions/entities/permission.entity';
import {
  Entity,
  PrimaryColumn,
  Column,
  CreateDateColumn,
  ManyToMany,
  JoinTable,
} from 'typeorm';

@Entity('roles')
export class Role {
  @PrimaryColumn({ length: 20 })
  role_code: string;

  @Column({ length: 50 })
  role_name: string;

  @Column({ length: 255, nullable: true })
  role_desc: string;

  @CreateDateColumn()
  created_at: Date;

  @ManyToMany(() => Permission) // eager: true 제거
  @JoinTable({
    name: 'role_permissions',
    joinColumn: { name: 'role_code', referencedColumnName: 'role_code' },
    inverseJoinColumn: {
      name: 'permission_code',
      referencedColumnName: 'prm_code',
    },
  })
  permissions: Permission[];
}
