//test

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
Planet p2 = new Planet(600, 450, 10000000000L, 20, numPlanets++);
Planet p3 = new Planet (100, 300, 10000000, 10, numPlanets++);
//Planet p3 = new Planet(500, 450, 100000000, 20, numPlanets++);

void setup(){
  surface.setSize(numPixelsX, numPixelsY);
  frameRate(frameRate);
  p2.setVelocity(new Vector(-0.5, 0));
  System.out.println("radius in m: " + (p.getRadius() / pixelsPerMeter));
} 

//for calculating force of gravity
Mass allMasses[] = {p, p2, p3};
//for calculating planetary collisions
Planet allPlanets[] = {p, p2, p3};

//Loop for drawing the sketch
void draw(){
  background(0,0,0);
  p.setColour(200,150,0);
  p2.setColour(100,200,0);
  p3.setColour(0, 200, 100);
  //p4.setColour(1, 55, 55);
  
  
  handleGravity(allMasses, pixelsPerMeter, secondsPerFrame);
  handleCollisions(allPlanets, numPlanets);  

  p.display();
  p2.display();
  p3.display();
  //p4.display();
  
}

//Ideally, all functions in this file other than setup and draw would be static functions belonging to the other classes
//unfortunately that doesn't seem to work with processing because all the other classes are inner classes

/*
  Function:   handleCollisions
   Purpose:   Inspect all planets and alter velocities using conservation of momentum and energy if there is a collision
        in:   Every planet currently in the simulation
       out:   Planets which have their velocities updated if they have collided
*/
void handleCollisions(Planet[] allPlanets, int numPlanets){
  for(int i = 0; i<numPlanets; i++){
    for(int j = i+1; j<numPlanets; j++){
      
      //the lengths on the axies between the two centers of the planets
      float xLen = allPlanets[i].getX() - allPlanets[j].getX();
      float yLen = allPlanets[i].getY() - allPlanets[j].getY();
      
      double r = Math.sqrt( Math.pow(xLen, 2) + Math.pow(yLen, 2) );
      if( r <= (allPlanets[i].getRadius() + allPlanets[j].getRadius()) ){
       
        //the hypotenuse distance which one planet must travel to be outside of the other planet
        //the overlap length if you will
        double distanceBack = Math.abs( Math.abs( r - allPlanets[i].getRadius() ) - allPlanets[j].getRadius() );
          
        //the ratio of the  distance between the 2 radii and the X and Y axies of the triangle
        float xRatio = (float)r / xLen;
        float yRatio = (float)r / yLen;
        
        //that ratio is the same as for the hypotenuse and X and Y axis of the overlap distance
        allPlanets[j].setX(allPlanets[j].getX() - xRatio*(float)distanceBack);
        allPlanets[j].setY(allPlanets[j].getY() - yRatio*(float)distanceBack);

        //These are the conservation of momentum and conservation of (kinetic) energy equations used to solve for the final velocities
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
    //allPlanets[i].borderCollision();
  }
}

/*
  Function:   handleGravity
   Purpose:   handle how gravity affects all masses in the simulation
        in:   Array of every mass used for calculating the gravitational forces being applied to every mass
        in:   Float containing how many pixels represent one meter 
        in:   Float representing how many seconds should pass in a single frame
*/
public void handleGravity(Mass[] allMasses, float pixelsPerMeter, float secondsPerFrame){
    for(Mass obj: allMasses){
       obj.calculateGravitationalForce(allMasses, pixelsPerMeter);
       obj.calculateAcceleration();
       obj.calculateVelocity(secondsPerFrame);
       obj.calculateNewPosition(secondsPerFrame, pixelsPerMeter);
    }
  }
