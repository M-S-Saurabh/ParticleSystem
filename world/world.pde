import peasy.*;

PeasyCam cam;
PShape sh;
float scaleFactor = 1;

void setup(){
  size(1000,1000,P3D);
  cam = new PeasyCam(this, 700);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(800);
  cam.setYawRotationMode();
  
  noStroke();
  sh = loadShape("OBJ/Terrain.obj");
}

void translateCamera(){
  float[] camPosition = cam.getLookAt();
  if(keyCode == UP){   
    cam.lookAt(camPosition[0], camPosition[1]+5, camPosition[2]);
  }
  if(keyCode == DOWN){
    cam.lookAt(camPosition[0], camPosition[1]-5, camPosition[2]);
  }
  if(keyCode == LEFT){
    cam.lookAt(camPosition[0]-5, camPosition[1], camPosition[2]);
  }
  if(keyCode == RIGHT){
    cam.lookAt(camPosition[0]+5, camPosition[1], camPosition[2]);
  }
}

void draw(){
  background(0);
  lights();
  fill(255);
  if(keyPressed && key == CODED){
    translateCamera();
  }
  
  pushMatrix();
  rotateX(PI);
  scale(10.0);
  translate(0,-20,0);
  shape(sh);
  translate(0,-1,0);
  box(40,2,40);
  popMatrix();
  print(str((int)cam.getDistance())+"\n");
}

void keyPressed() {
  print("keyCode is:"+keyCode+"\n");
  if (keyCode == 48) {
    cam.setYawRotationMode();
  }
  if(keyCode == 67){
    cam.setFreeRotationMode();
  }
}
