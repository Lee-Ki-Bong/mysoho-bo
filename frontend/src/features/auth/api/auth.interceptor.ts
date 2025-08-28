import axiosInstance from '@/shared/api/api.config'
import type { AxiosError, AxiosRequestConfig, InternalAxiosRequestConfig } from 'axios'
import axios from 'axios'
import type { TokenStoreInterface } from '../contexts/auth.interface'

const SKIP_AUTH = ['/auth/guest', '/auth/sso-login', '/auth/refresh', '/auth/logout']

/** 이 파일에서 사용하기 위해, 토큰 상태 관련 store 바인드 함수 정의 */
let tokenStore: TokenStoreInterface | null = null
export const bindTokenStore = (store: TokenStoreInterface) => {
  tokenStore = store
}

/**
 * 요청 인터셉터
 */
axiosInstance.interceptors.request.use(
  (config: InternalAxiosRequestConfig) => {
    // 인증이 필요없는 요청 url 스킵
    if (config.url && SKIP_AUTH.some(u => config.url!.includes(u))) return config

    // 스토리지(zustand)에서 토큰 가져오기
    const token = tokenStore?.getAccessToken?.() ?? null

    // 토큰 헤더에 추가
    if (token) config.headers.Authorization = `Bearer ${token}`
    return config
  },
  async (error: AxiosError) => Promise.reject(error),
)

/** ----- Response: 401 공통 처리 + 동시요청 큐 ----- */
let isRefreshing = false
let queue: Array<(t: string | null) => void> = []
const enqueue = (cb: (t: string | null) => void) => queue.push(cb)
const flushQueue = (t: string | null) => {
  queue.forEach(cb => cb(t))
  queue = []
}

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL

async function refreshAccessToken(): Promise<string | null> {
  // 서버 전략에 맞게 수정 (예: NestJS /auth/refresh, 쿠키 기반)
  // - 쿠키 기반: body 없이 POST 가능
  // - 토큰 본문형: { refreshToken } 전달
  const useBodyRefresh = false // 필요 시 true

  try {
    const res = await axios.post(
      `${API_BASE_URL}/auth/refresh`,
      useBodyRefresh ? { refreshToken: tokenStore?.getRefreshToken?.() ?? null } : {},
      { withCredentials: true },
    )
    const newAccessToken = (res.data?.accessToken ?? null) as string | null
    tokenStore?.setAccessToken(newAccessToken)
    return newAccessToken
  } catch (e) {
    tokenStore?.setAccessToken(null)
    return null
  }
}

/**
 * 응답 인터셉터
 */
axiosInstance.interceptors.response.use(
  response => response,
  async (error: AxiosError) => {
    const original = error.config as (AxiosRequestConfig & { _retry?: boolean }) | undefined

    // 네트워크 에러/타임아웃은 바로 전달
    if (!error.response) return Promise.reject(error)

    const status = error.response.status

    // 무한 재귀 방지: refresh 호출 자체의 401/403, 혹은 이미 재시도된 요청은 패스
    const isAuthEndpoint =
      original?.url?.includes('/auth/refresh') || original?.url?.includes('/auth/login')
    if (isAuthEndpoint || original?._retry) {
      return Promise.reject(error)
    }

    if (status === 401) {
      if (!isRefreshing) {
        isRefreshing = true
        const newToken = await refreshAccessToken()
        isRefreshing = false
        flushQueue(newToken)
      }

      // refresh 중에는 큐에 대기 후 재시도
      return new Promise((resolve, reject) => {
        enqueue(async newToken => {
          if (!original) return reject(error)
          if (!newToken) return reject(error) // 갱신 실패 → 상위에서 로그인 페이지로 유도

          try {
            original._retry = true
            original.headers = {
              ...(original.headers ?? {}),
              Authorization: `Bearer ${newToken}`,
            } as any
            const res = await axiosInstance(original)
            resolve(res)
          } catch (e) {
            reject(e)
          }
        })
      })
    }

    // CSRF 보호 적용 시 서버가 419/403을 줄 수 있음 → 필요 시 분기 추가
    if (status === 419 || status === 403) {
      // TODO: CSRF 토큰 재발급 로직 등
    }

    return Promise.reject(error)
  },
)
