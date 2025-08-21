import { Entity, PrimaryGeneratedColumn, Column } from 'typeorm';

@Entity('inquires')
export class Inquires {
    @PrimaryGeneratedColumn({ name: 'q_no' })
    q_no: number;

    @Column({ name: 'q_qsc_status' })
    q_qsc_status: string;

    @Column({ type: 'datetime', name: 'q_insert_date' })
    q_insert_date: Date;
}
