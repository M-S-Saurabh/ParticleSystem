class Particle{
  Ray location;
  Ray origin;
  Ray velocity;
  Ray acceleration;
  color splColor; 
  float lifespan;
  float death;
  float alpha;
  float size;
  
  Particle(Ray l){
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
    if(lifespan < 42.0){
      acceleration.x = 0; acceleration.z = 0;
      velocity.x = 0; velocity.z = 0;
      
    }
    lifespan-=1.0;
  }
  void display(){
    tint(255, 126);
    stroke(splColor);
    fill(splColor);
    point(location.x, location.y, location.z);
  }
  void restart(Ray l){
    acceleration = new Ray(0.0, 0.0, 0.0);
    Ray direction = new Ray(random(-0.5,0.5), 0, random(-0.5,0.5)).normalize();
    velocity = direction.copy().mult(1).add(new Ray(0, random(-1.5,-0.5), 0));
    acceleration = Ray.mult(direction, -0.08);
    location = l.copy();
    origin = l.copy();
    lifespan = 52.0;
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

class FireParticle extends Particle{
  color[] flameColors = {color(100,255),color(183,33,33),color(255,102,0), color(255,214,53)};
  
  FireParticle(Ray l){
    super(l);
    this.splColor = color(236, 85+random(-100,100), 17, this.alpha);
  }
  
  @Override
  void display(){
    color tempColor = flameColors[(int)(lifespan/13.0)];
    tint(255, 126);
    stroke(tempColor);
    fill(tempColor);
    float s = 1.0;
    line(location.x, location.y, location.z,
         location.x+random(-s,s),location.y+random(-s,s), location.z+random(-s,s));
  }
}

class SmokeParticle extends Particle{
  SmokeParticle(Ray l){
    super(l);
    this.splColor = color(random(150.0,255.0));
  }
  
  @Override
  void restart(Ray l){
    acceleration = new Ray(random(-0.5, 0.5), random(-0.1,0.0), random(-0.5, 0.5));
    velocity = new Ray(0.0, random(-0.5,-0.0), 0);
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
