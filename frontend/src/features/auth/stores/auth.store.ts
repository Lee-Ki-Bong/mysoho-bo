import { create } from 'zustand'

type AuthState = {
  accessToken: string | null
  setAccessToken: (t: string | null) => void
  getAccessToken: () => string | null
  clear: () => void
}

export const useAuthStore = create<AuthState>((set, get) => ({
  accessToken: null,
  setAccessToken: t => set({ accessToken: t }),
  getAccessToken: () => get().accessToken,
  clear: () => set({ accessToken: null }),
}))

// (선택) 헬퍼
export const getAccessTokenNow = () => useAuthStore.getState().accessToken
export const setAccessTokenNow = (t: string | null) => useAuthStore.getState().setAccessToken(t)
