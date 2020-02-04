class SpellParticle {
  
  Ray location;
  Ray velocity;
  Ray acceleration;
  color splColor; 
  float lifespan;
  float alpha;
  float size;
  int type ;
  
  SpellParticle(Ray l, color c, Ray v, Ray a, int t, float life){
    this.location = l ;
    this.velocity = v ;
    this.acceleration = a ; 
    this.splColor = c ;
    this.lifespan = life ;
    this.size = 1 ;
    this.type = t ;
  }
  
  void update(){
    location = location.sub(velocity) ;
    
    velocity = velocity.add(acceleration) ;
    if (type == 1){
      splColor = color(red(splColor)  + random(-10, 0), green(splColor) + random(0, 20) , blue(splColor) + random(-10, 100)) ;
      //location.x = location.x + random(-10, 10) ;
    }
    else{
      splColor = color(red(splColor)  + random(-10, 100), green(splColor) + random(0, 20) , blue(splColor)  + random(-20, 0)) ;
    }
    
    lifespan -= 1 ;
  }
  
  void display(){
    tint(255, 126) ;
    stroke(splColor) ;
    fill(splColor) ;
    //pushMatrix() ;
    point(location.x, location.y, location.z) ;
    //ellipse(0, 0, size, size) ;
    //popMatrix() ;
  }
  
  boolean isDead(){
   if (lifespan > 0){return false;}
   else{
     return true ;
   }
  }
  
  void run(){
    if(lifespan > 0){
      update();
      display();
    }
  }
  
  
}
