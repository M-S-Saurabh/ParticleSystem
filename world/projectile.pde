class Projectile{
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector direction;
  PVector origin;
  
  color splColor; 
  float lifespan = 100.0;
  float death = 0.0;
  float alpha = 200.0;
  
  boolean explode = false;
  
  float size = 2;
  float sizeMin = 1.5;
  boolean sizeInc = false;
  float sizeMax = 3;
  
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
  
  void drawStar(float x, float y, float z, float size){
    if(sizeInc){
      if(size >= sizeMax){sizeInc = false;}
      size += 0.5;
    }else{
      if(size <= sizeMin){sizeInc = false;}
      size -= 0.5;
    }
    pushMatrix();
    translate(x, y, z);
    sphere(size);
    popMatrix();
  }
  
  PVector perturb_away(PVector start, PVector end){
    return perturb_along(start, end).mult(-1);
  }
  
  void restart(PVector start_locn, PVector end_locn){
    direction = PVector.sub(end_locn, start_locn).normalize();
    acceleration = PVector.mult(direction, 0.0);
    velocity = PVector.mult(direction, 2.0); 
    location = start_locn.copy();
    origin = start_locn.copy();
  }
  boolean isDead(){
    if(lifespan<death){
      return true;
    }else{
      return false;
    }
  }
}

class WaterSpellProjectile extends Projectile{
  
  WaterSpellProjectile(PVector start_locn, PVector end_locn){
    super(start_locn, end_locn);
    this.splColor = color(12,160,240);
  }
  
  @Override
  void display(){
    // Change color in nearby shades of blue
    color tempColor = color(red(splColor),green(splColor)+random(-50,50),blue(splColor), alpha);
    stroke(tempColor);
    fill(tempColor);
    drawStar(location.x, location.y, location.z, size);
  }
}

class FireSpellProjectile extends Projectile{
  
  FireSpellProjectile(PVector start_locn, PVector end_locn){
    super(start_locn, end_locn);
    this.splColor = color(236,85,17);
  }
  
  @Override
  void display(){
    // Change color in shades of orange
    color tempColor = color(red(splColor),green(splColor)+random(-50,50),blue(splColor), alpha);
    stroke(tempColor);
    fill(tempColor);
    drawStar(location.x, location.y, location.z, size);
  }
}
