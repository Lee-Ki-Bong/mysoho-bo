import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { getSession, logout, silentRefresh, superLogin } from './auth.api'
import type { Session } from '../contexts/auth.types'

export const useSessionQuery = (enabled = true) => {
  return useQuery<Session>({
    queryKey: ['auth', 'session'],
    queryFn: getSession,
    enabled,
    staleTime: 60_000,
    gcTime: 5 * 60_000,
    refetchOnWindowFocus: true,
    retry: (fails, err: any) => {
      const s = err?.response?.status
      if (s === 401) return false // 비로그인 상태면 재시도 불필요
      return fails < 2
    },
  })
}

export const useSuperLoginMutation = (opts?: Parameters<typeof useMutation>[0]) => {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: (p: { userId: string }) => superLogin(p.userId),
    onSuccess: (data, vars, ctx) => {
      // setAccessTokenNow?.(data?.accessToken) // 쿠키전략이면 생략
      qc.invalidateQueries({ queryKey: ['auth', 'session'] })
      opts?.onSuccess?.(data, vars, ctx)
    },
  })
}

export const useLogoutMutation = () => {
  const qc = useQueryClient()
  return useMutation({
    mutationFn: () => logout(),
    onSettled: () => qc.removeQueries({ queryKey: ['auth', 'session'] }),
  })
}

/** (옵션) 주기적 리프레시. 보통은 응답 인터셉터로도 충분 */
export const useAutoRefreshQuery = (enabled = false, intervalMs = 14 * 60_000) => {
  return useQuery({
    queryKey: ['auth', 'auto-refresh'],
    queryFn: () => silentRefresh().then(() => true),
    enabled,
    refetchInterval: intervalMs,
    refetchIntervalInBackground: true,
    retry: false,
  })
}
