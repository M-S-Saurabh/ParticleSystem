class Particle{
  PVector location;
  PVector origin;
  PVector velocity;
  PVector acceleration;
  color splColor; 
  float lifespan;
  float death;
  float alpha;
  float size;
  
  Particle(PVector l){
    restart(l);
  }
  void run(){
    update();
    display();
  }
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    alpha -= 10.0;
    if(size > 0.05){
      size *= 0.95;
    }
    lifespan-=1.0;
    if(lifespan < 20.0){
      float dir = (velocity.x > 0)? -1.0 : 1.0;
      velocity.x = dir * random(1.75,2);
      splColor = color((1-(20-lifespan)/20)* 150);
    }
  }
  void display(){
    tint(255, 126);
    stroke(splColor);
    fill(splColor);
    pushMatrix() ;
    translate(location.x, location.y, location.z);
    ellipse(0,0,size,size);
    //point(0, 0, 0);
    //box(size);
    popMatrix() ;
  }
  void restart(PVector l){
    acceleration = new PVector(0.0, 0.0, 0.0);
    velocity = new PVector(random(-0.5,0.5), random(-1.5,-0.5), 0.0);
    location = l.copy();
    origin = l.copy();
    lifespan = random(50.0,60.0);
    alpha = 255.0;
    death = random(-10,10);
    size = random(0.7,1.2);
  }
  boolean isDead(){
    if(lifespan<death){
      return true;
    }else{
      return false;
    }
  }
}

class SmokeParticle extends Particle{
  SmokeParticle(PVector l){
    super(l);
    this.splColor = color(random(150.0,255.0));
  }
  
  @Override
  void restart(PVector l){
    acceleration = new PVector(random(-0.5, 0.5), random(-0.1,0.0), random(-0.5, 0.5));
    velocity = new PVector(0.0, random(-0.5,-0.0), 0);
    location = l.copy();
    origin = l.copy();
    lifespan = 1000.0;
    alpha = random(150.0,250.0);
    death = random(-10,10);
    size = random(0.3,0.7);
  }
  
  @Override
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    alpha -= 5.0;
    if(size > 0.05){
      size *= 0.99;
    }
    lifespan-=1.0;
    //splColor = color(red(splColor) * 0.99, alpha);
    splColor = color(211, 211, 211, alpha) ;
    if(lifespan < 200.0){
      float dir = (velocity.x > 0)? -1.0 : 1.0;
      velocity.x = dir * random(1.75,2);
    }
  }
}

class FireParticle extends Particle{
  FireParticle(PVector l){
    super(l);
    this.splColor = color(236, 85+random(-100,100), 17, this.alpha);
  }
}
