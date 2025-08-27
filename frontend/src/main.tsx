import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import App from './app/App.tsx'
import { QueryClient, QueryClientProvider } from '@tanstack/react-query'
import ThemeWatcher from './features/there/theme-watcher.tsx'

const queryClient = new QueryClient()

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <QueryClientProvider client={queryClient}>
      <ThemeWatcher />
      <App />
    </QueryClientProvider>
  </StrictMode>,
)
