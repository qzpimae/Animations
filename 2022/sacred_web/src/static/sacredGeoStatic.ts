import { SacredGeoQuery } from "../components/SacredGeo/SacredGeometryPage";

export const sacredGeoQueryInitialState:SacredGeoQuery = {
    buildingBlocks: [
        {name: 'proton', count: '6', min: 1, max: 60},
        {name: 'neutron', count: '6', min: 1, max: 60},
        {name: 'atom', count: '1', min: 0, max: 60},
        {name: 'element', count: '0', min: 0, max: 20},
    ],
    sliders: {
        renderScale: { value: 100, min: 50, max: 2000},
        hue: { value: 159, min: 1, max: 360},
    }
}