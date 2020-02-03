import peasy.*;

PeasyCam cam;
PShape sh, icemage;
float scaleFactor = 1;

Waterfall waterfall;
ArrayList<PVector> waterPoints;

MagicSpell ms;
color water = color(12,160,240);
color fire = color(236,85,17);

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
  // Draw a hill.
  pushMatrix();
  rotateX(PI);
  rotateY(PI/2);
  translate(0,-100,0);
  scale(20.0);
  shape(sh);
  popMatrix();
  
  // Draw ice mage.
  pushMatrix();
  rotateX(PI);
  translate(100,-100,-150);
  scale(0.2);
  shape(icemage);
  popMatrix();
  
  // Draw a plane
  pushMatrix();
  stroke(255);
  fill(255);
  translate(0,101,0);
  box(400,2,400);
  popMatrix();
  
  int start = millis();
  runParticles();
  int end = millis();
  if(end - start > 0){
    print("FPS:"+str(1000/(end-start))+"\n");
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
}
