
ParticleSystem spell = null;
color water = color(12,160,240);
color fire = color(236,85,17);

void setup(){
  size(1000, 1000, P3D);
  lights();
  frameRate(60);
}

void draw(){
  background(0);
  if(mousePressed){
    int rdm = (int) random(2);
    if( rdm % 2 == 0){
      spell = new ParticleSystem( new PVector(mouseX, mouseY), water);
    }else{
      spell = new ParticleSystem( new PVector(mouseX, mouseY), fire);
    }
  }
  if(spell != null){
    spell.run();
  }
}

class ParticleSystem{
  Projectile proj;
  ArrayList<Particle> particles;
  PVector origin;
  color splColor;
  float lifespan = 256.0;
  
  ParticleSystem(PVector start_locn, color splColor){
    particles = new ArrayList();
    origin = start_locn.copy();
    this.splColor = splColor;
    if(splColor == water){
      proj = new WaterSpellProjectile(start_locn, splColor);
    }else{
      proj = new FireSpellProjectile(start_locn, splColor);
    }
  }
  
  void addParticle(){
    PVector tempOrigin = new PVector(proj.location.x, proj.location.y+random(-10,+10));
    if(splColor == water){
      particles.add(new WaterSpellParticle(tempOrigin, splColor));
    }else{
      particles.add(new FireSpellParticle(tempOrigin, splColor));
    }
  }
  
  void run(){
    if(proj.isDead()){
      // projectile died.
      return;
    }
    proj.run();
    for(int i=0; i<20;i++){
      this.addParticle();
    }
    for(int i=0; i<particles.size(); i++){
      Particle p = particles.get(i);
      p.run();
      if(p.isDead()){
        particles.remove(i);
      }
    }
  }
}
