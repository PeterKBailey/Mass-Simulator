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
    this.printLines();
  }
 
  int getId(){
    return id; 
  }
  
  float getRadius(){
    return radius;
  }
  
  
  /*
  Function:   borderCollisions
   Purpose:   Check if the calling planet has collided with one of the borders of the window
              and bounce it off the wall
*/
  public void borderCollision(){
    //right wall
    if(this.x + radius > numPixelsX){
      this.x = numPixelsX - radius;
      this.velocity.setX(this.velocity.getX() * -1);
    }
    //left wall
    else if(this.x - radius < 0){
      this.x = 0 + radius;
      this.velocity.setX(this.velocity.getX() * -1);
    }
    
    //floor
    if(this.y + radius > numPixelsY){
      this.y = numPixelsY - radius;
      this.velocity.setY(this.velocity.getY() * -1);
    }
    //roof
    else if(this.y - radius < 0){
      this.y =  0 + radius;
      this.velocity.setY(this.velocity.getY() * -1);
    }
  }
}
