import React, { ChangeEventHandler } from 'react'
import { SacredGeoQuery } from './SacredGeometryPage'


const sliderStyle = 'bg-black text-white text-center text-2xl border-black border-2 rounded-lg w-4/5'
const inputLabelStyle = 'text-xl mr-3 w-1/12 min-w-fit text-left'
const inputContainerStyle = 'flex flex-row justify-around items-center mt-2 mx-5 block'
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
        onUpdate({...query, buildingBlocks: newBuildingBlocks})
    }

    const handleSliderChange = (e: React.ChangeEvent<HTMLInputElement>) => {

        const {value, id} = e.target;
        if (!query.sliders[id]) return
        
        const changedSliderQuery = {...query.sliders[id], value: parseInt(value)}
        const newSliders = {...query.sliders, [id]: {value, min: 0, max: 100}}
        
        onUpdate({...query, sliders: {...query.sliders, [id]: {...query.sliders[id], value: parseInt(value)}}})
        // onUpdate({...query, sliders: newSliders})
    }

    const renderBuildingBlocks = () => {
        return query.buildingBlocks.map((block, index) => {

            const blockName = block.name ? block.name : 'level-' + (index - 2);

            return (
                <div className={inputContainerStyle} key={index}>
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

    const renderSliders = () => {
        return Object.entries(query.sliders).map((slider, index) => {
            
            const [sliderName, sliderQuery] = slider;
            console.log(sliderName, sliderQuery)
            

            return (
                <div className={inputContainerStyle} key={index}>
                    <label className={inputLabelStyle} htmlFor={`sacred-geo-controls-input-${sliderName}-count-label`}>
                        {sliderName.substring(0, 1).toUpperCase() + sliderName.substring(1).replace('-', ' ')}
                    </label>
                    <input
                        id={sliderName}
                        className={sliderStyle}
                        type='range'
                        max={sliderQuery.max}
                        min={sliderQuery.min}
                        value={sliderQuery.value}
                        onChange={handleSliderChange}
                    />
                    <p className={'mx-3 text-lg w-1'}>{sliderQuery.value}</p>
                </div>
            )
        }
        )
    }

    return (
        <div style={props.style} className={controlsContainerStyle}>
            {renderBuildingBlocks()}
            {renderSliders()}
        </div>
    )
}

export default SacredGeoControls