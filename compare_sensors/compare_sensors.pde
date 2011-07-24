#include <Smooth.h>

#define OUT 9

// initialise smoothed analog reader objects
Smooth analog0(A0);
Smooth analog1(A1);

void setup() {
  // set output pin
  pinMode(OUT, OUTPUT); 
}

void loop() {
  // read smoothed analog signals
  int val0 = analog0.smoothedAnalogRead();
  int val1 = analog1.smoothedAnalogRead();

  // compare the two sensors 
  if(val0 < val1) {
    digitalWrite(OUT, HIGH); 
  } else {
    digitalWrite(OUT, LOW);
  }
  
  delay(50); 
}

