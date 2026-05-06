class Fader {


    float[] speeds = {.125, .25, .5, 1, 5};

    int speedSelect = 2; 

    public Fader () {

    }

    public void increaseSpeed() {
        if (speedSelect < speeds.length-1) {
            speedSelect++;
        }
    }

    public void decreaseSpeed() {
        if (speedSelect > 0) {
            speedSelect--;
        }
    }

    public void renderFade(float width, float height) {
    
        if (fadeTimer == 0) return;
        
        fadeTimer -= speeds[speedSelect];
        
        if (fadeTimer == 50) {
            controller.changeImg(imgChoice);
        } 

        //fadeScreen
        float alpha = (cos(Math.abs(fadeTimer-50)/50)-.5)*2;
        // println(fadeTimer + " - " + alpha);
        fill(0, alpha);

        rect(0,0,width,height);

    }

    public void setFadeTimer() {

    if (fadeTimer == 0) {
        fadeTimer = 100;
        return; 
    } else if (fadeTimer < 50) {
        fadeTimer = 100 - fadeTimer;
    }
}
}