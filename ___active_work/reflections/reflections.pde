
/** side length of usable square in full screen */

final int W = 1920;//(300dpi) 9933// (8K) 7680// (print) 3576// (4K) 3840//(UHD)//(72dpi) 2384// 2560//(HD) 1920//(M0S) 1680//(Square HD) 1280//(SD) 1280//2560
final int H = 1080;//(300dpi) 7016// (8K) 4320// (print) 2472// (4K) 2160//(UHD)//(72dpi) 1648// 1440//(HD) 1080//(M0S) 1050//(Square HD) 1024//(SD) 720 //1600
int radius = H;//(int)(H*1.02);

KaleidoscopeController controller;

float frames = 0;
float renderSpeed = .1;
int imgChoice = 4;
int IMAGE_NUM_MAX = 5;
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
   fullScreen();
}
void setup() {
    frameRate(60);
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
                renderSpeed = renderSpeed > -10 ? renderSpeed-.05 : -10;
                break;
            case 's':
                renderSpeed = renderSpeed < 10 ? renderSpeed+.05 : 10;
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

/**

    I want to have the screen fade to black/white (control option)
    when it is at peak black/white it will then switch the image and fade back in
    this will create a seemless transition

    if the imageChoice is changed while less than halfway, it should continue as is. 
    if the imageChoice is changed while fading back to clear the fade should seemlessly move back to opaque

    transition time should be adustable by hardcoded value (maybe a control in the future)


    HOW TO ACHEIVE 
        fadeTimer - gets set to 100 and increments down as the transistion goes
            100 - start (transparent)
            50 - tranistion frame (image changes, opaque)
            0 - finish (transparent again, now with new image)

        ?tempImageChoice - temporarily held image choice 
    LOGIC

        imageChoice can be modified before timer get to or is equal to 50

        if timer is less than 50 and imageChoice is updated, timer should equal (100 - fadeTimer), 
        this will set it to the same opacity but put it on track to transition again

    TRIGGERS
        any time imageChoice is modiffied by keyboard input or autochanger, setFadeTimer should be called

        fadeTranistion is called every frame, returns immedietly if fadeTimer is 0 or fade is turned off

    FUNCTIONS & VARS

        fadeTimer (used for timing)
        setFadeTimer() (timing logic)
        fadeTranistion() (render)

        future: 
            isAutoChanged - boolean to toggle autoChange
            autoChangeDelay - how many frames to wait before auto switching
            autoChange() -  timebased randmoized image switcher called every "autoChangeDelay" frames

 */

void fadeTransition() {

    // if (fadeTimer !== 0) {


    //     --fadeTimer;
    // }

}