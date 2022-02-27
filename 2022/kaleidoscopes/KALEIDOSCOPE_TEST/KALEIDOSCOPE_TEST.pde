
int tileSizeX = 256;
int tileSizeY = 256;
color pixelColor; 
PImage sourceImage;
Particle particle;
boolean showImage = false;

float time = 0;

//-----------------Setup


void setup() {
  //size(1024,683);
  // size(550,368);

   fullScreen();
   size(1920, 1080); 
  background(0);
  smooth();
  sourceImage=loadImage("testimg4.png");
  particle = new Particle();

}
 
//-----------------Main Loop
void draw() {
  time++;
  particle.update();

  
  tileCursor(particle);
  
  
  //SHOW PARTICLE LOCATION
  // stroke(255, 255, 255);
  // strokeWeight(20);
  // point(particle.position.x, particle.position.y);



  if (showImage) {
    image(sourceImage,0,0);
  }
}

//-----------------Defined Functions
PImage makeTile(PImage outputImage) {
  for (int i=0; i<=outputImage.width/2; i++) {
    for (int j=0; j<=outputImage.height/2; j++) {
      pixelColor = outputImage.get(i,j);
      outputImage.set(i,j,pixelColor);
      outputImage.set(outputImage.width-i,j,pixelColor);
      outputImage.set(i,outputImage.height-j,pixelColor);
      outputImage.set(outputImage.width-i,outputImage.height-j,pixelColor);
    }
  }
  return outputImage;
}

void tileCursor(Particle particle) {
  PImage tile = makeTile(sourceImage.get((int)particle.position.x,(int)particle.position.y,tileSizeX,tileSizeY));
     for (int i = 0; i < width; i += tileSizeX) {
        for (int j = 0; j < height; j += tileSizeY) {
          image(tile,i,j);
        }
      }
}

//-----------------Interactions
void keyPressed() {
  if (key == ' ') {
    showImage = !showImage;
  }
  switch (key) {
    case '1': 
    case '2': 
    case '3': 
    case '4': 
    case '5': 
    case '6': 
    case '7': 
    case '8':
      sourceImage=loadImage("testimg"+key+".png");
    break;
  }
  if (key == CODED) {
    if (keyCode == UP) {
      tileSizeY += 8;
      for (int i=0; i<width; i+=tileSizeX) {
      for (int j=0; j<height; j+=tileSizeY) {
        image(makeTile(sourceImage.get((int)particle.position.x,(int)particle.position.y,tileSizeX,tileSizeY)),i,j);
      }
    }
    }
    if (keyCode == DOWN) {
      tileSizeY -= 8;
      for (int i=0; i<width; i+=tileSizeX) {
      for (int j=0; j<height; j+=tileSizeY) {
        image(makeTile(sourceImage.get((int)particle.position.x,(int)particle.position.y,tileSizeX,tileSizeY)),i,j);
      }
    }
    }
        if (keyCode == RIGHT) {
      tileSizeX += 8;
      for (int i=0; i<width; i+=tileSizeX) {
      for (int j=0; j<height; j+=tileSizeY) {
        image(makeTile(sourceImage.get((int)particle.position.x,(int)particle.position.y,tileSizeX,tileSizeY)),i,j);
      }
    }
    }
    if (keyCode == LEFT) {
      tileSizeX -= 8;
      for (int i=0; i<width; i+=tileSizeX) {
      for (int j=0; j<height; j+=tileSizeY) {
        image(makeTile(sourceImage.get((int)particle.position.x,(int)particle.position.y,tileSizeX,tileSizeY)),i,j);
      }
    }
    }
  }
}

//-----------------Defined Classes
class Particle {
  PVector position, velocity;
  color particleColor = 255;
  float radius;
 
  Particle() {
    // position = new PVector(random(width),random(height),0);
    position = new PVector(1920/2, 1080/2);
    velocity = new PVector(0,0,0);
    radius = 25;
  }
   
  void update() {
    velocity.x = 0.25*cos(TWO_PI*noise(0.001*position.x,0.001*position.y,0.001*position.z));
    velocity.y = 0.25*sin(TWO_PI*noise(0.001*position.x,0.001*position.y,0.001*position.z));
    position.add(velocity);
 
    //deal with edge cases     
    if (position.x<0) {
       position.x+=width;
    }

    if (position.x>width) {
       position.x-=width;
    }

    if (position.y<0) {
       position.y+=height;
    }

    if (position.y>height) {
       position.y-=height;
    } 

    // position.x = cos(time/tileSizeX+tileSizeY) * tileSizeX/4 + 1920/2; 
    // position.y = sin(time/tileSizeX+tileSizeY) * tileSizeY/4 + 1080/2; 
  }
 
  void render() {
    stroke(particleColor,16);
    line(position.x,position.y,position.x+velocity.x,position.y+velocity.y);
  }
}
