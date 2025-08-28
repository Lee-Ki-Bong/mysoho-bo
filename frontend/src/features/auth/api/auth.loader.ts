import { redirect } from 'react-router-dom'
import type { QueryClient } from '@tanstack/react-query'
import { getSession } from './auth.api'
import { getAccessTokenNow } from '../stores/auth.store'

export const authLoader = (qc: QueryClient) => async () => {
  const token = getAccessTokenNow()
  if (!token) return redirect('/superlogin') // 1단계: 로컬에서 바로 컷
  try {
    await qc.ensureQueryData({
      queryKey: ['auth', 'session'] as const,
      queryFn: getSession,
    })
    return null
  } catch (e: any) {
    if (e?.response?.status === 401) return redirect('/superlogin')
    throw e
  }
}
