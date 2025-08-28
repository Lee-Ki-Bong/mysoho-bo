import { redirect } from 'react-router-dom'
import type { QueryClient } from '@tanstack/react-query'
import { getSession } from './auth.api'
import { getAccessTokenNow } from '../stores/auth.store'

export const authLoader = (qc: QueryClient) => async () => {
  const token = getAccessTokenNow()
  if (!token) return redirect('/superlogin') // 1단계: 로컬에서 바로 컷

  //   try {
  //     // 리액트쿼리에 세션을 미리 채워두면 이후 컴포넌트는 그대로 사용 가능
  //     await qc.ensureQueryData({
  //       queryKey: ['auth', 'session'],
  //       queryFn: getSession,
  //     })
  //     return null
  //   } catch (e: any) {
  //     const s = e?.response?.status
  //     if (s === 401) throw redirect('/superlogin')
  //     throw e
  //   }
}
