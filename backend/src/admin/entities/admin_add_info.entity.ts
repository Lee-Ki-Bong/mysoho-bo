import { Entity, PrimaryColumn, Column, OneToOne, JoinColumn } from 'typeorm';
import { Admin } from './admin.entity';

@Entity('admin_add_info')
export class AdminAddInfo {
    @PrimaryColumn({ name: 'aai_adm_seq' })
    aai_adm_seq: number;

    @Column({ name: 'aai_bank_uid' })
    aai_bank_uid: string;

    @Column({ name: 'aai_bank_number' })
    aai_bank_number: string;

    @Column({ name: 'aai_bank_owner' })
    aai_bank_owner: string;

    @OneToOne(() => Admin)
    @JoinColumn({ name: 'aai_adm_seq', referencedColumnName: 'adm_seq' })
    admin: Admin;
}
