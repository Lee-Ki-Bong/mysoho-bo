import { api } from '@/shared/api/api.method'
import { useAuthStore } from '../stores/auth.store'
import type { Session } from '../contexts/auth.types'

export const superLogin = async (userId: string) => {
  // 서버 전략 예시: 로그인 성공 시 accessToken(JSON), refreshToken은 쿠키(HTTP‑only)
  try {
    const { accessToken } = await api.post<{ accessToken: string }>('/auth/manager/sso-login', {
      userId,
    })
    useAuthStore.getState().setAccessToken(accessToken)
  } catch (e) {
    useAuthStore.getState().setAccessToken(null)
    throw e
  }
}

export const logout = async () => {
  try {
    await api.post('/auth/logout', {})
  } catch (e) {
    console.error(e)
  }
  useAuthStore.getState().setAccessToken(null)
}

export const silentRefresh = async () => {
  try {
    const { accessToken } = await api.post<{ accessToken: string }>('/auth/refresh')
    useAuthStore.getState().setAccessToken(accessToken)
    return true
  } catch {
    useAuthStore.getState().setAccessToken(null)
    return false
  }
}

export const getSession = async (): Promise<Session> => {
  return await api.get('/auth/manager/me')
}
