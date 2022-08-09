import React from 'react'
import { SacredGeoQuery } from './SacredGeometryMaker'

type Props = {
    style?: React.CSSProperties,
    query: SacredGeoQuery,
}

const SacredGeoCanvas = (props: Props) => {
  return (
    <div style={props.style} className='' >
      {props.query.buildingBlocks.map((buildingBlock, index) => {return(<div>{buildingBlock.name + " - " + buildingBlock.count}</div>)} )}
    </div>
  )
}

export default SacredGeoCanvas