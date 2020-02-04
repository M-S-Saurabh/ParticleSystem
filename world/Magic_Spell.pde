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
    for(int i=0; i<2000;i++){
      particles.add(getParticle());
    }
  }
  
  void run(){
    if(proj.isDead()){
      // projectile died.
      return;
    }
    proj.run();
    for(SpellParticle p : particles){
      if(p.isDead()){p.restart(this.proj);}
      p.run();
    }
  }
  
  SpellParticle getParticle(){
    return new WaterSpellParticle(this.proj);
  }
  
  //void explode(){
  //  particles.clear() ;
  //  for (int i = 0; i < 1000; i++){
  //    float radius = 50*sqrt(random(-1, 1)) ;
  //    float theta = 2*PI*sqrt(random(0, 1));
  //    PVector tempOrigin = new PVector(proj.location.x, proj.location.y, proj.location.z);
  //    PVector tempVelocity = new PVector(radius*cos(theta), random(40, 80), radius*sin(theta)) ;
  //    PVector tempAccel = new PVector(0, -10, 0) ;
  //    particles.add( this.getParticle(tempOrigin, direction));
      
  //  }
  //  for(SpellParticle p : particles){
  //    p.run();
  //  }
  //}
}

class FireSpell extends MagicSpell{
  FireSpell(PVector start_locn, PVector end_locn){
    super(start_locn, end_locn);
  }
  @Override
  Projectile getProjectile(){
    return new FireSpellProjectile(start_locn, end_locn);
  }
  @Override
  SpellParticle getParticle(){
    return new FireSpellParticle(this.proj);
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
  @Override
  SpellParticle getParticle(){
    return new WaterSpellParticle(this.proj);
  }
}
