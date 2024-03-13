/*\

    Light: 5/6

*/

q
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import arb.soundcipher.*;

SoundCipher sc;
Minim minim;
AudioPlayer sound1;
AudioPlayer sound2;
AudioPlayer sound3;

int testImgNum;
int frames = 0;
int fps = 60;
int baseNote = 100;
int lightOffset = 0;

float renderSpeed = 10;
float globalMagMin = -100;
float globalMagMax = 100;
float sW = 5;
boolean isPaused = false;
boolean isFastForwarding = false;
boolean showOpts = false;
boolean tenXSpeed = false;
boolean trailToggle = false;
boolean strokeToggle = false;
boolean toggle1 = false;
boolean toggle2 = false;
boolean toggle3 = false;
boolean playTone1 = true;
boolean playSample1 = false;
boolean playSample2 = false;
boolean playSample3 = false;

int MAX_HEADING_OPT = 5;
int headingOpt = 1;
int MAX_MAG_OPT = 5;
int magOpt = 1;
int mod1 = 10;

boolean soundReset = true;

ArrayList<Spec> specs;
int specCol = 1;

  //width: (4K) 3840; // (HD) 1920 //(Square HD) 1280 //(SD) 1280 //2560 //1440
  // height: (4K) 2160; //(HD) 1080 //(Square HD) 1024//(SD) 720 //1600 //900
float W = 1280;
float H = 720;

void settings() {
  //set canvas size
   fullScreen();
   size((int)W, (int)H); 
//    frameRate(10);
//   size((int)W, (int)H, P2D); 

}


void setup() {
  // //set colormode
    frameRate(fps);

  //   size(500,500, P2D);
  // colorMode(HSB, 360, 100, 100, 100);
  // // noLoop();

  //   // int lines = parseInt(loadStrings("./testimgnum.txt")[0]);
  //   // println(testImgNum);
  // //background(0);

    minim = new Minim(this);
    sc = new SoundCipher(this);
    // sc.instrument = sc.SYNTH_DRUM;
    sc.instrument = sc.XYLOPHONE; 
    sound1 = minim.loadFile("effect1.mp3");
    sound2 = minim.loadFile("effect2.mp3");
    sound3 = minim.loadFile("effect3.mp3");

//   frameRate(2);
  colorMode(HSB, 360, 100, 100, 100);
  // noLoop();
  noCursor();
  initalize();
//   fastForward ();
//   println(specs.size());


    

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
  for (float i = 0; i < H; i+=5) {
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
        soundReset = true;
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

      String controlData = ("MinMag: " + globalMagMin + "\nMaxMag: " + globalMagMax+ "\nMod-1: " + mod1 +"\nSpec Cols: " + specCol+"\nSpeed: " + renderSpeed+"\nHeadingOpt: " + headingOpt+"\nMagOpt: " + magOpt+"\n10x Speed: " + tenXSpeed+"\ntoggle1: " + toggle1+"\ntoggle2: " + toggle2+"\ntoggle3: " + toggle3 + "\nBaseNote: " + baseNote + "\nFPS: " + fps);
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
        case '5':
            lightOffset -= 10;
            if (lightOffset < -360) lightOffset = -360;
        break; 
        case '6':
            lightOffset += 1;
            if (lightOffset > 1) lightOffset = 0;
            break;
        case '7':
            fps = fps > 1 ? fps - 1 : 1;
            frameRate(fps);
            break;
        case '8':
            fps = fps < 120 ? fps + 1 : 120;
            frameRate(fps);

            break;
        case '9':
            if (headingOpt > 1) headingOpt--;
            break;
        case '0':
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
        case 'i':
            baseNote = baseNote < 1000 ? baseNote + 1 : 1000;
            break;
        case 'u':
            baseNote = baseNote > -1000 ? baseNote - 1 : -1000;
            break;
        case 'j':
            baseNote = baseNote < 1000 ? baseNote + 10 : 1000;
            break;
        case 'h':
            baseNote = baseNote > -1000 ? baseNote - 10 : -1000;
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
        case 'k':
            playTone1 = !playTone1;
            break;
        case 'l':
            playSample1 = !playSample1;
            break;
        case ';':
            playSample2 = !playSample2;
            break;
        case '\'':
            playSample3 = !playSample3;
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
        case '`':
            renderSpeed *= 2;
            break;
        case '\t':
            renderSpeed /= 2;
            break;
        case '1':
            trailToggle = !trailToggle;
            break;
        case '2':
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

