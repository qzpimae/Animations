import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer sound1;
AudioPlayer sound2;
AudioPlayer sound3;

int testImgNum;
int frames = 0;
float renderSpeed = .1;
float globalMagMin = -100;
float globalMagMax = 100;
float sW = 1;
boolean isPaused = false;
boolean isFastForwarding = false;
boolean showOpts = false;
boolean tenXSpeed = true;
boolean trailToggle = false;
boolean strokeToggle = false;
boolean toggle1 = false;
boolean toggle2 = false;
boolean toggle3 = false;
int MAX_HEADING_OPT = 5;
int headingOpt = 2;
int MAX_MAG_OPT = 5;
int magOpt = 2;
int mod1 = 10;

ArrayList<Spec> specs;
int specCol = 30;

  //width: (4K) 3840; // (HD) 1920 //(Square HD) 1280 //(SD) 1280 //2560 //1440
  // height: (4K) 2160; //(HD) 1080 //(Square HD) 1024//(SD) 720 //1600 //900
float W = 1440;
float H = 900;

void settings() {
  //set canvas size
   fullScreen();
  size((int)W, (int)H); 
//   size((int)W, (int)H, P2D); 

}


void setup() {
  // //set colormode

  //   size(500,500, P2D);
  // colorMode(HSB, 360, 100, 100, 100);
  // // noLoop();

  //   // int lines = parseInt(loadStrings("./testimgnum.txt")[0]);
  //   // println(testImgNum);
  // //background(0);

    minim = new Minim(this);
    sound1 = minim.loadFile("effect1.mp3");
    sound2 = minim.loadFile("effect2.mp3");
    sound3 = minim.loadFile("effect3.mp3");

    // sound1.loop();

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
  for (int k = 0; k < 222; ++k) {
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
  
    frames++;

    
    if (!isPaused) {
        if (
            !trailToggle
            //  || 
            // frames % 100 == 0
        ) background(0);
        boolean tempTrailToggle = trailToggle;

        
        for (int i = 0; i < specs.size(); ++i) {
            // for (int j = 0; j < specCol; ++j) {
                specs.get(i).draw(i);
                for (int k = 0; k < (tenXSpeed ? renderSpeed * 10 : renderSpeed); ++k) {
                  specs.get(i).move();
                }
                
            // }
            
        }

        trailToggle = tempTrailToggle;

        // fill(360);
        // circle((W/2), H/2, renderSpeed);


    }

    if (showOpts) {

      String controlData = ("MinMag: " + globalMagMin + "\nMaxMag: " + globalMagMax+ "\nMod-1: " + mod1 +"\nSpec Cols: " + specCol+"\nSpeed: " + renderSpeed+"\nHeadingOpt: " + headingOpt+"\nMagOpt: " + magOpt+"\n10x Speed: " + tenXSpeed+"\ntoggle1: " + toggle1+"\ntoggle2: " + toggle2+"\ntoggle3: " + toggle3);
      // println(controlData);
      
      textSize(30);
      fill(360);
      text(controlData, 100, 100, W/2, 1000f);
    }

}


void keyPressed() {
    switch(key) {
        case 'b':
            sW = sW > 0.1 ? sW-.1 : .1;
            break;
        case 'n':
            sW+=.1;
            break;
        case 'a':
            // renderSpeed--;
            renderSpeed = renderSpeed > 0.1 ? renderSpeed-.1 : .05;
            break;
        case 's':
            renderSpeed+=.1;
            break;
        case 'z':
            // renderSpeed--;
            renderSpeed = renderSpeed > 1 ? renderSpeed-1 : .5;
            break;
        case 'x':
            renderSpeed+=1;
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
        case 'f':
            mod1--;
            break;
        case 'g':
            mod1++;
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
        case '\t':
            tenXSpeed = !tenXSpeed;
            break;
        case '`':
            trailToggle = !trailToggle;
            break;
        case '1':
            strokeToggle = !strokeToggle;
            break;
        case ';':
            trailToggle = !trailToggle;
            break;
        case '\'':
            strokeToggle = !strokeToggle;
            break;
        case '/':
            println("\nMinMag: " + globalMagMin + "\nMaxMag: " + globalMagMax +"\nSpec Cols: " + specCol+"\nHeadingOpt: " + headingOpt+"\nMagOpt: " + magOpt);
            initalize();
            break;
        case '=': 
            saveFrame("../../../renderScreenShot/insync/insync_######.png");
            break;
    }
}

