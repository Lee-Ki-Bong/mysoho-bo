// auth.types.ts

export type Permission = {
  prm_code: string
  prm_name: string
  prm_desc: string
  created_at: string // ISO datetime string
}

export type Role = {
  role_code: string
  role_name: string
  role_desc: string
  created_at: string // ISO datetime string
  permissions: Permission[]
}

export type Session = {
  mng_id: number
  mng_user: string
  mng_ip: string
  mng_name: string
  mng_part: string
  mng_group: string // 예: "SUPER_ADMIN"
  mng_desc: string
  mng_status: string // 예: "active"
  mng_last_connection: string // ISO datetime string
  created_at: string // ISO datetime string
  updated_at: string // ISO datetime string
  role_code: string // 예: "SUPER_ADMIN"
  role: Role
}
