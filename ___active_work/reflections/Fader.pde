class Fader {


    float[] speeds = {.125, .25, .5, 1, 5};

    int speedSelect = 2; 

    boolean isFadeBlack = true;

    public Fader () {

    }

    public Fader (int speedSelect, boolean isFadeBlack) {
        this.speedSelect = speedSelect;
        this.isFadeBlack = isFadeBlack;
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

    public boolean renderFade(float width, float height) {
    
        if (fadeTimer == 0) return false;

        if (fadeTimer < 0 ) fadeTimer = 0;
        
        fadeTimer -= speeds[speedSelect];
        
        //fadeScreen
        float alpha = (cos(Math.abs(fadeTimer-50)/50)-.5)*2;
        float fillLightness = isFadeBlack ? 0 : 100;
        // println(fillLightness);
        fill(fillLightness, alpha);
        rect(0,0,width,height);

        // return true to indicate that the middle point (full black or full white) is currently active
        // this is the point where the other part of the program can trigger a change without it being seen
        if (fadeTimer == 50) return true;
        else return false;

    }

    public void starFadeTimer() {

        if (fadeTimer == 0) {
            fadeTimer = 100;
            return; 
        } else if (fadeTimer < 50) {
            fadeTimer = 100 - fadeTimer;
        }
    }

    public void setIsFadeBlack (boolean isBlack) {
        isFadeBlack = isBlack;
    }

    public void setSpeedSelect (int newSpeed) {
        if (newSpeed < 0 || newSpeed > speeds.length-1) {
            return;
        } else {
            this.speedSelect = newSpeed;
        }
    }
}