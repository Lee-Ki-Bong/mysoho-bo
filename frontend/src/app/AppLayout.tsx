import { SiteHeader } from '@/features/header/site-header'
import { SidebarInset, SidebarProvider } from '@/components/ui/sidebar'
import { AppSidebar } from '@/features/sidebar/app-sidebar'
import { Outlet } from 'react-router'
import { useSessionQuery } from '@/features/auth/api/auth.queries'

const AppLayout = () => {
  const { isPending, isError } = useSessionQuery(true)

  if (isPending) return null // 레이아웃 스켈레톤 가능
  if (isError) return null // 에러 바운더리/토스트 등

  return (
    <div className='[--header-height:calc(--spacing(14))]'>
      <SidebarProvider className='flex flex-col'>
        <SiteHeader />
        <div className='flex flex-1'>
          <AppSidebar />
          <SidebarInset>
            <Outlet />
          </SidebarInset>
        </div>
      </SidebarProvider>
    </div>
  )
}

export default AppLayout
