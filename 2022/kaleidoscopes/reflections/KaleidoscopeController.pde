class KaleidoscopeController {

    /** whether s key is handled or ignored */
    boolean canSave;

    /** control the amount 'r' and 'R' change the rotation speed */
    static final float ROTATE_INCREMENT = 0.005;

    /** factor to scale kaleidoscope to save high resolution */
    int scalefactor = 1; // > 1 won't work in full screen mode
    int segments;

    /** radius of a circle fitting onto the screen */
    int screenradius;

    /** current rotation situation of the whole screen */
    float baserotate;
    /** current rotation increment to change baserotate in each draw phase */
    float rotateKal = 0;

    //the H variables are used when saving with a scalefactor > 1
    /** buffer holding the base picture to draw */
    PImage img, imgH;
    /** an offscreen graphic to draw the image with translate and rotate, and mask away to have a nice slice of pie form */
    PGraphics graph, graphH;
    /** the kaleidoscope instance to draw the graph */
    Kaleidoscope kaleidoscope, kaleidoscopeH;

    /** change part of img that is put into graph: x, y are move, z is used for rotation */
    PVector drag = new PVector(0,0,0);;
    /** previous drag position, to see if graph needs to be redrawn */
    PVector lastDrag = new PVector(1,1,1); //initial content ignored but must be different from drag to trigger initial drawing of the screen
    /** used for smooth movement. the next draw uses part of last speed and changes acceleration based on mouse movement */
    PVector lastd = new PVector(0,0,0);
    
    /** whether the graph has to be refreshed */
    boolean refresh = false;

    /** current file name, to use with snapshot saving */
    String imagename;

    public KaleidoscopeController(int segments, int screenradius, int scalefactor, boolean canSave, boolean debug) {
        this.screenradius = screenradius;
        this.scalefactor = scalefactor;
        this.canSave = canSave;
        this.segments = segments;

        kaleidoscope = new Kaleidoscope(segments, screenradius);
        graph = kaleidoscope.getBuffer();
        if (scalefactor != 1) {
            kaleidoscopeH = new Kaleidoscope(segments, screenradius*scalefactor);
            graphH = kaleidoscopeH.getBuffer();
        }
    }


    //UPDATE SOURCE IMAGE
    public void changeImage(PImage i, boolean reset) {
        try {
            img = (PImage) i.clone();
            img.resize(Math.round(screenradius*1.5),0);

            if (scalefactor != 1) {
                imgH = (PImage) i.clone();
                imgH.resize(Math.round(screenradius*scalefactor*1.5),0);
            }
            
            refresh = true;

            if (reset) {
            //reset movement
            drag.x = 0;
            drag.y = 0;
            drag.z = 0;
            lastDrag.x = 0;
            lastDrag.y = 0;
            lastDrag.z = 0;
            }
        } catch(CloneNotSupportedException e) {
            //ignore
        }
    }

    //DRAW
    public void draw() {
        background(0);



        frames+=renderSpeed;

        calculateDrag();
        
        push();

            translate(W/2 - radius,H/2 - radius);

            baserotate = segments % 4 != 0 ? TWO_PI/segments/2 : 0;
            baserotate += globalRotation * PI / 180;

            kaleidoscope.draw(graph,baserotate);
        pop();

        //SHOW DRAG POINT
        // push();
        //     stroke(255);
        //     strokeWeight(20);
        //     point(drag.x+ W/2, drag.y+ H/2);
        // pop();

        
    }


    void changeImg (int imgNum) {
        PImage i = loadImage("../testimgs/testimg"+imgNum+".png");
        // if (i == null) throw new RuntimeException("pattern.jpg not found");
        controller.changeImage(i,true);
    }

    void updateGraph(PGraphics graph, PImage img, int m) {
        graph.beginDraw();
        graph.translate(drag.x*m,drag.y*m);
        graph.translate(m*screenradius/2,m*screenradius/2);
        graph.rotate(drag.z);
        graph.translate(-m*screenradius/2,-m*screenradius/2);
        graph.image(img,0,0);
        graph.endDraw();
    }

    void changeKaleidoscope() {
        // PGraphics oldg = graph;
        // kaleidoscope = new Kaleidoscope(segments, screenradius);
        // graph = kaleidoscope.getBuffer();
        // graph.image(oldg,0,0);

        // if (scalefactor != 1) {
        //     oldg = graphH;
        //     kaleidoscopeH = new Kaleidoscope(segments, screenradius*scalefactor);
        //     graphH = kaleidoscopeH.getBuffer();
        //     graphH.image(oldg,0,0);
        // }

        // lastDrag.x += 0.0001; //trigger redraw
        kaleidoscope = new Kaleidoscope(segments, screenradius);
        graph = kaleidoscope.getBuffer();
        if (scalefactor != 1) {
            kaleidoscopeH = new Kaleidoscope(segments, screenradius*scalefactor);
            graphH = kaleidoscopeH.getBuffer();
        }
    }

    public void calculateDrag () {
float dragRadius = radius/globalDragRadMult;

        if (autoMoveDrag) {

            switch (dragType) {
                case 1: 
                //perfect circle 1
                    drag.y = (cos(frames/500) * dragRadius) - H/2;
                    drag.x = (sin(frames/500) * dragRadius) - W/2;
                break;
                case 2:
                //ran sin wav 2
                    drag.y = (cos(frames/250) * dragRadius) - H/2;
                    drag.x = (sin(frames/500) * dragRadius) - W/2;
                break;
                case 3: 
                //ran sine wav 1
                    drag.y = -10 + ((sin(frames/222) * dragRadius/3) - dragRadius/3) * .95;
                    drag.x = -10 + ((-cos(frames/666) * dragRadius/2) - dragRadius/2) * .95;
                break;
            }

            
        }

        // println("Frames: " + frames + " - dragX: " +  drag.x + " - dragY: " + drag.y + " - dragY/X: " + (drag.y/drag.x) + " - dragx/y: " + (drag.x/drag.y));

        if (refresh || drag.x != lastDrag.x || drag.y != lastDrag.y || drag.z != lastDrag.z) {
            updateGraph(graph, img, 1);
            if (scalefactor != 1) {
                updateGraph(graphH, imgH, scalefactor);
            }
            lastDrag.x = drag.x;
            lastDrag.y = drag.y;
            lastDrag.z = drag.z;
        }
    }


    //MOUSE MOVE
    public void mouseDragged() {
        if (mouseButton == LEFT) {
            int dx = mouseX - pmouseX;
            int dy = mouseY - pmouseY;
            lastd.x = dx * 0.1 + lastd.x * 0.9;
            lastd.y = dy * 0.1 + lastd.y * 0.9;
            drag.x += lastd.x;
            drag.y += lastd.y;
            if (drag.x > graph.width) drag.x = graph.width;
            if (drag.x < -img.width) drag.x = -img.width;
            if (drag.y > graph.height) drag.y = graph.height;
            if (drag.y < -img.height) drag.y = -img.height;
        } else if (mouseButton == RIGHT) {
            drag.z += (mouseX - pmouseX) * 0.01;
        }
    }



}
