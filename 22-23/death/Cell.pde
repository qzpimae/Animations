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

    //GLITCH V1
    // if (scrollCellsHor) {
    //   x += 1;
    //   if (x >= cellCols) {
    //     x = 0;
    //     alive = true;
    //   }
    // }

    //GLITCH V2
    // if (scrollCellsHor) {
    //   x += 1;
    //   if (x >= cellRows) {
    //     x = 0;
    //     alive = true;
    //   }
    // }

    //GLITCHV3
    // if (scrollCellsHor) {
    //   y -= 1;
    //   if (y <= 0) {
    //     y = cellRows;
    //     alive = true;
    //   }
    // }

    if (true) {
      y += vertScroll;
      if (y <= 0) {
        y = cellRows;
        alive = true;
      } else if (y >= cellRows) {
        y = 0;
        alive = true;
      }

      x += horScroll;
      if (x >= cellCols) {
        x = 0;
        alive = true;
      } else if (x <= 0) {
        x = cellCols;
        alive = true;
      }
    }


    
    if (alive) {

      
      // int hue = (333-age*11)%360;
      // int sat = (90-age)%100;
      // int brt = (100-age)%100;
      // if (brt < 10) brt = 10;
      // fill(hue, sat, brt);
      // stroke(hue, sat, brt);
      // square(posX, posY, cellSize);

      //-----------------------------

      int hue = Math.abs(333-age*4)%323;
      int sat = isInColor ? Math.abs(55-age/3)%100 : 0;
      int brt = (Math.abs((isInColor ? -88 : 100 )+(isInColor ? (int)(age * ageMult) : age*20))%100) + lightOffset ;
      // int brt = Math.abs(88-(isInColor ? age : age*20))%100; //org
      int brtLim = isInColor ? 10 : 2;
      if (brt < brtLim) brt = brtLim;
      fill(hue, sat, brt);
      stroke(hue, sat, brt);
      square(posX, posY, cellSize);

      // if (playNotes && notesPlayed < noteLim && age == 1 ) {
      //   notesPlayed++;
      //   sc.playNote(x + ((y+1)/(x+1)), 100, Math.random() * 2);
      //   // sc.playNote(Math.random() * 100, 100, age/10);
      // }

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
