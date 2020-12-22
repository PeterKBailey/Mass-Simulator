public class Planet extends Mass{ 
  int id;
  //Things to consider: having energy (kinetic, potential?)
  float radius;
  public Planet(int x, int y, long mass, float radius, int id){
    super(x, y, mass);
    this.radius = radius;
    this.id = id;
  }
  
  public Planet(int x, int y, long mass, float radius, double vx, double vy, double ax, double ay, double fx, double fy, int id){
    super(x,y,mass,vx,vy,ax,ay,fx,fy);
    this.radius = radius;
    this.id = id;
  }
   
  void display(){
    ellipse(Math.round(x), Math.round(y), radius*2, radius*2);
  }
 
  int getId(){
    return id; 
  }
  
  float getRadius(){
    return radius;
  }
  
  //void calculateGravitationalForce(Planet[] allMasses, float pixelsPerMeter){
  //  double sumFX = 0;
  //  double sumFY = 0;
  //  for(Planet obj: allMasses){
  //    //the current object is the one we're calculating mass for
  //    if(this.x == obj.x && this.y == obj.y){
  //      continue;
  //    }
      
  //    //calculate x forces
  //    double xRad = (this.x - obj.x) / pixelsPerMeter;
  //    double yRad = (this.y - obj.y) / pixelsPerMeter;

  //    //if(Math.abs(xRad) < Math.max(this.getRadius(), obj.getRadius())){
  //    //  xRad = Math.max(this.getRadius(), obj.getRadius());
  //    //}
      
  //    //if(Math.abs(yRad) < Math.max(this.getRadius(), obj.getRadius())){
  //    //   yRad = Math.max(this.getRadius(), obj.getRadius());
  //    //}
      
      
  //    if(xRad > 0){
  //      sumFX -= (gravitationalConstant * this.mass * obj.mass)/(xRad * xRad);
  //    }
  //    else if(xRad < 0){
  //      sumFX += (gravitationalConstant * this.mass * obj.mass)/(xRad * xRad);
  //    }
      
      
  //    if(yRad > 0){ 
  //      sumFY -= (gravitationalConstant * this.mass * obj.mass)/(yRad * yRad);
  //    }
  //    else if(yRad < 0){
  //      sumFY += (gravitationalConstant * this.mass * obj.mass)/(yRad * yRad);
  //    }
  //  }
  //  this.force.setX(sumFX);
  //  this.force.setY(sumFY);
  //}
}
