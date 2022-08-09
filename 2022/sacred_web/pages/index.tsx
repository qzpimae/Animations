import React from 'react'
import type { NextPage } from 'next'
import Head from 'next/head'
import SacredGeometryMaker from '../src/components/SacredGeo/SacredGeometryPage'

const Home: NextPage = () => {
  return (
    <div className='display'>
      <Head>
        <title>Sacred Geometry Generator</title>
        <meta name="description" content="Sacred Geometry Generator" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <SacredGeometryMaker />

    </div>
  )
}

export default Home
