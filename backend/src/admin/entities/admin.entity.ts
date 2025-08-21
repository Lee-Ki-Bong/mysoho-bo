import { ApiProperty } from '@nestjs/swagger';
import {
    Entity,
    PrimaryGeneratedColumn,
    Column,
    OneToOne,
    OneToMany,
    AfterLoad,
} from 'typeorm';
import { AdminAddInfo } from './admin_add_info.entity';
import { AdminPg } from './admin_pg.entity';
import { AdminSearch } from './admin_search.entity';
import { AdminSns } from './admin_sns.entity';
import { AdminServerInfo } from './admin_server_info.entity';

@Entity('admin')
export class Admin {
    @ApiProperty()
    @PrimaryGeneratedColumn({ name: 'adm_seq' })
    adm_seq: number;

    @ApiProperty()
    @Column({ name: 'adm_id', unique: true })
    adm_id: string;

    @ApiProperty()
    @Column({ name: 'adm_ci' })
    adm_ci: string;

    @ApiProperty({ enum: ['N', 'Y'] })
    @Column({ name: 'adm_ms_integrated' })
    adm_ms_integrated: 'N' | 'Y';

    @ApiProperty()
    @Column({ name: 'adm_ms_integrated_id' })
    adm_ms_integrated_id: string;

    @ApiProperty()
    @Column({ name: 'adm_ms_member_key' })
    adm_ms_member_key: string;

    @ApiProperty()
    @Column({ name: 'adm_name' })
    adm_name: string;

    @ApiProperty()
    @Column({ name: 'adm_phone' })
    adm_phone: string;

    @ApiProperty()
    @Column({ name: 'adm_email' })
    adm_email: string;

    @ApiProperty()
    @Column({ name: 'adm_domain' })
    adm_domain: string;

    @ApiProperty()
    @Column({ name: 'adm_join_path' })
    adm_join_path: string;

    @ApiProperty({ enum: ['N', 'Y'] })
    @Column({ name: 'adm_agree_provision' })
    adm_agree_provision: 'N' | 'Y';

    @ApiProperty({ enum: ['N', 'Y'] })
    @Column({ name: 'adm_agree_privacy' })
    adm_agree_privacy: 'N' | 'Y';

    @ApiProperty({ enum: ['N', 'Y'] })
    @Column({ name: 'adm_agree_third_person' })
    adm_agree_third_person: 'N' | 'Y';

    @ApiProperty()
    @Column({ name: 'adm_agree_third_person_update_at' })
    adm_agree_third_person_update_at: Date;

    @ApiProperty()
    @Column({ name: 'adm_recommend_id' })
    adm_recommend_id: string;

    @ApiProperty()
    @Column({ name: 'adm_ipv4' })
    adm_ipv4: string;

    @ApiProperty({ enum: ['DELETED', 'WAIT', 'TEST', 'LIVE', 'DORMANT'] })
    @Column({ name: 'adm_type' })
    adm_type: 'DELETED' | 'WAIT' | 'TEST' | 'LIVE' | 'DORMANT';

    @ApiProperty()
    @Column({ name: 'adm_join_group' })
    adm_join_group: string;

    @ApiProperty({ enum: ['N', 'Y'] })
    @Column({ name: 'adm_ssl' })
    adm_ssl: 'N' | 'Y';

    @ApiProperty()
    @Column({ name: 'adm_memo' })
    adm_memo: string;

    @ApiProperty()
    @Column({ name: 'adm_date_login' })
    adm_date_login: Date;

    @ApiProperty({ enum: ['N', 'Y'] })
    @Column({ name: 'adm_dormant_send' })
    adm_dormant_send: 'N' | 'Y';

    @ApiProperty({ enum: ['N', 'E', 'S'] })
    @Column({ name: 'adm_dormant_send_type' })
    adm_dormant_send_type: 'N' | 'E' | 'S';

    @ApiProperty()
    @Column({ name: 'adm_dormant_send_date' })
    adm_dormant_send_date: Date;

    @ApiProperty()
    @Column({ name: 'dormant_complete_date' })
    dormant_complete_date: Date;

    @ApiProperty()
    @Column({ name: 'dormant_cancel_date' })
    dormant_cancel_date: Date;

    @ApiProperty()
    @Column({ name: 'created_at' })
    created_at: Date;

    @ApiProperty()
    @Column({ name: 'expired_at' })
    expired_at: Date;

    @ApiProperty()
    @Column({ name: 'updated_at' })
    updated_at: Date;

    @ApiProperty({ enum: ['N', 'Y'] })
    @Column({ name: 'adm_agree_14years' })
    adm_agree_14years: 'N' | 'Y';

    @OneToOne(() => AdminAddInfo, (adminAddInfo) => adminAddInfo.admin)
    adminAddInfo: AdminAddInfo;

    @OneToMany(() => AdminPg, (adminPg) => adminPg.admin)
    adminPgs: AdminPg[];

    @OneToOne(() => AdminSearch, (adminSearch) => adminSearch.admin)
    adminSearch: AdminSearch;

    @OneToMany(() => AdminSns, (adminSns) => adminSns.admin)
    adminSns: AdminSns[];

    @OneToOne(() => AdminServerInfo, (adminServerInfo) => adminServerInfo.admin)
    adminServerInfo: AdminServerInfo;

    @ApiProperty({ enum: ['SNS', 'NORMAL'] })
    registrationType: 'SNS' | 'NORMAL';

    @AfterLoad()
    setRegistrationType() {
        this.registrationType =
            this.adminSns && this.adminSns.length > 0 ? 'SNS' : 'NORMAL';
    }
}
