export interface TokenStoreInterface {
  getAccessToken: () => string | null
  setAccessToken: (t: string | null) => void
  /** 서버가 refreshToken을 쿠키로 관리한다면 null 리턴만 해도 됩니다 */
  getRefreshToken?: () => string | null
}
