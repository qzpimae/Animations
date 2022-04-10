
/** side length of usable square in full screen */

final int W = 1680;//(8K) 7680// (4K) 3840//(UHD) 2560//(HD) 1920//(M0S) 1680//(Square HD) 1280//(SD) 1280//2560
final int H = 1050;//(8K) 4320// (4K) 2160//(UHD) 1440//(HD) 1080//(M0S) 1050//(Square HD) 1024//(SD) 720 //1600
int radius = H;//(int)(H*1.02);

KaleidoscopeController controller;

float frames = 0;
float renderSpeed = 1;
int imgChoice = 1;
int IMAGE_NUM_MAX = 60;
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

    size(W,H, P2D);
    fullScreen();
}
void setup() {
    frameRate(10);
    noCursor();

    controller = new KaleidoscopeController(starterSegments, radius, 1, false);

    controller.changeImg(imgChoice);
}

/**
 * main draw loop: forward to KaleidoscopeController
 */
void draw() {
    
    // println(renderSpeed);

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
                println("- dragType: " + dragType + "- rotation: " + controller.rotateKal + "- imgChoice: " + imgChoice + "- segments: " + controller.segments + "- renderSpeed: " + renderSpeed);
                break;
            case 'r':
                controller.rotateKal += controller.ROTATE_INCREMENT;
                break;
            case 'e':
                controller.rotateKal -= controller.ROTATE_INCREMENT;
                break;
            case 'q':
                imgChoice = imgChoice > 1 ? imgChoice-1 : 1;
                controller.changeImg(imgChoice);
                break;
            case 'w':
                imgChoice = imgChoice < IMAGE_NUM_MAX ? imgChoice+1 : IMAGE_NUM_MAX;
                controller.changeImg(imgChoice);
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
                renderSpeed = renderSpeed > -10 ? renderSpeed-.1 : -10;
                break;
            case 's':
                renderSpeed = renderSpeed < 10 ? renderSpeed+.1 : 10;
                break;
            case ' ':
                isPaused = !isPaused;
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
