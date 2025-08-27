import js from '@eslint/js'
import globals from 'globals'
import reactHooks from 'eslint-plugin-react-hooks'
import reactRefresh from 'eslint-plugin-react-refresh'
import tseslint from 'typescript-eslint'
import { globalIgnores } from 'eslint/config'

export default tseslint.config([
  js.configs.recommended,
  tseslint.configs.recommended,

  // dist, build 등 린트에서 제외
  globalIgnores(['node_modules', 'dist', 'build', 'coverage']),

  {
    files: ['**/*.{ts,tsx}'],
    languageOptions: {
      ecmaVersion: 2020,
      globals: globals.browser, // 브라우저 환경 글로벌(window 등) 인식
      parserOptions: {
        project: './tsconfig.eslint.json', // 타입 기반 린트를 위한 ESLint 전용 tsconfig
      },
    },
    plugins: {
      'react-hooks': reactHooks,
      'react-refresh': reactRefresh,
    },
    rules: {
      // React Hooks 필수 규칙
      'react-hooks/rules-of-hooks': 'error',
      'react-hooks/exhaustive-deps': 'warn',

      // Vite 환경에서 HMR 안전성 확보
      'react-refresh/only-export-components': 'warn',

      // Prettier와 포맷 충돌 방지용 규칙 제거
      ...prettier.rules,
    },
  },
])
