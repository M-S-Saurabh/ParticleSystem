class Particle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float death;
  float alpha;
  float size = random(1,4);
  
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
    lifespan-=1.0;
    if(lifespan==40.0)
    {
      acceleration.x = random(-0.05,0.05);
      acceleration.y = -0.05;
      velocity.x = random(-0.5,0.5);
      velocity.y = random(0,0);
      alpha = random(30,50);
    }
  }
  void display(){
    stroke(255,alpha);
    fill(255,alpha);
    ellipse(location.x,location.y,size,4);
  }
  void restart(PVector l){
    acceleration = new PVector(0,0.05);
    velocity = new PVector(random(-0.5,0.5),random(0,0));
    location = l.get();
    lifespan = 156.0;
    alpha = random(100,150);
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
