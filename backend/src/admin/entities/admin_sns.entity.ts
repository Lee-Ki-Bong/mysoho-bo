import { Entity, PrimaryColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { Admin } from './admin.entity';

@Entity('admin_sns')
export class AdminSns {
    @PrimaryColumn({ name: 'adm_id' })
    adm_id: string;

    @PrimaryColumn({ name: 'as_type' })
    as_type: string;

    @Column({ name: 'as_id' })
    as_id: string;

    @Column({ name: 'as_key' })
    as_key: string;

    @Column({ name: 'as_date' })
    as_date: Date;

    @ManyToOne(() => Admin, (admin) => admin.adminSns)
    @JoinColumn({ name: 'adm_id', referencedColumnName: 'adm_id' })
    admin: Admin;
}
