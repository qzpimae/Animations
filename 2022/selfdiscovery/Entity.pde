class Entity {

    PShape atom;
    PShape level1;

    float deityHiger;
    float deityNum; //deitiy
    float deityAlg; //hdAgle
    float higherDims;//higherdims
    float dims;      //dim
    float lines;   //lines
    float sides;  //side
    float rndrScl;//size
    float hdAgl; //hdAgle

    Entity (
        float deityHiger, //higher deitiy
        float deityNum,   //deitiy 
        float higherDims,//higher dims
        float dims,    //dim
        float lines,   //lines
        float sides, //side
        float rndrScl,//size
        float hdAgl,
        float deityAlg

    ) {
        this.deityHiger = deityHiger; //higher deitiy
        this.deityNum = deityNum; //deitiy 
        this.higherDims = higherDims;//higherdims
        this.dims = dims;//dim
        this.lines = lines;   //lines
        this.sides = sides;   //side
        this.rndrScl = rndrScl;//size
        this.hdAgl = hdAgl;
        this.deityAlg = deityAlg;

        initializeAtom();
    }

    void initializeAtom() {
        
        // setStrokeColor();
        atom = createShape(GROUP);
        
        for (int i = 0; i < sides; i++) {
            
            if (entitiyType == 4) {
                generateCardioid(i);
            } else {
                generateLeaf(i);
            }    
            
        }

    }


            // stroke(color(177, 87, 100, globalLineAlpha)); //teal
            // stroke(color(309, 34, 95, globalLineAlpha));  //pink
            // stroke(333, 33, 100, globalLineAlpha); //pink 2
            // stroke(color(123, 72, 93, globalLineAlpha));  //emerald
            // stroke(color(159, 69, 93, globalLineAlpha));  //teal
            // stroke(color(222, 79, 93, globalLineAlpha));  //blue


    // void setStrokeColor () { 
    //     if (colorMode == 1) {
    //         // background(177, 22, 12, 0);
    //         stroke(0, 87, 100, globalLineAlpha);
    //         //background(333, 22, 12, 0);           
    //     } else if (colorMode == 2){
    //         stroke(color(0,0,70, globalLineAlpha));
    //         // background(globalLineHue, 44, 100);
    //         // stroke(globalBgHue, 20, 17); 
    //     } else if (colorMode  == 3){

    //         // background(177, 22, 12, 0);
    //         stroke(177, 87, 100, globalLineAlpha);
    //     } else {
    //         // background(177, 22, 12, 0);
    //         stroke(0, 87, 100, globalLineAlpha);
    //     }

    //     noFill();

    //     strokeWeight(globalLineWidth > 0 ? globalLineWidth : .001);
    // }

    // void setShapeStroke(PShape tempShape) {
    //     // stroke(360);
    //     //green
    //     // stroke(177, 87, 100); //teal
    //     // stroke(309, 34, 95); //pink
    //     // stroke(360, 100, 100);
    //     if (colorMode == 1) {
    //         // background(177, 22, 12, 0); 
    //         //tempShape.setStroke(color(309, 39, 93, globalLineAlpha));
    //         // background(333, 22, 12, 0); 
    //         tempShape.setStroke(color(159, 39, 93, globalLineAlpha));
    //     } else if (colorMode == 2){
    //          background(globalLineHue, 44, 100);
    //         tempShape.setStroke(color(globalBgHue, 20, 17)); 
    //     } else if (colorMode  == 3){

    //         background(177, 17, 17, 1);
    //         tempShape.setStroke(color(0, 87, 100, globalLineAlpha));

    //     } else {

    //         background(177, 22, 12, 0); 
    //         tempShape.setStroke(color(0, 33, 100, globalLineAlpha));
    //         // tempShape.setStroke(color(177, 87, 100, globalLineAlpha);

    //     } 

    //     // tempShape.noFill();

    //     tempShape.setStrokeWeight(globalLineWidth > 0 ? globalLineWidth : .001);
    // }

    void setShapeStroke(PShape tempShape, float colorVal) {

        int lightness = 100;
        // if (!toggle1) lightness = 50;


        if (colorMode == 1) {
            float hue = map(colorVal, 0, 360, 267, 333);
            float sat = map (hue, 277, 323, 95, 80);

            tempShape.setStroke(color(hue, sat, lightness, globalLineAlpha));

        } else if (colorMode == 2) {


            float hue = (int)colorVal == 0 ? 333 : (int)colorVal == 120 ? 333 : 177;
            float sat = map (hue, 159, 333, 100, 80);
            if (colorVal == 120) sat = 70;
            tempShape.setStroke(color(hue, sat, lightness, globalLineAlpha));
            // float hue = colorVal+159%360;
            // tempShape.setStroke(color(hue, 100, 100, globalLineAlpha));
        } else if (colorMode == 3) {


            float hue = ((int)colorVal == 0 ? globalLineHue : (int)colorVal == 120 ? globalLineHue-15 : globalLineHue-30);
            float sat = map (hue, 159, 333, 100, 80);
            tempShape.setStroke(color(hue, sat, lightness, globalLineAlpha));
            // float hue = colorVal+159%360;
            // tempShape.setStroke(color(hue, 100, 100, globalLineAlpha));
        } else if (colorMode == 4) {


            float hue = (int)colorVal == 0 ? 30 : (int)colorVal == 120 ? 45 : 177;
            float sat = map (hue, 30, 177, 100, 80);
            tempShape.setStroke(color(hue, sat, lightness, globalLineAlpha));
            // float hue = colorVal+159%360;
            // tempShape.setStroke(color(hue, 100, 100, globalLineAlpha));
        } else if (colorMode == 5 ) {
            float hue = map(colorVal, 0, 360, 322, 333);
            float sat = map (hue, 322, 333, 50, 10);


            tempShape.setStroke(color(hue, sat, lightness, globalLineAlpha));

        } else if (colorMode == 6 ) {

            tempShape.setStroke(color(60, 100, lightness, globalLineAlpha));

        } else if (colorMode == 7 ) {

            tempShape.setStroke(color(0, 0, toggle1?100:0, globalLineAlpha));

        } else if (colorMode == 8 ) {
            float hue = (int)colorVal == 0 ? 177 : 30;
            float sat = map (hue, 159, 333, 100, 80);
            if (hue == 177) sat = 70;
            else if (colorVal == 120 ||colorVal == 180 || colorVal == 240) sat = 0;

            println(colorVal);
            tempShape.setStroke(color(hue, sat, lightness, globalLineAlpha));


        } 
        // tempShape.noFill();

        tempShape.setStrokeWeight(globalLineWidth > 0 ? globalLineWidth : .001);
    }

    void renderAtom () {
        shape(atom);
        
    }

    void renderEntity () {
        // setStrokeColor();

        if (entitiyType == 4) {
            renderCardioid();
        } else {
            for (int i = 0; i < sides; ++i) {
                push();
                    rotate(map(i, 0, sides, 0, TWO_PI));
                    this.renderLeaf();
                pop();
            }
        }
    }

    void generateLeaf (int curSide) {
        float angleMinLf = entitiyType == 3 ? PI : 0;
        float angleMaxLf = entitiyType == 3 ? PI : TWO_PI;

        for (float i = 0; i < lines; ++i) {

            float x1 = (cos(map(i, 0, lines, angleMinLf, angleMaxLf)) * rndrScl);
            float y1 = (sin(map(i, 0, lines, angleMinLf, angleMaxLf)) * rndrScl);

            if (entitiyType != 2) {
                float temp = x1;
                x1 = y1;
                y1 = temp;
            }

            // atom.rotate(map(curSide, 0, sides, 0, TWO_PI));
            PVector vec1 = new PVector(x1, y1);
            PVector vec2 = new PVector(0, -rndrScl);
            vec1.rotate(map(curSide, 0, sides, 0, TWO_PI));
            vec2.rotate(map(curSide, 0, sides, 0, TWO_PI));
           
            PShape atomLine = createShape(LINE, vec1.x, vec1.y, vec2.x, vec2.y);    
            setShapeStroke(atomLine, map(i, 0, sides, 0, 360));
            atom.addChild(atomLine);
        }
    }

    void generateCardioid (int i) {
        PVector a = getVector(i);
        PVector b = getVector(i * lines);
        PShape atomLine = createShape(LINE, a.x, a.y, b.x, b.y);    
        setShapeStroke(atomLine, map(i, 0, sides, 0, 360));
        atom.addChild(atomLine);
    }
    
    PVector getVector ( float index ) {
        float angle = map(index % sides, 0, sides, 0, TWO_PI);
        PVector v = PVector.fromAngle(angle + PI/2);
        v.mult(rndrScl);
        return v;
    }

    void renderLeaf () {

        /*
            1) symentrical T -  halfLeaf F
            2) symentrical F -  halfLeaf F
            3) symentrical T -  halfLeaf T (DOTS)
            4) renderCardiod
        
        */

        float angleMinLf = entitiyType == 3 ? PI : 0;
        float angleMaxLf = entitiyType == 3 ? PI : TWO_PI;

        for (float i = 0; i < lines; ++i) {

            float x1 = (cos(map(i, 0, lines, angleMinLf, angleMaxLf)) * rndrScl);
            float y1 = (sin(map(i, 0, lines, angleMinLf, angleMaxLf)) * rndrScl);

            if (entitiyType != 2) {
                float temp = x1;
                x1 = y1;
                y1 = temp;
            }

            line(x1, y1, 0, -rndrScl);
        }
    }

    void renderCardioid () {
        for (int i = 0; i < sides; i++) {
            PVector a = getVector(i);
            PVector b = getVector(i * lines);
            line(a.x, a.y, b.x, b.y);
        }
    }

    void deityHigherDimRender() {
        for (int i = 0; i < deityHiger; ++i) {
             push();
                float x1 = (cos(map(i, 0, deityHiger, 0, TWO_PI)) * rndrScl);
                float y1 = (sin(map(i, 0, deityHiger, 0, TWO_PI)) * rndrScl);

                translate(x1, y1);

                deityRender();

            pop();
           
        }
        
    }

    void deityRender() {
        for (int i = 0; i < deityNum; ++i) {
             push();
                float x1 = (cos(map(i, 0, deityNum, 0, TWO_PI)) * rndrScl);
                float y1 = (sin(map(i, 0, deityNum, 0, TWO_PI)) * rndrScl);

                translate(x1, y1);

                rotate(deityAlg); 
                renderHigherDimensionalEntity();

            pop();
           
        }
        
    }

    void renderHigherDimensionalEntity () {

        
        for (float i = 0; i < higherDims; ++i) {

            push();
                float x1 = (cos(map(i, 0, higherDims, 0, TWO_PI)) * rndrScl);
                float y1 = (sin(map(i, 0, higherDims, 0, TWO_PI)) * rndrScl);

                translate(x1, y1);
 
                // println(this.sides);
                this.renderInterdimensionalEntity();

            pop();
        }

    }

    void renderInterdimensionalEntity () {
        
        
        for (float i = 0; i < dims; ++i) {
            
            push();
                float x1 = (cos(map(i, 0, dims, 0, TWO_PI)) * rndrScl);
                float y1 = (sin(map(i, 0, dims, 0, TWO_PI)) * rndrScl);

                translate(x1, y1);

                rotate(hdAgl);   
                renderAtom();

            pop();
        }

    }

}
