import { GalleryVerticalEnd } from 'lucide-react'

import { cn } from '@/lib/utils'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'
import { Label } from '@/components/ui/label'

export function SuperLoginForm({ className, ...props }: React.ComponentProps<'div'>) {
  return (
    <div className={cn('flex flex-col gap-6', className)} {...props}>
      <form>
        <div className='flex flex-col gap-6'>
          <div className='flex flex-col items-center gap-2'>
            <a href='#' className='flex flex-col items-center gap-2 font-medium'>
              <div className='flex size-8 items-center justify-center rounded-md'>
                <GalleryVerticalEnd className='size-6' />
              </div>
              <span className='sr-only'>Mysoho BackOffice</span>
            </a>
            <h1 className='text-xl font-bold'>Super Login</h1>
            <div className='text-center text-sm text-muted-foreground'>
              관리자 전용 로그인 페이지입니다.
            </div>
          </div>

          <div className='flex flex-col gap-6'>
            <div className='grid gap-3'>
              <Label htmlFor='account'>계정명</Label>
              <Input id='account' type='text' placeholder='관리자 계정명 입력' required />
            </div>
            <Button type='submit' className='w-full'>
              슈퍼 로그인
            </Button>
          </div>
        </div>
      </form>

      <div className='text-muted-foreground text-center text-xs text-balance'>
        본 서비스는 허가된 관리자만 사용할 수 있습니다.
      </div>
    </div>
  )
}
