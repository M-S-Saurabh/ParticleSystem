class SpellParticle{
  Ray location;
  Ray velocity;
  Ray acceleration;
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
    point(location.x, location.y, location.z) ;
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
    location = sampleShell(rMin, rMin+5.0).add(projectile.location);
    
    Ray direction = projectile.velocity.copy().normalize();
    velocity = Ray.mult(direction, -1);
    Ray locn_rel = Ray.sub(location, projectile.origin);
    Ray cylindrical_in = Ray.mult(direction, direction.dot(locn_rel)).sub(locn_rel).mult(0.05);  //;
    velocity.add(cylindrical_in);
    
    acceleration = new Ray(0,0,0);
    lifespan = random(5.0,15.0);
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
    this.splColor = color(12,160,240,this.alpha);
  }
}

class FireSpellParticle extends SpellParticle{
  FireSpellParticle(Projectile projectile){
    super(projectile);
    this.splColor = color(236,85,17,this.alpha);
  }
}
