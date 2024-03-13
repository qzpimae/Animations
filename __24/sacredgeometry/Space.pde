class Space  {

    void renderScene (int sceneNum) {

        if (clearScreen) {
            clear();
            color c1 = color(180, 75, 70);
            color c2 = color(275, 75, 45);
            if (toggle1) {
                // setGradient(0, 0, W, H, c1, c2, 1);
                background(0, 0, 0);   
            } else {
                background(0, 0, 100);
            } 
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
            } else {
                translate(transX, transY);

            }

            switch (renderOption) {

                case 1: 
                    //STANDARD ENTITY
                    // translate(-globalRndrScl*1.5, 0);
                    // renderingEntity.renderEntity();
                    
                    // translate(globalRndrScl*3, 0);
                        // if (toggle1) {
                            renderingEntity.renderAtom();
                        // } else {
                        //     renderingEntity.renderEntity();
                        // }
                    
          
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
                    //ENTITY GRID Diagram
                    this.renderEntityGridDia(renderingEntity);
                break;
                case 7:
                    //ENTITY GRID Homo
                    this.renderEntityGridHomo(renderingEntity);
                break;
                case 8:
                    //ENTITY GRID Homo
                    this.renderEntityGridPrimes(renderingEntity);
                break;
            }    
            

        pop();

        if (isShowingVars) displayVars();
        
    }


    void renderEntityGridDia (Entity rndEnt) {

        clear();
        background(toggle1 ? 0 : 360);
        
        stroke(toggle1 ? 360 : 0);
        strokeWeight(globalLineWidth);
        
        int minNum = (int) globalLines;
        int maxNum = (int) (globalLines + globalSides) ;

        int minSpace = H < W ? H : W;

        int enitiySz = (int) (minSpace / ((maxNum-minNum+1) * 2.5));

        float extraRoom = ((W - (H - enitiySz*3)) / (enitiySz*3)); 
        int extraLines = (int) Math.ceil((W - (H - enitiySz*3)) / (enitiySz*3));
        // println(W - (enitiySz*3 * maxNum));
        // println(enitiySz/extraRoom*2);

        push();
        // translate(W - (enitiySz*1.5 * maxNum), 0);

        for (int lineNum = minNum; lineNum <= maxNum+extraLines; ++lineNum) {
            for (int sideNum = minNum; sideNum <= maxNum; ++sideNum) {
                push();
                float transX = map(lineNum, minNum, maxNum, 0, H - enitiySz*3) + enitiySz*1.5;
                float transY = map(sideNum, maxNum, minNum, 0, H - enitiySz*3) + enitiySz*1.5;
                translate(transX, transY);

                rndEnt.lines = lineNum;
                rndEnt.sides= sideNum;

                rndEnt.renderEntity();

                pop();
            }
        }
        pop();
    }

    void renderEntityGridHomo (Entity rndEnt) {

        clear();
        background(toggle1 ? 0 : 360);
        
        stroke(toggle1 ? 360 : 0);
        strokeWeight(globalLineWidth);
        
        int minNum = (int) globalLines;
        int maxNum = (int) (globalLines + globalSides) ;

        int minSpace = H < W ? H : W;

        int enitiySz = (int) (minSpace / ((maxNum-minNum+1) * 2.5));

        for (int lineNum = minNum; lineNum <= maxNum; ++lineNum) {
            for (int sideNum = minNum; sideNum <= maxNum; ++sideNum) {
                push();
                float transX = map(lineNum, minNum, maxNum, 0, H - enitiySz*3) + enitiySz*1.5;
                float transY = map(sideNum, maxNum, minNum, 0, H - enitiySz*3) + enitiySz*1.5;
                translate(transX, transY);

                rndEnt.lines = lineNum;
                rndEnt.sides= sideNum;

                rndEnt.renderEntity();

                pop();
            }
        }
    }

    void renderEntityGridPrimes (Entity rndEnt) {

        clear();
        background(toggle1 ? 0 : 360);
        
        stroke(toggle1 ? 360 : 0);
        strokeWeight(globalLineWidth);
        
        int minNum = (int) globalLines;
        int maxNum = (int) (globalLines + globalSides) ;

        int minSpace = H < W ? H : W;

        int enitiySz = (int) (minSpace / ((maxNum-minNum+1) * 2.5));

        int count = minNum;

        for (int lineNum = minNum; lineNum <= maxNum; ++lineNum) {
            for (int sideNum = minNum; sideNum <= maxNum; ++sideNum) {
                push();
                float transX = map(lineNum, minNum, maxNum, 0, H - enitiySz*3) + enitiySz*1.5;
                float transY = map(sideNum, maxNum, minNum, 0, H - enitiySz*3) + enitiySz*1.5;
                translate(transX, transY);

                rndEnt.lines = count;
                rndEnt.sides= count;

                rndEnt.renderEntity();

                pop();

                count++;
            }
        }
    }

    void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

        noFill();

        if (axis == 1) {  // Top to bottom gradient
            for (int i = y; i <= y+h; i++) {
            float inter = map(i, y, y+h, 0, 1);
            color c = lerpColor(c1, c2, inter);
            stroke(c);
            line(x, i, x+w, i);
            }
        }  
        else if (axis == 2) {  // Left to right gradient
            for (int i = x; i <= x+w; i++) {
            float inter = map(i, x, x+w, 0, 1);
            color c = lerpColor(c1, c2, inter);
            stroke(c);
            line(i, y, i, y+h);
            }
        }
    }
}
