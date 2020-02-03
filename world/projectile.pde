class Projectile{
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector direction;
  color splColor; 
  float lifespan;
  float death;
  float alpha;
  float size = 1;
  boolean explode = false;
  
  Projectile(PVector start_locn, PVector end_locn){
    restart(start_locn, end_locn);
  }
  void run(){
    update();
    display();
  }
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    lifespan-=1.0;
  }
  void display(){
    stroke(splColor);
    fill(splColor);
    ellipse(location.x,location.y,size*0.8,size);
  }
  void collision(){
    explode = true;
    this.lifespan = 0.0;
  }
  PVector perturb_along(PVector start, PVector end){
    float len = PVector.sub(end,start).mag();
    PVector end_new = end.copy();
    end_new.x += random(0.01*len);
    end_new.y += random(0.01*len);
    end_new.z += random(0.01*len);
    return end_new.sub(start).normalize();
  }
  
  PVector perturb_away(PVector start, PVector end){
    return perturb_along(start, end).mult(-1);
  }
  
  void restart(PVector start_locn, PVector end_locn){
    direction = PVector.sub(end_locn, start_locn).normalize();
    // 0.1 in the direction and some perturbation new PVector(0.1,random(-0.05,0.05), random(-0.05, 0.05));
    acceleration = PVector.mult(direction, 0.1);
    // velocity of 4 in the direction
    velocity = PVector.mult(direction, 0.5); 
    location = start_locn.copy();
    lifespan = 100;
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

void drawStar(float x, float y, float z, float size){
  float p = random(-5,5)+size;
  int rdm = (int) random(3);
  if( rdm % 3 == 0){
    pushMatrix();
    translate(x, y, z);
    box(p);
    popMatrix();
  }else{
    pushMatrix();
    translate(x, y, z);
    sphere(p);
    popMatrix();
  }
}

class WaterSpellProjectile extends Projectile{
  
  WaterSpellProjectile(PVector start_locn, PVector end_locn){
    super(start_locn, end_locn);
    this.splColor = color(12,160,240);
  }
  
  @Override
  void display(){
    color tempColor = color(red(splColor),green(splColor)+random(-100,100),blue(splColor));
    stroke(tempColor);
    fill(tempColor);
    drawStar(location.x, location.y, location.z, size);
    location.x  += random(-3, 3) ;
  }
}

class FireSpellProjectile extends Projectile{
  
  FireSpellProjectile(PVector start_locn, PVector end_locn){
    super(start_locn, end_locn);
    this.splColor = color(236,85,17);
  }
  
  @Override
  void display(){
    color tempColor = color(red(splColor),green(splColor)+random(-100,100),blue(splColor));
    stroke(tempColor);
    fill(tempColor);
    drawStar(location.x, location.y, location.z, size);
    location.z += random(-2, 2) ;
  }
}
