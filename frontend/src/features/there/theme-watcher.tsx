import { useThemeStore, type Theme } from './theme-store'
import { useEffect } from 'react'

function getSystemTheme(): Exclude<Theme, 'system'> {
  return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
}

export default function ThemeWatcher() {
  const theme = useThemeStore(s => s.theme)

  // html에 dark/light 클래스 적용
  useEffect(() => {
    const root = document.documentElement
    const apply = () => {
      const resolved = theme === 'system' ? getSystemTheme() : theme
      root.classList.remove('light', 'dark')
      root.classList.add(resolved)
    }

    apply()

    // 시스템 테마 변경 실시간 반영 (theme === 'system'일 때만)
    const mq = window.matchMedia('(prefers-color-scheme: dark)')
    const onChange = () => {
      if (theme === 'system') apply()
    }
    if (mq.addEventListener) {
      mq.addEventListener('change', onChange)
    } else {
      // Safari 구버전 대응
      // @ts-ignore
      mq.addListener(onChange)
    }

    return () => {
      if (mq.removeEventListener) {
        mq.removeEventListener('change', onChange)
      } else {
        // @ts-ignore
        mq.removeListener(onChange)
      }
    }
  }, [theme])

  // 다른 탭에서 테마 바뀌면 동기화 (선택 사항)
  useEffect(() => {
    const onStorage = (e: StorageEvent) => {
      if (e.key === 'vite-ui-theme' && e.newValue) {
        const parsed = JSON.parse(e.newValue)
        const nextTheme = parsed?.state?.theme as Theme | undefined
        if (nextTheme) {
          // 무한 루프 방지: 값이 다를 때만 갱신
          if (nextTheme !== theme) {
            // 외부 이벤트 명시(optional third arg)
            useThemeStore.setState({ theme: nextTheme }, false)
          }
        }
      }
    }
    window.addEventListener('storage', onStorage)
    return () => window.removeEventListener('storage', onStorage)
  }, [theme])

  return null
}
