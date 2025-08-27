import { create } from 'zustand'
import { persist, createJSONStorage } from 'zustand/middleware'

export type Theme = 'dark' | 'light' | 'system'

type ThemeState = {
  theme: Theme
  setTheme: (t: Theme) => void
}

export const useThemeStore = create<ThemeState>()(
  persist(
    set => ({
      theme: 'system',
      setTheme: t => set({ theme: t }),
    }),
    {
      name: 'vite-ui-theme', // localStorage key (원래 코드와 동일)
      storage: createJSONStorage(() => localStorage),
      version: 1,
    },
  ),
)
