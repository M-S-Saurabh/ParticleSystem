void endFires(){
  fires = null;
}

class FireParticleSystem{
  ArrayList<Particle> particles;
  ArrayList<Ray> firePoints;
  PImage fireTexture = loadImage("textures/fire.png");
  boolean smoke = false;
  float lifespan = 100.0;
  float maxParticles = 10000;
  
  FireParticleSystem(){
    this.particles = new ArrayList();
    this.firePoints = new ArrayList<Ray>();
  }
  
  void putOut(){
    this.smoke = true;
    lifespan = 100.0;
  }
  
  void ignite(){
    this.smoke = false;
    lifespan = 100.0;
  }
  
  void drawLights(){
    for(Ray point : firePoints){
      if( (int)random(0,5) % 2 == 0){
        pointLight(255,255,255,point.x, point.y-20.0, point.z);
      }
    }
  }
  
  void addParticle(){
    for(Ray origin: this.firePoints){
      if(smoke){
        float radius = 5*sqrt(random(-1, 1)) ;
        float theta = 2*PI*random(0, 1);
        float xPosition = origin.x + radius*cos(theta)*randomGaussian() * 4;
        Ray tempOrigin = new Ray(xPosition, origin.y, origin.z + radius*sin(theta));
        particles.add(new SmokeParticle(tempOrigin));
      }else{
        // radius of the fire,  radius 30 encircles the trees completely 
        float radius = 20*sqrt(random(-1, 1)) ;
        float theta = 2*PI*random(0, 1);
        //Ray tempOrigin = new Ray(origin.x+random(-10,+10), origin.y, origin.z);
        Ray tempOrigin = new Ray(origin.x + radius*cos(theta), origin.y, origin.z + radius*sin(theta));
        particles.add(new FireParticle(tempOrigin, fireTexture));
      }
    }
  }
  
  void run(){
    this.lifespan -= 0.5;
    if(smoke && lifespan <= 5.0){
      endFires();
      return;
    }
    print("particles:"+str(particles.size())+"\n");
    this.drawLights();
    // increase the number of particles creates more realistic effect
    if(particles.size() < this.maxParticles){
      for(int i=0; i<300; i++){
        this.addParticle();
      }
    }
    for(int i=particles.size()-1; i>=0; i--){
      Particle p = particles.get(i);
      p.run();
      if(p.isDead()){
        p.restart(p.origin);
      }
    }
  }
}
