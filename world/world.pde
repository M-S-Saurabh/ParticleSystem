import peasy.*;

PeasyCam cam;
PShape sh, W, B, P, Db, Dp, Dw ;
float scaleFactor = 1;

ParticleSystem waterfall;
ArrayList<PVector> waterPoints;
FireParticleSystem fires = null;
PVector fireOrigin = new PVector(100, -10, -60) ;
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
  waterPoints.add(new PVector(0,-65,50));
  
  noStroke();
  sh = loadShape("OBJ/Terrain.obj");
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
}

void draw(){
  background(0);
  lights();
  fill(255);
  
  if(keyPressed && key == CODED){
    translateCamera();
  }
  // Draw a hill.
  //pushMatrix();
  //rotateX(PI);
  //translate(-100,-100,70);
  ////rotateY(PI/2);
  //scale(20.0);
  //shape(sh);
  //popMatrix();
  
  // Draw a plane
  //translate(0,110,0);
  //box(400,10,400);
  
  pushMatrix();
  rotateX(PI);
  translate(-100, 10, 70);
  scale(25.0);
  shape(sh);
  popMatrix() ;
    
  
  pushMatrix();
  scale(10.0) ;
  //translate(0,-1,0);
  fill(150, 75, 0) ;
  box(40,2,40);
  popMatrix();
    
  runParticles();
  
  if (burning){
    burningCount-= 1 ;
  }
  
  if (burningCount > 0){
    pushMatrix();
    rotateX(PI);
    translate(80, 10, 70);
    scale(10.0);
    shape(B);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(110, 10, 60);
    scale(10.0);
    shape(B);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(120, 10, 50);
    scale(10.0);
    shape(B);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(100,10, 70);
    scale(10.0);
    shape(P);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(90,10, 60);
    scale(10.0);
    shape(P);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(70,10, 50);
    scale(10.0);
    shape(P);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(120,10, 70);
    scale(10.0);
    shape(W);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(80,10, 60);
    scale(10.0);
    shape(W);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(100,10, 50);
    scale(10.0);
    shape(W);
    popMatrix() ;
  }
  
  if (burningCount <= 0){
    pushMatrix();
    rotateX(PI);
    translate(80, 10, 70);
    scale(10.0);
    shape(Db);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(110, 10, 60);
    scale(10.0);
    shape(Db);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(120, 10, 50);
    scale(10.0);
    shape(Db);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(100,10, 70);
    scale(10.0);
    shape(Dp);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(90,10, 60);
    scale(10.0);
    shape(Dp);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(70,10, 50);
    scale(10.0);
    shape(Dp);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(120,10, 70);
    scale(10.0);
    shape(Dw);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(80,10, 60);
    scale(10.0);
    shape(Dw);
    popMatrix() ;
    
    pushMatrix();
    rotateX(PI);
    translate(100,10, 50);
    scale(10.0);
    shape(Dw);
    popMatrix() ;
  }
  
  if(fires != null){
    fires.run();
    fireRadius += 10.0 ;
  }
  
  surface.setTitle("World FPS: "+ str(round(frameRate)) +"\n") ;
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
  // W key: toggles water flow
  if(keyCode == 87){
    if(waterfall == null){
      for(PVector point: waterPoints){
        waterfall = new ParticleSystem(point);
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
