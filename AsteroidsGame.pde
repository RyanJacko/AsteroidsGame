Bar Bob;
SpaceShip Blaster;
Star Rob;
int sw, sh, health, rama;
Star[] stars;
public void setup() 
{
  size (1250, 800);
  background (0);
  stars = new Star[50];
  for (int i = 0; i < stars.length; i++)
  {
    stars[i] = new Star();
  }
  sw = 1250;
  sh = 800;
  Bob = new Bar();
  Blaster = new SpaceShip();
}
public void draw() 
{
  if (mousePressed == true)
  {
    cursor(CROSS);
  }
  else
  {
    cursor(MOVE);
  }
  fill(50);
  background (0);
    for (int i = 0; i < stars.length; i++)
  {
   stars[i].show();
   System.out.println("Star" + System.currentTimeMillis());
  }
  Bob.show();
  Blaster.show();
  System.out.println("Blaster" + System.currentTimeMillis());
  Blaster.keyPressed();
  Blaster.rotate(Blaster);
  Blaster.move();
}
void keyPressed()
{
 if (keyPressed && keyCode == ALT)
 {
   Blaster.setX((int)(Math.random()*sw));
   Blaster.setY((int)(Math.random()*sh));
   Blaster.setDirectionX(0);
   Blaster.setDirectionY(0);
 }
}
public class Bar
{
  public int v1, myValue;
  Bar()
  {
   // v1 = myValue;
    myValue = 800;
  }
  public void show()
  {
    fill(255);
   rect (1250,800,50,800);
  }
}
  
public class Star
{
  int posX, posY, mySize;
  public Star()
  {
    posX = (int)(Math.random()*width);
    posY = (int)(Math.random()*height);
    mySize = (int)(Math.random()*5);
  }
  public void show()
  {
    noStroke();
    fill(255, 200);
    ellipse(posX, posY, mySize, mySize);
  }
}
class SpaceShip extends Floater  
{ 
  public int originalselecta;
  public void setX(int x) {
    myCenterX = x;
  }  
  public int getX() {
    return (int)myCenterX;
  } 
  public void setY(int y) {
    myCenterY = y;
  } 
  public int getY() {
    return (int)myCenterY;
  }
  public void setDirectionX(double x) {
    myDirectionX = x;
  }   
  public double getDirectionX() {
    return myDirectionX;
  }
  public void setDirectionY(double y) {
    myDirectionY = y;
  }     
  public double getDirectionY() {
    return myDirectionY;
  }  
  public void setPointDirection(int degrees) {
    myPointDirection = degrees;
  }  
  public double getPointDirection() {
    return myPointDirection;
  }

  public SpaceShip()
  {
    originalselecta = (int)(Math.random()*3)+1;
    corners = 4;  
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0]=20;
    xCorners[1]=-5;
    xCorners[2]=-3;
    xCorners[3]=-5;
    yCorners[0]=0;
    yCorners[1]=10;
    yCorners[2]=0;
    yCorners[3]=-10;  

    myColor = (int)(Math.random()*155)+100;
    myPointDirection=-90; 
    setX(sw/2);
    setY(sh/2);
  }

  public void rotate(SpaceShip theShip)
  {  
    //first quadrant 
    if (mouseX>theShip.getX() && mouseY<theShip.getY())
    {
      myPointDirection = (-1)*(180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
    }
    //second quadrant
    if (mouseX<theShip.getX() && mouseY<theShip.getY())
    {
      myPointDirection = 180 + (180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
    }
    //third quadrant
    if (mouseX<theShip.getX() && mouseY>theShip.getY())
    {
      myPointDirection = 180 - (180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
    }
    //fourth quadrant
    if (mouseX>theShip.getX() && mouseY>theShip.getY())
    {
      myPointDirection = (180/Math.PI)*Math.atan(Math.abs((double)mouseY - (double)theShip.getY())/Math.abs((double)mouseX - (double)theShip.getX()));
    }
  }

  public void keyPressed()
  {
    if (keyPressed && key == 32)
    {
      Blaster.accelerate(0.1);
    }
    if (keyPressed && keyCode == DOWN)
    {
      Blaster.accelerate(-0.1);
    }
    if (keyPressed && keyCode == ALT)
    {
      Blaster.setX((int)(Math.random()*sw));
      Blaster.setY((int)(Math.random()*sh));
      Blaster.setDirectionX(0);
      Blaster.setDirectionY(0);
    }
  }
  public void show ()
  { 
    if (originalselecta == 1)
    {
      fill(0, myColor-100, 0);   
      stroke(0, myColor, 0);
    } else if (originalselecta == 2)
    {
      fill(myColor-100, 0, 0);   
      stroke(myColor, 0, 0);
    } else {
      fill(0, 0, myColor-100);   
      stroke(0, 0, myColor);
    }

    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for (int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated, yRotatedTranslated);
    }   
    endShape(CLOSE);
  }
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if (myCenterX >width)
    {     
      myCenterX = 0;
    } else if (myCenterX<0)
    {     
      myCenterX = width;
    }    
    if (myCenterY >height)
    {    
      myCenterY = 0;
    } else if (myCenterY < 0)
    {     
      myCenterY = height;
    }
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for (int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated, yRotatedTranslated);
    }   
    endShape(CLOSE);
  }
}