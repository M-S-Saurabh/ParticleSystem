import peasy.*;

PeasyCam cam;
PShape sh;
float scaleFactor = 1;

ParticleSystem waterfall;
ArrayList<PVector> waterPoints;

void setup(){
  size(1000,1000,P3D);
  cam = new PeasyCam(this, 425);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(800);
  cam.setYawRotationMode();
  
  if(waterPoints == null){waterPoints = new ArrayList<PVector>();}
  waterPoints.add(new PVector(0,-65,0));
  
  noStroke();
  sh = loadShape("OBJ/Terrain.obj");
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
  pushMatrix();
  rotateX(PI);
  rotateY(PI/2);
  scale(20.0);
  translate(0,-5,0);
  shape(sh);
  popMatrix();
  
  // Draw a plane
  translate(0,110,0);
  box(400,10,400);
  
  runParticles();
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
}
