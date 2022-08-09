import React, { ChangeEventHandler } from 'react'
import { SacredGeoQuery } from './SacredGeometryMaker'


const sliderStyle = 'bg-black text-white text-center text-2xl border-black border-2 rounded-lg w-4/5'
const inputLabelStyle = 'text-xl mr-3 w-1/12 min-w-fit text-left'
const inputContainerStyle = 'flex flex-row justify-around items-center mt-2 mx-5'
const controlsContainerStyle = 'flex flex-col border-b-2 pb-3 border-white border-opacity-30'

type Props = {
    style?: React.CSSProperties,
    query: SacredGeoQuery,
    onUpdate: (sacredGeoQueryUpdate: SacredGeoQuery) => void,
}

const SacredGeoControls = (props: Props) => {

    const {query, onUpdate} = props;


    // const handleBuildingChange: ChangeEventHandler<HTMLInputElement> = (e) => {
    //     onUpdate(e.target.id, e.target.value)
    // }

    const handleBuildingChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const {id, value} = e.target;
        const buildingBlockIndex = parseInt(id.split('-')[id.split('-').length - 1]);
        const newBuildingBlocks = [...query.buildingBlocks]
        newBuildingBlocks[buildingBlockIndex].count = value;
        onUpdate({buildingBlocks: newBuildingBlocks})
    }

    const renderBuildingBlocks = () => {
        return query.buildingBlocks.map((block, index) => {

            const blockName = block.name ? block.name : 'level-' + (index - 2);

            return (
                <div className={inputContainerStyle}>
                    <label className={inputLabelStyle} htmlFor={`sacred-geo-controls-input-${blockName}-count-label`}>
                        {blockName.substring(0, 1).toUpperCase() + blockName.substring(1).replace('-', ' ')}
                    </label>
                    <input
                        id={'building-block-'+index}
                        className={sliderStyle}
                        type='range'
                        max={block.max ? block.max : 60}
                        min={block.min ? block.min : 0}
                        value={block.count}
                        defaultValue={2}
                        onChange={handleBuildingChange}
                    />
                    <p className={'mx-3 text-lg w-1'}>{block.count}</p>
                </div>
            )
        })
    }

    return (
        <div style={props.style} className={controlsContainerStyle}>
            {renderBuildingBlocks()}
        </div>
    )
}

export default SacredGeoControls