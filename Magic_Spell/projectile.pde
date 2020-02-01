class Projectile{
  PVector location;
  PVector velocity;
  PVector acceleration;
  color splColor; 
  float lifespan;
  float death;
  float alpha;
  float size = 15;
  
  Projectile(PVector l, color splColor){
    restart(l);
    this.splColor = splColor;
  }
  void run(){
    update();
    display();
  }
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    lifespan-=1.0;
    if(lifespan % 32 == 0.0)
    {
      acceleration.y = -1 * acceleration.y;
      acceleration.x = acceleration.x * random(0.9,1.1);
      velocity.y = random(0,0);
      alpha = random(30,50);
    }
  }
  void display(){
    stroke(splColor);
    fill(splColor);
    ellipse(location.x,location.y,size*0.8,size);
  }
  void restart(PVector l){
    acceleration = new PVector(0.1,random(-0.05,0.05));
    velocity = new PVector(random(3.5,4.0),random(0,0));
    location = l.copy();
    lifespan = 1000;
    alpha = random(100,150);
    splColor = color(red(splColor),green(splColor),blue(splColor),alpha);
    death = random(-10,10);
  }
  boolean isDead(){
    if(lifespan<death){
      return true;
    }else{
      return false;
    }
  }
}

void drawStar(float x, float y, float size){
  float p = random(-5,5)+size;
  int rdm = (int) random(3);
  if( rdm % 3 == 0){
    line (x+p, y, x, y);
    line (x, y+p, x, y);
    line (x, y, x-p, y);
    line (x, y, x, y-p);
  }else{
    ellipse(x, y, p*0.8, p);
  }
}

class WaterSpellProjectile extends Projectile{
  WaterSpellProjectile(PVector start_locn, color splColor){
    super(start_locn, splColor);
  }
  
  @Override
  void display(){
    color tempColor = color(red(splColor),green(splColor)+random(-100,100),blue(splColor));
    stroke(tempColor);
    fill(tempColor);
    drawStar(location.x, location.y, size);
  }
}

class FireSpellProjectile extends Projectile{
  FireSpellProjectile(PVector start_locn, color splColor){
    super(start_locn, splColor);
  }
  
  @Override
  void display(){
    color tempColor = color(red(splColor),green(splColor)+random(-100,100),blue(splColor));
    stroke(tempColor);
    fill(tempColor);
    drawStar(location.x, location.y, size);
  }
}
