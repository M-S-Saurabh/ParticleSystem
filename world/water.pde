ParticleSystem ps;

// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {
  ArrayList<WaterParticle> particles;
  PVector origin;

  ParticleSystem(PVector position) {
    origin = position.copy();
    particles = new ArrayList<WaterParticle>();
  }

  void addParticle() {
    for(int i=0;i<50;i++){
      particles.add(new WaterParticle(new PVector(origin.x,origin.y,origin.z+random(-5,5))));
    }
  }

  void run() {
    this.addParticle();
    for (int i = particles.size()-1; i >= 0; i--) {
      WaterParticle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}


// A simple WaterParticle class

class WaterParticle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  color splColor = color(12,160,240);
  float lifespan;
  float alpha;

  WaterParticle(PVector l) {
    acceleration = new PVector(0, 0.05, 0);
    velocity = new PVector(1, random(0,1), random(-0.5, 0.5));
    position = l.copy();
    lifespan = 40.0;
    alpha = 255.0;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
    alpha -= 5.0;
  }

  // Method to display
  void display() {
    //color tempColor = color(red(splColor), green(splColor), blue(splColor), lifespan);
    stroke(255, alpha);
    fill(255, alpha);
    pushMatrix();
    translate(position.x, position.y, position.z);
    box(0.5);
    popMatrix();
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
