// src/config/nav.ts
import { ChartLine, Users, type LucideIcon } from 'lucide-react'

export type ShadcnNavLeaf = {
  title: string
  url: string
}

export type ShadcnNavGroup = {
  title: string
  url: string // '#' 이면 섹션
  icon: LucideIcon // 부모만 icon 보유
  isActive?: boolean
  items?: ShadcnNavLeaf[] // 자식은 {title,url}만
}

export const navMain: ShadcnNavGroup[] = [
  {
    title: '통계',
    url: '#',
    icon: ChartLine,
    isActive: false,
    items: [
      {
        title: '매출',
        url: 'dashboard',
      },
      {
        title: '검색',
        url: '#',
      },
    ],
  },
  {
    title: '상점',
    url: '#',
    icon: Users,
    isActive: false,
    items: [
      {
        title: '상점 리스트',
        url: 'shoplist',
      },
      {
        title: '회원',
        url: '#',
      },
    ],
  },
]
