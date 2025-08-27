import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Menu } from './entities/menu.entity';
import { Manager } from '../manager/entities/manager.entity';

@Injectable()
export class MenusService {
  constructor(
    @InjectRepository(Menu)
    private readonly menusRepository: Repository<Menu>,
  ) {}

  async getMenusForManager(manager: Manager): Promise<Menu[]> {
    const allMenus = await this.menusRepository.find({
      order: { parent_id: 'ASC', menu_order: 'ASC' },
    });

    const userPermissions = new Set(
      manager.role.permissions.map((p) => p.prm_code),
    );

    const filterMenus = (menus: Menu[]): Menu[] => {
      return menus
        .filter(
          (menu) =>
            !menu.permission_code || userPermissions.has(menu.permission_code),
        )
        .map((menu) => ({
          ...menu,
          children: menu.children ? filterMenus(menu.children) : [],
        }));
    };

    const nestedMenus = this.buildMenuTree(allMenus);
    return filterMenus(nestedMenus);
  }

  private buildMenuTree(menus: Menu[]): Menu[] {
    const menuMap = new Map<number, Menu>();
    const rootMenus: Menu[] = [];

    menus.forEach((menu) => {
      menu.children = [];
      menuMap.set(menu.menu_id, menu);
    });

    menus.forEach((menu) => {
      if (menu.parent_id) {
        const parent = menuMap.get(menu.parent_id);
        if (parent) {
          parent.children.push(menu);
        }
      } else {
        rootMenus.push(menu);
      }
    });

    return rootMenus;
  }
}
