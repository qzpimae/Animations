
int testImgNum;
int renderSpeed = 10;
float globalMagMin = -200;
float globalMagMax = 200;
boolean isPaused = false;
boolean isFastForwarding = false;
boolean showOpts = false;
boolean toggle1 = false;
boolean toggle2 = false;
boolean toggle3 = false;
int MAX_HEADING_OPT = 4;
int headingOpt = 3;
int MAX_MAG_OPT = 5;
int magOpt = 2;

ArrayList<Spec> specs;
int specCol = 6;

  //width: (4K) 3840; // (HD) 1920 //(Square HD) 1280 //(SD) 1280 
  // height: (4K) 2160; //(HD) 1080 //(Square HD) 1024//(SD) 720
float W = 3840;
float H = 2160;

void settings() {
  //set canvas size
   fullScreen();
  // size((int)W, (int)H); 
  size((int)W, (int)H, P2D); 

}


void setup() {
  // //set colormode

  //   size(500,500, P2D);
  // colorMode(HSB, 360, 100, 100, 100);
  // // noLoop();

  //   // int lines = parseInt(loadStrings("./testimgnum.txt")[0]);
  //   // println(testImgNum);
  // //background(0);


//   frameRate(2);
  colorMode(HSB, 360, 100, 100, 100);
  // noLoop();
  noCursor();
  initalize();
  fastForward ();
  println(specs.size());


    

  //background(0);
}

void fastForward () {
  //FAST FORWARD
  for (int k = 0; k < 22222; ++k) {
    for (int i = 0; i < specs.size(); ++i) {
            // specs[i][j].draw();
            specs.get(i).move();
        
    }
  }
}

void initalize () {
  specs = new ArrayList<Spec>();
  for (float i = 0; i < H; i+=2) {
    for (float j = 0; j < specCol; j+=1) {

        float initX =  map(j, 0, specCol, 0, W) + W/specCol/2;
        float initY1 = i;
        float initY2 = H-i;
        float initMag = map(i, 0, H, globalMagMin, globalMagMax) * (j % 2 ==0 ? 1 : -1);
        
        specs.add(new Spec(
            initX, 
            initY1,
            initMag
            )
        );

        specs.add(new Spec(
            initX, 
            initY2,
            initMag
            )
        );
    }
  }

  if (isFastForwarding) fastForward();
}

void draw() {
  
    
    if (!isPaused) {
        background(0);
        
        for (int i = 0; i < specs.size(); ++i) {
            // for (int j = 0; j < specCol; ++j) {
                specs.get(i).draw();
                for (int k = 0; k < renderSpeed; ++k) {
                  specs.get(i).move();
                }
                
            // }
            
        }

        // fill(360);
        // circle((W/2), H/2, renderSpeed);


    }

    if (showOpts) {

      String controlData = ("MinMag: " + globalMagMin + "\nMaxMag: " + globalMagMax +"\nSpec Cols: " + specCol+"\nHeadingOpt: " + headingOpt+"\nMagOpt: " + magOpt+"\ntoggle1: " + toggle1+"\ntoggle2: " + toggle2+"\ntoggle3: " + toggle3);
      // println(controlData);
      
      textSize(30);
      fill(360);
      text(controlData, 100, 100, W/2, 1000f);
    }

}


void keyPressed() {
    switch(key) {
        case 'a':
            if (renderSpeed > 0)renderSpeed--;
            break;
        case 's':
            renderSpeed++;
            break;
        case 'u':
            if (headingOpt > 1) headingOpt--;
            break;
        case 'i':
            if (headingOpt < MAX_HEADING_OPT) headingOpt++;
            break;
        case 'o':
            if (magOpt > 0) magOpt--;
            break;
        case 'p':
            if (magOpt < MAX_MAG_OPT) magOpt++;
            break;
        case 'q':
            globalMagMin-=1;
            break;
        case 'w':
            globalMagMin+=1;
            break;
        case 'e':
            globalMagMax-=1;
            break;
        case 'r':
            globalMagMax+=1;
            break;
        case 't':
            if (specCol > 0) specCol-=1;
            break;
        case 'y':
            specCol+=1;
            break;
        case ' ':
            isPaused = !isPaused;
            break;
        case 'm':
            showOpts = !showOpts;
            break;
        case '.':
            isFastForwarding = !isFastForwarding;
            break;
        case '[':
            toggle1 = !toggle1;
            break;
        case ']':
            toggle2 = !toggle2;
            break;
        case '\\':
            toggle3 = !toggle3;
            break;
        case '/':
            println("\nMinMag: " + globalMagMin + "\nMaxMag: " + globalMagMax +"\nSpec Cols: " + specCol+"\nHeadingOpt: " + headingOpt+"\nMagOpt: " + magOpt);
            initalize();
            break;
    }
}

