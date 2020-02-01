
ParticleSystem fires = null;

void setup(){
  size(1000, 1000, P3D);
  lights();
  frameRate(60);
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      fires.ignite();
    } else if (keyCode == DOWN) {
      fires.putOut();
    } 
  } else {
    // nothing
  }
}

void draw(){
  background(0);
  if(mousePressed){
    if(fires == null){ 
      fires = new ParticleSystem();
    }
    fires.firePoints.add(new PVector(mouseX, mouseY));
  }
  int start = millis();
  if(fires != null){
    fires.run();
  }
  int end = millis();
  if(end-start > 0){
    print("FPS:"+str(1000/(end-start))+"\n");
  }
}

void endFires(){
  fires = null;
}

class ParticleSystem{
  ArrayList<Particle> particles;
  ArrayList<PVector> firePoints;
  boolean smoke = false;
  float lifespan = 100.0;
  
  ParticleSystem(){
    this.particles = new ArrayList();
    this.firePoints = new ArrayList<PVector>();
  }
  
  void putOut(){
    this.smoke = true;
    lifespan = 100.0;
  }
  
  void ignite(){
    this.smoke = false;
    lifespan = 100.0;
  }
  
  void addParticle(){
    for(PVector origin: this.firePoints){
      if(smoke){
        float xPosition = origin.x + randomGaussian() * 4;
        PVector tempOrigin = new PVector(xPosition, origin.y);
        particles.add(new SmokeParticle(tempOrigin));
      }else{
        PVector tempOrigin = new PVector(origin.x+random(-10,+10), origin.y);
        particles.add(new FireParticle(tempOrigin));
      }
    }
  }
  
  void run(){
    this.lifespan -= 0.5;
    if(smoke && lifespan <= 5.0){
      endFires();
      return;
    }
    for(int i=0; i<5;i++){
      this.addParticle();
    }
    for(int i=particles.size()-1; i>=0; i--){
      Particle p = particles.get(i);
      p.run();
      if(p.isDead()){
        particles.remove(i);
      }
    }
  }
}
