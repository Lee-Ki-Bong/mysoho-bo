// auth.types.ts
export type Session = {
  user: {
    id: number
    email: string
    name?: string
    roles: string[]
    permissions: string[]
  }
}
