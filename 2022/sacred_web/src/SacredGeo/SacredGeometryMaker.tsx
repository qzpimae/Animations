import React, { ChangeEventHandler } from 'react'
import SacredGeoCanvas from './SacredGeoCanvas'
import SacredGeoControls from './SacredGeoControls'

type SacredGeometryMakerProps = {
    style?: React.CSSProperties,
}

export interface BuildingBlock {
    name?: string,
    count: string,
    min?: number,
    max?: number,
}

export interface SacredGeoQuery {
    buildingBlocks: BuildingBlock[],
}

const SacredGeometryMaker = (props: SacredGeometryMakerProps) => {

  const [sacredGeoQuery, setSacredGeoQuery] = React.useState<SacredGeoQuery>({buildingBlocks: [
    {name: 'proton', count: '2', min: 1, max: 60},
    {name: 'neutron', count: '2', min: 1, max: 60},
    {name: 'atom', count: '1', min: 0, max: 60},
    {name: 'element', count: '0', min: 0, max: 20},
  ]})

  const onUpdate = (sacredGeoQueryUpdate: SacredGeoQuery) => {
    setSacredGeoQuery({...sacredGeoQuery, ...sacredGeoQueryUpdate})
  }

  return (
    <div style={props.style} className=' bg-black h-screen w-screen' >
      <div className='flex-row justify-center items-center h-screen w-screen'>
        <SacredGeoControls query={sacredGeoQuery} onUpdate={onUpdate}/>
        <SacredGeoCanvas query={sacredGeoQuery} />
      </div>
    </div>
  )
}

export default SacredGeometryMaker