public class Mass{
  protected int x;
  protected int y;
  protected long mass;
  protected Vector velocity;
  protected Vector acceleration;
  protected Vector force;
  protected Vector momentum;
  
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
  
  
  public Mass(int x, int y, long mass, double vx, double vy, double ax, double ay, double fx, double fy, double mx, double my){
    this.x = x;
    this.y = y;
    this.mass = mass;
    velocity = new Vector(vx, vy);
    acceleration = new Vector(ax, ay);
    force = new Vector(fx, fy);
    momentum = new Vector(mx, my);
  }
    
    
  
  int getX(){
    return x;
  }
  void setX(int x){
    this.x = x;
  }
  
  int getY(){
    return y;
  }
  void setY(int y){
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
  
  void setPosition(int x, int y){
    this.x = x;
    this.y = y;
  }
  
// might be more efficient not to do this for every mass, but a single function
// in the main/gravity class/file
  void calculateGravitationalForce(Mass[] allMasses){
    double sumFX = 0;
    double sumFY = 0;
    for(Mass obj: allMasses){
      //the current object is the one we're calculating mass for
      if(this.x == obj.x && this.y == obj.y){
        continue;
      }
      
      //calculate x forces
      double xRad = this.x - obj.x;
      if(xRad > 0){
        sumFX -= (gravitationalConstant * this.mass * obj.mass)/(xRad * xRad);
      }
      else if(xRad < 0){
        sumFX += (gravitationalConstant * this.mass * obj.mass)/(xRad * xRad);
      }
      
      //calculate y forces
      double yRad = this.y - obj.y;
      if(yRad > 0){ 
        sumFY -= (gravitationalConstant * this.mass * obj.mass)/(yRad * yRad);
      }
      else if(yRad < 0){
        sumFY -= (gravitationalConstant * this.mass * obj.mass)/(yRad * yRad);
      }
     }
     
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
  void calculateGravitationalDistance(float timeBetweenFrames, int pixelsPerMeter){
    this.x += (this.velocity.getX()*timeBetweenFrames) * pixelsPerMeter;
    this.y += (this.velocity.getY()*timeBetweenFrames) * pixelsPerMeter;  
  }
}
