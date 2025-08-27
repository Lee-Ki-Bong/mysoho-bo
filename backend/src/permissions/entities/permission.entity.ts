import { Entity, PrimaryColumn, Column, CreateDateColumn } from 'typeorm';

@Entity('permissions')
export class Permission {
  @PrimaryColumn({ length: 30 })
  prm_code: string;

  @Column({ length: 30 })
  prm_name: string;

  @Column({ length: 200 })
  prm_desc: string;

  @CreateDateColumn()
  created_at: Date;
}
