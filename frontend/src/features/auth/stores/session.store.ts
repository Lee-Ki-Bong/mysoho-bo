import { create } from 'zustand'
import type { Session } from '../contexts/auth.types'

type SessionState = {
  // 서버 응답 원본
  session: Session | null

  // 자주 쓰는 파생값
  userId: number | null
  username: string | null
  name: string | null
  roleCode: string | null
  permSet: Set<string>

  // 액션
  setSession: (s: Session) => void
  clear: () => void
}

export const useSessionStore = create<SessionState>(set => ({
  session: null,
  userId: null,
  username: null,
  name: null,
  roleCode: null,
  permSet: new Set(),

  setSession: s =>
    set({
      session: s,
      userId: s.mng_id,
      username: s.mng_user,
      name: s.mng_name,
      roleCode: s.role_code,
      permSet: new Set(s.role?.permissions?.map(p => p.prm_code) ?? []),
    }),

  clear: () =>
    set({
      session: null,
      userId: null,
      username: null,
      name: null,
      roleCode: null,
      permSet: new Set(),
    }),
}))

// 셀렉터/헬퍼
export const selectSession = (s: SessionState) => s.session
export const selectName = (s: SessionState) => s.name ?? ''
export const selectUsername = (s: SessionState) => s.username ?? ''
export const selectRoleCode = (s: SessionState) => s.roleCode
export const can = (code: string) => (s: SessionState) => s.permSet.has(code)
export const canAny = (codes: string[]) => (s: SessionState) => codes.some(c => s.permSet.has(c))
export const canAll = (codes: string[]) => (s: SessionState) => codes.every(c => s.permSet.has(c))

// 외부 즉시 접근
export const getMeNow = () => useSessionStore.getState().session
export const clearMeNow = () => useSessionStore.getState().clear()
