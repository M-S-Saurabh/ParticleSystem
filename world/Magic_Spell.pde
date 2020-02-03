// spell = new MagicSpell( new PVector(mouseX, mouseY), fire);

class MagicSpell{
  Projectile proj;
  ArrayList<Particle> particles;
  PVector start_locn;
  PVector end_locn;
  color splColor;
  float lifespan = 256.0;
  
  Projectile getProjectile(){
    return new WaterSpellProjectile(start_locn, end_locn);
  }
  
  MagicSpell(PVector start_locn, PVector end_locn){
    this.particles = new ArrayList<Particle>();
    this.start_locn = start_locn.copy();
    this.end_locn = end_locn.copy();
    proj = getProjectile();
    this.addParticles();
  }
  
  void addParticles(){
    //for(int i=0; i<20;i++){
    //  PVector tempOrigin = new PVector(proj.location.x, proj.location.y+random(-10,+10));
    //  if(splColor == water){
    //    particles.add(new WaterSpellParticle(tempOrigin, splColor));
    //  }else{
    //    particles.add(new FireSpellParticle(tempOrigin, splColor));
    //  }
    //}
  }
  
  void run(){
    if(proj.isDead()){
      // projectile died.
      return;
    }
    proj.run();
    //for(Particle p : particles){
    //  p.run();
    //  if(p.isDead()){
    //    PVector tempOrigin = new PVector(proj.location.x, proj.location.y+random(-10,+10));
    //    p.restart(tempOrigin);
    //  }
    //}
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
