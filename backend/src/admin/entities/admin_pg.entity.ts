import { Entity, PrimaryColumn, Column, ManyToOne, JoinColumn } from 'typeorm';
import { Admin } from './admin.entity';

@Entity('admin_pg')
export class AdminPg {
    @PrimaryColumn({ name: 'ap_adm_id' })
    ap_adm_id: string;

    @PrimaryColumn({ name: 'ap_code' })
    ap_code: string;

    @Column({ name: 'ap_use' })
    ap_use: 'N' | 'Y';

    @Column({ name: 'ap_status' })
    ap_status: string;

    @Column({ name: 'ap_manager_set_date' })
    ap_manager_set_date: Date;

    @Column({ name: 'confirmed_at' })
    confirmed_at: Date;

    @Column({ name: 'updated_at' })
    updated_at: Date;

    @Column({ name: 'created_at' })
    created_at: Date;

    @ManyToOne(() => Admin, (admin) => admin.adminPgs)
    @JoinColumn({ name: 'ap_adm_id', referencedColumnName: 'adm_id' })
    admin: Admin;
}
