class Projectile{
  Ray location;
  Ray velocity;
  Ray acceleration;
  Ray direction;
  Ray origin;
  color splColor; 
  float lifespan = 1000.0;
  float death = 0.0;
  float alpha = 200.0;
  ArrayList<ExplosionParticle> exp ;
  
  boolean explode = false;
  
  float size = 2;
  float sizeMin = 1.5;
  boolean sizeInc = false;
  float sizeMax = 3;
  
  Projectile(Ray start_locn, Ray end_locn){
    restart(start_locn, end_locn);
  }
  void run(){
    update();
    display();
    if (exp != null){
      for(ExplosionParticle e : exp){
         e.run() ;
      }
    }
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
  Ray perturb_along(Ray start, Ray end){
    float len = end.sub(start).mag();
    Ray end_new = end.copy();
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
  
  void restart(Ray start_locn, Ray end_locn){
    direction = Ray.sub(end_locn, start_locn).normalize();
    acceleration = Ray.mult(direction, 0.0);
    velocity = Ray.mult(direction, 2.0);
    location = start_locn.copy();
    origin = start_locn.copy();
    exp = null ;
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
  
  WaterSpellProjectile(Ray start_locn, Ray end_locn){
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
  
  @Override
  void collision(){
    explode = true;
    this.lifespan = 20.0;
    this.velocity = new Ray(0.0, 0.0, 0.0) ;
    this.acceleration = new Ray(0.0, 0.0, 0.0) ;
    this.exp = new ArrayList<ExplosionParticle>() ;
    for(int i = 0 ; i < 10000 ; i++) {
      float r = 100*sqrt(random(0,1)) ;
      float th = 2*PI*sqrt(random(0,1)) ;
      Ray tv = new Ray(r*cos(th), random(-30, -50), r*sin(th)) ;
      Ray ta = new Ray(0 , 2, 0) ;
      exp.add(new ExplosionParticle(this.location, tv, ta, this.splColor, 0.0)) ;
    }
  }
  
}

class FireSpellProjectile extends Projectile{
  
  FireSpellProjectile(Ray start_locn, Ray end_locn){
    super(start_locn, end_locn);
    this.splColor = color(255,232,8);
  }
  
  @Override
  void restart(Ray start_locn, Ray end_locn){
    direction = Ray.sub(end_locn, start_locn).normalize();
    acceleration = Ray.mult(direction, 0.0).add(new Ray(0,0.045,0));
    velocity = Ray.mult(direction, 2.0).add(new Ray(0,-2,0));
    location = start_locn.copy();
    origin = start_locn.copy();
  }
  
  @Override
  void display(){
    // Change color in shades of orange
    color tempColor = color(red(splColor),green(splColor),blue(splColor), alpha);
    stroke(tempColor);
    fill(tempColor);
    drawStar(location.x, location.y, location.z, size);
    pointLight(255,255,255,location.x, location.y, location.z);
  }
  
  @Override
  void collision(){
    explode = true;
    this.lifespan = 20.0;
    this.velocity = new Ray(0.0, 0.0, 0.0) ;
    this.acceleration = new Ray(0.0, 0.0, 0.0) ;
    this.exp = new ArrayList<ExplosionParticle>() ;
    for(int i = 0 ; i < 10000 ; i++) {
      float r = 5*sqrt(random(0,1)) ;
      float th = 2*PI*sqrt(random(0,1)) ;
      float y = random(10, 20) ;
      Ray l = new Ray(this.location.x + r*cos(th), this.location.y + y, this.location.z + r*sin(th)) ;
      Ray tv = new Ray(r*cos(th), 0, r*sin(th)) ;
      Ray ta = new Ray(0 , 0, 0) ;
      exp.add(new ExplosionParticle(l, tv, ta, this.splColor, 60.0)) ;
    }
  }
}
