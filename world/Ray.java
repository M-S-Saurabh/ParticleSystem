import java.lang.* ;

public class Ray {
  
  float x ;
  float y ;
  float z ;
  
  Ray(float i, float j){
    this.x = i ;
    this.y = j ;
    this.z = 0 ;
  }
  
  Ray(float i, float j, float k){
    this.x = i ;
    this.y = j ;
    this.z = k ;
  }
  
  Ray(Ray r){
    this.x = r.x ;
    this.y = r.y ;
    this.z = r.z ;
  }
  
  public static float dist(Ray r1, Ray r2){
    double dist = Math.pow(r1.x-r2.x, 2) + Math.pow(r1.y-r2.y, 2) + Math.pow(r1.z-r2.z, 2) ;
    return (float)Math.sqrt(dist) ;
  }
  
  Ray add(Ray r1){
    this.x += r1.x ;
    this.y += r1.y ;
    this.z += r1.z ;
    return this ;
  }
  
  public static Ray add(Ray r1, Ray r2){
    return new Ray(r1.x+r2.x, r1.y+r2.y, r1.z+r2.z) ;
  }
  
  Ray sub(Ray r1){
    this.x -= r1.x ;
    this.y -= r1.y ;
    this.z -= r1.z ;
    return this ;
  }
  
  public static Ray sub(Ray r1, Ray r2){
    return new Ray(r1.x-r2.x, r1.y-r2.y, r1.z-r2.z) ;
  }
  
  float dot(Ray r1){
    return this.x*r1.x + this.y*r1.y + this.z*r1.z ;
  }
  
  public static float dot(Ray r1, Ray r2){
    return r1.x*r2.x + r1.y*r2.y + r1.z*r2.z ;
  }
  
  Ray copy(){
    return new Ray(this.x, this.y, this.z) ;
  }
  
  Ray mult(float f){
    return new Ray(this.x*f, this.y*f, this.z*f) ;
  }
  
  public static Ray mult(Ray r1, float f){
    return new Ray(r1.x*f, r1.y*f, r1.z*f) ;
  }
  
  Ray div(float f){
    return new Ray(this.x/f, this.y/f, this.z/f) ;
  }
  
  public static Ray div(Ray r1, float f){
    return new Ray(r1.x/f, r1.y/f, r1.z/f) ;
  }
  
  float mag(){
    return (float)Math.sqrt(this.dot(this)) ;    
  }
  
  Ray normalize(){
    float m = this.mag() ;
    return this.div(m) ;
  }
  
}
