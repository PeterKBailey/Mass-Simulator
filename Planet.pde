public class Planet extends Mass{  
  //Things to consider: having energy (kinetic, potential?)
  float radius;
  public Planet(int x, int y, long mass, float radius){
    super(x, y, mass);
    this.radius = radius;
  }
  
  
  public Planet(int x, int y, long mass, float radius, double vx, double vy, double ax, double ay, double fx, double fy, double mx, double my){
    super(x,y,mass,vx,vy,ax,ay,fx,fy,mx,my);
    this.radius = radius;
  }
   
  void display(){
    ellipse(x, y, radius, radius);
  }
 
}
