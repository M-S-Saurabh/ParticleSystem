//void setup(){
//  size(1000, 1000, P3D);
//  lights();
//  frameRate(60);
//}

//void keyPressed() {
//  if (key == CODED) {
//    if (keyCode == UP) {
//      fires.ignite();
//    } else if (keyCode == DOWN) {
//      fires.putOut();
//    } 
//  } else {
//    // nothing
//  }
//}
//void draw(){
//  background(0);
//  if(mousePressed){

//  }
//  int start = millis();
//  if(fires != null){
//    fires.run();
//  }
//  int end = millis();
//  if(end-start > 0){
//    print("FPS:"+str(1000/(end-start))+"\n");
//  }
//}

void endFires(){
  fires = null;
}

class FireParticleSystem{
  ArrayList<Particle> particles;
  ArrayList<PVector> firePoints;
  boolean smoke = false;
  float lifespan = 100.0;
  
  FireParticleSystem(){
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
        float radius = 5*sqrt(random(-1, 1)) ;
        float theta = 2*PI*random(0, 1);
        float xPosition = origin.x + radius*cos(theta)*randomGaussian() * 4;
        PVector tempOrigin = new PVector(xPosition, origin.y, origin.z + radius*sin(theta));
        particles.add(new SmokeParticle(tempOrigin));
      }else{
        // radius of the fire,  radius 30 encircles the trees completely 
        float radius = 20*sqrt(random(-1, 1)) ;
        float theta = 2*PI*random(0, 1);
        //PVector tempOrigin = new PVector(origin.x+random(-10,+10), origin.y, origin.z);
        PVector tempOrigin = new PVector(origin.x + radius*cos(theta), origin.y, origin.z + radius*sin(theta));
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
    // increase the number of particles creates more realistic effect
    for(int i=0; i<100 ; i++){
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
