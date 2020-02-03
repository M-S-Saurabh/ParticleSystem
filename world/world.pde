import peasy.*;

PeasyCam cam;

PShape sh, icemage;
PShape W, B, P, Db, Dp, Dw ;
float scaleFactor = 1;

// Waterfall system
Waterfall waterfall;
ArrayList<PVector> waterPoints;

// MagiSpell system
MagicSpell ms;
color water = color(12,160,240);
color fire = color(236,85,17);


// FireParticles System
FireParticleSystem fires = null;
PVector fireOrigin = new PVector(190, 100, 0) ;
boolean burning = false ;
int burningCount = 30 ;
float fireRadius = 10 ;

void setup(){
  
  size(1000,1000,P3D);
  cam = new PeasyCam(this, 425);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(800);
  cam.setYawRotationMode();
  
  if(waterPoints == null){waterPoints = new ArrayList<PVector>();}
  waterPoints.add(new PVector(2,45,0));
  
  noStroke();
  sh = loadShape("OBJ/Terrain.obj");
  icemage = loadShape("iceMage.obj");
  W = loadShape("OBJ/Willow_3.obj");
  P = loadShape("OBJ/PalmTree_2.obj");
  B = loadShape("OBJ/BirchTree_1.obj");
  Dw = loadShape("OBJ/Willow_Dead_3.obj");
  Db = loadShape("OBJ/BirchTree_Dead_1.obj");
  Dp = loadShape("OBJ/CommonTree_Dead_2.obj");

}

void translateCamera(){
  float[] camPosition = cam.getLookAt();
  if(keyCode == UP){   
    cam.lookAt(camPosition[0], camPosition[1]+50, camPosition[2]);
  }
  if(keyCode == DOWN){
    cam.lookAt(camPosition[0], camPosition[1]-50, camPosition[2]);
  }
  if(keyCode == LEFT){
    cam.lookAt(camPosition[0]-50, camPosition[1], camPosition[2]);
  }
  if(keyCode == RIGHT){
    cam.lookAt(camPosition[0]+50, camPosition[1], camPosition[2]);
  }
}

void runParticles(){
  if(waterfall != null){waterfall.run();}
  if(ms != null){ms.run();}
}

void draw(){
  background(0);
  lights();
  stroke(255);
  fill(255);
  
  if(keyPressed && key == CODED){
    translateCamera();
  }
  
  pushMatrix();
  rotateX(PI);
  rotateY(PI/2);
  translate(0,-100,0);
  scale(20.0);
  shape(sh);
  popMatrix() ;
  
  // Draw ice mage.
  pushMatrix();
  rotateX(PI);
  translate(100,-100,-150);
  scale(0.2);
  shape(icemage);
  popMatrix();
  
  // Draw a plane
  pushMatrix();
  stroke(150, 75, 0);
  fill(150, 75, 0) ;
  translate(0,101,0);
  box(600,2,600);
  popMatrix();
  
  int start = millis();
  runParticles();
  int end = millis();
  if(end - start > 0){
    print("FPS:"+str(1000/(end-start))+"\n");
  }
  
  if (burning){
    burningCount-= 1 ;
  }
  
  if (burningCount > 0){
    greenScene();
  }
  
  if (burningCount <= 0){
    burntScene();
  }
  
  if(fires != null){
    fires.run();
    fireRadius += 10.0 ;
  }
  
  surface.setTitle("World FPS: "+ str(round(frameRate)) +"\n") ;
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
  
  // Pressing M key: shoots magic spell
  if(keyCode == 77){
    ms = new MagicSpell(new PVector(100,75,150), new PVector(2,45,0), water);
  }
  
  // Pressing W key: toggles water flow
  if(keyCode == 87){
    if(waterfall == null){
      for(PVector point: waterPoints){
        waterfall = new Waterfall(point);
      }
    }else{
      waterfall = null;
    }
  }
  // F key: creates Fire
  if (keyCode==70){
    
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
}
