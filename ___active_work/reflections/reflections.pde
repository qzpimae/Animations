
/** side length of usable square in full screen */

final int W = 800;//(300dpi) 9933// (8K) 7680// (print) 3576// (4K) 3840//(UHD)//(72dpi) 2384// 2560//(HD) 1920//(M0S) 1680//(Square HD) 1280//(SD) 1280//2560
final int H = 600;//(300dpi) 7016// (8K) 4320// (print) 2472// (4K) 2160//(UHD)//(72dpi) 1648// 1440//(HD) 1080//(M0S) 1050//(Square HD) 1024//(SD) 720 //1600
int radius = H;//(int)(H*1.02);

KaleidoscopeController controller;
Fader fader;

float time = 0;
int frames = 0;
float renderSpeed = .1;
int imgChoice = 4;
int IMAGE_NUM_MAX = 5;
boolean isAutoChanged = false;
int autoChangeDelay = 5000; 
float fadeTimer = 0;
int starterSegments = 12;
int dragType = 1;
int DRAG_TYPE_MAX = 3;
float globalRotation = 0;
boolean isPaused = false;
boolean autoMoveDrag = true;
float globalDragRadMult = 4;
int DRAG_MULT_MAX = 20;


/**
 * prepare the sketch
 */
void settings (){

   //size(W, H); // slow
   size(W, H, P2D); // fast  
//    fullScreen();
}
void setup() {
    frameRate(60);
    noCursor();
    colorMode(RGB, 1);

    controller = new KaleidoscopeController(starterSegments, radius, 1, false);

    fader = new Fader();

    controller.changeImg(imgChoice);
}

/**
 * main draw loop: forward to KaleidoscopeController
 */
void draw() {
    // println(renderSpeed);
    if (!isPaused) {
        controller.draw();
        boolean switchImg = fader.renderFade(W,H);
        if (switchImg) controller.changeImg(imgChoice);
        if (isAutoChanged && frames % autoChangeDelay == 0) {
            autoChange();
        }
        // saveFrame("../../../../renderScreenShot/kaleidoscopeRender22222/render22222_######.png");
        frames++;
    }
    
}

/**
 * forward mouse movement to KaleidoscopeController
 */
void mouseDragged() {
    controller.mouseDragged();
}

void autoChange() {
    int ranImage = (int) Math.ceil(Math.random() * IMAGE_NUM_MAX);
    if (imgChoice == ranImage) { //so that it's always a new images being changed to
        autoChange();
        return;
    }
    imgChoice = ranImage;
    fader.starFadeTimer();
}

/**
 * forward keyboard strokes to KaleidoscopeController
 */
void keyTyped() {
    switch(key) {
            case 'c':
                dragType = dragType > 1 ? dragType-1 : 1;
                break;
            case 'v':
                dragType = dragType < DRAG_TYPE_MAX ? dragType+1 : DRAG_TYPE_MAX;
                break;
            case 'b':
                globalDragRadMult = globalDragRadMult > .1 ? globalDragRadMult-.1 : .1;
                break;
            case 'n':
                globalDragRadMult = globalDragRadMult < DRAG_MULT_MAX ? globalDragRadMult+.1 : DRAG_MULT_MAX;
                break;
            case 'p':
                println("OUTPUT____ dragType: " + dragType + " --- rotation: " + controller.rotateKal + " --- imgChoice: " + imgChoice + " --- segments: " + controller.segments + " --- renderSpeed: " + renderSpeed);
                break;
            case 'y':
                controller.rotateKal += controller.ROTATE_INCREMENT;
                break;
            case 't':
                controller.rotateKal -= controller.ROTATE_INCREMENT;
                break;
            case 'q':
                imgChoice = imgChoice > 1 ? imgChoice-1 : IMAGE_NUM_MAX;
                fader.starFadeTimer();
                break;
            case 'w':
                imgChoice = imgChoice < IMAGE_NUM_MAX ? imgChoice+1 : 1;
                fader.starFadeTimer();
                break;
            case 'e':
                fader.decreaseSpeed();
                break;
            case 'r':
                fader.increaseSpeed();
                break;
            case 'd':
                controller.segments = controller.segments-2 > 4 ? controller.segments-2 : 4;
                controller.changeKaleidoscope();
                break;
            case 'f':
                controller.segments = controller.segments < 128 ? controller.segments+2 : 128;
                controller.changeKaleidoscope();
                break;
            case 'a':
                renderSpeed = renderSpeed > -10 ? renderSpeed-.05 : -10;
                break;
            case 's':
                renderSpeed = renderSpeed < 10 ? renderSpeed+.05 : 10;
                break;
            case ' ':
                isPaused = !isPaused;
                break;
            case 'u':
                isAutoChanged = !isAutoChanged;
                break;
            case '\'':
                autoMoveDrag = !autoMoveDrag;
                break;
            case '=':
                saveFrame("../../../../renderScreenShot/kaleidoscope/kaleidoscope_######.png");
                break;
            // case 'z':
            //     radius = radius > 100 ? radius-50 : 100;
            //     changeKaleidoscope();
            //     break;
            // case 'x':
            //     radius = radius < 5000 ? radius+50 : 5000;
            //     changeKaleidoscope();
            //     break;

        }
}

/**

        TODO: 
         only start fade if image is changing OR have image choice loop 


        future feature (auto image changer): 
            isAutoChanged - boolean to toggle autoChange
            autoChangeDelay - how many time to wait before auto switching
            autoChange() -  timebased randmoized image switcher called every "autoChangeDelay" time

 */



