class collisionSphere{
  float x;
  float y;
  float z;
  Ray location;
  float size;
  ArrayList<Projectile> detectList;
  
  
  collisionSphere(float x, float y, float z, float r){
    this.x = x;
    this.y = y;
    this.z = z;
    this.location = new Ray(x,y,z);
    this.size = r;
  }
  
  void drawSelf(){
    pushMatrix();
    stroke(255) ;
    translate(x,y,z);
    fill(255,0);
    sphere(size);
    popMatrix() ;
  }
  
  void addDetector(Projectile obj){
    if(detectList == null){detectList = new ArrayList<Projectile>();}
    this.detectList.add(obj);
  }
  
  void resetDetector(){
    this.detectList = null;
  }
  
  boolean checkCollision(){
    if(detectList == null){return false;}
    for(int i = detectList.size()-1; i>=0; i--){
      Projectile obj  = detectList.get(i);
      if(obj.lifespan <= 0.0){ detectList.remove(i); continue;}
      float distance = Ray.dist(obj.location, this.location);
      if(distance < (this.size + obj.size)){
        obj.collision();
        detectList.remove(i);
        return true;
      }
    }
    return false;
  }
  
}
