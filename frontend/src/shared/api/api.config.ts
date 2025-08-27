import axios from 'axios'

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL

const axiosInstance = axios.create({
  baseURL: API_BASE_URL,
  timeout: 15_000, // 15초
  withCredentials: true, // 쿠키 기반 리프레시(HTTP‑only)라면 true
  headers: { 'Content-Type': 'application/json' },
})

export default axiosInstance
