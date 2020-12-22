//Newtons, meters, kg, s
import java.util.HashSet;

//okay so this is a workaround because of how processing works
//I can't have any non-static classes with static fields because processing
//puts all classes as inner classes into one single main class
int numPlanets = 0;

int numPixelsX = 640;
int numPixelsY = 480;
int numMetersX = 1000;

float pixelsPerMeter = 1.0 * numPixelsX / numMetersX;

int frameRate = 600;
//float secondsPerFrame = 1.0/frameRate;
float secondsPerFrame = 1;


//might need to switch masses to a different unit and fix the equations...
Planet p = new Planet(300, 100, 10000000000000L, 60, numPlanets++);
Planet p2 = new Planet(600, 400, 10000000000L, 20, numPlanets++);
//Planet p3 = new Planet (100, 300, 100, 10, numPlanets++); 


void setup(){
  surface.setSize(numPixelsX, numPixelsY);
  frameRate(frameRate);
  //p2.setVelocity(new Vector(-0.5,-0.4));
  //p3.setVelocity(new Vector(0.4,-0.1));
  p2.setVelocity(new Vector(0, -1));
  System.out.println("radius in m: " + (p.getRadius() / pixelsPerMeter));
} 

Mass allMasses[] = {p, p2};
Planet allPlanets[] = {p, p2};
boolean julian = true;
void draw(){
  background(155);
  //p.display();
  //p2.display();
  //p3.display();
  //handleCollisions(allPlanets, numPlanets);
  
  p.calculateGravitationalForce(allMasses, pixelsPerMeter);
  p2.calculateGravitationalForce(allMasses, pixelsPerMeter);
  //p3.calculateGravitationalForce(allMasses, pixelsPerMeter);

  System.out.println("F p: " + p.getForce().getX() + " and " + p.getForce().getY());
  System.out.println("F p2: " + p2.getForce().getX() + " and " + p2.getForce().getY());
    
  p.calculateGravitationalAcceleration();
  p2.calculateGravitationalAcceleration();
  //p3.calculateGravitationalAcceleration();
  
  p.calculateGravitationalVelocity(secondsPerFrame);
  p2.calculateGravitationalVelocity(secondsPerFrame);
  //p3.calculateGravitationalVelocity(secondsPerFrame);
  System.out.println("V p: " + p.getVelocity().getX() + " and " + p.getVelocity().getY());
  System.out.println("V p2: " + p2.getVelocity().getX() + " and " + p2.getVelocity().getY());

  p.calculateGravitationalDistance(secondsPerFrame, pixelsPerMeter);
  System.out.println(p.getX() + " and " + p.getY());
  p2.calculateGravitationalDistance(secondsPerFrame, pixelsPerMeter);
  System.out.println(p2.getX() + " and " + p2.getY());
  //p3.calculateGravitationalDistance(secondsPerFrame, pixelsPerMeter);
 
 
   handleCollisions(allPlanets, numPlanets);
   //p.borderCollision();
   //p2.borderCollision();

  p.display();
  p2.display();
  //p3.display();
}

//this is gonna be kinda hard tbh...
void handleCollisions(Planet[] allPlanets, int numPlanets){
  boolean julian = true;
  for(int i = 0; i<numPlanets; i++){
    for(int j = i+1; j<numPlanets; j++){
      //the radius between the two centers of the planets
      double r = Math.sqrt( Math.pow((allPlanets[i].getX() - allPlanets[j].getX()), 2) + Math.pow((allPlanets[i].getY() - allPlanets[j].getY()), 2) );
      if( r <= (allPlanets[i].getRadius() + allPlanets[j].getRadius()) ){
               
        double newVeloIX = ( (allPlanets[i].getMass() - allPlanets[j].getMass()) / (allPlanets[i].getMass() + allPlanets[j].getMass()) ) * allPlanets[i].getVelocity().getX();
        newVeloIX += ( (2 * allPlanets[j].getMass()) / (allPlanets[i].getMass() + allPlanets[j].getMass()) ) * allPlanets[j].getVelocity().getX();
        
        double newVeloJX = ( (allPlanets[j].getMass() - allPlanets[i].getMass()) / (allPlanets[i].getMass() + allPlanets[j].getMass()) ) * allPlanets[j].getVelocity().getX();
        newVeloJX += ( (2 * allPlanets[i].getMass()) / (allPlanets[i].getMass() + allPlanets[j].getMass()) ) * allPlanets[i].getVelocity().getX();
        
        double newVeloIY = ( (allPlanets[i].getMass() - allPlanets[j].getMass()) / (allPlanets[i].getMass() + allPlanets[j].getMass()) ) * allPlanets[i].getVelocity().getY();
        newVeloIY += ( (2 * allPlanets[j].getMass()) / (allPlanets[i].getMass() + allPlanets[j].getMass()) ) * allPlanets[j].getVelocity().getY();
        
        double newVeloJY = ( (allPlanets[j].getMass() - allPlanets[i].getMass()) / (allPlanets[i].getMass() + allPlanets[j].getMass()) ) * allPlanets[j].getVelocity().getY();
        newVeloJY += ( (2 * allPlanets[i].getMass()) / (allPlanets[i].getMass() + allPlanets[j].getMass()) ) * allPlanets[i].getVelocity().getY();
        
        allPlanets[i].setVelocity(new Vector(newVeloIX, newVeloIY));
        allPlanets[j].setVelocity(new Vector(newVeloJX, newVeloJY));
      }
    }
  }
}
