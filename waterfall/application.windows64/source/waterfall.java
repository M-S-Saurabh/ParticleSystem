import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class waterfall extends PApplet {

ParticleSystem ps=null;
PImage img;
public void setup()
{
  size(640,480);
  frameRate(60);
  img= loadImage("Waterfall-640x480.jpg");
}

public void draw()
{
  fill(0,20);
  tint(255,20);
  image(img,0,0);
  rect(0, 0, width, height);
  if(mousePressed){
    startWaterfall();
  }
  if(ps!=null){
    if(ps.particles.size()<500){
      ps.addParticle();
    }  
    ps.run();
  }
  
}

public void startWaterfall(){
   ps = new ParticleSystem(new PVector(mouseX,mouseY));
}

class ParticleSystem {
  ArrayList<Particle> particles;
  PVector origin;
  ParticleSystem(PVector location){
    origin = location.get();
    particles = new ArrayList<Particle>();
  }
  public void addParticle(){
    PVector tempOrigin = new PVector(origin.x+random(-35,+35),origin.y);
    particles.add(new Particle(tempOrigin));
  }
  public void run(){
    for(int i=particles.size()-1; i>=0;i--){
      Particle p = particles.get(i);
      p.run();
      if(p.isDead()){
        //particles.remove(i);
        p.restart(new PVector(origin.x+random(-35,+35),origin.y));
      }
    }
  }
}
class Particle{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float death;
  float alpha;
  float size = random(1,4);
  
  Particle(PVector l){
    restart(l);
  }
  public void run(){
    update();
    display();
  }
  public void update(){
    velocity.add(acceleration);
    location.add(velocity);
    lifespan-=1.0f;
    if(lifespan==40.0f)
    {
      acceleration.x = random(-0.05f,0.05f);
      acceleration.y = -0.05f;
      velocity.x = random(-0.5f,0.5f);
      velocity.y = random(0,0);
      alpha = random(30,50);
    }
  }
  public void display(){
    stroke(255,alpha);
    fill(255,alpha);
    ellipse(location.x,location.y,size,4);
  }
  public void restart(PVector l){
    acceleration = new PVector(0,0.05f);
    velocity = new PVector(random(-0.5f,0.5f),random(0,0));
    location = l.get();
    lifespan = 156.0f;
    alpha = random(100,150);
    death = random(-10,10);
  }
  public boolean isDead(){
    if(lifespan<death){
      return true;
    }else{
      return false;
    }
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "waterfall" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
