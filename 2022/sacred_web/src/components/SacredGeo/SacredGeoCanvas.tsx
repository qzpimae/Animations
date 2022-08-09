import React, { useCallback, useRef } from 'react'
import { SacredGeoQuery } from './SacredGeometryPage'
import p5Types from "p5";
import dynamic from 'next/dynamic'

// Will only import `react-p5` on client-side
const Sketch = dynamic(() => import('react-p5')//.then((mod) => mod.default)
    , { ssr: false, }
)

type Props = {
    style?: React.CSSProperties,
    query: SacredGeoQuery,
    width?: number,
    height?: number,
}

const SacredGeoCanvas = (props: Props) => {


    const { style, query } = props
    const {renderScale, hue} = query.sliders
    const rndrScl = renderScale.value
    const hueValue = hue.value

    const setup = (p5: p5Types, canvasParentRef: Element) => {
        p5.createCanvas(
            props.width || p5.displayWidth,
            props.height || p5.displayHeight
        ).parent(canvasParentRef);
        p5.colorMode(p5.HSL, 360, 100, 100, 100);
    };

    const draw = (p5: p5Types) => {

        p5.background(0);

        p5.stroke(hueValue, 70, 45, 100);
        p5.strokeWeight(1);

        p5.push()
        renderSG(p5, query);
        p5.pop()

    }

    const renderSG = (p: p5Types, query: SacredGeoQuery) => {
        const [pCount, nCount, aCount, eCount] = query.buildingBlocks.map(b => parseInt(b.count))
        p.translate(p.width / 2, p.height / 2)
        renderEntity(p, [pCount, nCount, aCount, eCount])

    }

    const renderEntity = (p: p5Types, sgData: number[]) => {
        if (sgData.length > 2) {
            for (let i = 0; i < sgData.length; i++) {
                renderEntity(p, sgData.slice(0, sgData.length - 1))
            }
        } else if (sgData.length > 1) {
            const angleMinLf = 0
            const angleMaxLf = Math.PI * 2
            const protons = sgData[0]
            const neutrons = sgData[1]

            for (let k = 0; k < neutrons; k++) {
                for (let i = 0; i < protons; i++) {
    
                    const entityRadians = p.map(i, 0, protons, angleMinLf, angleMaxLf)
    
                    let x1 = Math.cos(entityRadians) * rndrScl
                    let y1 = Math.sin(entityRadians) * rndrScl
    
                    if (true) {
                        const temp = x1;
                        x1 = y1;
                        y1 = temp;
                    }
    
                    const vec1 = p.createVector(x1, y1)
                    const vec2 = p.createVector(0, -rndrScl)
                    vec1.rotate(p.map(k, 0, neutrons, 0, Math.PI * 2))
                    vec2.rotate(p.map(k, 0, neutrons, 0, Math.PI * 2))
    
                    p.line(vec2.x, vec2.y, vec1.x, vec1.y)
    
                }
            }


        }
    }

    return <Sketch setup={setup} draw={draw} />
}

export default SacredGeoCanvas