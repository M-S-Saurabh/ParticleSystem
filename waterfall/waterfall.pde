ParticleSystem ps=null;
PImage img;
void setup()
{
  size(640,480);
  frameRate(60);
  img= loadImage("Waterfall-640x480.jpg");
}

void draw()
{
  fill(0,20);
  tint(255,20);
  image(img,0,0);
  rect(0, 0, width, height);
  if(mousePressed){
    startWaterfall();
  }
  if(ps!=null){
    if(ps.particles.size()<500){
      ps.addParticle();
    }  
    ps.run();
  }
  
}

void startWaterfall(){
   ps = new ParticleSystem(new PVector(mouseX,mouseY));
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  ParticleSystem(PVector location){
    origin = location.get();
    particles = new ArrayList<Particle>();
  }
  void addParticle(){
    PVector tempOrigin = new PVector(origin.x+random(-35,+35),origin.y);
    particles.add(new Particle(tempOrigin));
  }
  void run(){
    for(int i=particles.size()-1; i>=0;i--){
      Particle p = particles.get(i);
      p.run();
      if(p.isDead()){
        //particles.remove(i);
        p.restart(new PVector(origin.x+random(-35,+35),origin.y));
      }
    }
  }
}
