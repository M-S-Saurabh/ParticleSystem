// spell = new MagicSpell( new PVector(mouseX, mouseY), fire);

class MagicSpell{
  Projectile proj;
  ArrayList<SpellParticle> particles;
  PVector start_locn;
  PVector end_locn;
  color splColor;
  float lifespan = 256.0;
  
  Projectile getProjectile(){
    return new WaterSpellProjectile(start_locn, end_locn);
  }
  
  MagicSpell(PVector start_locn, PVector end_locn){
    this.particles = new ArrayList<SpellParticle>();
    this.start_locn = start_locn.copy();
    this.end_locn = end_locn.copy();
    proj = getProjectile();
    this.addParticles();
  }
  
  void addParticles(){
    for(int i=0; i<100;i++){
      PVector tempOrigin = new PVector(proj.location.x + random(-2, 2), proj.location.y+random(-2,+2), proj.location.z + random(-2, 2) );
      PVector tempVelocity = proj.velocity.copy() ;
      tempVelocity = tempVelocity.div(10) ;
      //new PVector(random(-0.5, -0.2), random(0.2, 0.5), random(0.1,0.2)) ;
      PVector tempAccel = proj.acceleration.copy() ;
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
      PVector tempOrigin = new PVector(proj.location.x, proj.location.y, proj.location.z);
      PVector tempVelocity = new PVector(radius*cos(theta), random(40, 80), radius*sin(theta)) ;
      PVector tempAccel = new PVector(0, -10, 0) ;
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
  FireSpell(PVector start_locn, PVector end_locn){
    super(start_locn, end_locn);
  }
  @Override
  Projectile getProjectile(){
    return new FireSpellProjectile(start_locn, end_locn);
  }
}

class WaterSpell extends MagicSpell{
  WaterSpell(PVector start_locn, PVector end_locn){
    super(start_locn, end_locn);
  }
  @Override
  Projectile getProjectile(){
    return new WaterSpellProjectile(start_locn, end_locn);
  }
}
