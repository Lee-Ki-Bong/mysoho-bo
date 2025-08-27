import { ChartAreaInteractive } from '@/features/chart/chart-area-sample'
import { ChartPieLabel } from '@/features/chart/chart-pie-sample'

const Dashboard = () => {
  return (
    <div className='flex flex-1 flex-col gap-4 p-4'>
      <div className='bg-muted/50 min-h-[100vh] flex-1 rounded-xl md:min-h-min'>
        <ChartAreaInteractive />
      </div>
      <div className='grid auto-rows-min gap-4 md:grid-cols-2'>
        <div className='bg-muted/50 aspect-video rounded-xl border'>
          <ChartPieLabel />
        </div>
        <div className='bg-muted/50 aspect-video rounded-xl border'>
          <ChartPieLabel />
        </div>
        <div className='bg-muted/50 aspect-video rounded-xl border'>
          <ChartPieLabel />
        </div>
        <div className='bg-muted/50 aspect-video rounded-xl border'>
          <ChartPieLabel />
        </div>
      </div>
    </div>
  )
}

export default Dashboard
