PImage texture;

class Waterfall {
  ArrayList<WaterParticle> particles;
  Ray origin;
  float life = 200.0;
  color splColor = color(12,160,240);
  float river_r = 100.0;
  float river_w = 200.0;
  int maxParticles = 10000;
  
  Waterfall(Ray position) {
    origin = position.copy();
    particles = new ArrayList<WaterParticle>();
    texture = loadImage("textures/smoke.png");
  }

  void addParticle() {
    if(particles.size() < maxParticles){
      for(int i=0; i<50; i++){
        particles.add(new WaterParticle(new Ray(origin.x,origin.y,origin.z+random(-5,5))));
      }
    }
  }

  void update(){
    print("water particles:"+str(particles.size())+"\n");
    addParticle();
    for(WaterParticle p : particles){
      p.run();
      if (p.life < 0.0) {
        p.respawn(p.origin);
      }
    }
  }
  
  void display(){
    // Draw River.
    pushMatrix();
    translate(0,99,0);
    rotateX(PI/2);
    fill(splColor);
    stroke(splColor,100);
    // Grow the mouth of river (ellipse part)
    if(life < 200.0){
      float temp_r = (life<100.0)? river_r : river_r * (1 - (life-100.0)/100.0);
      ellipse(40, 0, temp_r, 0.7*temp_r);
    }
    // Grow length of the river
    if(life < 100){
      rectMode(CENTER);
      float temp_w = (life<0.0)? river_w : river_w * (1 - (life-0.0)/100.0);
      rect(70+(temp_w * 0.5), 0, temp_w, 30);
    }
    popMatrix();
  }
  
  void run() {
    update();
    display();
    life -= 1.0;
  }
}


// WaterParticle class
class WaterParticle {
  Ray position;
  Ray velocity;
  Ray acceleration;
  Ray origin;
  color splColor = color(12,160,240,100);
  boolean river;
  float life;
  float alpha;
  float rotation;

  WaterParticle(Ray l) {
    this.respawn(l);
  }
  
  void respawn(Ray l){
    acceleration = new Ray(0, random(0.25,0.35), 0);
    velocity = new Ray(random(1.5,2.5), 0.0, random(-0.5, 0.5));
    position = l.copy();
    origin = l.copy();
    life = 200.0;
    alpha = 255.0;
    river = false;
    rotation = random(0,PI);
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    life -= 1.0;
    alpha -= 5.0;
    if(position.y > 100.0){
      position.y = 98.0;
      velocity.y *= -0.35;
    }
    if(river ==false && abs(velocity.y) < 0.1){
      river = true;
    }
  }
  
  void drawQuad(float x, float y, float z, float size, color color_){
    float theta = atan(velocity.y/velocity.x);
    float x_opp = x + size*cos(theta);//random(0, size);
    float y_opp = y + size*sin(theta); //random(0, size);
    float z_opp = z + size; //random(0, size);
    int imgHeight = texture.height;
    int imgWidth = texture.width;
    noStroke();
    fill(color_);
    tint(color_);
    beginShape(QUAD_STRIP);
    //texture(texture);
    vertex(x,y,z,0,0);
    vertex(x_opp,y_opp,z,0,imgHeight);
    vertex(x,y,z_opp,imgWidth,0);
    vertex(x_opp,y_opp,z_opp,imgWidth,imgHeight);
    endShape();
  }
  
  // Method to display
  void display() {
    color tempColor;
    //if(river){
    //  tempColor = color(red(splColor), green(splColor), blue(splColor));
    //}else{
    //  tempColor = color(255.0);
    //}
    float s = 5.0;
    //line(position.x, position.y, position.z, position.x+random(-s,s),position.y+random(-s,s), position.z+random(-s,s));
    noStroke();
    tempColor = color(red(splColor), green(splColor), blue(splColor));
    drawQuad(position.x, position.y, position.z, s, tempColor);
  }
}
