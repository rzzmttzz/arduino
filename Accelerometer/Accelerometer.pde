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


Accelerometer acc(A0,A1,A2,2);

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
  
  Serial.print("{x:");
  Serial.print(vector->x);
  Serial.print(", y:");
  Serial.print(vector->y);
  Serial.print(", z:");
  Serial.print(vector->z);
  Serial.println("}");

  delay(100);
}
