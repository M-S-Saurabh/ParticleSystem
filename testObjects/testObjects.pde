PShape[] objects;
PShape P;

String objectsFolder = "/home/mylav008/Desktop/CSCI 5611/testObjects/trees"; 
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
  //preloadObjects(objectsFolder);
  P = loadShape("BirchTree_Dead_1.obj");
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
  translate(width/2, height/2);
  shapeMode(CENTER);
  shape(P, 0,0, 500,500);
  
}
