
import processing.sound.*;

int testImgNum;

final int W = 1680;//(8K) 7680// (4K) 3840//(UHD) 2560//(HD) 1920//(M0S) 1680//(Square HD) 1280//(SD) 1280//2560
final int H = 1050;//(8K) 4320// (4K) 2160//(UHD) 1440//(HD) 1080//(M0S) 1050//(Square HD) 1024//(SD) 720 //1600
boolean isPaused = true;
float frames;
int time; 
boolean timeForward = true;

float renderSpeed = 1;

Entity renderingEntity;
boolean entityUpdated = true; 

//Debuging var
boolean flag = false;

//41214142

float globalLines = 3;
float globalSides = 317;
float globalDimensions = 21;
float globalHigherDimensions = 10;
float globalDeityNum = 10;
float globalDeityHigherNum = 8;

float globalAngle = 90;
float globalHDAngle = 0;
float globalDeityAngle = 0;
float globalRndrScl = 5069;
float globalLineWidth = .2;
float globalLineAlpha = 15;
float incrementer = 10;

int colorMode = 1;
int globalLineHue = 177;
int globalBgHue = 339;

int renderOption = 2;
boolean toggle1 = true;
boolean isShowingVars = false;

int entitiyType = 1;
int MAX_ENTITIY_TYPE = 4;

boolean clearScreen = true;
boolean renderToggle = true;

boolean dragLocked = true;

float xOffset = 0;
float yOffset = 0;
float transX = 0;// screenshots: -300;
float transY = 0;
Space space;

void settings() {
  //set canvas size
   fullScreen();
  size(W, H); //width: (4K) 3840; // (HD) 1920 //(Square HD) 1280 //(SD) 1280 // height: (4K) 2160; //(HD) 1080 //(Square HD) 1024//(SD) 720

}


void setup() {
  //set colormode
  frameRate(10);
  colorMode(HSB, 360, 100, 100, 100);
  // noLoop();
  // noCursor();
  space = new Space();

  testImgNum = parseInt(loadStrings("./testimgnum.txt")[0]);

  //background(0);
}

//loop function that runs on a loop 
void draw() {
  
  if (renderToggle) space.renderScene(renderOption);

  // convolutionMask4(0xfffffff);
 
  if (!isPaused) {
    
    // INCREMENT NUMBERS
    timedIncrement ();
    // saveFrame("../../../newrender2822/img_######.png");
  
  }

}

void timedIncrement () {
    frames+=renderSpeed;
    time = timeForward ? time+1 : time -1;
    // yOffset += 1;
    //println(frames);
    // globalRndrScl -= .7 * renderSpeed;

    if ( time % 111 == 0 ) {
      // incrementAll(1);
      // ranIncrement();
    }

    globalHDAngle = timeForward ? globalHDAngle - .5 : globalHDAngle + .5;
    globalAngle = timeForward ? globalAngle + .5 : globalAngle - .5;
    entityUpdated = true;
    // globalLines+=.05;
    // globalSides+=.05;
    // globalLines += .02 * renderSpeed;
    // globalSides += .005;
    // globalDimensions += .002;
    // globalHigherDimensions += .001;
    // globalRndrScl = map(frames, 0, 3333, 3333, 222);

    // if (clearScreen) globalHDAngle = globalHDAngle > 0 ? globalHDAngle - .01 * incrementer : 360;
    // if (renderToggle) globalDeityAngle = globalDeityAngle > 0 ? globalDeityAngle - .01 * incrementer: 360;
    // globalAngle += .05;

    // if (colorMode == 1) {
    //   globalBgHue += .2;
    //   globalLineHue += .2;
    // }
    // if (time >= 1000 && globalAngle % 30 == 0) {
    //   timeForward = false;
    // }

    // if (time < 1 && globalAngle % 30 == 0) {
    //   isPaused = true;
    // }
}

void incrementAll (int inc) {
  globalLines += inc;
  globalSides += inc;
  globalDimensions += inc;
  globalHigherDimensions += inc;
  globalDeityNum += inc;
  globalDeityHigherNum += inc;
}

void ranIncrement() {
  float ran = random(1);
  if ( ran < .2) {
    globalLines += incrementer;
  } else if ( ran < .4) {
    globalSides += incrementer;
    
  } else if ( ran < .6) {
    globalDimensions += incrementer;
    
  } else if ( ran < .8) {
    globalHigherDimensions += incrementer;

  } else {
    globalDeityNum += incrementer;
  }

  // println((int)globalSides+"-"+(int)globalLines+"-"+(int)globalDimensions+"-"+(int)globalHigherDimensions);
}

void displayVars() {

  fill(0);
  rect(0, 0, 444, 1444);



  textSize(30);
  fill(360);
  text("frames: " + frames + " - time: " + time, 50, 30);
  text("lines(q/w): " + globalLines, 50, 70);
  text("sides(a/s): " + globalSides, 50, 110 );
  text("dim(d/f): " + globalDimensions, 50, 150 );
  text("higDm(c/v): " + globalHigherDimensions, 50, 190 );
  text("deityNum(g/h): " + globalDeityNum, 50, 230 );
  text("deityHigNum(j/k): " + globalDeityHigherNum, 50, 300 );
  text("inc(t/y): " + incrementer + " lw(e/r): " + globalLineWidth + " la(;/'): " + globalLineAlpha, 50, 400 );
  text("rndOpt(#): " + renderOption, 50, 450 );
  text("2X scl(n)", 50, 500 );
  text("/2 scl(b)", 50, 550 );
  text("screenshot(=)", 50, 600 );
  text("toggleDis(m): "+(isShowingVars?"on":"off") , 50, 650 );
  text("toggle1(,): "+(toggle1?"on":"off"), 50, 700 );
  text("entitiyType(.): "+entitiyType, 50, 750 );
  text("colorMode(/): "+colorMode, 50, 800 );
  text("transX: "+transX + " - transY: "+transY, 50, 850 );
  text("scl(z/x): " + globalRndrScl, 50, 900 );
  text("resetVars(\\)", 50, 950 );
  text("G-angle( [/] ):" + globalAngle, 50, 1000 );
  text("D-angle( o/p ):" + globalDeityAngle, 50, 1050 );
  text("HD-angle( u/i ):" + globalHDAngle, 50, 1100 );
  text("clearScreen(0):"+(clearScreen?"on":"off"), 50, 1150 );
  text("D-rotate(k):"+(renderToggle?"on":"off"), 50, 1200 );
  text("leaftType(l): REPLACE", 50, 1250 );
  text("Colors( ' ) bg:"+globalBgHue+" ln:"+globalLineHue, 50, 1300 );
  text("incrementAll(-)", 50, 1350 );
}


void keyPressed() {
  switch (key) {
    case 'l':
      println(flag);
      break;
    case ',':
      toggle1 = !toggle1;
      entityUpdated=true;
      break;
    //VAR 1 - line num
    case 'q': 
      globalLines-=incrementer;
      if (globalLines <1 ) globalLines = 1;
      entityUpdated = true;
      break;
    case 'w': 
      globalLines+=incrementer;
      entityUpdated = true;
      break;
    //VAR 2 - side num
    case 'a': 
      globalSides-=incrementer;
      if (globalSides <2 ) globalSides = 1;
      entityUpdated = true;
      break;
    case 's': 
      globalSides+=incrementer;
      entityUpdated = true;
      break;
    //VAR 3 - render scale
    case 'z': 
      globalRndrScl-=incrementer*10;
      if (globalRndrScl < 1) globalRndrScl = 1;
      entityUpdated = true;
      break;
    case 'x': 
      globalRndrScl+=incrementer*10;
      entityUpdated = true;
      break;
    //VAR 5 - dimensions
    case 'd': 
      globalDimensions-=incrementer;
      if (globalDimensions < 1) globalDimensions = 1;
      entityUpdated = true;
      break;
    case 'f': 
      globalDimensions+=incrementer;
      entityUpdated = true;
      break;
    //VAR 6 - higher dimensions
    case 'c': 
      globalHigherDimensions-=incrementer;
      if (globalHigherDimensions < 1) globalHigherDimensions = 1;
      entityUpdated = true;
      break;
    case 'v': 
      globalHigherDimensions+=incrementer;
      entityUpdated = true;
      break;
    //VAR 7 - deitiy dimensions
    case 'g': 
      globalDeityNum-=incrementer;
      if (globalDeityNum < 1) globalDeityNum = 1;
      entityUpdated = true;
      break;
    case 'h': 
      globalDeityNum+=incrementer;
      entityUpdated = true;
      break;
    //VAR 8 - deitiy higher dimensions
    case 'j': 
      globalDeityHigherNum-=incrementer;
      if (globalDeityHigherNum < 1) globalDeityHigherNum = 1;
      entityUpdated = true;
      break;
    case 'k': 
      globalDeityHigherNum+=incrementer;
      entityUpdated = true;
      break;
    //VAR 4 - line width
    case 'e': 
      globalLineWidth-=.010;
      if (globalLineWidth <= 0) globalLineWidth = .001;
      entityUpdated = true;
      break;
    case 'r': 
      globalLineWidth+=.010;
      entityUpdated = true;
      break;
    //VAR 5 - incrementer
    case 't': 
      incrementer-=1;
      if (incrementer <= 0) incrementer = 1;
      break;
    case 'y': 
      incrementer+=1;
      break;
    //PAUSE
    case ' ': 
      isPaused = !isPaused;
      break;
    case 'm': 
      isShowingVars = !isShowingVars;
      break;
    case '8': 
      entityUpdated=true;
      break;
    case '9': 
      renderToggle = !renderToggle;
      break;
    case '0': 
      clearScreen = !clearScreen;
      break;
    case 'b': 
      globalRndrScl = globalRndrScl/2;
      entityUpdated = true;
      break;
    case 'n': 
      globalRndrScl = globalRndrScl*2;
      entityUpdated = true;
      break;
    case '=': 
      saveScreenShot();
     
      break;
    case '-': 
      incrementAll((int)incrementer);
      entityUpdated = true;
      // ranIncrement();
      break;
    case '\\':
      globalAngle = 0;
      globalDeityAngle = 0;
      globalHDAngle = 0;
      globalDimensions = 2;
      globalHigherDimensions = 2;
      globalSides = 2;
      globalLines = 2;
      globalDeityNum = 2;
      globalDeityHigherNum = 2;
      globalLineWidth = .3;
      globalLineAlpha = 10;
      globalRndrScl = 177; 
      transX = 0;
      transY = 0;
      entityUpdated = true;
    break;
    case '.':
      entitiyType = entitiyType < MAX_ENTITIY_TYPE ? entitiyType+1 : 1;
      println("entitiyType: " + entitiyType);
      entityUpdated = true;
    break;
    case '/':
      colorMode = colorMode < 3 ? colorMode+1 : 1;
      println("colormode: " + colorMode);
      entityUpdated = true;
    break;
    case '[':
      globalAngle = globalAngle > 0 ? globalAngle-incrementer : 360;
    break;
    case ']':
      globalAngle = globalAngle < 360 ? globalAngle+incrementer : 0;

    break;
    case 'o':
      globalDeityAngle = globalDeityAngle > 0 ? globalDeityAngle-incrementer : 360;
      entityUpdated = true;
    break;
    case 'p':
      globalDeityAngle = globalDeityAngle < 360 ? globalDeityAngle+incrementer : 0;
      entityUpdated = true;
    break;
    case 'u':
      globalHDAngle = globalHDAngle > 0 ? globalHDAngle-incrementer : 360;
      entityUpdated = true;
    break;
    case 'i':
      globalHDAngle = globalHDAngle < 360 ? globalHDAngle+incrementer : 0;
      entityUpdated = true;

    break;
    case ';':
        globalLineAlpha = globalLineAlpha-incrementer/2 > 0 ? globalLineAlpha-incrementer/10 : .1;
        entityUpdated = true;
    break;
    case '\'':
        globalLineAlpha = globalLineAlpha < 100 ? globalLineAlpha+incrementer/10 : globalLineAlpha;
        entityUpdated = true;
    break;

      //RENDER OPTIONS 
    case '1': 
      renderOption = 1;
      break;
    case '2': 
      renderOption = 2;
      break;
    case '3': 
      renderOption = 3;
      break;
    case '4': 
      renderOption = 4;
      break;
    case '5': 
      renderOption = 5;
      break;
    case '6': 
      renderOption = 6;
      break;
  }

  if (key == CODED) {
    switch (keyCode) {
      case UP:
        transY += incrementer/10;
      break;
      case DOWN:
        transY -= incrementer/10;
      break;
      case LEFT:
        transX += incrementer/10;

      break;
      case RIGHT:
        transX -= incrementer/10;

      break;
    }
  }

  

}

void mousePressed() {
  dragLocked = true; 
  xOffset = mouseX-transX; 
  yOffset = mouseY-transY; 

}

void mouseDragged() {
  if(dragLocked) {
    transX = mouseX-xOffset; 
    transY = mouseY-yOffset; 
  }
}

void mouseReleased() {
  dragLocked = false;
}

void mouseWheel(MouseEvent event) {
  if (globalRndrScl > 10) {
    globalRndrScl -= event.getCount() * incrementer * 2;
  } else if ( globalRndrScl == 10 && event.getCount() == 1) {
    globalRndrScl = 10 * 2;
  } else {
    globalRndrScl = 10;
  }
  entityUpdated = true;
}

void saveScreenShot () {

    String code = (int)globalSides+"-"+(int)globalLines;
    if (renderOption>1) code+="-"+(int)globalDimensions;
    if (renderOption>2) code+="-"+(int)globalHigherDimensions;
    if (renderOption>3) code+="-"+(int)globalDeityNum;
    if (renderOption>4) code+="-"+(int)globalDeityHigherNum;
    if (globalAngle % 360 != 0) code+="-1Agl"+(int)globalAngle;
    if (globalHDAngle % 360 != 0) code+="-2Agl"+(int)globalDeityHigherNum;
    if (globalDeityAngle % 360 != 0) code+="-3Agl"+(int)globalDeityAngle;
    code += "-type"+entitiyType;
    code += "-size"+(int)globalRndrScl;
    
    if (true) { //CHANGE IF CONTROL IS NEEDED

      //SAVE IN REGULAR SS DIR
      saveFrame("../../../renderScreenShot/entity_"+code+"_######.png");

      //SAVING TEST IMGS
      saveFrame("../kaleidoscopes/testimgs/testimg"+ (testImgNum++) + ".png"); 
      saveStrings("./testimgnum.txt", new String[]{testImgNum+""});
     
     
     } else {
      saveTransparentCanvas(-1, "screenshot_");
     } 
}

void saveTransparentCanvas(final color bg, final String name) {
  final PImage canvas = get();
  canvas.format = ARGB;

  final color p[] = canvas.pixels, bgt = bg & ~#000000;
  for (int i = 0; i != p.length; ++i)  if (p[i] == bg)  p[i] = bgt;

  canvas.updatePixels();
  canvas.save(dataPath(name + nf(frameCount, 4) + ".png"));
}

void convolutionMask4(int maskVal){
  loadPixels();
  int[] pixelArray = pixels;
  for(int i = 1; i < height-1; i++){
    int yStart=i*width+1;
    int yFinish=i*width+(width-1);
    for(int j = yStart; j < yFinish; j++) {
      pixelArray[j]=((pixelArray[j-width] & maskVal) + (pixelArray[j+width] & maskVal) + (pixelArray[j-1] & maskVal) + (pixelArray[j+1] & maskVal)) >> 2;
    }
  }
  updatePixels();
}