boolean showCoord = false;


class Cell {
  
  private int cellNum;
  public int x;
  public int y;
  public float posX;
  public float posY;
  public boolean alive;
  public int age;
  
  public Cell (int x, int y, boolean alive) {
  
    age = 0;
    posX = x*cellSize;
    posY = y*cellSize;
    this.x = x;
    this.y = y;
    this.alive = alive;
    this.cellNum = y * cellSize + x;
    
    
  }
  
  public void render() {
  
    //println(alive);
    
    if (alive || ignoreAlive) {
      
      // int hue = (333-age*11)%360;
      // int sat = (90-age)%100;
      // int brt = (100-age)%100;
      // if (brt < 10) brt = 10;
      // fill(hue, sat, brt);
      // stroke(hue, sat, brt);
      // square(posX, posY, cellSize);

      //-----------------------------

      int hue = Math.abs(333-age*4)%323;
      int sat = Math.abs(55-age/3)%100;
      int brt = Math.abs(88-age)%100;
      if (brt < 10) brt = 10;
      fill(hue, sat, brt);
      stroke(hue, sat, brt);
      square(posX, posY, cellSize);

    // -------------------------------
      // float hue = Math.abs(360-age*7+frames*22)%323;
      // float sat = (100-age)%100;
      // float brt = (100-age)%100;
      // if (brt < 10) brt = 10;
      // fill(hue, sat, brt);
      // stroke(hue, sat, brt);
      // square(posX, posY, (int)(cellSize/2));
    // // -------------------------------
      // int hue = Math.abs(333-age*4)%323;
      // int sat = (90-age)%100;
      // int brt = (100-age)%100;
      // if (brt < 10) brt = 10;
      // fill(hue, sat, brt);
      // stroke(hue, sat, brt);
      // square(posX, posY, cellSize);

    // // -------------------------------
      // int hue = Math.abs(333-age*4)%323;
      // int sat = (90-age)%100;
      // int brt = (100-age)%100;
      // if (brt < 10) brt = 10;
      // fill(hue, sat, brt);
      // stroke(hue, sat, brt);
      // square(posX, posY, cellSize);





      //End of isAlive / ignore alive
    }


      //TESTING
    // if (showCoord) {
    //   if (alive) {
    //       fill(0);
    //       textSize(20);
    //       text(x+", "+y, posX + cellSize/3, posY + cellSize/1.5);

    //   } else {
        
    //     fill(360);
    //     textSize(20);
    //     text(x+", "+y, posX + cellSize/3, posY + cellSize/1.5);
    
      
    //   }
    // }
    
  }


}
