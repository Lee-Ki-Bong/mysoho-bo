import { useEffect } from 'react'
import { Link, useLocation } from 'react-router-dom'
import { SidebarIcon } from 'lucide-react'

import { SearchForm } from '../etc/search-form'
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator,
} from '@/components/ui/breadcrumb'
import { Button } from '@/components/ui/button'
import { Separator } from '@/components/ui/separator'
import { useSidebar } from '@/components/ui/sidebar'
import { ModeToggle } from '../there/theme-toggle'
import { useBreadcrumbStore } from '@/shared/stores/breadcrumb'
import { navMain } from '@/shared/config/nav'

export function SiteHeader() {
  const { toggleSidebar } = useSidebar()
  const location = useLocation()

  const items = useBreadcrumbStore(s => s.items)
  const setFromNav = useBreadcrumbStore(s => s.setFromShadcnNav)

  // URL 변경될 때 nav 기반으로 Breadcrumb 갱신
  useEffect(() => {
    setFromNav(navMain, location.pathname)
  }, [location.pathname, setFromNav])

  return (
    <header className='bg-background sticky top-0 z-50 flex w-full items-center border-b p-4'>
      <div className='flex h-[--header-height] w-full items-center gap-2 px-2'>
        <Button
          className='h-8 w-8'
          variant='ghost'
          size='icon'
          onClick={toggleSidebar}
          aria-label='Toggle sidebar'
        >
          <SidebarIcon />
        </Button>

        <Separator orientation='vertical' className='mr-2 h-4' />

        <Breadcrumb className='hidden sm:block'>
          <BreadcrumbList>
            {items.map((c, idx) => {
              const isLast = idx === items.length - 1
              return (
                <div className='flex items-center' key={`${c.label}-${idx}`}>
                  <BreadcrumbItem>
                    {isLast || !c.href ? (
                      <BreadcrumbPage>{c.label}</BreadcrumbPage>
                    ) : (
                      <BreadcrumbLink asChild>
                        <Link to={c.href}>{c.label}</Link>
                      </BreadcrumbLink>
                    )}
                  </BreadcrumbItem>
                  {!isLast && <BreadcrumbSeparator />}
                </div>
              )
            })}
          </BreadcrumbList>
        </Breadcrumb>

        <SearchForm className='w-full sm:ml-auto sm:w-auto' />
        <ModeToggle />
      </div>
    </header>
  )
}
