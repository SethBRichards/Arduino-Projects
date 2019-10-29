//SERIAL PORT VARIABLES

import processing.serial.*;
Serial myPort;

String[] sData = {"","","","",""};  //Supports 3 values...needed for the getSerialData() function
//***********************************************************************

//Data from Arduino
//Expecting ThumbStick value from -1 to +1
//Representing full Reverse to full Forward
float axisX = -999.99;
float axisY = -999.99;
float digitalPin1 =  -999.99;
float digitalPin2 =  -999.99;
float digitalPin3 =  -999.99;

int colorRside, colorBside, colorGside;
int textColorRed, textColorGreen, textColorBlue;
int rectR, rectG, rectB;
int rectR2, rectG2, rectB2;
int rectR3, rectG3, rectB3;
int rectR4, rectG4, rectB4;
int rectR5, rectG5, rectB5;


int redRSide, redGSide, redBSide;
int yellowRSide, yellowGSide, yellowBSide;
int blueRSide, blueGSide, blueBSide;
int ballRColor, ballGColor, ballBColor;
int ballRColorSecondary, ballGColorSecondary, ballBColorSecondary;
int colorVariableDeux, colorVariableTrois, colorVariableQuatre, colorVariableCinq, colorVariableSix;

int rectX = 250;
int rectY= 0;
int rectLength = 500;
int rectHeight= 100;
int rectSpeed = 10;

int rectX2 = 250;
int rectY2 ;
int rectLength2;
int rectHeight2;
int rectSpeed2;

int rectX3 = 250;
int rectY3;
int rectLength3;
int rectHeight3;
int rectSpeed3;

int rectX4 = 250;
int rectY4;
int rectLength4;
int rectHeight4;
int rectSpeed4;

int rectX5 = 250;
int rectY5;
int rectLength5;
int rectHeight5;
int rectSpeed5;

int ballY;
int deathRectYPosition;
float difficulty = 50;
int setDifficulty;
int lifeForce;
int ballColor;
String colorOfBall;

int time;
int scoreboardTime;

int energy = 0;
int healingFactor = 100;
int initialDificulty;
int maximumDifficulty2;
int level = 0;
float centerValue = 500;
int anotherTimer;
int pulse=25;
int pulseVariable = 1;
int start = 1;
int newTimer = 0;
float ttime = 9.5;
boolean starting;
int buttonPulse;
int vv = 1;
void setup()
{
  
  frameRate(30);
  
  //*****************************************************************
  //DISPLAY SERIAL PORTS AND CONNECT TO THE ARDUINO PORT
  
  //printCommPorts();
  //myPort = new Serial(this, Serial.list()[0], 9600);  //Baud rate (9600, 115200,...) must match Arduino
  
  //****************************************************************
   size(1000, 925);
   //First Value is Initial Health
   //Second Value is Maximum Difficulty level avalible
  colorSplahSetup(125,30);
  
}

void draw()
{
  
  //**********************************************************************************************
  //GET DATA FROM THE SERIAL BUS AND STORE IT IN DATA VARIABLES
  /*
  getSerialData();  //This will populate sData with the three current values from Arduino
  axisX = string2float(sData[0]);  //Convert the #1 Arduino data from a string to decimal number.
  axisY = string2float(sData[1]);  //Convert the #1 Arduino data from a string to decimal number.
  digitalPin1 = string2float(sData[2]);  //Convert the #1 Arduino data from a string to decimal number.
  digitalPin2 = string2float(sData[3]);  //Convert the #1 Arduino data from a string to decimal number.
  digitalPin3 = string2float(sData[4]);  //Convert the #1 Arduino data from a string to decimal number.
*/
  //**********************************************************************************************
  println("digitalPin1    " +digitalPin1);
  println("digitalPin2    " +digitalPin2);
  println("digitalPin3    " +digitalPin3);
  println("axisX    " +axisX);
  println("axisY    " +axisY);


  //First Value is health returned after death
  //Second Value is Initial Difficulty 
  if (mouseX < 500 && starting == false)
  {
     noStroke() ;  
    if (buttonPulse < 0)
    {
      vv = 1;
    }
    else if (buttonPulse > 15)
    { 
      vv = -1;
    }

    buttonPulse = buttonPulse + vv;
    
      fill(150,20,80);
 rect(0,0,1000,1000); 
   fill(255,0,0);
 rect(20,120,970,90); 
   fill(255,0,0);
    fill(255, 255, 0);
 rect(0,0,20,900);
  rect(983,0,17,900);
   fill(0,255,0);
 ellipse(700,380,200,120); 
   fill(0,255,0);
     fill(0,100,255);
    ellipse(250,50,50,50);
    ellipse(500,50,50,50);
    ellipse(750,50,50,50);
        
   fill(255,153,255);
   triangle(100, 300, 50, 800, 150, 800);
   triangle(900, 300, 950, 800, 850, 800);
   
   fill(150, 150, 150);
   rect(250, 790, 500, 75);
   
   fill(0,200,0);
   rect(100, 50, 50, 50);
   rect(900, 50, 50, 50);


fill(148,0,211);
 ellipse(500,675,pulse * 15,pulse * 12); 
fill(148,0,211);
fill(75,0,130);
 ellipse(500,675,pulse * 13,pulse * 10); 
   fill(75,0,130);
 
   fill(0,0,255);
 ellipse(500,675,pulse * 11,pulse * 8); 
   fill(0,0,255);

   fill(0,255,0);
 ellipse(500,675,pulse * 9,pulse * 6); 
   fill(0,255,0);

   fill(255,255,0);
 ellipse(500,675,pulse * 7,pulse * 4); 
   fill(255,255,0);
   
      fill(255,127,0);
 ellipse(500,675,pulse * 5,pulse *2); 
      fill(255,127,0);

   fill(255,0,0);
 ellipse(500,675,pulse * 3,pulse *1); 
      fill(255,0,0);
      
        
     textSize(60);
    fill(0,20,100);
text("Beginning in ", 200,400);
    fill(0,20,100);


 textSize(80);
     fill(0,20,100);
text("Welcome to Color Splash", 25,200);
 textSize(40);
 fill(200,200,10);
text("Made by Seth Richards of Sunset High School", 50, 250);
    fill(200,200,10);
    if (buttonPulse < 12)
    {
     fill(255,127,10);
text("Press any Button to Begin", 250, 300);
     fill(255,127,10);
    }
  }
  else if (mouseX > 500)
  {
    starting = true;
  }
  if (starting == true)
  {
  colorSplashDraw(100, 12, true);
  }
}


//*************************************************************
void getSerialData()
{
  //This function gets chunks of serial data and breaks it up
  //Assumes three different pieces of data are sent.
  //Stores the extracted data in the sData variable (at Top of code)
  
  if(myPort.available() > 16)
  {
    String[] sDataTemp = {"","","","",""};
    myPort.readStringUntil(',');
    for(int i = 0; i < 5; i++)
    {
      sDataTemp[i] = myPort.readStringUntil(',');
      
      if(sDataTemp[i] != null)
      {
        sDataTemp[i] = sDataTemp[i].substring(0, sDataTemp[i].length() - 1);
      }
      else
      {
        sDataTemp[i] = "0:0.0"; 
      }
    }
        
    for(int i = 0; i < sDataTemp.length; i++)
    {
      String[] dataDictionary = split(sDataTemp[i], ':');
      
      switch(dataDictionary[0])
      {
        case("1"):
        {
          sData[0] = dataDictionary[1];
          break;
        }
        case("2"):
        {
          sData[1] = dataDictionary[1];
          break;      
        }
        case("3"):
        {
          sData[2] = dataDictionary[1];
          break;    
        }
         case("4"):
        {
          sData[3] = dataDictionary[1];
          break;    
        }
         case("5"):
        {
          sData[4] = dataDictionary[1];
          break;    
        }
      }
    }
    myPort.clear();
  }
}

//*********************************************************
int printCommPorts()
{
  //Prints a list of the used COM ports to the Console Window
  //If no COM ports are listed it prints that no COM ports are active in the Console Window
  //Returns the number of COM ports used
  
  int nCommPorts = 0;
  
  String[] portNames = Serial.list();
  
  if(portNames.length > 0)
  {
    nCommPorts = portNames.length;
    for(int i = 0; i < portNames.length; i++)
    {
      println("Index = " + i + " , Port = " + portNames[i]);
    }
  }
  else
  {
    println("No COM ports used");
  }
  
  return nCommPorts;
}

//***************************************************************
float string2float(String s)
{
  //Function that converts strings 
  //to decimal numbers (float type)
  
  return float(s);
}

//***************************************************************
int string2int(String s)
{
  //Function that converts strings 
  //to integer numbers.
  
  return (int)float(s);
}

//***************************************************************
boolean string2boolean(String s)
{
  //Function that converts strings 
  //to booleans.  Assumes anything starting with 0.xxxx will be false.
  //anything else will be true.
  
  boolean result = false;
  
  int temp = (int)float(s);
  if(temp != 0)
  {
    result = true;
  }
  
  return result;
}

public void colorSplahSetup(int h, int maximumDifficulty)
{
  lifeForce = h;
  initialDificulty = 1;
  maximumDifficulty2 = maximumDifficulty;
  frameRate(30);
  

  rect(0, 0, 250, 1000);
  rect(750, 0, 250, 1000);

colorVariableDeux = 1;
colorVariableTrois = 1;
colorVariableQuatre = 1;
colorVariableCinq = 1;
colorVariableSix = 1;

  fill(0, 0, 0);
  ellipse(centerValue, ballY, 25, 25);
  fill(0,0,0);
  ellipse(centerValue, ballY, pulse, pulse);

  //Variables
  redRSide = 255;
  redBSide = 20;
  redGSide = 30;
  yellowRSide  = 255;
  yellowBSide  = 20;
  yellowGSide = 255;
  blueRSide = 0;
  blueGSide = 0;
  blueBSide = 255;
 
 rectX = 250;
 rectY=-20;
 rectLength = 500;
 rectHeight = 150;
 rectSpeed = 10;
  rectR =0;
  rectG =0;
  rectB =0;

  rectX2 = 380;
  rectY2=0;
  rectLength2 = 300;
  rectHeight2 = 100;
  rectSpeed2 = 12;
  rectR2 =0;
  rectG2 =0;
  rectB2 =0;
  
  rectX3 = 600;
  rectY3=0;
  rectLength3 = 150;
  rectHeight3 = 200;
  rectSpeed3 = 8;
  rectR3 = 0;
  rectG3 =0;
  rectB3 =0;

  rectX4 = 260;
  rectY4=-80;
  rectLength4 = 150;
  rectHeight4 = 300;
  rectSpeed4 = 11;
  rectR4 = 0;
  rectG4 =0;
  rectB4 =0;
  
  rectX5 = 320;
  rectY5=0;
  rectLength5 = 200;
  rectHeight5 = 70;
  rectSpeed5 = 13;
  rectR5 = 0;
  rectG5 =0;
  rectB5 =0;

  ballRColor = 0;
  ballGColor = 0;
  ballBColor = 255;
  ballRColorSecondary =0;
  ballGColorSecondary = 0;
  ballBColorSecondary = 0;

  ballY = 875;
  deathRectYPosition = 875;
  ballColor = 3;
  setDifficulty = 0;
  

}



public void colorSplashDraw( int h, int diff, boolean crazy)
{
println(pulse);
println(pulseVariable);
ttime = ttime - 0.1;
if (newTimer < 15+30+30+20)
{
newTimer = newTimer + 1;
start = 2;
}
else if (newTimer < 30+30+30+20)
{
    digitalPin1 =  1;
    start = 1;
    newTimer = newTimer + 1;
}
else if (newTimer > 36+30+30+20)
{
    newTimer = newTimer + 1;
}
else if (newTimer > 29+30+30+20)
{
  digitalPin1 = 0;
    newTimer = newTimer + 1;
        lifeForce = 100;
}



  if (pulse > 45)
  {
  pulseVariable = -1;  
}
  else if (pulse < 7)
  {
  pulseVariable = 1;  }

pulse = pulse + pulseVariable;
  
  
  centerValue = centerValue + ((axisX+0.02) * 17);
  
  //BACKGROUND FORMATING

  if (crazy == false)
  {
 background(255, 255, 255);
  }
  else if (crazy == true)
  {
    background((int)random(0, 255),(int)random(0, 255),(int)random(0, 255));
    fill(0,0,0);
    textSize(90);
    text("THIS IS LIT", 270, 250);
  }
 noStroke() ;  
 
 //DIFFICULTY TRACKER

  difficulty = diff ;
  rectSpeed = (int)random(8, difficulty);
  rectSpeed2 = (int)random(10, difficulty);
  rectSpeed3 = (int)random(9, difficulty);
  rectSpeed4 = (int)random(7, difficulty);
  rectSpeed5 = (int)random(6, difficulty);
  if (difficulty > maximumDifficulty2)
  {
    difficulty = maximumDifficulty2;
  }
//SCOREBOARD VALUES

time = time + 1;
scoreboardTime = time/20;


//COLOR SELECTOR

if (rectY > 990 )
{
  if (colorVariableDeux == 1)
  {
    colorVariableDeux = (int)random(2,4);
  }
  else if (colorVariableDeux == 3)
  {
    colorVariableDeux =(int)random(1,3);
  }
  else if(colorVariableDeux == 2)
  {
    int a;
    a = (int)random(2,4);
    if (a == 2)
    {
     a = 1; 
    }
    colorVariableDeux = a;
  }
}

if (rectY2 > 990 )
{
  if (colorVariableTrois == 1)
  {
    colorVariableTrois = (int)random(2,5);
  }
  else if (colorVariableTrois == 3)
  {
    colorVariableTrois =(int)random(1,3);
  }
  else if(colorVariableTrois == 2)
  {
    int a;
    a = (int)random(2,4);
    if (a == 2)
    {
     a = 1; 
    }
    colorVariableTrois = a;
  }
  else if (colorVariableTrois == 4)
  {
   colorVariableTrois =(int)random(1,4);
  }
}

if (rectY3 > 990 )
{
  if (colorVariableQuatre == 1)
  {
    colorVariableQuatre =(int)random(2,5);
  }
  else if (colorVariableQuatre == 3)
  {
    colorVariableQuatre =(int)random(1,3);
  }
  else if(colorVariableQuatre == 2)
  {
    int a;
    a = (int)random(2,4);
    if (a == 2)
    {
     a = 1; 
    }
    colorVariableQuatre = a;
  }
   else if (colorVariableQuatre == 4)
  {
   colorVariableQuatre =(int)random(1,4);
  }
}
if (rectY4 > 990 )
{
  if (colorVariableCinq == 1)
  {
    colorVariableCinq = (int)random(2,5);
  }
  else if (colorVariableCinq == 3)
  {
    colorVariableCinq =(int)random(1,3);
  }
  else if(colorVariableCinq == 2)
  {
    int a;
    a = (int)random(2,4);
    if (a == 2)
    {
     a = 1; 
    }
    colorVariableCinq = a;
  }
  else if (colorVariableCinq == 4)
  {
   colorVariableCinq =(int)random(1,4);
  }
}

if (rectY5 > 990 )
{
  if (colorVariableSix == 1)
  {
    colorVariableSix = (int)random(2,5);
  }
  else if (colorVariableSix == 3)
  {
    colorVariableSix =(int)random(1,3);
  }
  else if(colorVariableSix == 2)
  {
    int a;
    a = (int)random(2,4);
    if (a == 2)
    {
     a = 1; 
    }
    colorVariableSix = a;
  }
  else if (colorVariableSix == 4)
  {
   colorVariableSix =(int)random(1,4);
  }
}

//ACTUAL COLORING OF OBSTACLES 

    if (colorVariableSix ==1)
    {
    rectR5 = redRSide; 
    rectG5 = redGSide; 
    rectB5 = redBSide;
    }
    else if (colorVariableSix ==2)
    {
    rectR5 = yellowRSide; 
    rectG5 = yellowGSide; 
    rectB5 = yellowBSide;    
    }
    else if (colorVariableSix == 3)
    {
    rectR5 = blueRSide; 
    rectG5 = blueGSide; 
    rectB5 = blueBSide;
    }  
    else if (colorVariableSix == 4)
    {
    rectR5 = 0 ;
    rectG5 = 255;
    rectB5= 0;
    }
    
    if (colorVariableCinq ==1)
    {
    rectR4 = redRSide; 
    rectG4 = redGSide; 
    rectB4 = redBSide;
    }
    else if (colorVariableCinq ==2)
    {
    rectR4 = yellowRSide; 
    rectG4 = yellowGSide; 
    rectB4 = yellowBSide;    
    }
    else if (colorVariableCinq == 3)
    {
    rectR4 = blueRSide; 
    rectG4 = blueGSide; 
    rectB4 = blueBSide;
    }  
    else if (colorVariableCinq == 4)
    {
    rectR4 = 0 ;
    rectG4 = 255;
    rectB4= 0;
    }
    
    if (colorVariableQuatre ==1)
    {
    rectR3 = redRSide; 
    rectG3 = redGSide; 
    rectB3 = redBSide;
    }
    else if (colorVariableQuatre ==2)
    {
    rectR3 = yellowRSide; 
    rectG3 = yellowGSide; 
    rectB3 = yellowBSide;    
    }
    else if (colorVariableQuatre == 3)
    {
    rectR3 = blueRSide; 
    rectG3 = blueGSide; 
    rectB3 = blueBSide;
    }
    else if (colorVariableQuatre == 4)
    {
    rectR3 = 0 ;
    rectG3 = 255;
    rectB3= 0;
    }
    
    if (colorVariableTrois ==1)
    {
    rectR2 = redRSide; 
    rectG2 = redGSide; 
    rectB2 = redBSide;
    }
    else if (colorVariableTrois ==2)
    {
    rectR2 = yellowRSide; 
    rectG2 = yellowGSide; 
    rectB2 = yellowBSide;    
    }
    else if (colorVariableTrois == 3)
    {
    rectR2 = blueRSide; 
    rectG2 = blueGSide; 
    rectB2 = blueBSide;
    } 
    else if (colorVariableTrois == 4)
    {
    rectR2 = 0 ;
    rectG2 = 255;
    rectB2= 0;
    }

    colorCondenser(colorVariableDeux);
    
//MAKING THE OBSTACLES

  fill(rectR,rectG,rectB);
  rect(rectX, rectY, rectLength, rectHeight);
  rectY = rectY + rectSpeed;

  fill(rectR2,rectG2,rectB2);
  rect(rectX2, rectY2, rectLength2, rectHeight2);
  rectY2 = rectY2 + rectSpeed2;
  
  fill(rectR3,rectG3,rectB3);
  rect(rectX3, rectY3, rectLength3, rectHeight3);
  rectY3 = rectY3 + rectSpeed3;

  fill(rectR4,rectG4,rectB4);
  rect(rectX4, rectY4, rectLength4, rectHeight4);
  rectY4 = rectY4 + rectSpeed4;

  fill(rectR5,rectG5,rectB5);
  rect(rectX5, rectY5, rectLength5, rectHeight5);
  rectY5 = rectY5 + rectSpeed5;

  //Ball Itself
    fill(ballRColor, ballGColor, ballBColor);

  ellipse(centerValue, 875, 50, 50);

  if (centerValue > 720)
  {
    centerValue = 719;
  }
  else if (centerValue < 280)
  {
   centerValue = 281;
  }  fill(ballRColor, ballGColor, ballBColor);

  
  fill(ballRColorSecondary,ballGColorSecondary,ballBColorSecondary);
  
  ellipse(centerValue, 875, pulse, pulse);
  
  fill(ballRColorSecondary,ballGColorSecondary,ballBColorSecondary);


  fill(ballRColor, ballGColor, ballBColor);
       ellipse(centerValue, 875, pulse-5 , pulse-5 );
       
         fill(ballRColorSecondary,ballGColorSecondary,ballBColorSecondary);
  
  ellipse(centerValue, 875, pulse-10, pulse-10);
  
  fill(ballRColorSecondary,ballGColorSecondary,ballBColorSecondary);
    fill(ballRColor, ballGColor, ballBColor);
  ellipse(centerValue, 875, pulse-15, pulse-15);
   fill(ballRColorSecondary,ballGColorSecondary,ballBColorSecondary);
  
  ellipse(centerValue, 875, pulse-20, pulse-20);
  
  fill(ballRColorSecondary,ballGColorSecondary,ballBColorSecondary);
    fill(ballRColor, ballGColor, ballBColor);
      ellipse(centerValue, 875, pulse-25, pulse-25);
fill(ballRColorSecondary,ballGColorSecondary,ballBColorSecondary);
  
  ellipse(centerValue, 875, pulse-30, pulse-30);
  
  fill(ballRColorSecondary,ballGColorSecondary,ballBColorSecondary);
    fill(ballRColor, ballGColor, ballBColor);

if (ballColor == 1)
{
    colorOfBall = "Red";
}
else if (ballColor == 2)
{
    colorOfBall = "Yellow";
} 
 else if (ballColor == 3)
{
    colorOfBall = "Blue";
}
  //RECTANGULAR CONSTRUCTS
  rect(0, 0, 250, 1000);
  rect(750, 0, 250, 1000);
   fill(25,100,10);
  rect(250,0,10,1000);
  rect(740,0,10,1000);
  rect(0,0,250,10);
  rect(750,0,250,10);
  rect(0,0,5,1000);
  rect(995,0,5,1000);



  if (rectY > 1000)
  {
   rectY = -101; 
  }
  
  if (rectY2 > 1000)
  {
   rectY2 = -131; 
  } 
  if (rectY3 > 1000)
  {
   rectY3 = -120; 
  } 
  if (rectY4 > 1000)
  {
   rectY4 = -250; 
  }  
    if (rectY5 > 1000)
  {
   rectY5 = -250; 
  }  
  
 fill(ballRColor, ballGColor, ballBColor);

  
  if (lifeForce <= 0)
  {
  lifeForce = 0;
  rect(260, deathRectYPosition-20, 480, 1000);
  deathRectYPosition = deathRectYPosition - 8;
  colorOfBall = "----";
  ballRColor = 0;
  ballGColor = 0;
  ballBColor = 0;
  time = 0;
  scoreboardTime = 0;
  difficulty = 0;
  setDifficulty = 0;
  healingFactor = 100;
  energy = 0;
  }
  else
  {
    //NORMAL VARIABLES TAKE OVER
  }
  
  if (deathRectYPosition < -1000)
  {
   deathRectYPosition = 1150;
   lifeForce = h; 
  }

  
      if (digitalPin1 == 1)
  {
  ballRColor = redRSide;
  ballGColor = redGSide;
  ballBColor = redBSide;
  ballRColorSecondary = 0;
  ballGColorSecondary =50 ;
  ballBColorSecondary = 50;
 ballColor = 1;
 textColorRed= 10;
 textColorGreen =205;
 textColorBlue=255;
  }
  else if (digitalPin2 == 1)
  {
  ballRColor = yellowRSide;
  ballGColor = yellowGSide;        
  ballBColor = yellowBSide;
   ballRColorSecondary = 0;
  ballGColorSecondary =50 ;
  ballBColorSecondary = 50;
  ballColor = 2;
   textColorRed= 204;
 textColorGreen =0;
 textColorBlue=102;
  }
else  if (digitalPin3 == 1)
  {
  ballRColor = blueRSide;
  ballGColor = blueGSide;
  ballBColor = blueBSide;
   ballRColorSecondary = 0;
  ballGColorSecondary =50 ;
  ballBColorSecondary = 50;
  ballColor = 3;
   textColorRed= 255;
 textColorGreen =128;
 textColorBlue=5;
  }
else {
  
}

  if (rectY <(875+25) && (rectY+150) > (875-25) && colorVariableDeux != ballColor )
  {
  lifeForce = lifeForce - 1;
  // println(lifeForce);
  }
  else if (rectY2 <(875+25) && (rectY2 +100) > (875-25) && colorVariableTrois != ballColor && centerValue < (rectX2 + 300) && centerValue > rectX2)
  {
  lifeForce = lifeForce - 1;
  }
  else if (rectY3 <(875+25) && (rectY3 +200)> (875-25) && colorVariableQuatre != ballColor && centerValue < (rectX3 + 150) && centerValue > rectX3)
  {
  lifeForce = lifeForce - 1;
  }
  else if (rectY4 <(875+25) && (rectY4 +300)> (875-25) && colorVariableCinq != ballColor && centerValue < (rectX4 + 150) && centerValue > rectX4)
  {
  lifeForce = lifeForce - 1;
  }
  else if(rectY5 <(875+25) && (rectY5 +70)> (875-25) && colorVariableSix != ballColor && centerValue < (rectX5 + 200) && centerValue > rectX5)
  {
    lifeForce = lifeForce - 1;
  }
 
  
  if (rectY <(875+25) && (rectY+150) > (875-25) && colorVariableDeux == ballColor )
  {
energy = energy + 1;  // println(lifeForce);
  }
  else if (rectY2 <(875+25) && (rectY2 +100) > (875-25) && colorVariableTrois == ballColor && centerValue < (rectX2 + 300) && centerValue > rectX2)
  {
energy = energy + 1;   }
  else if (rectY3 <(875+25) && (rectY3 +200)> (875-25) && colorVariableQuatre == ballColor && centerValue < (rectX3 + 150) && centerValue > rectX3)
  {
energy = energy + 1;   }
  else if (rectY4 <(875+25) && (rectY4 +300)> (875-25) && colorVariableCinq== ballColor && centerValue < (rectX4 + 150) && centerValue > rectX4)
  {
energy = energy + 1;   }
  else if(rectY5 <(875+25) && (rectY5 +70)> (875-25) && colorVariableSix == ballColor && centerValue < (rectX5 + 200) && centerValue > rectX5)
  {
energy = energy + 1;   }
  
if (energy > healingFactor)
{
  lifeForce = 100;
  setDifficulty = setDifficulty +1;
  healingFactor = healingFactor * 2;
  energy = 0;
}
  

  fill(textColorRed, textColorGreen, textColorBlue);
  textSize(46);
  text("Life Force:", 752, 70);
  text(lifeForce, 835,120);
  text("Ball Color:", 752, 190);
  text(colorOfBall, 815, 240);
  text("Time:", 800, 320);
  text(scoreboardTime, 850, 370);
  text("Difficulty:", 760, 440);
  text("IDK Fam", 780, 495);
  text("Color:", 790, 560);
  text(energy, 835, 610);
  text("Color to", 770, 670);
  text(" Heal:", 790, 720);
  text(healingFactor, 825, 770);

  text(" Welcome!", 5, 80);
  text("to the", 50, 130);
   
   textSize(65);
  fill(textColorRed, textColorGreen, textColorBlue);
  text("Color ", 30, 245);
  text("Splash!", 15, 305);

  textSize(46);
  text("To win,", 30, 500-80);
  text("simply", 40, 550-80);
  text("conform to", 2, 600-80);
  text("societal", 35, 650-80);
  text("norms", 50, 700-80);
  text("and fit", 45, 750-80);
  text("in with", 45, 800-80);
  text("the crowd.", 15, 850-80);
  text("Yeah!", 70, 970-100);
if (start == 2)
{

  fill(200,20,100);
 rect(0,0,1000,1000); 
   fill(255,0,0);
 rect(20,120,970,90); 
   fill(255,0,0);
   fill(0,255,0);
 ellipse(700,380,200,120); 
   fill(0,255,0);
    fill(255, 255, 0);
 rect(0,0,20,900);
  rect(983,0,17,900);
fill(148,0,211);
 ellipse(500,675,pulse * 15,pulse * 12); 
fill(148,0,211);
fill(75,0,130);
 ellipse(500,675,pulse * 13,pulse * 10); 
   fill(75,0,130);
 
   fill(0,0,255);
 ellipse(500,675,pulse * 11,pulse * 8); 
   fill(0,0,255);

   fill(0,255,0);
 ellipse(500,675,pulse * 9,pulse * 6); 
   fill(0,255,0);

   fill(255,255,0);
 ellipse(500,675,pulse * 7,pulse * 4); 
   fill(255,255,0);
   
      fill(255,127,0);
 ellipse(500,675,pulse * 5,pulse *2); 
      fill(255,127,0);

   fill(255,0,0);
 ellipse(500,675,pulse * 3,pulse *1); 
      fill(255,0,0);
      
     fill(0,100,255);
    ellipse(250,50,50+pulse,50+pulse);
    ellipse(500,50,50+pulse,50+pulse);
    ellipse(750,50,50+pulse,50+pulse);
        
   fill(255,153,255);
   triangle(100, 300+(pulse * 2), 50, 800-(pulse * 2), 150, 800-(pulse * 2));
   triangle(900, 300+(pulse * 2), 950, 800-(pulse * 2), 850, 800-(pulse * 2));
   
   fill(150, 150, 150);
   rect(250, 790, 500, 75);
   
   fill(0,200,0);
   rect(100, 50, 50, 50);
   rect(900, 50, 50, 50);

 textSize(80);
     fill(0,20,100);
text("Welcome to Color Splash", 25,200);
 textSize(40);
 fill(200,200,10);
text("Made by Seth Richards of Sunset High School", 50, 250);
    fill(200,200,10);
    
    
     textSize(60);
    fill(0,20,100);
text("Beginning in ", 200,400);
    fill(0,20,100);

    fill(0,100,255);
text(ttime, 600, 400);
    fill(0,100,255);

 
}
}



    
    void colorCondenser(float f)
    {
      if (f ==1)
      {
      rectR = redRSide; 
      rectG = redGSide; 
      rectB= redBSide;
      }
      else if (f ==2)
      {
      rectR = yellowRSide; 
      rectG = yellowGSide; 
      rectB= yellowBSide;    
      }
      else if (f == 3)
      {
      rectR = blueRSide; 
      rectG = blueGSide; 
      rectB= blueBSide;
      }
      else if (f == 4)
      {
      rectR = 0 ;
      rectG = 255;
      rectB= 0;
      }
    }


