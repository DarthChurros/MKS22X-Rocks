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
  Thing(float x, float y, float xinc, float yinc) {
    this.x = x; 
    this.y = y;
    this.xinc = xinc;
    this.yinc = yinc;
  }
  abstract void display();
}

class Rock extends Thing {
  PImage image;
  Rock(float x, float y, PImage image) {
    super(x, y);
    this.image = image;
  }

  void display() {
    /* ONE PERSON WRITE THIS */
    //________rock with moss____
    image(image, x -25 , y - 25, 50, 50);
  }
}

public class LivingRock extends Rock implements Moveable {
  PImage eyeImage;
  LivingRock(float x, float y,  PImage image, PImage eyeimg) {
    super(x, y, image);
    eyeImage = eyeimg;
    
    
  }
  void move() {
    float d = dist(x, y, mouseX, mouseY);
    if (d <= 100) {
       if (x + 30 <= width && x - 30 >= 0) x += ((x - mouseX) / sq(.15 * d)) ;
      if (y + 20 <= height && y - 20 >= 0)y += ((y - mouseY) / sq(.15 * d)) ;
    }
  }
  void display(){
      super.display();
      image(eyeImage, x -25 , y - 25, 50, 50);
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
    PImage rockimg;
    PImage eyeimg;
    eyeimg = loadImage("eyes.png");
  for (int i = 0; i < 10; i++) {
    rockimg = (random(1) > 0.5) ? loadImage("rock1.png") : loadImage("rock2.png");
    Ball b = new Ball(50+random(width-100), 50+random(height-100), random(10), random(10));
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100), rockimg);
    thingsToDisplay.add(r);
  }
  for (int i = 0; i < 3; i++) {
    rockimg = (random(1) > 0.5) ? loadImage("rock1.png") : loadImage("rock2.png");
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100), rockimg, eyeimg);
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