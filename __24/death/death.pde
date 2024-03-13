//Game of life

//TODO
/*

  () add directional control for 

*/

/*\

    Light: C/V

*/



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

  import ddf.minim.*;
  import ddf.minim.analysis.*;
  import ddf.minim.effects.*;
  import ddf.minim.signals.*;
  import ddf.minim.spi.*;
  import ddf.minim.ugens.*;
  import arb.soundcipher.*;

  SoundCipher sc;
  Minim minim;

  //Noise algorithm that produces values used in this animation, not made by me
 OpenSimplex2S noise;
  
  int WIDTH = 1920;//1504//3840; //1920
  int HEIGHT = 1080;//846//2160; //1080
  
  boolean paused = true;
  boolean trailToggle = true;
  boolean ignoreAlive = false;
  boolean isInColor = true;
  boolean inLoopMode = false;
``````
  boolean playNotes = false; // c: /

  boolean autoDynamicsToggle = false; //c: 8


  boolean scrollCells = true;
  boolean surroundCalcType = true;
  
  boolean scrollCellsUni = true;
  
  int horScroll = -1; 
  int vertScroll = 0; 
  
  int genType = 3;
  
  int frames = 0;
  float fps = 120;
  int cellSize =  2;
  int tempCellSize = cellSize;
  int cellCols;
  int cellRows;

  int autoResetCounter = 0;
  int loopFrameCount = 0;

  //array of Points to keep track of quadrent information and x/y position aswell as pixel index
  Cell[][] allCells;


  int noteLim = 20;
  int notesPlayed = 0;

  float lightOffset = -25;
  float ageMult = 1;


  void settings () {
    fullScreen();
    //set canvas size
    //WIDTH //3840; //1920 //1280 //800
    //HEIGHT //2160; //1080 //720  //450
    size(WIDTH,HEIGHT);
  }
  
  void setup() {
    
    //set color mode to hue/saturation/brightness which i perfer for my animations
    colorMode(HSB, 360, 100, 100);
    //noLoop();
    noCursor();
    //create instance of the simplex noise class
    noise = new OpenSimplex2S( 314159265 );


    minim = new Minim(this);
    sc = new SoundCipher(this);
    // sc.instrument = sc.SYNTH_DRUM;
    sc.instrument = sc.XYLOPHONE; 
    
    initalizeGame();
    frameRate(fps);
  }


  //loop function that runs on a loop 
  void draw() {
    frames++;
    loopFrameCount++;
    // if (inLoopMode) {
    //   if (frames % 1500 == 0) initalizeGame();
    //   // if (frames % 150 == 0 ) trailToggle = !trailToggle;
    // }
    // background((frames*10)%360, 100, 33); // reset screen // uncomment for rainbow strobe ( trail does not work)
    if (trailToggle) background(0);



    if (autoDynamicsToggle) autoDynamics();

    //double count = 0;

    //itterate through all pixels/Points
    for ( int i = 0; i < allCells.length; i++) {  
      
      for ( int j = 0; j < allCells[i].length; j++) {
  
        allCells[i][j].render();
        //if (allCells[i][j].alive) count++;
      
      }
      
    } 

    if (scrollCells && scrollCellsUni) {
      Cell[] tempCellRow;

      for (int i = 0; i < allCells.length; ++i) {
        // println("sg");
        if (i < allCells.length-1) {
          tempCellRow = allCells[i+1];
          allCells[i+1] = allCells[i];
          allCells[i] = tempCellRow;
        } else {
          tempCellRow = allCells[0];
          allCells[0] = allCells[allCells.length-1];
          allCells[allCells.length-1] = tempCellRow;
        }
      }
      
    }
    
    if (!paused) calcNextGen();
    
    //println(count / (cellCols*cellRows));
  
  }

  
  /* 
  SPC = pause
  t = trail toggle
  n = calcNextGen
  m = next gen * 4 
  r = reset 
  o = --framrate
  p = ++framrate
  u = --cell size
  i = __cell size
  1 - 8 = render select
  = = screenshot
  */
  void keyPressed() {
    switch (Character.toLowerCase(key)) {
      case '/':
        playNotes = !playNotes;
      break;
      case ' ': 
        paused = !paused;
      break;
      case 'q':
        ignoreAlive = !ignoreAlive;
      break;
      case 't': 
        trailToggle = !trailToggle;
      break;
      case '`':
        scrollCells = !scrollCells;
      break;
      case TAB:
        surroundCalcType = !surroundCalcType;
        break;
      case 'n':
        calcNextGen();
      break;
      case 'm':
        calcNextGen();
        calcNextGen();
        calcNextGen();
        calcNextGen();
      break;
      case 'r':
        initalizeGame();
      break;
      case 'o':
        fps-=1;
        if (fps < 1) fps = 1;
        setFramerate(fps);
      break;
      case 'p':
        fps+=1;
        if (fps > 60) fps = 60;
        setFramerate(fps);
      break;
      case ';':
        fps-=.1;
        if (fps < .1) fps = .1;
        setFramerate(fps);
      break;
      case '\'':
        fps+=.1;
        if (fps > 120) fps = 120;
        setFramerate(fps);
      break;
      case '0':
        fps*=2;
        if (fps > 120) fps = 120;
        setFramerate(fps);
        break;
      case '9':
        fps/=2;
        if (fps<.5) fps = .5;
        setFramerate(fps);
        break;
      case '8':
        autoDynamicsToggle = !autoDynamicsToggle;
        break;
      case '6':
        tempCellSize--;
        if (tempCellSize < 1) tempCellSize = 1;
        println("Cell size: " + tempCellSize + "px");
      break;
      case '7':
        tempCellSize++;
        println("Cell size: " + tempCellSize + "px");
      break;
      case '1':
      case '2':
      case '3':
      case '4':
        genType = Character.getNumericValue(key);
      break;
     
      case '=': 
        saveFrame("../../../renderScreenShot/life/life_######.png");
      break;
      case 'v':
        lightOffset = lightOffset >= 100 ? 100 : lightOffset + 1;
        break;
      case 'c':
        lightOffset = lightOffset <= -100 ? -100 : lightOffset - 1;
        break;
      case 'z':
        ageMult = ageMult >= 100 ? 100 : ageMult + .1;
        break;
      case 'x':
        ageMult = ageMult <= .1 ? .1 : ageMult - .1;
        break;
      case 'i':
        vertScroll = vertScroll < 100 ? vertScroll+1 : 100; 
      break;
      case 'k':
        vertScroll = vertScroll > -100 ? vertScroll-1 : -100; 
      break;
      case 'l':
        horScroll = horScroll < 0 ? 0 : -1; 
      break;
      case 'j':
        horScroll = horScroll < 100 ? vertScroll+1 : 100; 
      break;


    }

    if (key == CODED) {
    switch (keyCode) {
      case UP:
        vertScroll = vertScroll > 0 ? 0 : 1; 
      break;
      case DOWN:
        vertScroll = vertScroll < 0 ? 0 : -1; 
      break;
      case RIGHT:
        horScroll = horScroll < 0 ? 0 : -1; 
      break;
      case LEFT:
        horScroll = horScroll > 0 ? 0 : 1; 
      break;
      case SHIFT:
        scrollCellsUni = !scrollCellsUni;
      break;
      case CONTROL:
        quickControl();
      break;
     
    } 
  }
    
    
  }

  void  quickControl () {
        scrollCellsUni = false;
        horScroll = 0;
        vertScroll = 0;
        surroundCalcType = false;
        scrollCells = false;
  }

  void setFramerate(float frameRate) {
    // println(frameRate);
    if (frameRate > 0) frameRate(frameRate);
    else println("NEGITIVE FRAMERATE\n\n\n\n\n\n\n");
  }
  
  void mouseDragged() {
  
    int indX = mouseX / cellSize;
    int indY = mouseY / cellSize;
    
    try {
      if (mouseButton == RIGHT) {
      
        allCells[indX][indY].alive = false;
      
      } else if (mouseButton == LEFT) {
      
        allCells[indX][indY].alive = true;
      
      }
    } catch (Exception e) {
    
    }
    
  
  }
  
  void autoDynamics (){

      if (frames % 30 == 0 && random(1) > .5) {
        if (random(1) > .5) {
          surroundCalcType = !surroundCalcType;
        } else {
          scrollCells = !scrollCells;
          scrollCellsUni = !scrollCellsUni;
        }
      }

      if (frames % 30 == 0 && !scrollCellsUni && random(1) > .5) {
        scrollCellsUni = !scrollCellsUni;
      }

      if (frames % (20 - (autoResetCounter < 10 ? autoResetCounter : 10))  == 0 && random(1) > .3){

        boolean trailToggleSwitch = random(1) > .5;
        if (trailToggleSwitch != trailToggle) {
          lightOffset = random(-60, 20);
          trailToggle = trailToggleSwitch;
        }
        scrollCellsUni = scrollCellsUni ? random(1) < .9 : false;
        
        // frameRate += (random(1) > frameRate/120 ? 1 : -1) * Math.ceil(random(1) * 5);
        // println("FPS: " + frameRate);

        // println(horScroll + "\nVert:" + vertScroll);
        horScroll += random(1) > .75 ? 1 : -1;
        vertScroll += random(1) > .75 ? 1 : -1;



        if (random(1) > .2) {
          
          float randomNum = random(1);
          float randomTrigger1 = (abs(horScroll)+abs(vertScroll));
          float randomTrigger2 = 40 + loopFrameCount / 100;//((loopFrameCount+10) / (1+autoResetCounter*loopFrameCount/50));
          
          println(randomNum + .1 + " > "  +  (randomTrigger1 /randomTrigger2)+ " = "+randomTrigger1 +" / " + randomTrigger2 );

          if (randomNum + .1 > randomTrigger1 / randomTrigger2 ) {
          
            horScroll*= random(1) > abs(horScroll)/150 ? 1.25 : .5;
            vertScroll*= random(1) > abs(vertScroll)/150 ? 1.25 : .5;
            // println(frames +") v: " + vertScroll + " h: " + horScroll );
          } else {
            println(frames + " / " + loopFrameCount + ": "+ "RESET");
            loopFrameCount = 0;
            scrollCellsUni = true;  
            autoResetCounter++;
            cellSize = ceil(random(3));
            horScroll=0;
            vertScroll=0;
            trailToggle = random(1) > .5;
            initalizeGame();


          }
         }
      }

    
    
  }
  
  void initalizeGame() {
    
    // background(0);
    cellSize = tempCellSize;
    cellCols = WIDTH / cellSize;
    cellRows =  HEIGHT / cellSize;
    
    
    allCells = new Cell[cellCols][cellRows];
    
    int columns = cellCols;
    int rows = cellRows;
    boolean startsAlive;
    
    
    for (int i = 0; i < columns; i++) {
      
      for (int j = 0; j < rows; j++) {
        
        switch (genType) {
          case 2: 
            startsAlive = random(0,1) > .7;
          break;
          case 1: 
            double noiseVal = noise.noise2((double)i/77,(double)j/444);
            startsAlive = noiseVal > PI/42;
          break;
          case 4:
            startsAlive = false;
          break;
          case 3:
       
            if (
              // i > (columns/4)+1 
              // && i < (columns *3/4)-1 
              //&& 
              j == rows/2
            ) { startsAlive = true;
            } else startsAlive = false;
          break;
          default: startsAlive = true;
        }
        
        
        allCells[i][j] = new Cell(i,j, startsAlive);
      
      }    
    
    }
    
    //calcNextGen();
  
  }
  
  void calcNextGen() {

    notesPlayed = 0;
    
    
    int[][] aliveCount = new int[cellCols][cellRows];
  
    //CALCULATE ALIVE COUNT
    for ( int i = 0; i < cellCols; i++) {   
      for ( int j = 0; j < cellRows; j++) {  
        int x = allCells[i][j].x;
        int y = allCells[i][j].y;
        
        aliveCount[i][j] = calcSurroundingAliveV1(x, y);
        // aliveCount[i][j] = surroundCalcType && scrollCellsUni ? calcSurroundingAliveV1(x, y) : calcSurroundingAliveV2(x, y);
      }  
    }   
    
    //CHANGE ALIVE STATUS
    
    for ( int i = 0; i < cellCols; i++) {   
        //println();
      for ( int j = 0; j < cellRows; j++) { 
        //print(i, aliveCount[i][j]);
        int count = aliveCount[i][j];
        Cell cell = allCells[i][j];
        
        cell.age++;
        
        if (count == 3 && !cell.alive) {
          cell.alive = true;
          cell.age = 0;
        } else if (cell.alive && count < 2 || count > 3 ) {
          cell.alive = false;
          cell.age = 0;
        }
        
      }  
    }   
        
  }
  
  int calcSurroundingAliveV1(int x, int y) {
    
    int aCount = 0;
    for (int i = x - 1; i < x + 2; i++) {
      for (int j = y - 1; j < y + 2; j++) {
        
          //if (x == 0 && y == 0) println (i,j);
        
         if ((i == x && j == y)) continue;
         if (
           i >= 0 && j >= 0
           && i < cellCols && j < cellRows 
           && allCells[i][j].alive
         ) { aCount++; }
      
      }
    
    }
    //println(x, y, aCount);
    return aCount;
  }
  
  //V1 CAlSurround (edges are dead)
  int calcSurroundingAliveV2(int x, int y) {
    

    int aCount = 0;
    for (int i = x - 1; i < x + 2; i++) {
      for (int j = y - 1; j < y + 2; j++) {
        
          //if (x == 0 && y == 0) println (i,j);
         if ((i == x && j == y)) continue;
         if (
           i >= 0 && j >= 0
           && i < cellCols && j < cellRows 
           && allCells[i][j].alive
          //  || i < 0 && j > 0 && allCells[cellCols-1+i][j].alive && !(i == x && j == y)
          //  || j < 0 && i > 0 && allCells[i][cellRows-1+j].alive && !(i == x && j == y)
           || i < 0 && j < 0 && allCells[cellCols-1+i][cellRows-1+j].alive && !(i == x && j == y)
         ) { aCount++; }
      

      }
    
    }
    //println(x, y, aCount);
    return aCount;
  }