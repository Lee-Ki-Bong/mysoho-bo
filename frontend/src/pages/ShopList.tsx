import TableDemo from '@/features/table/table-sample'

const ShopList = () => {
  return (
    <div className='flex flex-1 flex-col gap-4 p-4'>
      <div className='bg-muted/50 min-h-[100vh] flex-1 rounded-xl md:min-h-min p-4'>
        <TableDemo />
      </div>
    </div>
  )
}

export default ShopList
