interface Displayable {
  void display();
}

interface Moveable {
  void move();
}


interface Collideable {
  boolean isTouching(Thing other);
}

abstract class Thing implements Displayable {
  float x, y;//Position of the Thing
  float xinc, yinc; //increments

  Thing(float x, float y) {
    this.x = x;
    this.y = y;
  }
  Thing(float x, float y, float xinc, float yinc) {
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
    //________rock with moss____
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
    //image of Dwayne Johnson 
    //PImage theRock;
    //theRock = loadImage("theRock.jpg");
    //image(theRock, x, y, 50, 50);
  }
}

public class LivingRock extends Rock implements Moveable {
  LivingRock(float x, float y) {
    super(x, y);
  }
  void move() {
    float d = dist(x, y, mouseX, mouseY);
    if (d <= 100) {
       if (x + 30 <= width && x - 30 >= 0) x += ((x - mouseX) / sq(.15 * d)) ;
      if (y + 20 <= height && y - 20 >= 0)y += ((y - mouseY) / sq(.15 * d)) ;
    }
  }
}

class Ball extends Thing implements Moveable {
  int col;
  Ball(float x, float y) {
    super(x, y);
    col = int(random(3));
  }
  Ball(float x, float y, float xinc, float yinc) {
    super(x, y, xinc, yinc);
    col = int(random(3));
  }


  void display() {
    switch(col) {
    case 0: 
      fill(255, 0, 0);
      break;
    case 1: 
      fill(127, 0, 255);
      break;
    case 2: 
      fill(0, 0, 255);
    }

    ellipse(x, y, 30, 30);

    switch(col) {
    case 0: 
      fill(0, 255, 0);
      break;
    case 1: 
      fill(255, 255, 0);
      break;
    case 2: 
      fill(255, 127, 0);
    }
    ellipse(x, y, 20, 20);
  }

  void move() {
    /* ONE PERSON WRITE THIS */
    //part a
    //x+=random(2)-1;
    //y+=random(2)-1;
    //part b
    if (x < 0||x>width) {
      xinc=-xinc;
    }
    if (y < 0||y>height) {
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
