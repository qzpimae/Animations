class Kaleidoscope {
    /** kaleidoscope segments */
    int segments;
    /** kaleidoscope radius in pixels */
    int radius;
    /** height of the buffer, calculated from the radius and the number of segments */
    int bufferheight;
    /** rotation step for the segments, based on the number of segments */
    float angle;

    /** the buffer for getBuffer, in the right size for current bufferheight */
    PGraphics buffer;
    /** mask image to apply to the buffer to get a slice of pie */
    PGraphics triangle_mask;

    /**
     * Instantiate a Kaleidoscope
     *
     * @param segments number of parts. half of them will be mirrored
     * @param radius the radius of the kaleidoscope
     */
    public Kaleidoscope(int segments, int radius) {
        this.segments = segments;
        this.radius = radius;
        angle = TWO_PI/segments;
        bufferheight = Math.round(sin(angle+0.02)*radius)+1;
        buffer = createGraphics(radius,bufferheight);
        // println(buffer.background());
        triangle_mask = createGraphics(radius,bufferheight);
        
    //  triangle_mask.color(255); //processing refuses to compile this line. luckily, white seems to be default color
        triangle_mask.stroke(255);
        triangle_mask.beginDraw();
        triangle_mask.arc(0,0,radius*2,radius*2,0,angle+0.02); //ellipse with center 0,0 and width and height of 2*radius. part angle of that, with an additional 0.02 to avoid black gaps
        triangle_mask.endDraw();
    }

    /**
     * Get an image buffer to draw on, for using with the kaleidoscope.
     *
     * Use this as parameter to draw, to make sure you have the correct buffer
     * size and optimal performance.
     */
    public PGraphics getBuffer() {
        return buffer;
    }

    /**
     * Draws the img rotated and mirrored around the center.
     *
     * The img is masked to get the piece of pie format.
     *
     * @param img Should be the object returned by {@link getBuffer}. Even if not, must be of exactly the same dimensions.
     * @param rotation Rotate whole kaleidoscope by this angle (in radians)
     */
    public void draw(PImage img, float rotation) {
        img.mask(triangle_mask);

        //regular segments
        for (int i=0; i<segments/2; i++) {
            push();
                //rotate around center
                translate(radius,radius);
                rotate(rotation);
                rotate(i*angle*2);
                translate(-radius,-radius); //but keep origin intact
                //draw the image with upper left corner in center
                image(img,radius,radius);
            pop();
        }
        //mirrored segments
        for (int i=0; i<segments/2; i++) {
            push();
                //mirror on x axis. (mirroring inverts all following values on that axis)
                scale(-1,1);
                //rotate around center
                translate(-radius,radius);
                rotate(-rotation);
                rotate(-PI); //start directly adjacent to unmirrored segment
                rotate(i*angle*2);
                translate(radius,-radius); //but keep origin intact
                //draw the image with upper left corner in center
                image(img,-radius,radius);
            pop();
        }
    }
}
