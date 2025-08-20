import { Entity, PrimaryColumn, Column, OneToOne, JoinColumn } from 'typeorm';
import { Admin } from './admin.entity';

@Entity('admin_search')
export class AdminSearch {
  @PrimaryColumn({ name: 'as_adm_id' })
  as_adm_id: string;

  @Column({ name: 'as_shop_name' })
  as_shop_name: string;

  @Column({ name: 'as_biz_company_name' })
  as_biz_company_name: string;

  @Column({ name: 'as_biz_status' })
  as_biz_status: string;

  @Column({ name: 'as_biz_type' })
  as_biz_type: string;

  @Column({ name: 'as_biz_num' })
  as_biz_num: string;

  @Column({ name: 'as_pg_use' })
  as_pg_use: 'N' | 'Y';

  @Column({ name: 'as_pg_confirm_date' })
  as_pg_confirm_date: Date;

  @Column({ name: 'as_pg_set_date' })
  as_pg_set_date: Date;

  @Column({ name: 'as_sms_cnt' })
  as_sms_cnt: number;

  @Column({ name: 'as_price_total' })
  as_price_total: number;

  @Column({ name: 'as_price_bank' })
  as_price_bank: number;

  @Column({ name: 'as_price_pg' })
  as_price_pg: number;

  @Column({ name: 'as_prd_cnt' })
  as_prd_cnt: number;

  @Column({ name: 'as_user_cnt' })
  as_user_cnt: number;

  @Column({ name: 'as_advertise_agree' })
  as_advertise_agree: 'N' | 'Y';

  @Column({ name: 'as_mobile_skin' })
  as_mobile_skin: string;

  @Column({ name: 'as_pc_skin' })
  as_pc_skin: string;

  @Column({ name: 'as_users_display' })
  as_users_display: 'N' | 'Y';

  @Column({ name: 'as_is_total_sales_limit' })
  as_is_total_sales_limit: 'N' | 'Y';

  @Column({ name: 'advertised_at' })
  advertised_at: Date;

  @Column({ name: 'created_at' })
  created_at: Date;

  @Column({ name: 'updated_at' })
  updated_at: Date;

  @OneToOne(() => Admin)
  @JoinColumn({ name: 'as_adm_id', referencedColumnName: 'adm_id' })
  admin: Admin;
}
