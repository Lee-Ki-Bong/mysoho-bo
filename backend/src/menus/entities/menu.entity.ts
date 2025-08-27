import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, JoinColumn } from 'typeorm';

@Entity('menus')
export class Menu {
  @PrimaryGeneratedColumn()
  menu_id: number;

  @Column({ nullable: true })
  parent_id: number;

  @Column({ length: 50 })
  menu_name: string;

  @Column({ length: 100, nullable: true })
  menu_path: string;

  @Column()
  menu_order: number;

  @Column({ length: 30, nullable: true })
  permission_code: string;

  @ManyToOne(() => Menu, (menu) => menu.children)
  @JoinColumn({ name: 'parent_id' })
  parent: Menu;

  @OneToMany(() => Menu, (menu) => menu.parent)
  children: Menu[];
}
