import { NavLink } from 'react-router-dom'
import { ChevronRight, type LucideIcon } from 'lucide-react'

import { Collapsible, CollapsibleContent, CollapsibleTrigger } from '@/components/ui/collapsible'
import {
  SidebarGroup,
  SidebarMenu,
  SidebarMenuAction,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarMenuSub,
  SidebarMenuSubButton,
  SidebarMenuSubItem,
} from '@/components/ui/sidebar'
import { useBreadcrumbStore } from '@/shared/stores/breadcrumb'

type NavLeaf = { title: string; url: string }
type NavGroup = {
  title: string
  url: string
  icon: LucideIcon
  isActive?: boolean
  items?: NavLeaf[]
}

const normalize = (u: string) => (!u || u === '#' ? '#' : u.startsWith('/') ? u : `/${u}`)

export function NavMain({ items }: { items: NavGroup[] }) {
  const active = useBreadcrumbStore(s => s.active)
  const labelLine = active?.leaf ? active.leaf.title : ''
  console.log(labelLine)

  return (
    <SidebarGroup>
      <SidebarMenu>
        {items.map(item => {
          const hasChildren = !!item.items?.length
          const Icon = item.icon

          // 하위가 있는 "그룹" — 행 전체를 누르면 펼치기/접기
          if (hasChildren) {
            return (
              <Collapsible key={item.title} asChild defaultOpen={item.isActive}>
                <SidebarMenuItem>
                  {/* 행 전체(버튼)를 트리거로 */}
                  <CollapsibleTrigger asChild>
                    <SidebarMenuButton asChild tooltip={item.title}>
                      <button type='button' className='w-full text-left'>
                        <Icon />
                        <span>{item.title}</span>
                      </button>
                    </SidebarMenuButton>
                  </CollapsibleTrigger>

                  {/* 보조 트리거: > 아이콘 (회전 유지) */}
                  <CollapsibleTrigger asChild>
                    <SidebarMenuAction className='transition-transform data-[state=open]:rotate-90'>
                      <ChevronRight />
                      <span className='sr-only'>Toggle</span>
                    </SidebarMenuAction>
                  </CollapsibleTrigger>
                  <CollapsibleContent>
                    <SidebarMenuSub>
                      {item.items!.map(sub => (
                        <SidebarMenuSubItem key={sub.title}>
                          <SidebarMenuSubButton asChild>
                            {sub.url !== '#' ? (
                              <NavLink
                                to={normalize(sub.url)}
                                end
                                className={
                                  labelLine === sub.title
                                    ? 'bg-accent text-accent-foreground font-medium rounded-md shadow-sm'
                                    : undefined
                                }
                              >
                                <span>{sub.title}</span>
                              </NavLink>
                            ) : (
                              <div className='cursor-default'>
                                <span>{sub.title}</span>
                              </div>
                            )}
                          </SidebarMenuSubButton>
                        </SidebarMenuSubItem>
                      ))}
                    </SidebarMenuSub>
                  </CollapsibleContent>
                </SidebarMenuItem>
              </Collapsible>
            )
          }

          // 하위가 없는 "리프" — 링크 이동
          return (
            <SidebarMenuItem key={item.title}>
              <SidebarMenuButton asChild tooltip={item.title}>
                {item.url !== '#' ? (
                  <NavLink
                    to={normalize(item.url)}
                    end
                    className={({ isActive }) =>
                      isActive ? 'font-semibold text-primary' : undefined
                    }
                  >
                    <Icon />
                    <span>{item.title}</span>
                  </NavLink>
                ) : (
                  <div className='cursor-default'>
                    <Icon />
                    <span>{item.title}</span>
                  </div>
                )}
              </SidebarMenuButton>
            </SidebarMenuItem>
          )
        })}
      </SidebarMenu>
    </SidebarGroup>
  )
}
