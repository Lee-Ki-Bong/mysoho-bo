import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import './features/auth/auth.init'
import App from './app/App.tsx'
import { QueryClientProvider } from '@tanstack/react-query'
import ThemeWatcher from './features/there/theme-watcher.tsx'
import { queryClient } from './shared/lib/queryClient.ts'

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <QueryClientProvider client={queryClient}>
      <ThemeWatcher />
      <App />
    </QueryClientProvider>
  </StrictMode>,
)
