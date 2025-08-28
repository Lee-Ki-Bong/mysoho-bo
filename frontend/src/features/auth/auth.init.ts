import { bindTokenStore } from './api/auth.interceptor'
import { useAuthStore } from './stores/auth.store'

bindTokenStore({
  getAccessToken: () => useAuthStore.getState().accessToken,
  setAccessToken: t => useAuthStore.getState().setAccessToken(t),
  // refresh 토큰을 쓰신다면 여기에 getRefreshToken도 추가
})
