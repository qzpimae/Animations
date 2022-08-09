import React, { ChangeEventHandler } from 'react'
import useDimensions from '../../hooks/useDimensions'
import { sacredGeoQueryInitialState } from '../../static/sacredGeoStatic'
import SacredGeoCanvas from './SacredGeoCanvas'
import SacredGeoControls from './SacredGeoControls'

type SacredGeometryMakerProps = {
    style?: React.CSSProperties,
}

export interface BuildingBlocksQuery {
    name?: string
    count: string
    min?: number
    max?: number
}

export interface SliderQuery {
  value: number
  min: number
  max: number
}

export interface SacredGeoQuery {
    buildingBlocks: BuildingBlocksQuery[],
    sliders: {
      [key: string]: SliderQuery
    },
}

const SacredGeometryMaker = (props: SacredGeometryMakerProps) => {

  const [sacredGeoQuery, setSacredGeoQuery] = React.useState<SacredGeoQuery>(sacredGeoQueryInitialState)

  const onUpdate = (sacredGeoQueryUpdate: SacredGeoQuery) => {
    setSacredGeoQuery({...sacredGeoQuery, ...sacredGeoQueryUpdate})
  }


  const {width, height} = useDimensions();

  return (
    <div style={props.style} className=' bg-black h-screen w-screen' >
      <div className='flex-row justify-center items-center h-screen w-screen'>
        <SacredGeoControls query={sacredGeoQuery} onUpdate={onUpdate}/>
        <SacredGeoCanvas query={sacredGeoQuery} width={width || undefined} height={height|| undefined}/>
      </div>
    </div>
  )
}

export default SacredGeometryMaker