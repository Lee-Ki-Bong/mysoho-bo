import * as React from 'react'
import {
  Card,
  CardHeader,
  CardTitle,
  CardDescription,
  CardContent,
  CardFooter,
} from '@/components/ui/card'
import { Label } from '@/components/ui/label'
import { Input } from '@/components/ui/input'
import { Button } from '@/components/ui/button'
import { Loader2, LogIn } from 'lucide-react'

// Minimal, self-contained login form.
// Drop this component anywhere; it only needs shadcn/ui + lucide-react installed.
// Props:
// - onLogin?: (account: string) => void | Promise<void>
// - title?: string
// - helperText?: string

export type SuperLoginProps = {
  onLogin?: (account: string) => void | Promise<void>
  title?: string
  helperText?: string
  className?: string
}

export default function SuperLogin({
  onLogin,
  title = '슈퍼 로그인',
  helperText = '계정명을 입력하고 로그인하세요.',
  className,
}: SuperLoginProps) {
  const [account, setAccount] = React.useState('')
  const [loading, setLoading] = React.useState(false)
  const inputRef = React.useRef<HTMLInputElement>(null)

  const disabled = account.trim().length === 0 || loading

  const handleSubmit = async (e?: React.FormEvent) => {
    e?.preventDefault()
    if (disabled) return
    try {
      setLoading(true)
      await onLogin?.(account.trim())
    } finally {
      setLoading(false)
    }
  }

  // Press Enter to submit
  const onKeyDown: React.KeyboardEventHandler<HTMLInputElement> = e => {
    if (e.key === 'Enter') {
      handleSubmit()
    }
  }

  React.useEffect(() => {
    inputRef.current?.focus()
  }, [])

  return (
    <form onSubmit={handleSubmit} className={className}>
      <Card className='w-full max-w-sm mx-auto rounded-2xl shadow-sm'>
        <CardHeader>
          <CardTitle className='text-xl'>{title}</CardTitle>
          <CardDescription>{helperText}</CardDescription>
        </CardHeader>
        <CardContent className='space-y-3'>
          <div className='space-y-2'>
            <Label htmlFor='account'>계정명</Label>
            <Input
              id='account'
              ref={inputRef}
              value={account}
              onChange={e => setAccount(e.target.value)}
              onKeyDown={onKeyDown}
              placeholder='아이디 또는 계정명'
              autoComplete='username'
              aria-label='계정명'
            />
          </div>
        </CardContent>
        <CardFooter>
          <Button type='submit' disabled={disabled} className='w-full'>
            {loading ? (
              <>
                <Loader2 className='mr-2 h-4 w-4 animate-spin' />
                로그인 중...
              </>
            ) : (
              <>
                <LogIn className='mr-2 h-4 w-4' />
                로그인
              </>
            )}
          </Button>
        </CardFooter>
      </Card>
    </form>
  )
}
