import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class AsteroidsGame extends PApplet {

SpaceShip falcon9;
Stars olion;
public void setup() 
{ 
  size(800, 800);
  background(0);
  falcon9 = new SpaceShip() ;
  olion = new Stars();
  
 
}
public void draw() 
{
  background(0);
  olion.show();
  falcon9.move();
  falcon9.show();
  
}
class SpaceShip extends Floater  
{   
    public  SpaceShip() 
    {
      corners = 4;
       xCorners = new int [corners];  
       xCorners[0] =  10;
       xCorners[1] =  -7;
       xCorners[2] =  -3;
       xCorners[3] = -7;
       yCorners = new int [corners];
       yCorners[0]= 0; 
       yCorners[1]= -10;  
       yCorners[2]= 0;  
       yCorners[3]= 10;    
       myColor = 255;   
       myCenterX = 400;
       myCenterY = 400;    
       myDirectionX = 0;
       myDirectionY = 0; //holds x and y coordinates of the vector for direction of travel   
     myPointDirection = 270;  
     
      
    }
 public void setX(int x) 
  {
    myCenterX = x;
  }
 public int getX()
  {
    return (int)myCenterX;
  }
 public void setY(int y)
  {
    myCenterY = y;
  }   
 public int getY()
  {
    return (int)myCenterY;
  }   
 public void setDirectionX(double x)
  {
    myDirectionX = x;
  } 
 public double getDirectionX()   
  {
    return myDirectionX;
  }
 public void setDirectionY(double y) 
  {
    myDirectionY = y;
  }  
 public double getDirectionY()   
  {
    return myDirectionY;
  }
 public void setPointDirection(int degrees)
  {
    myPointDirection = degrees;
  }   
 public double getPointDirection()
  {
    return myPointDirection;
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
    if(myCenterX >800)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = 800;    
    }    
    if(myCenterY >800)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = 800;    
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
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE); 
    
  }   
} 
public void keyPressed()
{
  if (key == 'w')
  {

    falcon9.accelerate(.5f);
  }
   if (key == 's')
  {

    falcon9.accelerate(-.5f);
  }
  if (key == 'd')
  {

    falcon9.rotate(5);
  }
   if (key == 'a')
  {

    falcon9.rotate(-5);
  }
  
}

class Stars
{
  int numStars; 
  Stars()
  {
    numStars = 500;
  }
public void show()
{
    for(int i = 0; i < numStars; ++i) 
  {
    fill((int)(Math.random() * 255), (int)(Math.random() * 255), (int)(Math.random() * 255));
    ellipse((int)(Math.random() * 800), (int)(Math.random() * 800), (int)(Math.random()*6), (int)(Math.random()*6));
  }
}


}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "AsteroidsGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
