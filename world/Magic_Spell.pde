//void draw(){
//  background(0);
//  if(mousePressed){
//    int rdm = (int) random(2);
//    if( rdm % 2 == 0){
//      spell = new MagicSpell( new PVector(mouseX, mouseY), water);
//    }else{
//      spell = new MagicSpell( new PVector(mouseX, mouseY), fire);
//    }
//  }
//  if(spell != null){
//    spell.run();
//  }
//}

class MagicSpell{
  Projectile proj;
  ArrayList<Particle> particles;
  PVector start_locn;
  PVector end_locn;
  color splColor;
  float lifespan = 256.0;
  
  MagicSpell(PVector start_locn, PVector end_locn, color splColor){
    this.particles = new ArrayList<Particle>();
    this.start_locn = start_locn.copy();
    this.end_locn = end_locn.copy();
    this.splColor = splColor;
    if(splColor == water){
      proj = new WaterSpellProjectile(start_locn, end_locn, splColor);
    }else{
      proj = new FireSpellProjectile(start_locn, end_locn, splColor);
    }
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
