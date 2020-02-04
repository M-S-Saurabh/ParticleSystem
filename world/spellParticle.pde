class SpellParticle{
  PVector location;
  PVector velocity;
  PVector acceleration;
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
  
  PVector sampleShell(float rMin, float rMax){
    float f = pow(random(0,1), 1/3);
    float r = f*(rMax-rMin)/rMin +rMin;
    float phi = acos(2*random(0,1)-1);
    float theta = 2*PI*random(0,1);
    PVector result = new PVector(r*cos(theta)*sin(phi), r*sin(theta)*sin(phi), r*cos(phi));
    return result;
  }
  
  void restart(Projectile projectile){
    float rMin = projectile.size;
    location = sampleShell(rMin, rMin+5.0).add(projectile.location);
    //location = new PVector(projectile.location.x + random(-2, 2),
    //                       projectile.location.y+random(-2,+2), 
    //                       projectile.location.z +random(-2, 2));
    PVector direction = projectile.velocity.copy().normalize();
    velocity = PVector.mult(direction, -1);
    PVector locn_rel = PVector.sub(location, projectile.origin);
    PVector cylindrical_in = PVector.mult(direction, direction.dot(locn_rel)).sub(locn_rel).mult(0.05);  //;
    velocity.add(cylindrical_in);
    //float radial_dist = sin(PVector.angleBetween(radial_in, projectile.velocity));
    //PVector radial_vel = radial_dist;
    
    acceleration = new PVector(0,0,0);//PVector.mult(radial_in, 0.5);
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
