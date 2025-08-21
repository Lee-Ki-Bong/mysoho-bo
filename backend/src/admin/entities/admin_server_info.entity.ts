import { Entity, PrimaryColumn, Column, OneToOne, JoinColumn } from 'typeorm';
import { Admin } from './admin.entity';

@Entity('admin_server_info')
export class AdminServerInfo {
    @PrimaryColumn({ name: 'asi_adm_seq' })
    asi_adm_seq: number;

    @Column({ name: 'asi_db_master_si_seq' })
    asi_db_master_si_seq: number;

    @Column({ name: 'asi_db_slave_si_seq' })
    asi_db_slave_si_seq: number;

    @Column({ name: 'asi_session_si_seq' })
    asi_session_si_seq: number;

    @Column({ name: 'asi_db' })
    asi_db: string;

    @OneToOne(() => Admin)
    @JoinColumn({ name: 'asi_adm_seq', referencedColumnName: 'adm_seq' })
    admin: Admin;
}
