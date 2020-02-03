PShape[] objects;
PShape P;
PShape F;
PShape B;
PShape C;
PShape W ;
float z = 10.0 ;
float x = 25.0 ;
String objectsFolder = "trees"; 
int totalNumObjects = 0;

// Taken from: https://processing.org/examples/directorylist.html
// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

void preloadObjects(String folderName){
  String[] filenames = listFileNames(folderName);
  totalNumObjects = filenames.length;
  objects = new PShape[totalNumObjects];
  for(int i=0; i<totalNumObjects; i++){
    String filename = filenames[i];
    objects[i] = loadShape(filename);
  }
}

void setup(){
  size(1000,1000,OPENGL);
  //size(500, 500, P3D);
  noFill();
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
              cameraZ/10.0, cameraZ*100.0);
  //translate(150, 150, 0);
  //rotateX(-PI/6);
  //rotateY(PI/3);
  //box(45);
  P = loadShape("KnightCharacter.obj");
  F = loadShape("ModularFloor.obj");
  C = loadShape("palm1.obj") ;
  W = loadShape("Willow_3.obj") ;
  B = loadShape("Bush_1.obj") ;
}

int lifetime = 0;
int index = 0;

void draw(){
  background(0);
  lights();
  //lifetime += 1;
  //if(lifetime > 300){
  //  index  = (index+1) % totalNumObjects;
  //  lifetime = 0;
  //}
  
  if(keyPressed && keyCode == UP){
    z += 10 ;
  }
  
  if(keyPressed && keyCode == DOWN){
    z -= 10 ;
  }
  
  if(keyPressed && keyCode == LEFT){
    x -= 10 ;
  }
  
  if(keyPressed && keyCode == RIGHT){
    x += 10 ;
  }
  
  pushMatrix();
  translate(width/2, height/2, z);
  rotateX(radians(180)) ;
  scale(100);
  shape(P) ;
  //, 50, 50, 300, 300);
  //shape(P, 200, 50, 300, 300);
  popMatrix() ;
   
  
  //pushMatrix();
  //translate(width/2, height/2, 25) ;
  //rotateX(radians(180)) ;
  //shapeMode(CORNER);
  //shape(C, -100, 0, 250, 250);
  ////shape(C, 140, 0, 250, 250);
  //popMatrix() ;
  
  //pushMatrix();
  //translate(width/2, height/2, 15);
  //rotateX(radians(180)) ;
  //shapeMode(CORNER);
  //shape(W, -50, -25, 150, 150);
  ////shape(W, 75, -25, 150, 150);
  //popMatrix() ;
  
  
  //pushMatrix();
  //translate(width/2, height/2, z);
  //rotateX(radians(180)) ;
  //shapeMode(CORNER);
  //shape(P, 300,120, 500,500);
  //popMatrix() ;
  
  //pushMatrix();
  //translate(width/2, height/2, z);
  //rotateX(radians(180)) ;
  //shapeMode(CORNER);
  //shape(P, 80,80, 500,500);
  //popMatrix() ;
  
  //pushMatrix();
  //translate(500, 0, -10);
  ////rotateX(radians(180)) ;
  //shapeMode(CORNER);
  //shape(F, 0,0, 500,500);
  //popMatrix() ;
  
  //pushMatrix();
  //translate(0, 501, -10);
  ////rotateX(radians(180)) ;
  //shapeMode(CORNER);
  //shape(F, 0,0, 500,500);
  //popMatrix() ;
  
  //pushMatrix();
  //translate(501, 0, -10);
  ////rotateX(radians(180)) ;
  //shapeMode(CORNER);
  //shape(F, 0,0, 500,500);
  //popMatrix() ;
  
  //pushMatrix();
  //translate(501, 501, -10);
  ////rotateX(radians(180)) ;
  //shapeMode(CORNER);
  //shape(F, 0,0, 500,500);
  //popMatrix() ;
  
}
