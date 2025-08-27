/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_API_BASE_URL: string
  // 다른 키도 여기서 추가
}
interface ImportMeta {
  readonly env: ImportMetaEnv
}
