#include <Accelerometer.h>

#define X A0
#define Y A1
#define Z A2
#define ZEROG 2
#define AREF 3.3
#define V0GXY 1.65
#define V0GZ 1.5
#define SENSITIVITY 0.44
/*


*/
//Smooth smoothX(X);
//Smooth smoothY(Y);
//Smooth smoothZ(Z);
Accelerometer acc(X,Y,Z,ZEROG,AREF,V0GXY,V0GZ,SENSITIVITY);
//Accelerometer acc(smoothX,smoothY,smoothZ,ZEROG,AREF);

void setup()
{
  // initialize the serial communications:
  Serial.begin(9600);
  // set analog reference to 3.3V
  analogReference(EXTERNAL);
  pinMode(2, INPUT); 
}

void loop()
{
  // read from acceremoter object
  vector* vector = acc.getVector();
  
  Serial.print("{x:");
  Serial.print(vector->x);
  Serial.print(", y:");
  Serial.print(vector->y);
  Serial.print(", z:");
  Serial.print(vector->z);
  //Serial.print(", ax:");
  //Serial.print(vector->ax);
  //Serial.print(", ay:");
  //Serial.print(vector->ay);
  //Serial.print(", az:");
  //Serial.print(vector->az);
  //Serial.print(", d:");
  //Serial.print(vector->d);
  Serial.print(", zerog:");
  Serial.print(vector->zerog);
  Serial.println("}");

  delay(10);
}
