PShape[] objects;
PShape P;
PShape F ;
float z = 10.0 ;
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
  size(1000,1000,P3D);
  //size(500, 500, P3D);
  noFill();
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  perspective(fov, float(width)/float(height), 
              cameraZ/10.0, cameraZ*10.0);
  //translate(150, 150, 0);
  //rotateX(-PI/6);
  //rotateY(PI/3);
  //box(45);
  perspective();
  P = loadShape("BirchTree_1.obj");
  F = loadShape("ModularFloor.obj");
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
  pushMatrix();
  translate(width/2, height/2, z);
  rotateX(radians(180)) ;
  shapeMode(CENTER);
  shape(P, 100,100, 500,500);
  popMatrix() ;
  
  pushMatrix();
  translate(width/2, height/2, -10);
  //rotateX(radians(180)) ;
  shapeMode(CENTER);
  shape(F, 100,100, 500,500);
  popMatrix() ;
  
  //pushMatrix();
  //translate(width/2+100, height/2+100, -10);
  ////rotateX(radians(180)) ;
  //shapeMode(CENTER);
  //shape(F, 100,100, 500,500);
  //popMatrix() ;
  
  //pushMatrix();
  //translate(width/2, height/2+100, -10);
  ////rotateX(radians(180)) ;
  //shapeMode(CENTER);
  //shape(F, 100,100, 500,500);
  //popMatrix() ;
}
