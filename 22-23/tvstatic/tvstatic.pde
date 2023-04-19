/**
(r/f) noiseVar1: 6442
(t/g) noiseVar2: 2001
(y/h) noiseVar3: 8146
(u/j) globalInc: 38.0
(q/a) posrange: 90
(w/s) subrange: 1
(e/d) imgChoice: 10
(x)   autoReset: false
(c)   randomizeMag: 15.820855
(v)   randomize range

 */



int W = 1440;//(8K) 7680// (4K) 3840//(UHD) 2560//(HD) 1920//(M0S) 1680//(Square HD) 1280//(SD) 1280//2560
int H = 900;//(8K) 4320// (4K) 2160//(UHD) 1440//(HD) 1080//(M0S) 1050//(Square HD) 1024//(SD) 720 //1600

PVector v;
PVector p;
PVector rx;
PVector rz;

int C = H;
int LIM = C - 1;
int posrange = 100;
int subrange = 1;
float globalInc = 100;

float angx = 0; // degrees
float angz = 0; // degrees

PImage img, imgH;

int IMG_MAX = 16;
int NOISE_VAR_MAX = 10000;
int noiseVar1 = 500;
int noiseVar2 = 100;
int noiseVar3 = 1;

float globalMag = 1;

int imgChoice = 1;
int prevImgChoice = -1;

int frames = 0;

int imgSelections = 1;

boolean autoReset = false;

void settings () {
  
  size(W,H);
  // size(W,H,P2D);
  fullScreen();
}
void setup() {
  
  colorMode(HSB, 360, 100, 100);
  angx = 321;
  angz = 280;
  v = new PVector(-31, -41, 15);
  
  //Using vectors of unit length will let us rotate without changing speed
  rz = new PVector(cos(angx*PI/180), sin(angx*PI/180), 0);
  rx = new PVector(0, sin(angz*PI/180), cos(angz*PI/180));
  p = new PVector(0, 0, 0);
  
  frameRate(18);

  noCursor();

}

void resetScreen () {


  int tempImg = (int)random(IMG_MAX);
  while (imgSelections == 0 && tempImg > 3 && tempImg < 11 || imgSelections == 1 && tempImg < 4 ) {
    tempImg = (int)random(IMG_MAX);
  }

  println(tempImg);
  imgChoice = tempImg;

  v.set(random(posrange)-subrange, random(posrange)-subrange, random(posrange)-subrange);
  
  p.set(random(W), random(H), random(H)); //start point could be random too
  // p.set(mouseX, mouseY, random(H)); //start point could be random too
  
  v.normalize();
  float mag = random(globalMag);
  v.setMag(mag);
  
  angx = random(90)-30; // degrees
  angz = random(90)-30; // degrees
  
  rz.set(cos(angx*PI/180), sin(angx*PI/180), 0);
  rx.set(0, sin(angz*PI/180), cos(angz*PI/180));
  
  //if you want to save a pattern for later
  // println("V: " + v);
  // println("angx: " + angx);
  // println("angz: " + angz);
  // println("mag: " + mag);
  // println("point: (" + p.x + "," + p.y + "," + p.z + ")");
}

void mouseClicked() {
  resetScreen();

}

void rotz(PVector vec, PVector ro) {
  float x = vec.x*ro.x - vec.y*ro.y;
  float y = vec.x*ro.y + vec.y*ro.x;
  vec.x = x;
  vec.y = y;
}

void rotx(PVector vec, PVector ro) {
  float z = vec.z*ro.z - vec.y*ro.y;
  float y = vec.z*ro.y + vec.y*ro.z;
  vec.z = z;
  vec.y = y;
}

void draw() {
  background(0);
  loadPixels();

  frames++;

  if (frames % 500 == 0 && autoReset) resetScreen();


  if (imgChoice != prevImgChoice) {
    img = loadImage("./imgs/img" + (imgChoice) + ".png");
    img.resize(W, H);
    img.loadPixels();
    prevImgChoice = imgChoice;
  }
  
  for (int i=0; pixels.length>i; i++)  {

    rotz(v, rz);
    rotx(v, rx);
    
    p.add(v);
    
    if (p.x > LIM) p.x = p.x - LIM+1;
    if (p.y > LIM) p.y = p.y - LIM+1;
    if (p.z > LIM) p.z = p.z - LIM+1;
    
    if (p.x < 0) p.x = p.x + LIM;
    if (p.y < 0) p.y = p.y + LIM;
    if (p.z < 0) p.z = p.z + LIM;
    
    translate(W/2 , H/2);
    
    //map x,y,z to somewhere in x,y only
    int counter = (int(p.z) << 12) | (int(p.y) << 6) | int(p.x);
    if ( (counter < pixels.length) && (counter >= 0)) {
      if (img.pixels[counter] != color( cos(frames/(float)noiseVar1) * (float)noiseVar2)) {
        pixels[counter] = img.pixels[counter];
      } else {
        pixels[counter] = color(random(360), random(100), random(80)+20);
      }
      // pixels[counter] = color(random(360), random(100), random(80)+20);
    }
    
  }
  
  //for (int i=0; pixels.length>i; i++) {
  //   pixels[i] = color(random(255), random(255), random(255));
  
  //}
  updatePixels();


  // convolutionMask4((int)((0xfffffff/(10*(sin(frames/10.0))))));

  // convolutionMask4(0xfffffff);


}

void keyPressed() {
    switch(key) {
      case '=':
        saveFrame("frame-####.png");
        break;       
      case 'q':
        posrange += 10;
        break;
      case 'a':
        if (posrange > 10) {
          posrange -= 10;
        }
        break;
      case 'w':
        subrange += 10;
        break;
      case 's':
        if (subrange > 10) {
          subrange -= 10;
        }
        break;  

      case '2':
        imgChoice++;
        if (imgChoice > IMG_MAX) {
          imgChoice = 0;
        }
        break;
      case '1':
        imgChoice--;
        if (imgChoice < 0) {
          imgChoice = IMG_MAX;
        }
        break;
      case 'r':
        noiseVar1+=globalInc;
        // if (noiseVar1 > NOISE_VAR_MAX) {
        //   noiseVar1 = 0;
        // }
        break;
      case 'f':
        noiseVar1-=globalInc;
        if (noiseVar1 < 0) {
          noiseVar1 = NOISE_VAR_MAX;
        }
        break;
      case 't':
        noiseVar2+=globalInc;
        // if (noiseVar1 > NOISE_VAR_MAX) {
        //   noiseVar1 = 0;
        // }
        break;
      case 'g':
        noiseVar2-=globalInc;
        if (noiseVar2 < 0) {
          noiseVar2 = NOISE_VAR_MAX;
        }
        break;
      case 'y':
        noiseVar3+=globalInc;
        // if (noiseVar1 > NOISE_VAR_MAX) {
        //   noiseVar1 = 0;
        // }
        break;
      case 'h':
        noiseVar3-=globalInc;
        if (noiseVar3 < 0) {
          noiseVar3 = NOISE_VAR_MAX;
        }
        break;
        case 'm':
          println("(r/f) noiseVar1: "+noiseVar1);
          println("(t/g) noiseVar2: "+noiseVar2);
          println("(y/h) noiseVar3: "+noiseVar3);
          println("(u/j) globalInc: "+globalInc);
          println("(q/a) posrange: "+posrange);
          println("(w/s) subrange: "+subrange);
          println("(1/2) imgChoice: "+imgChoice);
          println("(x)   autoReset: "+(autoReset==true));
          println("(c)   randomizeMag: "+globalMag);
          println("(v/z)   randomize range/noiseVars");
          // println("noiseVar4: "+noiseVar4);
        break;
        case 'u':
          globalInc+=1;
          break;
        case 'j':
          globalInc-=1;
          break;
        case 'z':
          noiseVar1 = (int) random(NOISE_VAR_MAX);
          noiseVar2 = (int) random(NOISE_VAR_MAX);
          noiseVar3 = (int) random(NOISE_VAR_MAX);
        break;
        case 'x':
          autoReset = !autoReset;
        break;
        case 'c':
          globalMag = random(100);
        break;
        case 'v':
          posrange = (int) random(500);
          subrange = (int) random(500);
        break;

    }
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