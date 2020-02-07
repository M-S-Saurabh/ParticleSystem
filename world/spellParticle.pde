class SpellParticle{
  Ray location;
  Ray velocity;
  Ray acceleration;
  ArrayList<Ray> history;
  color splColor; 
  float lifespan;
  float death;
  float alpha;
  float size = random(1,4);
  
  SpellParticle(Projectile projectile){
    restart(projectile);
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
    float s = 1.0;
    point(location.x, location.y, location.z);
  }
  
  Ray sampleShell(float rMin, float rMax){
    float f = pow(random(0,1), 1/3);
    float r = f*(rMax-rMin)/rMin +rMin;
    float phi = acos(2*random(0,1)-1);
    float theta = 2*PI*random(0,1);
    Ray result = new Ray(r*cos(theta)*sin(phi), r*sin(theta)*sin(phi), r*cos(phi));
    return result;
  }
  
  void restart(Projectile projectile){
    float rMin = projectile.size;
    location = sampleShell(rMin, rMin+3.0).add(projectile.location);
    
    Ray direction = projectile.velocity.copy().normalize();
    velocity = Ray.mult(direction, random(0,1));
    Ray locn_rel = Ray.sub(location, projectile.origin);
    Ray cylindrical_in = Ray.mult(direction, direction.dot(locn_rel)).sub(locn_rel);  //;
    velocity.add( Ray.mult(cylindrical_in, random(-0.05,-0.01)));
    
    acceleration = new Ray(0,0,0).add(cylindrical_in).mult(0.01);
    lifespan = random(10.0,20.0);
    alpha = random(200,250);
    death = 0.0;
  }
  boolean isDead(){
    if(lifespan<death){
      return true;
    }else{
      return false;
    }
  }
}

class WaterSpellParticle extends SpellParticle{
  WaterSpellParticle(Projectile projectile){
    super(projectile);
    this.splColor = color(12,160+random(-100,100),240,this.alpha);
  }
}

class FireSpellParticle extends SpellParticle{
  color[] flameColors = {color(100,255),color(183,33,33),color(255,102,0), color(255,214,53)};
  
  FireSpellParticle(Projectile projectile){
    super(projectile);
    this.splColor = color(89,35+random(-20,20),13,this.alpha);
  }
  
  @Override
  void display(){
    color tempColor = this.flameColors[(int)(this.lifespan/5.0)];
    stroke(tempColor);
    fill(tempColor);
    float s = 1.0;
    point(location.x, location.y, location.z);
  }
  
  @Override
  void restart(Projectile projectile){
    float rMin = projectile.size;
    location = sampleShell(rMin, rMin+3.0).add(projectile.location);
    
    Ray direction = projectile.velocity.copy().normalize();
    velocity = Ray.mult(direction, random(0,1));
    
    acceleration = new Ray(0,0,0);
    lifespan = random(10.0,20.0);
    alpha = random(200,250);
    death = 0.0;
  }
}
