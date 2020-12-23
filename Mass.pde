import java.lang.Math;
import java.util.LinkedList;
public class Mass{
  protected float x;
  protected float y;
  protected long mass;
  protected Vector velocity;
  protected Vector acceleration;
  protected Vector force;
  
  protected LinkedList<Line> lines;
  final int numLines = 50;
  
  final double gravitationalConstant =  0.0000000000667;
 
  public Mass(int x, int y, long mass){
    this.x = x;
    this.y = y;
    this.mass = mass;
    velocity = new Vector(0, 0);
    acceleration = new Vector(0, 0);
    force = new Vector(0, 0);
    lines = new LinkedList<Line>();
  }
  
  
  public Mass(int x, int y, long mass, double vx, double vy, double ax, double ay, double fx, double fy){
    this.x = x;
    this.y = y;
    this.mass = mass;
    velocity = new Vector(vx, vy);
    acceleration = new Vector(ax, ay);
    force = new Vector(fx, fy);
    lines = new LinkedList<Line>();
  }
  
  int getX(){
    return Math.round(x);
  }
  void setX(float x){
    this.x = x;
  }
  
  int getY(){
    return Math.round(y);
  }
  void setY(float y){
    this.y = y;
  }
  
  double getMass(){
    return mass;
  }
  void setMass(long mass){
    this.mass = mass;
  }
  
  Vector getVelocity(){
    return velocity;
  }
  void setVelocity(Vector v){
    velocity.x = v.x;
    velocity.y = v.y;
  }
  
  Vector getAcceleration(){
    return acceleration;
  }
  void setAcceleration(Vector a){
    acceleration.x = a.x;
    acceleration.y = a.y;
  }  
  
  Vector getForce(){
    return force;
  }
  void setForce(Vector f){
    force.x = f.x;
    force.y = f.y;
  }
  
  //possible that these should be a single method returning a vector
  double getMomentumX(){
    return this.mass*this.velocity.getX(); 
  }
  double getMomentumY(){
    return this.mass*this.velocity.getY(); 
  }
  
  private boolean isSameSign(double a, double b){
    return a*b >= 0;
  }

 /*
  Function:   calculateGravitationalForce
   Purpose:   Determine all gravitational forces being applied to the calling Mass
        in:   Array of every mass in the simulation
        in:   Float representing how many pixels represent one meter
*/
    boolean julian = false;

  void calculateGravitationalForce(Mass[] allMasses, float pixelsPerMeter){
    double sumFX = 0;
    double sumFY = 0;
    for(Mass obj: allMasses){
      
      double xRad = (this.x - obj.x) / pixelsPerMeter;
      double yRad = (this.y - obj.y) / pixelsPerMeter;

      double squaredX = xRad*xRad;
      double squaredY = yRad*yRad;
    
      //calculate x forces
      if(xRad > 0){
        sumFX -= (gravitationalConstant * this.mass * obj.mass)/(squaredX);
      }
      else if(xRad < 0){
        sumFX += (gravitationalConstant * this.mass * obj.mass)/(squaredX);
      }
      
      //calculate y forces

      if(yRad > 0){ 
        sumFY -= (gravitationalConstant * this.mass * obj.mass)/(squaredY);
      }
      else if(yRad < 0){
        sumFY += (gravitationalConstant * this.mass * obj.mass)/(squaredY);
      }
    }
    
    //sort of fixes the problems, still not a very convincing orbit being formed
    //also this might not work well with other mass combinations
    //double maxForce = 50000000L;
    
    //if(sumFX > maxForce)
    //  sumFX = maxForce;
    //else if(sumFX*-1 > maxForce)
    //  sumFX = maxForce*-1;
      
    //if(sumFY > maxForce)
    //  sumFY = maxForce;
    //else if(sumFY*-1 > maxForce)
    //  sumFY = maxForce*-1;
    
    
    force.setX(sumFX);
    force.setY(sumFY);

  }
   
/*
  Function:   calculateAcceleration
   Purpose:   Determine the acceleration for the mass based on its force vector
              a = f / m
*/
   void calculateAcceleration(){
     
     double accX = this.force.getX() / this.mass;
     double accY = this.force.getY() / this.mass;
     
     double maxAcc = 0.005;
    
    if(accX > maxAcc)
      accX = maxAcc;
    else if(accX*-1 > maxAcc)
      accX = maxAcc*-1;
      
    if(accY > maxAcc)
      accY = maxAcc;
    else if(accY*-1 > maxAcc)
      accY = maxAcc*-1;
    
     this.acceleration.setX(accX);
     this.acceleration.setY(accY);
   }
   

/*
  Function:   calculateVelocity
   Purpose:   Determine the velocity for the mass based on its acceleration vector and the old velocity
              Delta v = a * delta t
        in:   Float representing how much time passes between frames
*/
   void calculateVelocity(float timeBetweenFrames){
     double newVeloX = this.velocity.getX() + this.acceleration.getX()*timeBetweenFrames;
     double newVeloY = this.velocity.getY() + this.acceleration.getY()*timeBetweenFrames;
      
     this.velocity.setX(newVeloX);  
     this.velocity.setY(newVeloY);
   }
  
  
/*
  Function:   calculateNewPosition
   Purpose:   Determine the next position for the mass based on its velocity vector and the old position
              Delta d = v * delta t
        in:   Float representing how much time passes between frames
        in:   Float representing how many pixels make up a meter
*/
  void calculateNewPosition(float timeBetweenFrames, float pixelsPerMeter){
    double xChange = (this.velocity.getX()*timeBetweenFrames) * pixelsPerMeter;
    double yChange = (this.velocity.getY()*timeBetweenFrames) * pixelsPerMeter;  
    if(numLines == lines.size()){
      lines.remove(0);
    }
    lines.add( new Line( this.x, this.y, (float)(this.x+xChange), (float)(this.y+yChange) ) );
    this.x += xChange;
    this.y += yChange;
  }
  
  /*
  Function:   printLines
   Purpose:   print the path which the calling mass has followed
*/
  public void printLines(){
    for(Line currLine: lines){
      line(currLine.sx, currLine.sy, currLine.fx, currLine.fy);
    }
  }
  

  
  
}



  
