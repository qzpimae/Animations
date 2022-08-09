import React from 'react'
import type { NextPage } from 'next'
import Head from 'next/head'
import styles from '../styles/Home.module.css'
import SacredGeometryMaker from '../src/SacredGeo/SacredGeometryMaker'

const Home: NextPage = () => {
  return (
    <div className={styles.container}>
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
