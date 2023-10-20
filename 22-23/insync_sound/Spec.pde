class Spec {

    int frames;
    PVector pos;
    PVector heading;
    float hue;
    float mag;
    float x;
    float y;

    Spec (float x, float y, float mag) {
        frames = 0;
        pos = new PVector(x, y);
        this.mag = mag;
        this.x = x;
        this.y = y;
        setHeading();
    }
    
    void move() {

        pos.add(heading);
        if (toggle3) {

            mag*=.999;
            setHeading();
        };

        
        if (
            pos.x > W || pos.x < 0
            // x >= W || x < 0
        ) {

            if (playTone1) {
                sc.playNote((this.mag*5) + baseNote, 100, Math.abs(this.mag) + 1);
            }
            if (soundReset) {

                // println(this.mag);

                // sc.playNote(60, 100, 2);

                    if (playSample1) {
                        if (sound1.isPlaying()) {
                            sound1.rewind();
                        } else {
                            sound1.play();
                        }
                    }
                    if (playSample2) {
                        if (sound2.isPlaying()) {
                            sound2.rewind();
                        } else {
                            sound2.play();
                        }
                    }
                    if (playSample3) {
                        if (sound3.isPlaying()) {
                            sound3.rewind();
                        } else {
                            sound3.play();
                        }
                    }
                    
                    

                    

            }
            // println("bounce");

            heading.mult(-1);
            if (pos.x > W) pos.x = W;
            // if (pos.x < 0) pos.x = 0;
            // heading.mult(-1/heading.mag());

            // heading.mult(-random(1, 1.005));
            // heading.mult(-random(1, 1.005)/heading.mag());

            // heading.mult((mag > 0?-1:1)*(mag/2));
            
            // this.heading.mult(random(1, 1.005));
            // mag = -mag;
            // x = x >= W ? W : 0;


        };
        
        
        // x += mag;
    }

    void draw(int idx) {

        frames++;
        // hue = ((abs(pos.y-H/2) + abs(pos.x-W/2)) %360 );
        // hue=159;
        // stroke(hue, 30, 100);
        // if (strokeToggle) idx++; //quick fix to toggle stroke
        // stroke(idx % 2 == 0 ? 300 : 0);
        stroke(!trailToggle ? 360 + lightOffset : frames % 2 == 0 ? 360 + lightOffset : 0);
        strokeWeight(sW);
        point(pos.x, pos.y);
        // fill(360);
        // square(pos.x, pos.y, 1);
    }

    void setHeading () {

        //HEADING OPT
            switch (headingOpt) {
                case 1: 
                    this.heading = PVector.fromAngle(0); 
                    break;
                case 2: 
                    this.heading = PVector.fromAngle(0.1*mag); 
                    break;
                case 3: 
                    this.heading = PVector.fromAngle(pos.y/H/2*mag); 
                    break;
                case 4: 
                    this.heading = PVector.fromAngle((pos.y-H/2)/H/2*mag); 
                    break;
                case 5: 
                    this.heading = PVector.fromAngle(TWO_PI/(float)mod1); 
                    break;
                default:
                    this.heading = PVector.fromAngle(0);
                    break;	

            }
        //MAG OPT
            switch (magOpt) {
                case 1: 
                    this.heading.mult(mag/100);
                    break;
                case 2: 
                    this.heading.mult(.1/ (mag)); 
                    break;
                case 3: 
                    this.heading.mult(.1/ (mag) * (mag<0?1:-1)) ;
                    break;
                case 4: 
                    this.heading.mult(.1/ sqrt(mag<0?-(mag):(mag)));
                    break;
                case 5: 
                    this.heading.mult(.1/ sqrt(mag<0?-(mag):(mag)) * (mag<0?1:-1));
                    break;
                default:
                    // this.heading.mult(mag);
                    break;	

            }
        // if (toggle1) this.heading.mult(mag*.5 );
        if (toggle2) this.heading.mult((mag<0?1:-1)) ;



        //OLD ----------------------------------
        // //HEADING OPT
            
            // this.heading = PVector.fromAngle(0.1*mag);
            // this.heading = PVector.fromAngle(y/H/2*mag);
            // this.heading = PVector.fromAngle((y-H/2)/H/2*mag);
        

        // this.heading.mult(mag );
        // println(mag + " " +sqrt(mag));

        // this.heading.mult(1/ mag * (mag<0?1:-1)) ;
        // this.heading.mult(1/ sqrt(mag<0?-mag:mag)  * (mag<0?1:-1)); // * (mag<0?1:-1)
        
        // hue = random((y*0 + abs(x-W/2)) %360 );
    }

}
