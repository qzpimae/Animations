

/** show debug messages */
static final boolean DEBUG = false;
/** side length of usable square in full screen */

final int W = 1680;//(8K) 7680// (4K) 3840//(UHD) 2560//(HD) 1920//(M0S) 1680//(Square HD) 1280//(SD) 1280//2560
final int H = 1050;//(8K) 4320// (4K) 2160//(UHD) 1440//(HD) 1080//(M0S) 1050//(Square HD) 1024//(SD) 720 //1600
int radius = H;//(int)(H*1.02);

KaleidoscopeController controller;

float frames = 0;
float renderSpeed = 1;
int imgChoice = 15;
int IMAGE_NUM_MAX = 15;
int starterSegments = 12;
float globalRotation = 90;
boolean isPaused = false;
boolean autoMoveDrag = true;
float globalDragRadMult = 4;


/**
 * prepare the sketch
 */
void settings (){

    size(W,H, P2D);
    fullScreen();
}
void setup() {
    // frameRate(10);

    controller = new KaleidoscopeController(starterSegments, radius, 1, false, DEBUG);

    controller.changeImg(imgChoice);
}

/**
 * main draw loop: forward to KaleidoscopeController
 */
void draw() {
    
    println(renderSpeed);

    if (!isPaused) {
        controller.draw();
        // saveFrame("../../../../renderScreenShot/kaleidoscopeRender22222/render22222_######.png");
    }
    
}

/**
 * forward mouse movement to KaleidoscopeController
 */
void mouseDragged() {
    controller.mouseDragged();
}

/**
 * forward keyboard strokes to KaleidoscopeController
 */
void keyPressed() {
    controller.keyPressed();
}
