const int STATE_CALIBRATE = -1;
const int STATE_OBSERVE = 0;
const int STATE_READ = 1;

int STATE = STATE_CALIBRATE;

int t0 = 0;
int t1 = 0;

float threshold = 600;
int T = 20;

int tDelayStart = 15;
int tRead = T * 8;

int bits[] = {0,0,0,0,0,0,0,0};
int iBit = 0;
char c = 0;

/*Encryption Method #1
 * 
 * Each value 1-7 is represented once in the array
 * Less secure than Method #2
*/
int encryptionArray[8] = {0,1,2,3,4,5,6,7};

/*Encryption Method #2
 * 
 * The letters are modified by a user entered password that can vary in length
 * Password must be composed of characters ranging in decimal value from 23 to 126
 * Password is all letters,uppercase and lowercase, all numbers, and most special characters, and space
 * More secure than Method #1
*/

//---------------------------

String password = "!!";

//---------------------------
int counter = 0;
int passLength = 1;

//Calibration Variables
int highestValue;
int lowestValue;
int oldHigh = 1;
int oldLow = 999;
int recentValue;
int configureDelay = 300;
float thresholdold;
int startSignalDelay = 200;
int state = 1;
int analogSignal;
float tenPercentDifference;
//Calibration Variables

void setup()
{
  // put your setup code here, to run once:
  Serial.begin(9600);
  passLength = password.length();

  delay(1000);
}

void loop() 
{
  //printData();
    //  Serial.println(STATE);

  if(STATE == STATE_CALIBRATE)
  {
    //Serial.println(configureSequenceRecieve());
    if (configureSequenceRecieve() == 1)
    {
      //Serial.println("success");
      
      STATE = STATE_OBSERVE;
    }
  }
 
  else if(STATE == STATE_OBSERVE)
  {
 
    if(analogRead(A0) > (threshold))
    {
      STATE = STATE_READ;

      delay(tDelayStart);
      t0 = millis();
      t1 = t0;
    }
 

    delay(1);
  }
  else if (STATE == STATE_READ)
  {
    //Serial.print("State = ");
    //Serial.println(STATE);
    
    delay(T/2);
    if(analogRead(A0) > threshold)
    {
      //bits[7] = 1;
      bitWrite(c, encryptionArray[7], 1);
    }

    delay(T);
    if(analogRead(A0) > threshold)
    {
      //bits[6] = 1;
      bitWrite(c, encryptionArray[6], 1);
    }

    delay(T);
    if(analogRead(A0) > threshold)
    {
      //bits[5] = 1;
      bitWrite(c, encryptionArray[5], 1);
    }

    delay(T);
    if(analogRead(A0) > threshold)
    {
      //bits[4] = 1;
      bitWrite(c, encryptionArray[4], 1);
    }

    delay(T);
    if(analogRead(A0) > threshold)
    {
      //bits[3] = 1;
      bitWrite(c, encryptionArray[3], 1);
    }

    delay(T);
    if(analogRead(A0) > threshold)
    {
      //bits[2] = 1;
      bitWrite(c, encryptionArray[2], 1);
    }

    delay(T);
    if(analogRead(A0) > threshold)
    {
      //bits[1] = 1;
      bitWrite(c, encryptionArray[1], 1);
    }

    delay(T);
    if(analogRead(A0) > threshold)
    {
      //bits[1] = 1;
      bitWrite(c, encryptionArray[0], 1);
    }

    delay((int)(T/2 + 12));
         //  Serial.print("c  ");

        //Serial.print(c);

    int encryptedInt = (int)c;
  
    
    //Serial.print("unencrypt  ");

    int unEncryptedInt = loopEncodeFunction(encryptedInt);
    char unEncryptedChar = (char)unEncryptedInt;
    Serial.print(unEncryptedChar);
    
    c = 0;
    STATE = STATE_OBSERVE;
    t0 = t1;
    
  }
  
  //delay(1);
}

void printData()
{
  Serial.print(millis());
  Serial.print(",");
  Serial.print(analogRead(A0));
  Serial.print("\r\n");
}
int configureSequenceRecieve()
{
  //delay = 3000
  delay(300);

  recentValue = analogRead(A0);
  if (oldHigh < recentValue)
  {
    delay(150);
    oldHigh = recentValue;
  }
  else if (oldLow > recentValue)
  {
    oldLow = recentValue;
  }

  delay(configureDelay);

  recentValue = analogRead(A0);
  if (oldHigh < recentValue)
  {
    delay(150);
    oldHigh = recentValue;
  }
  else if (oldLow > recentValue)
  {
    oldLow = recentValue;
  }

  delay(configureDelay);

  recentValue = analogRead(A0);
  if (oldHigh < recentValue)
  {
    delay(150);
    oldHigh = recentValue;
  }
  else if (oldLow > recentValue)
  {
    oldLow = recentValue;
  }

  delay(configureDelay);

  recentValue = analogRead(A0);
  if (oldHigh < recentValue)
  {
    delay(150);
    oldHigh = recentValue;
  }
  else if (oldLow > recentValue)
  {
    oldLow = recentValue;
  }

  delay(configureDelay);

    recentValue = analogRead(A0);
  if (oldHigh < recentValue)
  {
    delay(150);
    oldHigh = recentValue;
  }
  else if (oldLow > recentValue)
  {
    oldLow = recentValue;
  }

  delay(configureDelay);

    recentValue = analogRead(A0);
  if (oldHigh < recentValue)
  {
    delay(150);
    oldHigh = recentValue;
  }
  else if (oldLow > recentValue)
  {
    oldLow = recentValue;
  }

  delay(configureDelay);

  highestValue = oldHigh;
  lowestValue = oldLow;
  tenPercentDifference=(highestValue - lowestValue)* (0.1);
  threshold = (highestValue - lowestValue) * (0.5) + lowestValue;

  delay(100);
   //Testing Calibration Print Statements
  Serial.print("Highest Value = ");
  Serial.println(highestValue);
  Serial.print("Lowest Value = ");
  Serial.println(lowestValue);
  Serial.print("        thresh = ");
  Serial.println(threshold);
  
  return 1;
}
int loopEncodeFunction(int n)
{
   if (counter >= passLength)
  {
    counter = 0;
  }
  int passwordValue;
  passwordValue = (int)password.charAt(counter);
  int difference;
  int intermediateValue;
  int returnedVar;
 
  int initialEncryptedInt = n - passwordValue;
  if (initialEncryptedInt < 32)
  {
    difference = 32 - initialEncryptedInt;
    intermediateValue = 126- difference;
    if (intermediateValue < 32)
    {
    difference = 32 - intermediateValue;
    intermediateValue = 126- difference;
    }

  
  counter = counter + 1;
  returnedVar = intermediateValue;
  return returnedVar;
  }
  else
  {
    counter = counter + 1;
    returnedVar = initialEncryptedInt;
    return returnedVar;
  }
}
