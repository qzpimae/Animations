//imports
import controlP5. *;

//GLOBAL VARS
//Noise algorithm that produces values used in this animation, not made by me
OpenSimplex2S noise;

//TEST VARS
boolean isTesting = false;
boolean keepPrinting = true;
int printCount = 0;
int printLim = 100;
boolean switched = true;

//CONTROLERS
ControlP5 controller;
ControlGroup gui;

int colorMode = 1;
int colorModeMax = 4;

final float fps = 60;
float renderSpeed = 3;
// boolean renderFullSpeed = true;

boolean showStars = true;
boolean showGalaxy = true;
boolean showNebula = false;
boolean showFlower = true;
boolean showLife = true;
boolean showInfinity = false;




//tracker for how many frames have elapsed
boolean isPaused = false;
float frames;
int time; //kindof like frames but frames will always increase by one. Time by increase at a slower or quicker rate for 
int count;

//width and height of canvas 
//to change the resolution update both the WIDTH AND HEIGHT also change the values on  line 48
final int WIDTH = 1440;//(300dpi) 9933// (8K) 7680// (print) 3576// (4K) 3840//(UHD)//(72dpi) 2384// 2560//(HD) 1920//(M0S) 1680//(Square HD) 1280//(SD) 1280//2560 //960
final int HEIGHT = 900;//(300dpi) 7016// (8K) 4320// (print) 2472// (4K) 2160//(UHD)//(72dpi) 1648// 1440//(HD) 1080//(M0S) 1050//(Square HD) 1024//(SD) 720 //1600 //540
final float centerX = WIDTH/2;
final float centerY = HEIGHT/2;
final float maxDistance = centerX+centerY;//centerX+centerY;

Planet planet;

Infinity infinity;
Matrix matrix;
Geometry geoRender;
SpaceRender spaceRender;
ThreeDimCam cam3D;
SpaceFlower spaceFlower;
ThreeDimLife lifeRender;
//NebulaController nebulaCtrl;
Nebula nebula;
SpaceDebris spaceDebris;

void settings() {
  //set canvas size
  size(WIDTH, HEIGHT, P3D); //width: (4K) 3840; // (HD) 1920 //(Square HD) 1280 //(SD) 1280 // height: (4K) 2160; //(HD) 1080 //(Square HD) 1024//(SD) 720
  fullScreen();
}

void setup() {
  //set colormode
  colorMode(HSB, 10000, 100, 100, 1);
  //create objects
  controller = new ControlP5(this);
  cam3D = new ThreeDimCam();
  geoRender = new Geometry();
  spaceRender = new SpaceRender();
  spaceFlower = new SpaceFlower();
  lifeRender = new ThreeDimLife();
  nebula = new Nebula();
  spaceDebris = new SpaceDebris();
  noise = new OpenSimplex2S( 314159265 ); 
  infinity = new Infinity();
  matrix = new Matrix();
  //nebulaCtrl = new NebulaController();



  spaceRender.starGenesis();
  lifeRender.lifeGenesis(2);
  //nebulaCtrl.birthNebula();
  spaceDebris.spawnGalaxies();
  spaceDebris.spawnDust();
  noStroke(); 
  frameRate(fps);

  //planet = new Planet("./testing (6).png", 1000); //switch to either 'earth-render' or 'mars-render' to see diffrent planets 

  createGUI();
  if (isTesting) {
    gui.show();
  } else {
    noCursor(); //commented for live testing
    gui.hide();
  }
  // noLoop(); ///uncomment to only render one frame

  //set up controllers

}

//loop function that runs on a loop 
void draw() {
  
  //println(radius);

  perspective(1.5, width/height, 1, 4000);
  cam3D.configureCamera(cameraSelection);

  if (!isPaused) {
    //println(frames);
    frames+=renderSpeed;
    time=(int)frames;
    // saveFrame("../../../sakura314/img_######.png");
  }

  renderScene();

}

void renderScene () {
  clear(); // reset screen
    //background(0);
    
    spaceRender.displayStars();

    geoRender.renderMain();

    // matrix.render();
    
    //nebulaCtrl.renderNebula();
    //lifeRender.lifeGenesis(2);
    //lifeRender.renderLife();

    if (isTesting) {
      // cam3D.renderCamGumball();

      //sphere 
      // noFill();
      // stroke(10000);
      // sphere(500);
      renderGUI();
    } 

    //planet.render();

}

void printTestOutput () {

  String var1 = "1: " + cameraSelection;
  String var2 = "2: " + radius;
  String var3 = "3: " + globalAngl;
  String var4 = "4: " + infinityVar;

  push();

    noStroke();
    fill(0);
    rect(0, 0, 200, 300, 0, 0, 20, 0); 

    fill(10000);
    text(var1, 40, 60);
    text(var2, 40, 90);
    text(var3, 40, 120);
    text(var4, 40, 150);
    
  pop();
}

void renderGUI () {
  textSize(20);
  blendMode(BLEND);
  camera();
  perspective();
  printTestOutput();
  
}

void createGUI () {
    Slider slider1 = controller.addSlider("cameraSelection")
     .setPosition(30,0)
     .setRange(0,5);

    Slider slider2 = controller.addSlider("infinityVar")
     .setPosition(30,20)
     .setRange(1,10);

    Slider slider3 = controller.addSlider("globalAngl")
     .setPosition(30,40)
     .setRange(.01,.5);

    Slider slider4 = controller.addSlider("renderSpeed")
     .setPosition(30,60)
     .setRange(.5,5);

    gui = controller.addGroup("gui", 0, 400, 300);
    
    gui.setBackgroundHeight(80);
    // gui.setBackgroundColor(color(0,100));
    gui.hideBar();

    slider1.moveTo(gui);
    slider2.moveTo(gui);
    slider3.moveTo(gui);
    slider4.moveTo(gui);

}

void keyPressed() {
  switch (key) {
    case ' ': 
      isPaused = !isPaused;
      break;

    case 'p': 
      println(camTiltX, camTiltY);
      break;
    case 'm':
      isTesting = !isTesting;
      break;
    case '=':
      saveFrame("../../../sakura314/img_######.png");
      break;
    case '\\':
      cameraSelection = cameraSelection < 6 ? cameraSelection+1 : 1;
      break;
    case '/':
      colorMode = colorMode < colorModeMax ? colorMode+1 : 1;
      break;
    case 'a':
      renderSpeed = renderSpeed < 10 ? renderSpeed+0.1 : 10;
      break;
    case 's':
      renderSpeed = renderSpeed > 0.1 ? renderSpeed-0.1: 0.1;
      break;
    case 'w':
      renderSpeed = renderSpeed < 10 ? renderSpeed+1 : 10;
      break;
    case 'q':
      renderSpeed = renderSpeed > 1 ? renderSpeed-1: 1;
      break;
    case 'z':
      showStars = !showStars;
      break;
    case 'x':
      showGalaxy = !showGalaxy;
      break;
    case 'c':
      showFlower = !showFlower;
      break;
    case 'n':
      showInfinity = !showInfinity;
      break;
    case 'b':
      showNebula = !showNebula;
      break;
    case 'v':
      showLife = !showLife;
      break;
    case '\t':
      renderSpeed /= 10;
      break;




      
  }

  

}
