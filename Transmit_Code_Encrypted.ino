//For a system using LEDs on pins 3, with option to add three more LEDs on pins 4,5,6
const int STATE_CALIBRATE = -1;
const int STATE_GET_LETTERS = 0;
const int STATE_SEND_START_BIT = 1;
const int STATE_LETTER_TO_BITS = 2;
const int STATE_GET_NEXT_BIT = 3;
const int STATE_SEND_BIT = 4;

int STATE = STATE_CALIBRATE;

char letter = 'a';
char bits[8] = {'0', '0', '0', '0', '0', '0', '0', '0'};
char bitToSend = '0';
int iBit = 0;

int t0 = 0;  //Time marker0 = start of letter
int t1 = 0;  //Time marker1 = start of bit period
int t2 = 0;  //Time marker2 = present time

int T = 20; //Period in milliseconds
int calibrationDelay = 375;
/*Encryption Method #1
 * 
 * Each value 1-7 is represented once in the array
 * Less secure than Method #2
*/
int encryptionArray[8] = {0,1,2,3,4,5,6,7};

/*Encryption Method #2
 * 
 * The letters are modified by a user entered password that can vary in length
 * Password must be composed of characters ranging in deciamal value from 32 to 126
 * Password is all letters,uppercase and lowercase, all numbers, and most special characters, and space
 * More secure than Method #1
*/
//---------------------------

String password = "!!";

//---------------------------


int counter = 0;
int passLength = 1;
void setup()
{
  setPinsAsOutputs();
  Serial.begin(9600);
  passLength = password.length();
  setPinsLow();

  delay(100);
}

void loop()
{
  if (STATE == STATE_CALIBRATE)
  {
    if ( calibrationSequence() == 1)
    {
      STATE = STATE_GET_LETTERS;
    }
    delay(100);
  }
  else if (STATE == STATE_GET_LETTERS)
  {
    //Serial.println(Serial.available());
    if (Serial.available())
    {
      STATE = STATE_LETTER_TO_BITS;
      //STATE = STATE_SEND_START_BIT;
    }
    delay(100);
  }
  else if (STATE == STATE_SEND_START_BIT)
  {
    setPinsHigh();
    //delay(int(T/4));
    delay(5);
    setPinsLow();
    delay(10);
    //STATE = STATE_LETTER_TO_BITS;
    STATE = STATE_GET_NEXT_BIT;
  }
  else if (STATE == STATE_LETTER_TO_BITS)
  {
    letter = Serial.read();
    int number = int(letter);
    //Serial.println(letter);
    //Serial.println(number);
    int encryptedValue = loopEncodeFunction(number);
    //Serial.println(encryptedValue);
    setBinary(encryptedValue, bits);

    //printBits(bits);

    //STATE = STATE_GET_NEXT_BIT;
    STATE = STATE_SEND_START_BIT;

    t0 = millis();
    t1 = t0;
    t2 = t0;
  }
  else if (STATE == STATE_GET_NEXT_BIT)
  {
    if (iBit == 8) //Whole letter was sent
    {
      iBit = 0;                     //Reset bit index
      setPinsLow();                 //Set bus to low value
      STATE = STATE_GET_LETTERS;    //Go look for another letter

    }
    else
    {
      bitToSend = bits[iBit];
      iBit = iBit + 1;

      STATE = STATE_SEND_BIT;
      t1 = millis();
      t2 = t1;
    }
  }
  else if (STATE == STATE_SEND_BIT)
  {
    if (t2 - t1 < T)
    {
      if (bitToSend == '0')
      {
        setPinsLow();
      }
      else
      {
        setPinsHigh();
      }
    }
    else
    {
      STATE = STATE_GET_NEXT_BIT;
    }

    ///*--------FOR DEBUGGING SINGLE BOARD.  REMOVE---------
    //delay(int(T/50)); //FOR SINGLE BOARD TESTING ONLY
    //Serial.print(millis()); //FOR SINGLE BOARD TESTING ONLY
    //Serial.print(","); //FOR SINGLE BOARD TESTING ONLY
    //Serial.println(analogRead(A0)); //FOR SINGLE BOARD TESTING ONLY
    //-----------------------------------------------*/

    t2 = millis();  //Update latest time.
  }

  //Serial.println(STATE);
}


void setBinary(int n, char bits[])
{
  int sum = 0;

  for (int i = 0; i < 8; i++)
  {
    bits[i] = '0';
  }

  if (n / 128.0 >= 1)
  {
    bits[encryptionArray[0]] = '1';
    n = n - 128;
    // sum = n - 128;
  }

  if (n / 64.0 >= 1)
  {
    bits[encryptionArray[1]] = '1';
    // sum = n - 64;
    n = n - 64;

  }
  if (n / 32.0 >= 1)
  {
    bits[encryptionArray[2]] = '1';
    n = n - 32;
    // sum = n - 32;
  }
  if (n / 16.0 >= 1)
  {
    bits[encryptionArray[3]] = '1';
    //sum = n - 16;
    n = n - 16;
  }
  if (n / 8.0 >= 1)
  {
    bits[encryptionArray[4]] = '1';
    // sum = n - 8;
    n = n - 8;
  }
  if (n / 4.0 >= 1)
  {
    bits[encryptionArray[5]] = '1';
    // sum = n - 4;
    n = n - 4;
  }
  if (n / 2.0 >= 1)
  {
    bits[encryptionArray[6]] = '1';
    n = n - 2;
  }
  if (n / 1.0 >= 1)
  {
    bits[encryptionArray[7]] = '1';
  }
  
  String sBits(bits);
  // delay(100);

  //Serial.print("bits");

  //Serial.println(bits);
  //Serial.print("bits");

}



void printBits(char *b)
{
  for (int j = 0; j < 8; j++)
  {
    Serial.print(b[j]);
  }

  Serial.print("\r\n");
}

void setPinsAsOutputs()
{
  pinMode(3, OUTPUT);
    pinMode(4, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(12, OUTPUT);

  //pinMode(4, OUTPUT);
  //pinMode(5, OUTPUT);
  //pinMode(6, OUTPUT);
}

void setPinsLow()
{
  digitalWrite(3, LOW);
    digitalWrite(4, LOW);
  digitalWrite(7, LOW);
  digitalWrite(8, LOW);
  digitalWrite(10, LOW);
  digitalWrite(12, LOW);

  //digitalWrite(4,LOW);
  //digitalWrite(5,LOW);
  //digitalWrite(6,LOW);
}

void setPinsHigh()
{
  digitalWrite(3, HIGH);
    digitalWrite(4, HIGH);
  digitalWrite(7, HIGH);
  digitalWrite(8, HIGH);
  digitalWrite(10, HIGH);
  digitalWrite(12, HIGH);  //digitalWrite(4,HIGH);
  //digitalWrite(5,HIGH);
  //digitalWrite(6,HIGH);
}
int calibrationSequence()
{
  //totalDelay = calibrationDelay * 8 = 3200
  setPinsHigh();
  delay(calibrationDelay);
  setPinsLow();
  delay(calibrationDelay);
  setPinsHigh();
  delay(calibrationDelay);
  setPinsLow();
  delay(calibrationDelay);
  setPinsHigh();
  delay(calibrationDelay);
  setPinsLow();
  delay(calibrationDelay);
  setPinsHigh();
  delay(calibrationDelay);
  setPinsLow();
  delay(calibrationDelay);

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
  int returnedVar;
  int difference;
  int initialEncryptedInt = n + passwordValue;
  int intermediateValue;

  if (initialEncryptedInt > 126)
  {
    difference = initialEncryptedInt - 126;
    intermediateValue = 32 + difference;
    if (intermediateValue > 126)
    {
      difference = intermediateValue - 126;
      intermediateValue = 32 + difference;
    }


    counter = counter + 1;
    returnedVar = intermediateValue;
    //Serial.println("Result of encrypt ");
    //Serial.println(returnedVar);

    return returnedVar;
  }
  else
  {
    counter = counter + 1;
    returnedVar = initialEncryptedInt;
    return returnedVar;
    //Serial.println("Result of encrypt ");
    //Serial.println(returnedVar);
  }
}
