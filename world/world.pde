import peasy.*;

PeasyCam cam;

PShape sh, icemage, wizard;
ArrayList<PShape> hills;
PShape W, B, P, Db, Dp, Dw ;
float scaleFactor = 1;
PImage grassMossy;
// Waterfall system
Waterfall waterfall;
ArrayList<Ray> waterPoints;

// MagiSpell system
MagicSpell ms;

float gx ;
float gy ;
float gz ;


// FireParticles System
FireParticleSystem fires = null;
Ray fireOrigin = new Ray(190, 95, 0) ;
boolean burning = false ;
int burningCount = 60 ;
float fireRadius = 10 ;
PImage fireTexture;
boolean rotationMode = true ;

boolean debug_collisions = false;
ArrayList<collisionSphere> collisionList = null;

void setup(){
  
  size(1000,1000,P3D);
  // Setup the camera
  cam = new PeasyCam(this, 425);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(800);
  cam.setYawRotationMode();
  
  waterPoints = new ArrayList<Ray>();
  waterPoints.add(new Ray(2,45,0));
  
  collisionList = new ArrayList<collisionSphere>();
  collisionList.add(new collisionSphere(0,42,0,8)); // Mountain top
  collisionList.add(new collisionSphere(190,80,0,25)); // Forest heart
  
  noStroke();
  // load objects
  sh = loadShape("terrain/Terrain.obj");
  icemage = loadShape("iceMage.obj");
  W = loadShape("OBJ/Willow_3.obj");
  P = loadShape("OBJ/PalmTree_2.obj");
  B = loadShape("OBJ/BirchTree_1.obj");
  Dw = loadShape("OBJ/Willow_Dead_3.obj");
  Db = loadShape("OBJ/BirchTree_Dead_1.obj");
  Dp = loadShape("OBJ/CommonTree_Dead_2.obj");
  grassMossy = loadImage("textures/grass_mossy.png");
  wizard = loadShape("wizard.obj");
  hills = new ArrayList<PShape>();
  fireTexture = loadImage("textures/fire.png");
  for(int i=0; i<3; i++){
    hills.add(loadShape("terrain/Terrain"+str(i+2)+".obj"));
  }
}

void translateCamera(){
  if(keyCode == UP){
    PeasyDragHandler zoomer =  cam.getZoomDragHandler();
    zoomer.handleDrag(-1.0, -1.0) ;
  }
  if(keyCode == DOWN){
    PeasyDragHandler zoomer =  cam.getZoomDragHandler();
    zoomer.handleDrag(1.0, 1.0) ;
  }
  if(keyCode == LEFT){
    PeasyDragHandler pan =  cam.getPanDragHandler();
    pan.handleDrag(15.0, 0.0) ;
  }
  if(keyCode == RIGHT){
    PeasyDragHandler pan =  cam.getPanDragHandler();
    pan.handleDrag(-15.0, 0.0) ;
  }
  if(keyCode == 16){
    PeasyDragHandler pan =  cam.getPanDragHandler();
    pan.handleDrag(0.0, 20.0) ;
  }
  if(keyCode == 11){
    PeasyDragHandler pan =  cam.getPanDragHandler();
    pan.handleDrag(0.0, -20.0) ;
  }
}

void runParticles(){
  if(waterfall != null){waterfall.run();}
  if(ms != null){ms.run();}
  if (burning){
    burningCount-= 1 ;
  }
  if(fires != null){
    fires.run();
    fireRadius += 10.0 ;
  }
  if(waterfall != null && waterfall.life < 40.0){ stopFire();}
  
  if(collisionList.get(0).checkCollision()){
    toggleWaterfall();
  }
  if(collisionList.get(1).checkCollision()){
    toggleForestfire();
  }
}

void draw(){
  background(0.0);
  lights();
  stroke(255);
  fill(255);
  if(keyPressed && key == CODED){
    translateCamera();
  }
  drawWorld();
  runParticles();
  surface.setTitle("World FPS: "+ str(round(frameRate)) +"\n") ;
}

void drawQuad(float x, float y, float z, float size, color color_, float time){
  float rotation = 0;
  float x_opp = x + size*cos(rotation);//random(0, size);
  float y_opp = y + size; //random(0, size);
  float z_opp = z + size*sin(rotation); //random(0, size);
  int imgHeight = fireTexture.height;
  int imgWidth = fireTexture.width;
  noStroke();
  fill(color_);
  beginShape(QUAD_STRIP);
  texture(fireTexture);
  vertex(x,y,z,0,0);
  vertex(x,y_opp,z,0,imgHeight);
  vertex(x_opp,y,z_opp,imgWidth,0);
  vertex(x_opp,y_opp,z_opp,imgWidth,imgHeight);
  endShape();
}
  
float time = 0.0;
void drawWorld(){
  // Draw collision spheres to debug.
  if(debug_collisions){
    for(collisionSphere sph : collisionList){
      sph.drawSelf();
    }
  }
  
  //pointLight(255,255,255,200.0,00.0,-200.0);
  //pushMatrix();
  //translate(200.0,0.0,-200.0);
  //sphere(3);
  //popMatrix();
  
  //pointLight(255,255,255,98.0,50.0,60.0);
  //Test
  //time += 0.1;
  //drawQuad(0,0,0, 10, color(255,214,53), time);
  //drawQuad(2,2,2, 10, color(255,214,53), time);
  
   //Draw the hill
  pushMatrix();
  rotateX(PI);
  rotateY(PI/2);
  translate(0,-100,0);
  scale(20.0);
  shape(sh);
  translate(3,0,0);
  shape(hills.get(0));
  translate(-6,0,0);
  shape(hills.get(0));
  translate(3,0.01,-4);
  shape(hills.get(1));
  translate(-4,0,0);
  shape(hills.get(2));
  translate(8,0,0);
  shape(sh);
  popMatrix() ;
  pointLight(255,255,255,200,-200,0);
  
  // Draw ice mage.
  pushMatrix();
  rotateX(PI);
  translate(100,-100,-150);
  scale(0.2);
  shape(icemage);
  popMatrix();
  
  // Draw wizard.
  pushMatrix();
  rotateX(PI);
  translate(100,-80,+180);
  rotateY(PI);
  scale(110);
  shape(wizard);
  popMatrix();
  
  // Draw the ground
  pushMatrix();
  //stroke(150, 75, 0);
  //fill(150, 75, 0) ;
  //fill(86,176,0);
  translate(0,100,0);
  beginShape(QUAD_STRIP);
  noTint();
  texture(grassMossy);
  vertex(-200, 0,-250,0,0);
  vertex(-200, 0,+250,0,512);
  vertex(300, 0, -250,512,0);
  vertex(300, 0, 250,512,512);
  endShape();
  popMatrix();
  
  if (burningCount > 0){
    greenScene();
  }
  if (burningCount <= 0){
    burntScene();
  }
}

void greenScene(){
  pushMatrix();
  rotateX(PI);
  translate(170, -100, 10);
  scale(10.0);
  shape(B);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(200, -100, 0);
  scale(10.0);
  shape(B);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(210, -100, -10);
  scale(10.0);
  shape(B);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(190, -100, 10);
  scale(10.0);
  shape(P);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(180, -100, 0);
  scale(10.0);
  shape(P);
  popMatrix() ;
      
  pushMatrix();
  rotateX(PI);
  translate(210, -100, 10);
  scale(10.0);
  shape(W);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(170,-100, 0);
  scale(10.0);
  shape(W);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(190,-100, -10);
  scale(10.0);
  shape(W);
  popMatrix() ;
  
}

void burntScene(){
  pushMatrix();
  rotateX(PI);
  translate(170, -100, 10);
  scale(10.0);
  shape(Db);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(200, -100, 0);
  scale(10.0);
  shape(Db);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(210, -100, -10);
  scale(10.0);
  shape(Db);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(190,-100, 10);
  scale(10.0);
  shape(Dp);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(180,-100, 0);
  scale(10.0);
  shape(Dp);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(210,-100, 10);
  scale(10.0);
  shape(Dw);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(180,-100, 0);
  scale(10.0);
  shape(Dw);
  popMatrix() ;
  
  pushMatrix();
  rotateX(PI);
  translate(190,-100, -10);
  scale(10.0);
  shape(Dw);
  popMatrix() ; 
}

void toggleWaterfall(){
  if(waterfall == null){
    for(Ray point: waterPoints){
      waterfall = new Waterfall(point);
    }
  }else{
    waterfall = null;
  }
}

void stopFire(){
  burningCount = 30 ;
  fires = null ;
  burning = false ;
}

void toggleForestfire(){
  if(fires == null){ 
    fires = new FireParticleSystem();
    fires.firePoints.add(fireOrigin);
    burning = true ;
  }else{
    burningCount = 30 ;
    fires = null ;
    burning = false ;
  }
}

void keyPressed() {
  print("keyCode is:"+keyCode+"\n");
  // reset camera constraints
  if (keyCode == 48) {
    cam.setYawRotationMode();
  }
  // C key: clear the camera constraints.
  if(keyCode == 67){
    cam.setFreeRotationMode();
  }
  
  // Pressing M key: shoots water spell
  if(keyCode == 77){
    if(ms != null){collisionList.get(0).resetDetector();}
    ms = new WaterSpell(new Ray(100,75,-150), new Ray(2,45,0));
    collisionList.get(0).addDetector(ms.proj);
  }
  // Pressing N key: shoots fire spell
  if(keyCode == 78){
    if(ms != null){collisionList.get(1).resetDetector();}
    ms = new FireSpell(new Ray(100,75,150), new Ray(190,80,0));
    collisionList.get(1).addDetector(ms.proj);
  }
  
  // Pressing W key: toggles water flow
  if(keyCode == 87){
    toggleWaterfall();
  }
  // F key: creates Fire
  if (keyCode==70){
    toggleForestfire();
  }
  
  if (keyCode == 16 || keyCode == 11){
     translateCamera() ; 
  }
  
  if (keyCode == 65){
    rotationMode = !rotationMode ;
    if (rotationMode == false){
      gx = screenX(0, 0, 0) ;
      gy = screenY(0, 0, 0) ;
      gz = screenZ(0, 0, 0) ;
    }
    cam.setActive(rotationMode) ;
  }
}

void mousePressed(){
  if(rotationMode == false){
    if (waterfall != null){
      if (mouseButton == LEFT){
        waterfall.moveSphereForward() ;
      }
      if (mouseButton == RIGHT){
        waterfall.moveSphereBackward() ;
      }
      
    }
  }
}
