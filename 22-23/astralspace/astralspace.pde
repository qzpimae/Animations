//IMPORTS
boolean isPaused = false;
float globalXScale = 121;
float globalYScale = 121;
float globalDimensions = 6;
float renderSpeed = .15;
float globalNoiseMult = 17;

float globalRndrScl = 333;

float globalAngle = 0;
float globalHDAngle = 0;
float globalDeityAngle = 0;
float noiseVar1 = 1;
float incrementer = 1;

int colorMode = 1;
int globalLineHue = 177;
int globalBgHue = 339;

int renderOption = 9;
boolean invertHue = false;
boolean invertLight = true;

boolean isShowingVars = false;
boolean renderAdvanceToggle = true;
boolean toggle1 = true;
boolean toggle2 = true;

boolean dragLocked = true;

float xOffset = 0;
float yOffset = 0;
float transX = 0;
float transY = 0;

//Created for preformance boost
PImage a;
color [] A;


//GLOBAL VARS
  //Noise algorithm that produces values used in this animation, not made by me
OpenSimplex2S noise;
NoiseController noiseController;
NoiseMult nMult;
//seeds for noise algorithm, can be randomized for unique image every render
NoiseSeed nSeedX1 = new NoiseSeed((float) Math.random()*1000 + 417.3939);
NoiseSeed nSeedX2 = new NoiseSeed((float) Math.random()*1000 + 777.777);
NoiseSeed nSeedY1 = new NoiseSeed((float) Math.random()*1000 + 3939.719);
NoiseSeed nSeedY2 = new NoiseSeed((float) Math.random()*1000 + 3141.5826);
//width and height of canvas

final int WIDTH =   1280;//(300dpi) 9933// (8K) 7680// (print) 3576// (4K) 3840//(UHD)//(72dpi) 2384// 2560//(HD) 1920//(M0S) 1680//(Square HD) 1280//(SD) 1280//2560 //960
final int HEIGHT = 720;//(300dpi) 7016// (8K) 4320// (print) 2472// (4K) 2160//(UHD)//(72dpi) 1648// 1440//(HD) 1080//(M0S) 1050//(Square HD) 1024//(SD) 720 //1600 //540
//tracker for how many frames have elapsed
float frames = 0;
//array of Points to keep track of quadrent information and x/y position aswell as pixel index
Point[] allPixs = new Point[WIDTH*HEIGHT];


double xStatic;
double yStatic;
//boolean testPrint = true; //this gets used print testing logs only a certain number of times while looping
//setup function that runs before render

void settings() {
  //set canvas size
  //
  fullScreen();
  //width: (4K) 3840; // (HD) 1920 //(Square HD) 1280 //(SD) 1280 =
  //height: (4K) 2160; //(HD) 1080 //(Square HD) 1024//(SD) 720
  // size(WIDTH, HEIGHT, P2D); 
  size(WIDTH, HEIGHT); 

}

void setup() {
  frameRate(24);
  
  //set canvas size
  colorMode(HSB, 360, 100, 100);
  //create instance of the simplex noise class
  noise = new OpenSimplex2S( 3141592 );
  noiseController = new NoiseController();
  nMult = new NoiseMult();
  //run function to fill allPixs array
  noiseController.initalizePixels();
  nMult.initalize();
   noCursor();
    //noLoop(); //uncomment to only render one frame
}

//loop function that runs on a loop 
void draw() {


  if (!isPaused) {
    // isPaused = true;
    
    // xStatic -= .1 * renderSpeed;
    // yStatic -= .1 * renderSpeed;
    // globalXScale = globalXScale - .2 * renderSpeed > 0 ? globalXScale - .2 * renderSpeed : globalXScale;
    // globalYScale = globalYScale - .5 * renderSpeed > 0 ? globalYScale - .5 * renderSpeed : globalYScale;
    // renderSpeed += .001;
    // println(globalXScale,globalYScale,globalRndrScl);//xStatic,yStatic,
    // background(0); // reset screen
    
    frames++; //iterate frame tracker

    switch (renderOption) {
      case 1: noiseController.displayNoise(); break;
      case 2: nMult.renderNoise1(); break;
      case 3: nMult.renderNoise2(); break;
      case 4: nMult.renderNoise3(); break;
      case 5: nMult.renderNoise4(); break;
      case 6: nMult.renderNoise5(); break;
      case 7: nMult.renderNoise6(); break;
      case 8: nMult.renderNoise7(); break;      
      case 9: nMult.renderNoise8(); break;
      case 10: nMult.renderNoise4(); break;
      
    }

    // saveFrame("../../../static/noise_#####.png");
    if (isShowingVars) displayVars();

  }
}


void displayVars() {

  fill(0);
  rect(0, 0, 444, 1444);



  textSize(30);
  fill(360);
  text("frames: " + frames, 50, 30);
  text("XScale(q/w): " + globalXScale, 50, 70);
  text("YScale(a/s): " + globalYScale, 50, 110 );
  text("dim(d/f): " + globalDimensions, 50, 150 );
  text("renderSpeed(c/v): " + renderSpeed, 50, 190 );
  text("deityNum(g/h): " + globalNoiseMult, 50, 230 );
  text("scl(z/x): " + globalRndrScl, 50, 300 );
  text("lw(e/r): " + noiseVar1, 50, 350 );
  text("inc(t/y): " + incrementer, 50, 400 );
  text("rndOpt(#): " + renderOption, 50, 450 );
  text("2X scl(n)", 50, 500 );
  text("/2 scl(b)", 50, 550 );
  text("screenshot(=)", 50, 600 );
  text("toggleDis(m): "+(isShowingVars?"on":"off") , 50, 650 );
  text("invertHue(,): "+(invertHue?"on":"off"), 50, 700 );
  text("invertLight(.): "+(invertLight?"on":"off"), 50, 750 );
  text("colorMode(/): "+colorMode, 50, 800 );
  text("transX: "+transX, 50, 850 );
  text("transY: "+transY, 50, 900 );
  text("resetVars(\\)", 50, 950 );
  text("G-angle( [/] ):" + globalAngle, 50, 1000 );
  text("D-angle( o/p ):" + globalDeityAngle, 50, 1050 );
  text("HD-angle( u/i ):" + globalHDAngle, 50, 1100 );
  text("HD-rotate(j):"+(toggle1?"on":"off"), 50, 1150 );
  text("D-rotate(k):"+(toggle2?"on":"off"), 50, 1200 );
  text("leaftType(l):"+(renderAdvanceToggle?"0":"1"), 50, 1250 );
  text("Colors( ' ) bg:"+globalBgHue+" ln:"+globalLineHue, 50, 1300 );
  text("incrementAll(-)", 50, 1350 );
}


void keyPressed() {
  
  // print("key");
  switch (key) {
    case ',':
      invertHue = !invertHue;
      break;
    //VAR 1 - line num
    case 'q': 
    globalXScale = globalXScale-incrementer/10 > 0 ? globalXScale-incrementer/10 : .01;
      break;
    case 'w': 
      globalXScale+=incrementer/10;
      break;
    //VAR 2 - side num
    case 'a': 
      globalYScale = globalYScale-incrementer/10 > 0 ? globalYScale-incrementer/10 : .01;
      break;
    case 's': 
      globalYScale+=incrementer/10;
      
      break;
    //VAR 3 - render scale
    case 'z': 
      globalRndrScl = globalRndrScl-incrementer/10 > 0 ? globalRndrScl-incrementer/10 : .01;
      break;
    case 'x': 
      globalRndrScl+=incrementer/10;
      break;
    //VAR 5 - dimensions
    case 'd': 
      globalDimensions-=incrementer;
      if (globalDimensions < 1) globalDimensions = 1;
      
      break;
    case 'f': 
      globalDimensions+=incrementer;
      break;
    //VAR 6 - higher dimensions
    case 'c': 
      renderSpeed = renderSpeed-incrementer/100 > 0 ? renderSpeed-incrementer/100 : .01;
      break;
    case 'v': 
      renderSpeed+=incrementer/100;
      break;
    //VAR 7 - deitiy dimensions
    case 'g': 
      globalNoiseMult-=incrementer;
      if (globalNoiseMult < 1) globalNoiseMult = 1;
      break;
    case 'h': 
      globalNoiseMult+=incrementer;
      break;
    //VAR 4 - line width
    case 'e': 
      noiseVar1-=.010;
      if (noiseVar1 <= 0) noiseVar1 = .001;
      
      break;
    case 'r': 
      noiseVar1+=.010;
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
    case 'j': 
      toggle1 = !toggle1;
      break;
    case 'k': 
      toggle2 = !toggle2;
      break;
    case 'l': 
      renderAdvanceToggle = !renderAdvanceToggle;
      break;
    case 'b': 
      globalRndrScl = globalRndrScl/2;
      break;
    case 'n': 
      globalRndrScl = globalRndrScl*2;
      break;
    case '=': 
      saveFrame("../../../renderScreenShot/screenshot_######.png");
      break;
    case '-': 
      // ranIncrement();
      break;
    case '\\':
      globalAngle = 0;
      globalDeityAngle = 0;
      globalHDAngle = 0;
      globalDimensions = 1;
      renderSpeed = 1;
      globalYScale = 1;
      globalXScale = 1;
      globalNoiseMult = 1;
      noiseVar1 = .01;
      globalRndrScl = 272; 
      transX = 0;
      transY = 0;
      invertLight = false;
    break;
    case '.':
      invertLight = !invertLight;
    break;
    case '/':
      colorMode = colorMode < 3 ? colorMode+1 : 1;
      println("colormode: " + colorMode);
    break;
    case '[':
      globalAngle = globalAngle > 0 ? globalAngle-incrementer : 360;
    break;
    case ']':
      globalAngle = globalAngle < 360 ? globalAngle+incrementer : 0;

    break;
    case 'o':
      globalDeityAngle = globalDeityAngle > 0 ? globalDeityAngle-incrementer : 360;
    break;
    case 'p':
      globalDeityAngle = globalDeityAngle < 360 ? globalDeityAngle+incrementer : 0;

    break;
    case 'u':
      globalHDAngle = globalHDAngle > 0 ? globalHDAngle-incrementer : 360;
    break;
    case 'i':
      globalHDAngle = globalHDAngle < 360 ? globalHDAngle+incrementer : 0;

    break;
    case ';':
      
    break;
    case '\'':
      globalBgHue = globalBgHue < 361 ? globalBgHue + (int) incrementer : 1;
      globalLineHue = globalLineHue < 361 ? globalLineHue + (int) incrementer : 1;

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
    case '7': 
      renderOption = 7;
      break;
    case '8': 
      renderOption = 8;
      break;
    case '9': 
      renderOption = 9;
      break;
    case '0': 
      renderOption = 10;
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
  if (globalXScale > 1) {
    float sclChangeX = globalXScale + (event.getCount() * incrementer);
    globalXScale = sclChangeX > 1 ? sclChangeX : 3;

    float sclChangeY = globalYScale + (event.getCount() * incrementer);
    globalYScale = sclChangeY > 1 ? sclChangeY : 3;
  }else {
    globalXScale = 1;
  }
  //  else if ( globalRndrScl == 10 && event.getCount() == 1) {
  //   globalRndrScl = 10 * 2;
  // } 
}