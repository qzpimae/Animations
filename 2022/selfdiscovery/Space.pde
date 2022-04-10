class Space  {

    void renderScene (int sceneNum) {

        if (clearScreen) {
            clear();
            // background(333, 50, 5);
        }

        if (entityUpdated) {
            renderingEntity = new Entity(
                globalDeityHigherNum,
                globalDeityNum,
                globalHigherDimensions,//higherdims
                globalDimensions,//dim
                globalLines,//lines
                globalSides,//side
                globalRndrScl,
                globalHDAngle*PI/180, //higher dim angle
                globalDeityAngle*PI/180 //inner dim angle
            );
            entityUpdated = false;
        }



        push();

            if (renderOption < 6 ) {
                translate(W/2 + transX, H/2 + transY);
                rotate(globalAngle*PI/180);
            }

            switch (renderOption) {

                case 1: 
                    //STANDARD ENTITY
                    // translate(-globalRndrScl*1.5, 0);
                    // renderingEntity.renderEntity();
                    
                    // translate(globalRndrScl*3, 0);
                        if (toggle1) {
                            renderingEntity.renderAtom();
                        } else {
                            renderingEntity.renderEntity();
                        }
                    
          
                break;
                case 2: 
                    //INTERDIMENSIONAL
                    renderingEntity.renderInterdimensionalEntity();
                break;
                case 3: 
                    //HIGHER DIMENSIONAL
                    renderingEntity.renderHigherDimensionalEntity();
                break;
                case 4: 
                    //DEITY
                    renderingEntity.deityRender();           
                break;
                case 5: 
                    //HIGH DIMENSIONAL DEITY
                    renderingEntity.deityHigherDimRender();           
                break;
                case 6:
                    //ENTITY GRID
                    this.renderEntityGrid(renderingEntity);
                break;
            }    
            

        pop();

        if (isShowingVars) displayVars();
        
    }


    void renderEntityGrid (Entity rndEnt) {

        clear();
        background(0);
        
        stroke(360);
        strokeWeight(globalLineWidth);
        
        int minNum = (int) globalLines;
        int maxNum = (int) (globalLines + globalSides);

        int minSpace = H < W ? H : W;

        int enitiySz = (int) (minSpace / ((maxNum-minNum+1) * 2.5));

        for (int lineNum = minNum; lineNum <= maxNum; ++lineNum) {
            for (int sideNum = minNum; sideNum <= maxNum; ++sideNum) {
                push();
                float transX = map(lineNum, minNum, maxNum, 0, W - enitiySz*3) + enitiySz*1.5;
                float transY = map(sideNum, minNum, maxNum, 0, H - enitiySz*3) + enitiySz*1.5;
                translate(transX, transY);

                rndEnt.lines = lineNum;
                rndEnt.sides= sideNum;

                rndEnt.renderEntity();

                pop();
            }
        }
    }
}
