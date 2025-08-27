import {
  Table,
  TableBody,
  TableCaption,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from '@/components/ui/table'

/*
사용법
1) 위 파일을 예: src/features/sales/ShadcnStoresSalesTable.tsx 로 저장.
2) 페이지/라우트에서 import 후 <ShadcnStoresSalesTable /> 렌더링.
3) 실제 데이터로 바꿀 때는 sample 대신 서버 응답을 동일 타입(StoreSalesRow)으로 맞춰 사용.
*/

// ---- 타입 정의 ------------------------------------------------------------
export type StoreSalesRow = {
  storeId: string
  storeName: string
  cashSales: number // 무통장(원)
  pgSales: number // PG매출(원)
  pgPendingCount: number // PG 결제 대기 (건)
  pgFailCount: number // PG 결제 실패 (건)
  naverPaySales: number // 네이버페이 결제형 (원)
  joinedAt: string // 가입일 (ISO or yyyy-MM-dd)
  dormancyDueAt: string // 휴먼예정일
  pgSetupAt: string // PG세팅일
}

// ---- 통화 & 날짜 포맷터 --------------------------------------------------
const toKRW = (v: number) =>
  new Intl.NumberFormat('ko-KR', {
    style: 'currency',
    currency: 'KRW',
    maximumFractionDigits: 0,
  }).format(v)

const toDate = (v: string | Date) => {
  const d = typeof v === 'string' ? new Date(v) : v
  if (Number.isNaN(d.getTime())) return '-'
  const yyyy = d.getFullYear()
  const mm = String(d.getMonth() + 1).padStart(2, '0')
  const dd = String(d.getDate()).padStart(2, '0')
  return `${yyyy}-${mm}-${dd}`
}

// ---- 샘플 데이터 ----------------------------------------------------------
const sample: StoreSalesRow[] = [
  {
    storeId: 'S0001',
    storeName: '스타숍',
    cashSales: 2_100_000,
    pgSales: 8_450_000,
    pgPendingCount: 3,
    pgFailCount: 1,
    naverPaySales: 1_550_000,
    joinedAt: '2024-11-12',
    dormancyDueAt: '2025-10-01',
    pgSetupAt: '2024-11-20',
  },
  {
    storeId: 'S0002',
    storeName: '그린마켓',
    cashSales: 1_200_000,
    pgSales: 4_320_000,
    pgPendingCount: 1,
    pgFailCount: 0,
    naverPaySales: 980_000,
    joinedAt: '2025-01-08',
    dormancyDueAt: '2025-09-15',
    pgSetupAt: '2025-01-10',
  },
  {
    storeId: 'S0003',
    storeName: '블루베이커리',
    cashSales: 720_000,
    pgSales: 6_110_000,
    pgPendingCount: 0,
    pgFailCount: 2,
    naverPaySales: 530_000,
    joinedAt: '2024-09-20',
    dormancyDueAt: '2025-08-30',
    pgSetupAt: '2024-09-25',
  },
  {
    storeId: 'S0004',
    storeName: '모던리빙',
    cashSales: 3_450_000,
    pgSales: 3_050_000,
    pgPendingCount: 2,
    pgFailCount: 0,
    naverPaySales: 2_220_000,
    joinedAt: '2025-03-18',
    dormancyDueAt: '2026-01-05',
    pgSetupAt: '2025-03-20',
  },
  {
    storeId: 'S0005',
    storeName: '포레스트문고',
    cashSales: 560_000,
    pgSales: 1_980_000,
    pgPendingCount: 0,
    pgFailCount: 0,
    naverPaySales: 220_000,
    joinedAt: '2023-12-02',
    dormancyDueAt: '2025-09-10',
    pgSetupAt: '2023-12-05',
  },
  {
    storeId: 'S0006',
    storeName: '더브루커피',
    cashSales: 1_110_000,
    pgSales: 3_410_000,
    pgPendingCount: 4,
    pgFailCount: 1,
    naverPaySales: 640_000,
    joinedAt: '2025-04-02',
    dormancyDueAt: '2026-02-14',
    pgSetupAt: '2025-04-05',
  },
  {
    storeId: 'S0007',
    storeName: '어반핏',
    cashSales: 980_000,
    pgSales: 2_700_000,
    pgPendingCount: 1,
    pgFailCount: 1,
    naverPaySales: 450_000,
    joinedAt: '2024-07-11',
    dormancyDueAt: '2025-11-30',
    pgSetupAt: '2024-07-15',
  },
  {
    storeId: 'S0008',
    storeName: '라이트닝샵',
    cashSales: 4_100_000,
    pgSales: 5_600_000,
    pgPendingCount: 2,
    pgFailCount: 0,
    naverPaySales: 1_300_000,
    joinedAt: '2025-02-22',
    dormancyDueAt: '2026-01-10',
    pgSetupAt: '2025-02-25',
  },
  {
    storeId: 'S0009',
    storeName: '한결리빙',
    cashSales: 640_000,
    pgSales: 1_240_000,
    pgPendingCount: 0,
    pgFailCount: 0,
    naverPaySales: 180_000,
    joinedAt: '2024-03-05',
    dormancyDueAt: '2025-08-01',
    pgSetupAt: '2024-03-09',
  },
  {
    storeId: 'S0010',
    storeName: '바닐라샵',
    cashSales: 1_800_000,
    pgSales: 2_150_000,
    pgPendingCount: 3,
    pgFailCount: 2,
    naverPaySales: 700_000,
    joinedAt: '2025-05-30',
    dormancyDueAt: '2026-03-01',
    pgSetupAt: '2025-06-02',
  },
]

const withTotal = (rows: StoreSalesRow[]) =>
  rows.map(r => ({
    ...r,
    total: r.cashSales + r.pgSales + r.naverPaySales,
  }))

// ---- 메인 컴포넌트 --------------------------------------------------------
const TableDemo = () => {
  // 총매출 내림차순 정렬 후, 순번 부여
  const data = withTotal(sample).sort((a, b) => b.total - a.total)

  return (
    <div className='w-full'>
      <div className='mb-3 text-sm text-muted-foreground'>
        샘플 데이터입니다. 실제 API 연동 시 데이터만 교체하세요.
      </div>

      <div className='max-h-[520px] overflow-auto rounded-xl border'>
        <Table>
          <TableCaption>상점 매출 현황 (샘플)</TableCaption>
          <TableHeader className='sticky top-0 z-10 bg-background'>
            <TableRow>
              <TableHead className='w-[64px] text-center'>순서</TableHead>
              <TableHead>상점명</TableHead>
              <TableHead>상점ID</TableHead>
              <TableHead className='text-right'>총매출(원)</TableHead>
              <TableHead className='text-right'>무통장(원)</TableHead>
              <TableHead className='text-right'>PG매출(원)</TableHead>
              <TableHead className='text-center'>PG 결제 대기 (건)</TableHead>
              <TableHead className='text-center'>PG 결제 실패 (건)</TableHead>
              <TableHead className='text-right'>네이버페이 결제형 (원)</TableHead>
              <TableHead>가입일</TableHead>
              <TableHead>휴먼예정일</TableHead>
              <TableHead>PG세팅일</TableHead>
            </TableRow>
          </TableHeader>
          <TableBody>
            {data.map((row, idx) => (
              <TableRow key={row.storeId} className='hover:bg-muted/40'>
                <TableCell className='text-center font-medium'>{idx + 1}</TableCell>
                <TableCell className='font-medium'>{row.storeName}</TableCell>
                <TableCell className='text-muted-foreground'>{row.storeId}</TableCell>
                <TableCell className='text-right'>{toKRW(row.total)}</TableCell>
                <TableCell className='text-right'>{toKRW(row.cashSales)}</TableCell>
                <TableCell className='text-right'>{toKRW(row.pgSales)}</TableCell>
                <TableCell className='text-center'>
                  <span className='inline-flex min-w-[2ch] items-center justify-center rounded-full border px-2 py-0.5 text-xs'>
                    {row.pgPendingCount}
                  </span>
                </TableCell>
                <TableCell className='text-center'>
                  <span className='inline-flex min-w-[2ch] items-center justify-center rounded-full border px-2 py-0.5 text-xs'>
                    {row.pgFailCount}
                  </span>
                </TableCell>
                <TableCell className='text-right'>{toKRW(row.naverPaySales)}</TableCell>
                <TableCell>{toDate(row.joinedAt)}</TableCell>
                <TableCell>{toDate(row.dormancyDueAt)}</TableCell>
                <TableCell>{toDate(row.pgSetupAt)}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </div>
    </div>
  )
}

export default TableDemo
