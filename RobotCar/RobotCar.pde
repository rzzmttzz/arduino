#include "Ultrasonic.h"
#include "Accelerometer.h"

#define TRIGGER 12
#define ECHO 13

#define X A0
#define Y A1
#define Z A2
#define ZEROG 2
#define AREF 3.3
#define V0GXY 1.65
#define V0GZ 1.5
#define SENSITIVITY 0.44

Ultrasonic ultrasonic(TRIGGER,ECHO);
Accelerometer accelerometer(X,Y,Z,ZEROG,AREF,V0GXY,V0GZ,SENSITIVITY);

void setup() {
  Serial.begin(9600);
  analogReference(EXTERNAL);
  pinMode(TRIGGER, OUTPUT);
  pinMode(ECHO, INPUT);
}

void loop() {
  Serial.print("range: ");
  Serial.print(ultrasonic.Range(CM));
  Serial.println(" cm");
  
  vector* vector = accelerometer.getVector();
  Serial.print("{x:");
  Serial.print(vector->x);
  Serial.print(", y:");
  Serial.print(vector->y);
  Serial.print(", z:");
  Serial.print(vector->z);
  //Serial.print(", zerog:");
  //Serial.print(vector->zerog);
  Serial.println("}");
  
  delay(100);
}
