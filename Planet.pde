//test
public class Planet extends Mass{ 
  int id;
  int xCol, yCol, zCol;
  //Things to consider: having energy (kinetic, potential?)
  float radius;
  public Planet(int x, int y, long mass, float radius, int id){
    super(x, y, mass);
    this.radius = radius;
    this.id = id;
    xCol = 0;
    yCol = 0;
    zCol = 0;
  }
  
  public Planet(int x, int y, long mass, float radius, double vx, double vy, double ax, double ay, double fx, double fy, int id){
    super(x,y,mass,vx,vy,ax,ay,fx,fy);
    this.radius = radius;
    this.id = id;
  }
   
  void display(){
    //System.out.println(xCol + " " + yCol + " " + zCol);
    fill(xCol, yCol, zCol);
    ellipse(Math.round(x), Math.round(y), radius*2, radius*2);
    this.printLines();
    xCol = 0;
    yCol = 0;
    zCol = 0;
  }
 
  int getId(){
    return id; 
  }
  
  float getRadius(){
    return radius;
  }
  
  void setColour(int x, int y, int z){
    this.xCol = x;
    this.yCol = y;
    this.zCol = z;
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
