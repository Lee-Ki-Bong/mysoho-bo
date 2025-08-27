import { create } from 'zustand'
import type { ShadcnNavGroup, ShadcnNavLeaf } from '../config/nav'

export type Crumb = { label: string; href?: string }

type ActiveMenu = {
  path: string
  group?: { title: string; url?: string } // url: '#'이면 undefined
  leaf?: { title: string; url: string }
}

type BreadcrumbState = {
  items: Crumb[]
  active: ActiveMenu | null // ✅ 추가: 현재 활성 메뉴 상태
  set: (items: Crumb[]) => void
  /** shadcn Nav 구조 + 현재 경로로 crumbs + active 생성 */
  setFromShadcnNav: (nav: ShadcnNavGroup[], pathname: string) => void
  /** 마지막 항목 라벨만 교체 (페이지에서 동적 타이틀 바꿀 때) */
  setLabel: (label: string) => void
}

const normalize = (u: string) => (!u || u === '#' ? '#' : u.startsWith('/') ? u : `/${u}`)

const isMatch = (pathname: string, url: string) => {
  if (url === '#') return false
  const t = normalize(url)
  return pathname === t || pathname.startsWith(t + '/')
}

function findTrail(
  nav: ShadcnNavGroup[],
  pathname: string,
): { group: ShadcnNavGroup; leaf?: ShadcnNavLeaf } | null {
  for (const group of nav) {
    if (isMatch(pathname, group.url)) {
      return { group }
    }
    if (group.items?.length) {
      for (const leaf of group.items) {
        if (isMatch(pathname, leaf.url)) {
          return { group, leaf }
        }
      }
    }
  }
  return null
}

export const useBreadcrumbStore = create<BreadcrumbState>((set, get) => ({
  items: [{ label: 'Mysoho Back-office', href: '/' }],
  active: null,

  set: items => set({ items }),

  setFromShadcnNav: (nav, pathname) => {
    const trail = findTrail(nav, pathname)
    const crumbs: Crumb[] = [{ label: 'Mysoho Back-office', href: '/' }]
    const active: ActiveMenu = { path: pathname }

    if (trail) {
      // 그룹(섹션)
      const groupHref = trail.group.url !== '#' ? normalize(trail.group.url) : undefined
      crumbs.push({ label: trail.group.title, href: groupHref })
      active.group = { title: trail.group.title, url: groupHref }

      // leaf(현재 페이지)
      if (trail.leaf) {
        const leafHref = normalize(trail.leaf.url)
        crumbs.push({ label: trail.leaf.title, href: leafHref })
        active.leaf = { title: trail.leaf.title, url: leafHref }
      }

      // 마지막은 현재 페이지 → 링크 제거
      const last = crumbs[crumbs.length - 1]
      crumbs[crumbs.length - 1] = { ...last, href: undefined }
    } else {
      // nav에 없을 때의 안전한 폴백 (URL 세그먼트로 생성)
      const parts = pathname.split('/').filter(Boolean)
      let acc = ''
      for (const p of parts) {
        acc += `/${p}`
        const label = decodeURIComponent(p)
          .replace(/-/g, ' ')
          .replace(/\b\w/g, c => c.toUpperCase())
        crumbs.push({ label, href: acc })
      }
      if (crumbs.length) {
        const last = crumbs[crumbs.length - 1]
        crumbs[crumbs.length - 1] = { ...last, href: undefined }
      }
    }

    set({ items: crumbs, active })
  },

  setLabel: label => {
    const items = [...get().items]
    if (!items.length) return set({ items: [{ label }] })
    items[items.length - 1] = { ...items[items.length - 1], label }
    set({ items })
  },
}))
