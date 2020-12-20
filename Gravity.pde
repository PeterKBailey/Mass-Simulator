//Newtons, meters, kg, s

int numPixelsX = 640;
int numPixelsY = 480;
int numMetersX = 100;

int pixelsPerMeter = numPixelsX / numPixelsY;

int frameRate = 24;
float secondsPerFrame = 1.0/frameRate;

void setup(){
  surface.setSize(numPixelsX, numPixelsY);
  frameRate(frameRate);
}
//might need to switch masses to a different unit and fix the equations...
Planet p = new Planet(100, 100, 1000000000000000000L, 60);
Planet p2 = new Planet(600, 100, 10000000000000000L, 12);
Mass allMasses[] = {p, p2};
  //System.out.println(p.getX() + " and " + p.getY());

void draw(){
    //System.out.println("initial: " + p.getX() + " and " + p.getY());

  background(155);
  
  p.calculateGravitationalForce(allMasses);
  System.out.println("Fx: " + p.getForce().getX());
  p.calculateGravitationalAcceleration();
  System.out.println("Ax: " + p.getAcceleration().getX());
  p.calculateGravitationalVelocity(secondsPerFrame);
  System.out.println("Vx: " + p.getVelocity().getX());
  p.calculateGravitationalDistance(secondsPerFrame, pixelsPerMeter);
  System.out.println(p.getX() + " and " + p.getY());
  p.display();
  
  p2.calculateGravitationalForce(allMasses);
  p2.calculateGravitationalAcceleration();
  p2.calculateGravitationalVelocity(secondsPerFrame);
  p2.calculateGravitationalDistance(secondsPerFrame, pixelsPerMeter);
  p2.display();
}
