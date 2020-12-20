import java.lang.Math;

public class Vector{
  private double x;
  private double y;
  
  public Vector(double x, double y){
    this.x = x;
    this.y = y;
  }
    
  
  double getX(){
    return x;
  }
  void setX(double x){
    this.x = x;
  }
  
  double getY(){
    return y;
  }
  void setY(double y){
    this.y = y;
  }
  
  double getMagnitude(){
    double sum = x*x + y*y;
    return Math.sqrt(sum);
  }

}
