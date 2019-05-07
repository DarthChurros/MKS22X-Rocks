interface Displayable {
  void display();
}

interface Moveable {
  void move();
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing
  float xinc, yinc; //increments

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  Thing(float x, float y, float xinc, float yinc){
    this.x = x; 
    this.y = y;
    this.xinc = xinc;
    this.yinc = yinc;
    }
  abstract void display();
}

class Rock extends Thing {
  Rock(float x, float y) {
    super(x, y);
  }

  void display() {
    /* ONE PERSON WRITE THIS */
    int r = 34;
    int g = 139;
    int b = 34;
    fill(192, 192, 192);
    ellipse(x, y, 50, 30);
    //moss changes color when it reaches the edge
    if(x + 25>= width || y+15 >= width || x-25 <= 0 || y-15 <= 0) {
      r = (int)random(255);
      g = (int)random(255);
      b = (int)random(255);
    }
    fill(r,g,b);
    //moss
    noStroke();
    beginShape();
    vertex(x-20, y-10);
    bezierVertex(x-20, y-10, x, y-20, x+20, y-10);
    vertex(x+20, y-10);
    endShape();
    triangle(x, y-10, x - 10, y, x - 20, y-10);
    triangle(x-10, y-10, x, y, x + 10, y-10);
    triangle(x, y-10, x + 10, y, x + 20, y-10);
    
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    if (dist(x, y, mouseX, mouseY) <= 100){
      y++;
    }
  }
}

class Ball extends Thing implements Moveable {
  int col;
  Ball(float x, float y) {
    super(x, y);
    col = (int)random(3);
  }
  Ball(float x, float y, float xinc, float yinc){
    super(x,y,xinc,yinc);
  }
  

  void display() {
    switch(col) {
      case 0: fill(255,0,0);
      break;
      case 1: fill(0,255,0);
      break;
      case 2: fill(0,0,255);
    }
    
    ellipse(x,y,30,30);
    
    switch(col) {
      case 1: fill(255,0,0);
      break;
      case 2: fill(0,255,0);
      break;
      case 0: fill(0,0,255);
    }
    ellipse(x,y,15,15);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
    //part a
    //x+=random(2)-1;
    //y+=random(2)-1;
    //part b
    if (x < 0||x>width){
      xinc=-xinc;
    }
    if (y < 0||y>height){
      yinc=-yinc;
    }
    x+=xinc;
    y+=yinc;
    
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  for (int i = 0; i < 10; i++) {
    Ball b = new Ball(50+random(width-100), 50+random(height-100), random(10), random(10));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100));
    thingsToDisplay.add(m);
    thingsToMove.add(m);
  }
}
void draw() {
  background(255);

  for (Displayable thing : thingsToDisplay) {
    thing.display();
  }
  for (Moveable thing : thingsToMove) {
    thing.move();
  }
}
