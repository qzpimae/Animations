//Game of life

//CONTROLS
/*
    R:       restart
    T:       leave trails toggle
    N:       skip one generation
    M:       skip four generations
    O:       decrease max framerate
    P:       increase max framerate
    U:       zoom out / decrease cell size
    I:       zoom in / increase cell size
    Q:       toggle
    0-3      select preset games (press R after selecting)
    Space:   toggle ignoreAlive
    R-Click: kill cell
    L-Click: birth cell
    

*/

//GLOBAL VARS

//   import ddf.minim.*;
//   import ddf.minim.analysis.*;
//   import ddf.minim.effects.*;
//   import ddf.minim.signals.*;
//   import ddf.minim.spi.*;
//   import ddf.minim.ugens.*;
//   import arb.soundcipher.*;

//   SoundCipher sc;
//   Minim minim;

//   //Noise algorithm that produces values used in this animation, not made by me
//  OpenSimplex2S noise;
  
  int WIDTH = 1280;//1504//3840; //1920
  int HEIGHT = 720;//846//2160; //1080
  
  boolean paused = false;
  boolean isInColor = true;
  boolean inLoopMode = false;
  boolean randomSize = false;
  
  
  int frames = 0;
  float fps = 60;
  float globalSpeed = 1;

  char[] chars = "1234567890asdfghjklzxcvbnm".toCharArray(); //QWERTYUIOPASDFGHJKLZXCVBNM

  ScrollingChar[] scrollingText = new ScrollingChar[100];

  void settings () {
    fullScreen();
    //set canvas size
    //WIDTH //3840; //1920 //1280 //800
    //HEIGHT //2160; //1080 //720  //450
    size(WIDTH,HEIGHT);

    // String[] fontList = PFont.list();
    // printArray(fontList);
  }
  
  void setup() {
    
    //set color mode to hue/saturation/brightness which i perfer for my animations
    colorMode(HSB, 360, 100, 100);
    background(0);
    //noLoop();
    frameRate(fps);


    textFont(createFont("Wingdings-Regular", 32));

    initalizeScrollingText();
  }
  
  /* 
  SPC = pause
  t = trail toggle
  = = screenshot
  */
  void keyPressed() {
    switch (Character.toLowerCase(key)) {
      case ' ': 
        paused = !paused;
      break;
      case 'e': 
        randomSize = !randomSize;
      break;
      case 'r':
        restart();
      break;
      case 'q':
        globalSpeed /= 2;
        break;
      case 'w':
        globalSpeed *= 2;
        break;
      case 'o':
        fps-=5;
        if (fps < 1) fps = 1;
        frameRate(fps);
        println("FPS set to: " + fps);
      break;
      case 'p':
        fps+=5;
        if (fps > 60) fps = 60;
        frameRate(fps);
        println("FPS set to: " + fps);
      break;
      case '=': 
        saveFrame("../../../renderScreenShot/textglitch/textglitch_######.png");
      break;
    }
    
    
  }
  
  void mouseDragged() {
  
  }
  
  //loop function that runs on a loop 
  void draw() {
    frames++;
    if (inLoopMode) {
      if (frames % 1500 == 0) restart();
      // if (frames % 150 == 0 ) trailToggle = !trailToggle;
    }
    // background((frames*10)%360, 100, 33); // reset screen // uncomment for rainbow strobe ( trail does not work)
 
    if (!paused) {
        // renderRandomText();
        renderScrollingText();
    }

    if (randomSize) {
      textFont(createFont("Wingdings-Regular", random(300)));

    } else {
      textFont(createFont("Wingdings-Regular", 32));

    }
    
    //println(count / (cellCols*cellRows));
  
  }

  void renderRandomRect() {

    for (int i = 0; i < 10; i++) {
      int x = (int)random(0, WIDTH);
      int y = (int)random(0, HEIGHT);
      int w = (int)random(1, 100);
      int h = (int)random(1, 100);
      int c = color(random(0, 360), 100, random(0, 100));

      
      blendMode(i % 2 == 0 ? BLEND : i % 3 == 0 ? ADD : SUBTRACT);

      fill(c);
      noStroke();
      rect(x, y, w, h);
    }

  }

  void renderRandomText() {

    for (int i = 0; i < 1000; i++) {

        float size = random(0, 4) * random(0, 3) ;
        int w = (int)random(1, WIDTH);
        int h = (int)random(1, HEIGHT);
        int c = color(random(0, 360), random(0, 50), random(0, 100));

        String randomizedCharacter = chars[(int)random(0, chars.length)] + "";

      
        blendMode(i % 2 == 0 ? BLEND : i % 3 == 0 ? ADD : SUBTRACT);


        textSize(size);
        fill(c);
        text(randomizedCharacter, w, h); 

    }

  }
  

  void initalizeScrollingText() {
    for (int i = 0; i < scrollingText.length; i++) {
      scrollingText[i] = new ScrollingChar();

    }
  }

  void renderScrollingText() {
    for (int i = 0; i < scrollingText.length; i++) {
      scrollingText[i].render();
      scrollingText[i].update();
    }
  }

  void restart() {
    initalizeScrollingText();
    background(0);
    frames = 0;
  }
