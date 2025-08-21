import {
    Entity,
    PrimaryGeneratedColumn,
    Column,
    CreateDateColumn,
} from 'typeorm';

@Entity('admin_sales_statistic')
export class AdminSalesStatistic {
    @PrimaryGeneratedColumn({ name: 'ass_seq' })
    ass_seq: number;

    @Column({ name: 'ass_adm_id' })
    ass_adm_id: string;

    @Column({ name: 'ass_shop_total_price' })
    ass_shop_total_price: number;

    @Column({ name: 'ass_total_cnt' })
    ass_total_cnt: number;

    @Column({ type: 'date', name: 'std_date' })
    std_date: Date;
}
