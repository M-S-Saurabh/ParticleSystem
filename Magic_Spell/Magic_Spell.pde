
ParticleSystem spell = null;
color water = color(12,160,240);
color fire = color(236,85,17);

void setup(){
  size(1000, 1000, P3D);
  lights();
  frameRate(60);
}

void draw(){
  fill(0,20);
  rect(0,0, width, height);
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
    proj = new Projectile(start_locn, splColor);
  }
  
  void addParticle(){
    PVector tempOrigin = new PVector(proj.location.x+random(-10,+10), proj.location.y);
    particles.add(new Particle(tempOrigin, splColor));
  }
  
  void run(){
    proj.run();
    if(proj.isDead()){
      // projectile died.
      return;
    }
    for(int i=0; i<20;i++){
      this.addParticle();
    }
    for( Particle p : particles){
      p.run();
      if(p.isDead()){
        PVector tempOrigin = new PVector(proj.location.x+random(-10,+10), proj.location.y);
        p.restart(tempOrigin);
      }
    }
  }
}
