// spell = new MagicSpell( new Ray(mouseX, mouseY), fire);

class MagicSpell{
  Projectile proj;
  ArrayList<SpellParticle> particles;
  Ray start_locn;
  Ray end_locn;
  color splColor;
  float lifespan = 256.0;
  
  Projectile getProjectile(){
    return new WaterSpellProjectile(start_locn, end_locn);
  }
  
  MagicSpell(Ray start_locn, Ray end_locn){
    this.particles = new ArrayList<SpellParticle>();
    this.start_locn = start_locn.copy();
    this.end_locn = end_locn.copy();
    proj = getProjectile();
    this.addParticles();
  }
  
  void addParticles(){
    for(int i=0; i<100;i++){
      Ray tempOrigin = new Ray(proj.location.x + random(-2, 2), proj.location.y+random(-2,+2), proj.location.z + random(-2, 2) );
      Ray tempVelocity = proj.velocity.copy() ;
      tempVelocity = tempVelocity.div(10) ;
      //new Ray(random(-0.5, -0.2), random(0.2, 0.5), random(0.1,0.2)) ;
      Ray tempAccel = proj.acceleration.copy() ;
      tempAccel = tempAccel.div(10) ;
      if(blue(proj.splColor) == 240.0){
        particles.add( new SpellParticle(tempOrigin, proj.splColor, tempVelocity, tempAccel, 1, 100 - proj.lifespan)) ;
      }
      else{
        particles.add( new SpellParticle(tempOrigin, proj.splColor, tempVelocity, tempAccel, 2, 100 - proj.lifespan)) ;
      }
    }
  }
  
  void run(){
    if(proj.isDead()){
      // projectile died.
      return;
    }
    proj.run();
    for(SpellParticle p : particles){
      p.run();
    }
    addParticles() ;
  }
  
  void explode(){
    particles.clear() ;
    for (int i = 0; i < 1000; i++){
      float radius = 50*sqrt(random(-1, 1)) ;
      float theta = 2*PI*sqrt(random(0, 1));
      Ray tempOrigin = new Ray(proj.location.x, proj.location.y, proj.location.z);
      Ray tempVelocity = new Ray(radius*cos(theta), random(40, 80), radius*sin(theta)) ;
      Ray tempAccel = new Ray(0, -10, 0) ;
      if(blue(proj.splColor) == 240.0){
        particles.add( new SpellParticle(tempOrigin, proj.splColor, tempVelocity, tempAccel, 1, 20)) ;
      }
      else{
        particles.add( new SpellParticle(tempOrigin, proj.splColor, tempVelocity, tempAccel, 2, 20)) ;
      }
      
    }
    for(SpellParticle p : particles){
      p.run();
    }
  }
}

class FireSpell extends MagicSpell{
  FireSpell(Ray start_locn, Ray end_locn){
    super(start_locn, end_locn);
  }
  @Override
  Projectile getProjectile(){
    return new FireSpellProjectile(start_locn, end_locn);
  }
}

class WaterSpell extends MagicSpell{
  WaterSpell(Ray start_locn, Ray end_locn){
    super(start_locn, end_locn);
  }
  @Override
  Projectile getProjectile(){
    return new WaterSpellProjectile(start_locn, end_locn);
  }
}
