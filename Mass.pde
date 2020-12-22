import java.lang.Math;

public class Mass{
  protected float x;
  protected float y;
  protected long mass;
  protected Vector velocity;
  protected Vector acceleration;
  protected Vector force;
  protected Vector momentum;
  
  //double maxVelo = 3;
  
  final double gravitationalConstant =  0.0000000000667;
  //Things to consider: having energy (kinetic, potential?)
 
  public Mass(int x, int y, long mass){
    this.x = x;
    this.y = y;
    this.mass = mass;
    velocity = new Vector(0, 0);
    acceleration = new Vector(0, 0);
    force = new Vector(0, 0);
    momentum = new Vector(0, 0);
  }
  
  
  public Mass(int x, int y, long mass, double vx, double vy, double ax, double ay, double fx, double fy){
    this.x = x;
    this.y = y;
    this.mass = mass;
    velocity = new Vector(vx, vy);
    acceleration = new Vector(ax, ay);
    force = new Vector(fx, fy);
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
  
   Vector getMomentum(){
    return momentum;
  }
  void setMomentum(Vector m){
    force.x = m.x;
    force.y = m.y;
  }
  
  int findNewPositionX(){
    //kinematics and stuff here
    return 0;
  }
  int findNewPositionY(){
    //kinematics and stuff here
    return 0;
  }
  
  double getMomentumX(){
    return this.mass*this.velocity.getX(); 
  }
  
  double getMomentumY(){
    return this.mass*this.velocity.getY(); 
  }
  
  void setPosition(int x, int y){
    this.x = x;
    this.y = y;
  }
  
// might be more efficient not to do this for every mass, but a single function
// in the main/gravity class/file
  void calculateGravitationalForce(Mass[] allMasses, float pixelsPerMeter){
    double sumFX = 0;
    double sumFY = 0;
    for(Mass obj: allMasses){
      //the current object is the one we're calculating mass for
      if(this.x == obj.x && this.y == obj.y){
        continue;
      }
      
      //calculate x forces
      double xRad = (this.x - obj.x) / pixelsPerMeter;
      
      if(xRad > 0){
        sumFX -= (gravitationalConstant * this.mass * obj.mass)/(xRad * xRad);
      }
      else if(xRad < 0){
        sumFX += (gravitationalConstant * this.mass * obj.mass)/(xRad * xRad);
      }
      
      //calculate y forces
      double yRad = (this.y - obj.y) / pixelsPerMeter;
      
      if(yRad > 0){ 
        sumFY -= (gravitationalConstant * this.mass * obj.mass)/(yRad * yRad);
      }
      else if(yRad < 0){
        sumFY += (gravitationalConstant * this.mass * obj.mass)/(yRad * yRad);
      }
    }
    //double maxForce = 50000000;
    
    //if(sumFX > maxForce)
    //  sumFX = maxForce;
      
    //if(sumFY > maxForce)
    //  sumFY = maxForce;
      
    //if(sumFX*-1 > maxForce)
    //  sumFX = -1*maxForce;
      
    //if(sumFY*-1 > maxForce)
    //  sumFY = -1*maxForce;
    
    
    this.force.setX(sumFX);
    this.force.setY(sumFY);
  }
   
   //use the force to find acceleration a = f / m (Newton's 2nd law)
   void calculateGravitationalAcceleration(){
     this.acceleration.setX(this.force.getX() / this.mass);
     this.acceleration.setY(this.force.getY() / this.mass);
   }
   
   //use the acceleration, along with how long has passed since the last time this was called
   //to find the change in velocity (change in v = a * change in t)
   //add the change to the old velocity to get the new velocity
   void calculateGravitationalVelocity(float timeBetweenFrames){
     this.velocity.setX(this.velocity.getX() + this.acceleration.getX()*timeBetweenFrames);  
     this.velocity.setY(this.velocity.getY() + this.acceleration.getY()*timeBetweenFrames);
   }
  
  //use the velocity to get the new position based on how long has passed
  //this is a bit harder because x and y are actually not in meters but the velocity is
  void calculateGravitationalDistance(float timeBetweenFrames, float pixelsPerMeter){
    //System.out.println("The x calculation " + (this.velocity.getX()*timeBetweenFrames) * pixelsPerMeter);
    double xChange = (this.velocity.getX()*timeBetweenFrames) * pixelsPerMeter;
    this.x += xChange;
    double yChange = (this.velocity.getY()*timeBetweenFrames) * pixelsPerMeter;  
    this.y += yChange;
    //this.x += (this.velocity.getX()*timeBetweenFrames) * pixelsPerMeter;
    //this.y += (this.velocity.getY()*timeBetweenFrames) * pixelsPerMeter;  
    
  }
  
  public void borderCollision(){
    if(this.x > numPixelsX){
      this.x = numPixelsX;
      this.velocity.setX(this.velocity.getX() * -1);
    }
    else if(this.x < 0){
      this.x = 0;
      this.velocity.setX(this.velocity.getX() * -1);
    }
    
    if(this.y > numPixelsY){
      this.y = numPixelsY;
      this.velocity.setY(this.velocity.getY() * -1);
    }
    else if(this.y < 0){
      this.y =  0;
      this.velocity.setY(this.velocity.getY() * -1);
    }
  }
}



  
