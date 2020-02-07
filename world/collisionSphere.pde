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
    //stroke(255) ;
    noStroke();
    translate(x,y,z);
    fill(255,0,0,255);
    sphere(size);
    popMatrix() ;
  }
  
  void addDetector(Projectile obj){
    if(detectList == null){detectList = new ArrayList<Projectile>();}
    this.detectList.add(obj);
  }
  
  void updateZY(float z, float y){
    this.z = z; this.y = y;
    this.location.z = z;
    this.location.y = y;
  }
  void updateX(float dx){
    this.x += dx;
    this.location.x += dx;
  }
  
  void resetDetector(){
    this.detectList = null;
  }
  
  //boolean checkCollision(){
  //  if(detectList == null){return false;}
  //  for(int i = detectList.size()-1; i>=0; i--){
  //    Projectile obj  = detectList.get(i);
  //    if(obj.lifespan <= 0.0){ detectList.remove(i); continue;}
  //    float distance = Ray.dist(obj.location, this.location);
  //    if(distance < (this.size + obj.size)){
  //      obj.collision();
  //      detectList.remove(i);
  //      return true;
  //    }
  //  }
  //  return false;
  //}
  
  boolean checkCollision(){
    if(detectList == null){return false;}
    for(int i = detectList.size()-1; i>=0; i--){
      Projectile obj  = detectList.get(i);
      if(obj.lifespan <= 0.0){ detectList.remove(i); continue;}
      float distance = Ray.dist(obj.location, this.location);
      Ray next = obj.velocity ;
      Ray np = Ray.add(obj.location ,next) ;
      Ray pl = Ray.sub(this.location, obj.location) ;
      Ray cross = next.cross(pl) ;
      float area = cross.mag() ;
      float d = area/next.mag() ;
      float d1 = Ray.dist(this.location,np) ;
      float d2 = Ray.dist(this.location, obj.location) ;
      float d3 = Ray.dist(np, obj.location) ;
      if (this.size > d){
        float mid = sqrt(d2*d2 - d*d) ;
        float rmid = sqrt(d1*d1 - d*d) ;
        float diff = d3 - (mid + rmid) ;
        if (d1 < this.size || abs(diff) < 0.5 ){
          obj.collision();
          detectList.remove(i);
          return true ;
        }
      }
    }
    return false;
  }
  
}
