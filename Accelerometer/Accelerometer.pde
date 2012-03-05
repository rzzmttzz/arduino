#include <Accelerometer.h>



/*
 ADXL3xx
 
 Reads an Analog Devices ADXL3xx accelerometer and communicates the
 acceleration to the computer.  The pins used are designed to be easily
 compatible with the breakout boards from Sparkfun, available from:
 http://www.sparkfun.com/commerce/categories.php?c=80

 http://www.arduino.cc/en/Tutorial/ADXL3xx

 The circuit:
 analog 0: accelerometer self test
 analog 1: z-axis
 analog 2: y-axis
 analog 3: x-axis
 analog 4: ground
 analog 5: vcc
 
 created 2 Jul 2008
 by David A. Mellis
 modified 4 Sep 2010
 by Tom Igoe 
 
 This example code is in the public domain.

*/

// these constants describe the pins. They won't change:
const int groundpin = 18;             // analog input pin 4 -- ground
const int powerpin = 19;              // analog input pin 5 -- voltage
const int xpin = A3;                  // x-axis of the accelerometer
const int ypin = A2;                  // y-axis
const int zpin = A1;                  // z-axis (only on 3-axis models)

Accelerometer acc(A1,A2,A3,2);

void setup()
{
  // initialize the serial communications:
  Serial.begin(9600);
  analogReference(EXTERNAL);
  pinMode(2, INPUT); 
}

void loop()
{
  vector* vector = acc.getVector();
  
  Serial.print(vector->x);
  Serial.print("\t");
  Serial.print(vector->y);
  Serial.print("\t");
  Serial.print(vector->z);
  Serial.println();

  delay(100);
}
