SpaceShip falcon9;
Stars [] olion;
ArrayList <Asteroids> rosetta;
public void setup() 
{ 
  size(800, 800);
  background(0);
  
  falcon9 = new SpaceShip() ;
  olion = new Stars[500];
  for (int i = 0; i < olion.length; ++i) 
  {
    olion [i] = new Stars();
  }
  rosetta = new ArrayList <Asteroids>();

  for (int i = 0; i < 10; ++i) 
  {
    rosetta.add(new Asteroids());
  }
  
  
}
public void draw() 
{
  background(0);
  for (int i = 0; i < olion.length; ++i) 
  {
    olion[i].starShow();
  }
  for (int i = 0; i < rosetta.size(); ++i) 
  {
    rosetta.get(i).rotate(5);
    rosetta.get(i).move();
    rosetta.get(i).show();
    double d = dist(rosetta.get(i).getX(), rosetta.get(i).getY(), falcon9.getX(), falcon9.getY());
    if (d <= 25) 
    {
      rosetta.remove(i);
    }
    
  }

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

    falcon9.accelerate(.5);
  }
  if (key == 's')
  {

    falcon9.accelerate(-.5);
  }
  if (key == 'd')
  {

    falcon9.rotate(5);
  }
  if (key == 'a')
  {

    falcon9.rotate(-5);
  }
  if (key == 'h')
  {
    falcon9.setX((int)(Math.random() * 800));
    falcon9.setY((int)(Math.random() * 800));
    falcon9.setPointDirection((int)(Math.random() * 360)) ;
    falcon9.setDirectionX(0);
    falcon9.setDirectionY(0);
  }
}

class Stars
{
  private float ellipseXC;
  private float ellipseYC;
  private  float ellipseX;
  private float ellipseY;
  public Stars()
  {
   ellipseXC = (int)(Math.random()*800);
   ellipseYC= (int)(Math.random()*800);
   ellipseX= (int)(Math.random()*6);
   ellipseY= (int)(Math.random()*6);
 }
 public void starShow()
 {
   fill(255);
   ellipse(ellipseXC, ellipseYC, ellipseX, ellipseY);
 }



}
class Asteroids extends Floater
{
 public  Asteroids() 
 {
  corners = 6;
  xCorners = new int [corners];  
  xCorners[0]= 40;
  xCorners[1]= 28;
  xCorners[2]=-28;
  xCorners[3]=0;
  xCorners[4]= 8;
  xCorners[5]= 36;
  yCorners = new int [corners];
  yCorners[0]= 0; 
  yCorners[1]= -12;  
  yCorners[2]= -16;  
  yCorners[3]= 24; 
  xCorners[4]= 18 ;
  xCorners[5]= 28;   
  myColor = 200;   
  myCenterX = (int)(Math.random() * 800);
  myCenterY = (int)(Math.random() * 800);    
  myDirectionX = (int)(Math.random() * 7);
       myDirectionY = (int)(Math.random() * 7); //holds x and y coordinates of the vector for direction of travel   
       myPointDirection = (int)(Math.random() * 360);     
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

