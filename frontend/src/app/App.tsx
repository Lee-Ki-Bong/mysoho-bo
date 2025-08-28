import { createBrowserRouter, RouterProvider } from 'react-router'
import AppLayout from './AppLayout'
import Dashboard from '@/pages/Dashboard'
import Home from '@/pages/Home'
import ShopList from '@/pages/ShopList'
import SuperLogin from '@/pages/SuperLogin'

const App = () => {
  const router = createBrowserRouter([
    {
      path: '/superlogin',
      element: <SuperLogin />,
      handle: { breadcrumb: '슈퍼 로그인' },
    },
    {
      path: '/',
      element: <AppLayout />,
      children: [
        { index: true, Component: Home, handle: { breadcrumb: '홈' } },
        { path: 'dashboard', Component: Dashboard, handle: { breadcrumb: '대시보드' } },
        { path: 'shoplist', Component: ShopList, handle: { breadcrumb: '상점 목록' } },
      ],
    },
  ])

  return (
    <>
      <RouterProvider router={router} />
    </>
  )
}

export default App
