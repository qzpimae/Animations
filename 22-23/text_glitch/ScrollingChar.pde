
class ScrollingChar {

    float hue;
    float lightness;
    float saturation;
    float x;
    float y;
    float size;
    float speed;
    char character;
    int blendMode;

    final int[] BLEND_MODES = {
        // BLEND, 
        // ADD, 
        // DARKEST, 
        // LIGHTEST, 
        // DIFFERENCE, 
        // MULTIPLY, 
        SCREEN, 
        // REPLACE, 
        // OVERLAY, 
        HARD_LIGHT, 
        // SOFT_LIGHT, 
        // ADD
    };
    
    ScrollingChar () {
        initalizeScrollingChar();
        this.x = random(width);
        this.y = 0;
    }
    
    void render() {
        blendMode(this.blendMode);
        fill(150, this.saturation, this.lightness);
        textSize(this.size );
        text(this.character, this.x, this.y);
        
        // text(this.character, (float)Math.random() * WIDTH, (float)Math.random() * HEIGHT);
    }
    
    void update() {
        this.y += this.speed * globalSpeed;
        this.x += random(-1, 1) * size;

        this.lightness = this.lightness < 50 ? this.lightness + 0.2 : 50;
        
        if (this.y > height + 30) {
            initalizeScrollingChar();
            this.y = random(-HEIGHT/4,HEIGHT/4);
        }
    }

    void initalizeScrollingChar () {
            // this.x = random(width);
            this.size = random(1, 20);
            this.character = char((int)random(0, 200));
            this.hue = random(360);
            this.lightness = random(-100, 0);
            this.saturation = random(20, 70);
            this.speed = random(.5, 5);
            this.blendMode = BLEND_MODES[(int)random(BLEND_MODES.length)];
    }
}