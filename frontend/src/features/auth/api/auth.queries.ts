import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'
import { getSession, logout, silentRefresh, superLogin } from './auth.api'
import type { Session } from '../contexts/auth.types'
import { useSessionStore } from '../stores/session.store'
import { getAccessTokenNow, useAuthStore } from '../stores/auth.store'
import { useEffect } from 'react'

export const useSessionQuery = (enabled = true) => {
  const setSession = useSessionStore(s => s.setSession)
  const token = getAccessTokenNow()

  const q = useQuery<Session>({
    queryKey: ['auth', 'session'] as const,
    queryFn: getSession,
    enabled: enabled && !!token,
    staleTime: 60_000,
    gcTime: 5 * 60_000,
    refetchOnWindowFocus: true,
    retry: (fails, err: any) => (err?.response?.status === 401 ? false : fails < 2),
  })

  useEffect(() => {
    if (q.data) setSession(q.data) // 여기서 미러링
  }, [q.data, setSession])

  return q
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
    onSettled: () => {
      qc.removeQueries({ queryKey: ['auth', 'session'] })
      useSessionStore.getState().clear()
      useAuthStore.getState().clear()
    },
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
