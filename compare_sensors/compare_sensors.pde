#include <Smooth.h>

#define LED 9

Smooth analog0(0);
Smooth analog1(1);

void setup() {
  pinMode(LED, OUTPUT); 
}

void loop() {
  int val0 = analog0.smoothedAnalogRead();
  int val1 = analog1.smoothedAnalogRead();
    
  if(val0 < val1) {
    digitalWrite(LED, HIGH); 
  } else {
    digitalWrite(LED, LOW);
  }
  
  delay(50); 
}

