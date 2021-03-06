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

class Rock extends Thing implements Collideable {
  PImage image;
  Rock(float x, float y, PImage image) {
    super(x, y);
    this.image = image;
  }

  boolean isTouching(Thing other) {
    return (dist(x, y, other.x, other.y) <= 25);
  }

  void display() {
    /* ONE PERSON WRITE THIS */
    //________rock with moss____
    image(image, x -25, y - 25, 50, 50);
  }
}

public class LivingRock extends Rock implements Moveable {
  PImage eyeImage;
  LivingRock(float x, float y, PImage image, PImage eyeimg) {
    super(x, y, image);
    eyeImage = eyeimg;
  }
  void move() {
    float d = dist(x, y, mouseX, mouseY);
    if (d <= 100) {
       if (x + 30 <= width && x - 30 >= 0) x += ((x - mouseX) / sq(.15 * d)) ;
       if (y + 20 <= height && y - 20 >= 0) y += ((y - mouseY) / sq(.15 * d)) ;
       if (x + 30 > width || x - 30 < 0) x -= ((x - mouseX) / sq(.15 * d));
       if (y + 20 > height || y - 20 < 0) y -= ((y-mouseY) / sq(.15 * d));
    }

  }
  void display() {
    super.display();
    image(eyeImage, x -25, y - 25, 50, 50);
  }
}

class Ball extends Thing implements Moveable {
  int col;
  int timer;
  Ball(float x, float y) {
    super(x, y);
    col = int(random(3));
  }
  Ball(float x, float y, float xinc, float yinc) {
    super(x, y, xinc, yinc);
    col = int(random(3));
  }

  void chooseColor() {
    if (timer > 0) {
      fill(255, 0, 0);
      ellipse(x, y, 30, 30);
      timer--;
      return;
    }
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
  }


  void display() {
    chooseColor();
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
    collide();
    x+=xinc;
    y+=yinc;
  }
  void collide() {
    for (Collideable c : listOfCollideables) {
      if (c.isTouching(this)) {
        fill(255, 0, 0);
        ellipse(x, y, 30, 30);
        xinc*=random(-10)/abs(xinc);
        yinc*=random(-10)/abs(yinc);
        x+=xinc/abs(xinc)*10;
        y+=yinc/abs(yinc)*10;
        timer = 15;
      }
    }
  }
}
class WavyBall extends Ball {
  float speed;
  WavyBall(float x, float y) {
    super(x, y);
    float speed = random(10, 20);
  }
  WavyBall(float x, float y, float xinc, float yinc) {
    super(x, y, xinc, yinc);
    float speed = random(10, 20);
  }
  WavyBall(float x, float y, float xinc, float yinc, float speed) {
    super(x, y, xinc, yinc);
    this.speed = speed;
  }
  void move() {
    super.move();
    x -= xinc;
    x += 10 * sin(1/speed * y); //sinusoidal movement
    if (x < 0) {
      x+=width/20;
    } else if (x > width) {
      x-=width/20;
    }
  }
  void collide() {
    for (Collideable c : listOfCollideables) {
      if (c.isTouching(this)) {
        fill(0, 255, 0);
        ellipse(x, y, 30, 30);
        xinc*=random(-10)/abs(xinc);
        yinc*=random(-10)/abs(yinc);
        x+=xinc/abs(xinc)*10;
        y+=yinc/abs(yinc)*10;
        timer = 15;
      }
    }
  }
  void display() {
    chooseColor();
    beginShape();
    vertex(x, y+15);
    vertex(x+7.5, y+7.5);
    vertex(x+15, y);
    vertex(x-15, y-15);
    endShape(CLOSE);
  }
}
class GravityBall extends Ball {
  float gforce;
  GravityBall(float x, float y) {
    super(x, y);
    gforce = random(0.7);
  }
  GravityBall(float x, float y, float xinc, float yinc) {
    super(x, y, xinc, yinc);
    gforce = random(0.7);
  }
  void move() {
    super.move();
    yinc+= gforce;
  }
  void collide() {
    for (Collideable c : listOfCollideables) {
      if (c.isTouching(this)) {
        fill(0, 255, 255);
        ellipse(x, y, 30, 30);
        xinc*=random(-10)/abs(xinc);
        yinc*=random(-10)/abs(yinc);
        x+=xinc/abs(xinc)*10;
        y+=yinc/abs(yinc)*10;
        timer = 15;
      }
    }
  }
  void display() {
    chooseColor();
    beginShape();
    vertex(x, y+15);
    vertex(x-7.5, y-sqrt(3)*7.5);
    vertex(x, y-7.5);
    vertex(x+7.5, y-sqrt(3)*7.5);
    endShape(CLOSE);
  }
}

/*DO NOT EDIT THE REST OF THIS */

ArrayList<Displayable> thingsToDisplay;
ArrayList<Moveable> thingsToMove;
ArrayList<Collideable> listOfCollideables;

void setup() {
  size(1000, 800);

  thingsToDisplay = new ArrayList<Displayable>();
  thingsToMove = new ArrayList<Moveable>();
  PImage rockimg;
  PImage eyeimg;
  eyeimg = loadImage("eyes.png");
  listOfCollideables = new ArrayList<Collideable>();
  for (int i = 0; i < 10; i++) {
    rockimg = (random(1) > 0.5) ? loadImage("rock1.png") : loadImage("rock2.png");
    Ball b;
    //if (i % 3 == 0) {
    //  b = new Ball(50+random(width-100), 50+random(height-100), random(10), random(10));
    //} else 
    //Modify the setup to change the ball creation. 
    //Create half as one of the subclasses, 
    //and the other half should be the other subclass.
    if (i % 2 == 1) {
      b = new GravityBall(50+random(width-100), 50+random(height-100), random(10), random(10));
    } else {
      b = new WavyBall(50+random(width-100), 50+random(height - 100), random(10), random(10), random(10, 20));
    }
    thingsToDisplay.add(b);
    thingsToMove.add(b);
    Rock r = new Rock(50+random(width-100), 50+random(height-100), rockimg);
    thingsToDisplay.add(r);
    listOfCollideables.add(r);
  }
  for (int i = 0; i < 3; i++) {
    rockimg = (random(1) > 0.5) ? loadImage("rock1.png") : loadImage("rock2.png");
    LivingRock m = new LivingRock(50+random(width-100), 50+random(height-100), rockimg, eyeimg);
    thingsToDisplay.add(m);
    thingsToMove.add(m);
    listOfCollideables.add(m);
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
